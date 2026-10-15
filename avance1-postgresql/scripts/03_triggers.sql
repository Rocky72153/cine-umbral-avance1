-- Trigger para la validación del horario de una función
CREATE OR REPLACE FUNCTION validar_horario_funcion ()
RETURNS TRIGGER
LANGUAGE plpgsql 
AS $$ 
BEGIN
  IF NEW.hora_fin <= NEW.hora_inicio THEN
    RAISE EXCEPTION 'La hora de finalización debe ser posterior a la hora de inicio de la función';
  END IF;

  RETURN NEW;
END;
$$;

CREATE TRIGGER validar_horario_funcion_trigger
BEFORE INSERT OR UPDATE OF hora_inicio, hora_fin
ON Funcion
FOR EACH ROW
EXECUTE FUNCTION validar_horario_funcion();

-- Trigger de validación del precio de la boleta
CREATE OR REPLACE FUNCTION validar_precio_boleta()
RETURNS TRIGGER AS $$
BEGIN
  IF NEW.precio <= 0 THEN
    RAISE EXCEPTION 'El precio de una boleta debe ser mayor a 0';
  END IF;

  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER validar_precio_boleta_trigger
BEFORE INSERT OR UPDATE OF precio
ON Boleta
FOR EACH ROW
EXECUTE FUNCTION validar_precio_boleta();

-- Función que valida el monto total de una venta
CREATE OR REPLACE FUNCTION validar_monto_venta()
RETURNS TRIGGER AS $$
BEGIN
  IF NEW.monto_total <= 0 THEN 
    RAISE EXCEPTION 'El monto total no puede ser menor a cero';
  END IF;

  RETURN NEW;

END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER validar_monto_venta_trigger
BEFORE INSERT OR UPDATE OF monto_total
ON Venta
FOR EACH ROW
EXECUTE FUNCTION validar_monto_venta();


-- Función que valida la capacidad de una sala
CREATE OR REPLACE FUNCTION validar_capacidad_sala()
RETURNS TRIGGER AS $$
BEGIN
  IF NEW.capacidad <= 0 OR NEW.capacidad > 100 THEN
    RAISE EXCEPTION 'La capacidad máxima de la sala es de 100 personas y la mínima es de 1 persona';
  END IF;
  RETURN NEW;
  
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER valida_capacidad_sala_trigger
BEFORE INSERT OR UPDATE OF capacidad
ON sala 
FOR EACH ROW
EXECUTE FUNCTION validar_capacidad_sala();

-- Función que valida el salario y las fechas de un contrato
CREATE OR REPLACE FUNCTION validar_contrato()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.salario <= 0 OR NEW.salario > 20000000 THEN
        RAISE EXCEPTION 'El salario del contrato debe ser mayor que cero y no superar los 20.000.000';
    END IF;

    IF NEW.fecha_inicio > CURRENT_DATE THEN
        RAISE EXCEPTION 'La fecha de inicio del contrato no puede ser posterior a la fecha actual';
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER validar_contrato_trigger
BEFORE INSERT OR UPDATE OF salario, fecha_inicio 
ON Contrato
FOR EACH ROW
EXECUTE FUNCTION validar_contrato();

-- Trigger que controla el estado del staff
CREATE OR REPLACE FUNCTION controlEstadoStaff_trigger_fn()
RETURNS trigger AS $$
DECLARE
  v_estado_nuevo VARCHAR(50);
  v_cantidad_contratos INT;
BEGIN
  SELECT nombre
  INTO v_estado_nuevo
  FROM Estado_Staff
  WHERE id_estado_staff = NEW.id_estado_staff;

  IF v_estado_nuevo = 'Activo' THEN
    SELECT COUNT(*)
    INTO v_cantidad_contratos
    FROM Contrato
    WHERE id_staff = NEW.id_staff;

    IF v_cantidad_contratos = 0 THEN
      RAISE EXCEPTION 'El empleado % % no puede quedar Activo porque no tiene un contrato registrado', NEW.primer_nombre, NEW.primer_apellido;
    END IF;
  END IF;

  RETURN NEW;
END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER controlEstadoStaff_trigger
  BEFORE UPDATE OF id_estado_staff ON Staff
  FOR EACH ROW
  EXECUTE FUNCTION controlEstadoStaff_trigger_fn();


-- Trigger Validacion del correo del espectador
CREATE OR REPLACE FUNCTION validarCorreoEspectador_trigger_fn()
RETURNS trigger AS $$
BEGIN
  IF NEW.correo IS NOT NULL AND NEW.correo !~ '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$' THEN
    RAISE EXCEPTION 'El correo % del espectador % % no tiene un formato válido', NEW.correo, NEW.primer_nombre, NEW.primer_apellido;
  END IF;

  RETURN NEW;
END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER validarCorreoEspectador_trigger
  BEFORE INSERT OR UPDATE OF correo ON Espectador
  FOR EACH ROW
  EXECUTE FUNCTION validarCorreoEspectador_trigger_fn();
