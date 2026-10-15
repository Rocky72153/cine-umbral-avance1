CREATE OR REPLACE PROCEDURE sp_registrar_venta(
    IN p_id_staff INTEGER,
    IN p_id_funcion INTEGER,
    IN p_id_espectador INTEGER,
    IN p_id_metodo_pago INTEGER,
    IN p_asientos TEXT[],
    IN p_id_tipos_boleta INTEGER[],
    IN p_precios NUMERIC[],
    OUT p_id_venta INTEGER
)
LANGUAGE plpgsql
AS $procedimiento$
DECLARE
    v_cantidad_boletas INTEGER;
    v_indice INTEGER;
    v_asientos_distintos INTEGER;
    v_monto_total NUMERIC(10, 2);
BEGIN
    p_id_venta := NULL;

    IF p_id_staff IS NULL
       OR p_id_funcion IS NULL
       OR p_id_espectador IS NULL
       OR p_id_metodo_pago IS NULL THEN
        RAISE EXCEPTION 'Staff, función, espectador y método de pago son obligatorios.'
            USING ERRCODE = '22023';
    END IF;

    IF p_asientos IS NULL
       OR p_id_tipos_boleta IS NULL
       OR p_precios IS NULL THEN
        RAISE EXCEPTION 'Debe indicar asientos, tipos de boleta y precios.'
            USING ERRCODE = '22023';
    END IF;

    IF COALESCE(array_ndims(p_asientos), 0) <> 1
       OR COALESCE(array_ndims(p_id_tipos_boleta), 0) <> 1
       OR COALESCE(array_ndims(p_precios), 0) <> 1
       OR COALESCE(array_lower(p_asientos, 1), 0) <> 1
       OR COALESCE(array_lower(p_id_tipos_boleta, 1), 0) <> 1
       OR COALESCE(array_lower(p_precios, 1), 0) <> 1 THEN
        RAISE EXCEPTION 'Los datos de las boletas deben ser arreglos unidimensionales que inicien en el índice 1.'
            USING ERRCODE = '22023';
    END IF;

    v_cantidad_boletas := cardinality(p_asientos);

    IF v_cantidad_boletas = 0
       OR cardinality(p_id_tipos_boleta) <> v_cantidad_boletas
       OR cardinality(p_precios) <> v_cantidad_boletas THEN
        RAISE EXCEPTION 'Cada asiento debe tener exactamente un tipo de boleta y un precio.'
            USING ERRCODE = '22023';
    END IF;

    IF EXISTS (
        SELECT 1
        FROM unnest(p_asientos) AS asiento(numero_asiento)
        WHERE asiento.numero_asiento IS NULL
           OR BTRIM(asiento.numero_asiento) = ''
    ) THEN
        RAISE EXCEPTION 'Los números de asiento no pueden estar vacíos.'
            USING ERRCODE = '22023';
    END IF;

    IF EXISTS (
        SELECT 1
        FROM unnest(p_asientos) AS asiento(numero_asiento)
        GROUP BY UPPER(BTRIM(asiento.numero_asiento))
        HAVING COUNT(*) > 1
    ) THEN
        RAISE EXCEPTION 'La solicitud contiene asientos repetidos.'
            USING ERRCODE = '23505';
    END IF;

    IF EXISTS (
        SELECT 1
        FROM unnest(p_precios) AS dato(precio)
        WHERE dato.precio IS NULL OR dato.precio < 0
    ) THEN
        RAISE EXCEPTION 'Los precios de las boletas deben ser valores no negativos.'
            USING ERRCODE = '22023';
    END IF;

    PERFORM 1
    FROM Staff
    WHERE id_staff = p_id_staff;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'No existe el integrante de staff indicado (id_staff=%).', p_id_staff
            USING ERRCODE = '23503';
    END IF;

    -- El bloqueo serializa las ventas de una misma función y reduce el riesgo
    -- de que dos llamadas simultáneas asignen el mismo asiento.
    PERFORM 1
    FROM Funcion
    WHERE id_funcion = p_id_funcion
    FOR UPDATE;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'No existe la función indicada (id_funcion=%).', p_id_funcion
            USING ERRCODE = '23503';
    END IF;

    PERFORM 1
    FROM Espectador
    WHERE id_espectador = p_id_espectador;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'No existe el espectador indicado (id_espectador=%).', p_id_espectador
            USING ERRCODE = '23503';
    END IF;

    PERFORM 1
    FROM Metodo_Pago_Venta
    WHERE id_metodo_pago = p_id_metodo_pago;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'No existe el método de pago indicado (id_metodo_pago=%).', p_id_metodo_pago
            USING ERRCODE = '23503';
    END IF;

    IF EXISTS (
        SELECT 1
        FROM unnest(p_id_tipos_boleta) AS tipo_solicitado(id_tipo_boleta)
        LEFT JOIN Tipo_Boleta AS tipo
            ON tipo.id_tipo_boleta = tipo_solicitado.id_tipo_boleta
        WHERE tipo.id_tipo_boleta IS NULL
    ) THEN
        RAISE EXCEPTION 'Uno o más tipos de boleta no existen.'
            USING ERRCODE = '23503';
    END IF;

    SELECT COUNT(DISTINCT UPPER(BTRIM(asiento.numero_asiento)))
    INTO v_asientos_distintos
    FROM unnest(p_asientos) AS asiento(numero_asiento);

    IF EXISTS (
        SELECT 1
        FROM unnest(p_asientos) AS solicitado(numero_asiento)
        JOIN Venta AS venta
            ON venta.id_funcion = p_id_funcion
        JOIN Boleta AS boleta
            ON boleta.id_venta = venta.id_venta
        WHERE UPPER(BTRIM(boleta.numero_asiento))
              = UPPER(BTRIM(solicitado.numero_asiento))
    ) THEN
        RAISE EXCEPTION 'Uno o más asientos ya fueron vendidos para la función indicada.'
            USING ERRCODE = '23505';
    END IF;

    SELECT COALESCE(SUM(ROUND(dato.precio, 2)), 0)::NUMERIC(10, 2)
    INTO v_monto_total
    FROM unnest(p_precios) AS dato(precio);

    INSERT INTO Venta (
        id_staff,
        id_funcion,
        id_espectador,
        id_metodo_pago,
        monto_total,
        fecha
    )
    VALUES (
        p_id_staff,
        p_id_funcion,
        p_id_espectador,
        p_id_metodo_pago,
        v_monto_total,
        CURRENT_TIMESTAMP
    )
    RETURNING id_venta INTO p_id_venta;

    FOR v_indice IN 1..v_cantidad_boletas LOOP
        INSERT INTO Boleta (
            id_venta,
            id_tipo_boleta,
            precio,
            numero_asiento
        )
        VALUES (
            p_id_venta,
            p_id_tipos_boleta[v_indice],
            ROUND(p_precios[v_indice], 2),
            BTRIM(p_asientos[v_indice])
        );
    END LOOP;

    RAISE NOTICE 'Venta % registrada. Total: %', p_id_venta, v_monto_total;

