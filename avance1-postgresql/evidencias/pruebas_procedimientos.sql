\echo '=== PRUEBA 1: sp_registrar_venta ==='
CALL sp_registrar_venta(
    1,
    1,
    1,
    1,
    ARRAY['Z99']::TEXT[],
    ARRAY[1]::INTEGER[],
    ARRAY[18000.00]::NUMERIC[],
    NULL
);
SELECT id_venta, id_funcion, monto_total
FROM Venta
WHERE id_funcion = 1
ORDER BY id_venta DESC
LIMIT 1;
SELECT id_boleta, numero_asiento, precio
FROM Boleta
WHERE numero_asiento = 'Z99';

\echo '=== PRUEBA 2: sp_reporte_ventas_por_funcion ==='
BEGIN;
CALL sp_reporte_ventas_por_funcion(
    DATE '2026-10-16',
    DATE '2026-10-18',
    'reporte_funciones'
);
FETCH ALL FROM reporte_funciones;
COMMIT;

\echo '=== PRUEBA 3: sp_actualizar_estado_sala ==='
CALL sp_actualizar_estado_sala(1, 2);
SELECT sala.id_sala, estado.nombre AS estado_actual
FROM Sala AS sala
JOIN Estado_Sala AS estado
  ON estado.id_estado_sala = sala.id_estado_sala
WHERE sala.id_sala = 1;

\echo '=== FIN: las tres llamadas terminaron sin error ==='