EXCEPTION
    WHEN OTHERS THEN
        RAISE EXCEPTION 'sp_registrar_venta: %', SQLERRM
            USING ERRCODE = SQLSTATE;
END;
$procedimiento$;


-- 2. Reporte agregado por función para un rango de fechas.
-- Tablas: Funcion, Pelicula, Sala, Venta y Boleta.
-- El cursor devuelve cantidad de ventas, boletas y recaudo por función.
-- Ejecutar dentro de una transacción y luego hacer FETCH del cursor.
CREATE OR REPLACE PROCEDURE sp_reporte_ventas_por_funcion(
    IN p_fecha_desde DATE,
    IN p_fecha_hasta DATE,
    INOUT p_resultado REFCURSOR
)
LANGUAGE plpgsql
AS $procedimiento$
BEGIN
    IF p_fecha_desde IS NULL OR p_fecha_hasta IS NULL THEN
        RAISE EXCEPTION 'El rango de fechas es obligatorio.'
            USING ERRCODE = '22023';
    END IF;

    IF p_fecha_desde > p_fecha_hasta THEN
        RAISE EXCEPTION 'La fecha inicial no puede ser posterior a la fecha final.'
            USING ERRCODE = '22023';
    END IF;

    OPEN p_resultado FOR
        SELECT
            funcion.id_funcion,
            pelicula.titulo,
            funcion.fecha,
            funcion.hora_inicio,
            sala.id_sala,
            sala.capacidad,
            COALESCE(ventas.cantidad_ventas, 0) AS cantidad_ventas,
            COALESCE(boletas.cantidad_boletas, 0) AS cantidad_boletas,
            COALESCE(ventas.recaudo, 0)::NUMERIC(10, 2) AS recaudo
        FROM Funcion AS funcion
        JOIN Pelicula AS pelicula
            ON pelicula.id_pelicula = funcion.id_pelicula
        JOIN Sala AS sala
            ON sala.id_sala = funcion.id_sala
        LEFT JOIN (
            SELECT
                id_funcion,
                COUNT(*) AS cantidad_ventas,
                SUM(monto_total) AS recaudo
            FROM Venta
            GROUP BY id_funcion
        ) AS ventas
            ON ventas.id_funcion = funcion.id_funcion
        LEFT JOIN (
            SELECT
                venta.id_funcion,
                COUNT(boleta.id_boleta) AS cantidad_boletas
            FROM Venta AS venta
            LEFT JOIN Boleta AS boleta
                ON boleta.id_venta = venta.id_venta
            GROUP BY venta.id_funcion
        ) AS boletas
            ON boletas.id_funcion = funcion.id_funcion
        WHERE funcion.fecha BETWEEN p_fecha_desde AND p_fecha_hasta
        ORDER BY funcion.fecha, funcion.hora_inicio, funcion.id_funcion;

EXCEPTION
    WHEN OTHERS THEN
        RAISE EXCEPTION 'sp_reporte_ventas_por_funcion: %', SQLERRM
            USING ERRCODE = SQLSTATE;
END;
$procedimiento$;


-- 3. Cambia el estado operativo de una sala.
-- Tablas: Sala y Estado_Sala.
-- Valida que existan la sala y el estado antes de realizar el mantenimiento.
CREATE OR REPLACE PROCEDURE sp_actualizar_estado_sala(
    IN p_id_sala INTEGER,
    IN p_id_estado_sala INTEGER
)
LANGUAGE plpgsql
AS $procedimiento$
BEGIN
    IF p_id_sala IS NULL OR p_id_estado_sala IS NULL THEN
        RAISE EXCEPTION 'La sala y el nuevo estado son obligatorios.'
            USING ERRCODE = '22023';
    END IF;

    PERFORM 1
    FROM Sala
    WHERE id_sala = p_id_sala
    FOR UPDATE;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'No existe la sala indicada (id_sala=%).', p_id_sala
            USING ERRCODE = '23503';
    END IF;

    PERFORM 1
    FROM Estado_Sala
    WHERE id_estado_sala = p_id_estado_sala;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'No existe el estado de sala indicado (id_estado_sala=%).', p_id_estado_sala
            USING ERRCODE = '23503';
    END IF;

    UPDATE Sala
    SET id_estado_sala = p_id_estado_sala
    WHERE id_sala = p_id_sala;

    RAISE NOTICE 'Se actualizó el estado de la sala %.', p_id_sala;

EXCEPTION
    WHEN OTHERS THEN
        RAISE EXCEPTION 'sp_actualizar_estado_sala: %', SQLERRM
            USING ERRCODE = SQLSTATE;
END;
$procedimiento$;
