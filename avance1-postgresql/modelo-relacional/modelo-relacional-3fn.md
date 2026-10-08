# Modelo relacional — Cine Umbral

**Versión:** 1.0 · **Alcance:** las ocho entidades solicitadas en el Avance 1.

## Convenciones

- PK: clave primaria. FK: clave foránea. UQ: clave candidata con restricción UNIQUE.
- Los tipos de datos especificados son los tipos previstos para la implementación en PostgreSQL.
- Los nombres corresponden a las tablas requeridas. En PostgreSQL sin comillas, los identificadores se guardan en minúsculas.

## Relaciones

### ACTORES_DIRECTORES

- **PK:** id_talento BIGINT.
- **Atributos:** nombres VARCHAR(80), apellidos VARCHAR(80), tipo_talento VARCHAR(12), pais_origen VARCHAR(60), fecha_nacimiento DATE, correo VARCHAR(254).
- **Restricción:** tipo_talento admite ACTOR, DIRECTOR o AMBOS.
- **Dependencia:** id_talento determina los atributos del talento.

### CONTRATOS

- **PK:** id_contrato BIGINT.
- **FK:** id_talento → ACTORES_DIRECTORES(id_talento), obligatorio.
- **UQ:** codigo_contrato VARCHAR(30).
- **Atributos:** nombre_proyecto VARCHAR(160), tipo_contrato VARCHAR(40), fecha_firma DATE, fecha_inicio DATE, fecha_fin DATE, honorarios NUMERIC(12,2), estado VARCHAR(15).
- **Restricciones:** honorarios ≥ 0; fecha_fin puede ser nula o igual/posterior a fecha_inicio; fecha_firma ≤ fecha_inicio.
- **Cardinalidad:** un talento puede tener cero o varios contratos; cada contrato pertenece a un talento.

### SALAS

- **PK:** id_sala BIGINT.
- **UQ:** nombre VARCHAR(60).
- **Atributos:** capacidad INTEGER, formato VARCHAR(30), estado VARCHAR(15).
- **Restricción:** capacidad > 0.
- **Dependencia:** id_sala determina los datos de la sala.

### FUNCIONES

- **PK:** id_funcion BIGINT.
- **FK:** id_sala → SALAS(id_sala), obligatorio.
- **UQ:** (id_sala, fecha_hora_inicio), para impedir dos funciones con la misma hora de inicio en una sala.
- **Atributos:** titulo_obra VARCHAR(160), fecha_hora_inicio TIMESTAMPTZ, duracion_minutos SMALLINT, idioma VARCHAR(40), clasificacion VARCHAR(20), precio_base NUMERIC(12,2), estado VARCHAR(15).
- **Restricciones:** duracion_minutos > 0 y precio_base ≥ 0. La exclusión de funciones traslapadas en una sala se valida con una regla de integridad adicional.
- **Cardinalidad:** una sala puede tener cero o varias funciones; cada función ocurre en una sala.

### TIPOS_BOLETA

- **PK:** id_tipo_boleta BIGINT.
- **UQ:** nombre VARCHAR(60).
- **Atributos:** descripcion VARCHAR(180), factor_precio NUMERIC(5,2), activo BOOLEAN.
- **Restricción:** factor_precio > 0. El precio de referencia se calcula con la tarifa base de la función y el factor del tipo de boleta.

### ESPECTADORES

- **PK:** id_espectador BIGINT.
- **UQ:** (tipo_documento, numero_documento).
- **Atributos:** tipo_documento VARCHAR(20), numero_documento VARCHAR(30), nombres VARCHAR(80), apellidos VARCHAR(80), correo VARCHAR(254), telefono VARCHAR(30), fecha_nacimiento DATE.
- **Cardinalidad:** un espectador puede tener cero o varias ventas; cada venta queda asociada a un espectador registrado.

### STAFF

- **PK:** id_staff BIGINT.
- **UQ:** (tipo_documento, numero_documento).
- **Atributos:** tipo_documento VARCHAR(20), numero_documento VARCHAR(30), nombres VARCHAR(80), apellidos VARCHAR(80), cargo VARCHAR(60), correo VARCHAR(254), fecha_ingreso DATE, activo BOOLEAN.
- **Cardinalidad:** un empleado puede registrar cero o varias ventas. La FK de STAFF en VENTAS es opcional para permitir ventas digitales.

### VENTAS

- **PK:** id_venta BIGINT.
- **FK obligatorias:** id_funcion → FUNCIONES(id_funcion); id_espectador → ESPECTADORES(id_espectador); id_tipo_boleta → TIPOS_BOLETA(id_tipo_boleta).
- **FK opcional:** id_staff → STAFF(id_staff), nula para ventas en línea.
- **UQ:** (id_funcion, asiento), para evitar vender el mismo asiento en la misma función.
- **Atributos:** fecha_hora_venta TIMESTAMPTZ, asiento VARCHAR(12), precio_pagado NUMERIC(12,2), estado VARCHAR(15).
- **Restricciones:** precio_pagado ≥ 0. Una fila representa una boleta/asiento, no una orden con varias líneas.
- **Cardinalidades:** cada venta corresponde a una función, tipo de boleta y espectador; una venta tiene cero o un empleado registrador. Cada una de esas entidades puede relacionarse con muchas ventas.

## Resumen de claves foráneas

| Tabla hija | Columna | Tabla referenciada | Cardinalidad |
|---|---|---|---|
| CONTRATOS | id_talento | ACTORES_DIRECTORES | 1 talento : 0..N contratos |
| FUNCIONES | id_sala | SALAS | 1 sala : 0..N funciones |
| VENTAS | id_funcion | FUNCIONES | 1 función : 0..N ventas/boletas |
| VENTAS | id_espectador | ESPECTADORES | 1 espectador : 0..N ventas |
| VENTAS | id_tipo_boleta | TIPOS_BOLETA | 1 tipo : 0..N ventas |
| VENTAS | id_staff (nulo permitido) | STAFF | 1 empleado : 0..N ventas; cada venta tiene 0..1 empleado |

## Verificación de tercera forma normal

1. **Primera forma normal:** los atributos son atómicos; no se almacenan listas de actores, asientos o tipos de boleta en una columna. Una fila de VENTAS representa una sola boleta y un solo asiento.
2. **Segunda forma normal:** cada relación usa una PK de una sola columna. Las claves compuestas indicadas son restricciones candidatas; ningún atributo no clave depende solo de una parte de ellas.
3. **Tercera forma normal:** los atributos descriptivos se guardan junto con su determinante. Los contratos no duplican nombres del talento; las funciones no duplican nombre/capacidad de sala; las ventas no duplican título de función, nombre del espectador ni nombre del tipo de boleta. Se almacenan sus FK.
4. **Valores transaccionales:** VENTAS conserva precio_pagado como monto histórico efectivamente cobrado. No guarda copia de precio_base ni factor_precio. Esto evita que una actualización futura del precio de lista altere ventas pasadas.
5. **Atributos derivados:** no se almacena un total de función o de sala en otra tabla; capacidad pertenece a SALAS y se consulta cuando se necesita.

## Reglas de negocio del diseño

- La venta se modela como una boleta por asiento.
- FUNCIONES conserva el título de la obra programada porque el alcance de ocho entidades no incluye una tabla PELÍCULAS.
- Dos funciones de una misma sala no pueden traslaparse; esta regla requiere validar horarios considerando la duración.
- Cada venta se asocia con un espectador registrado.
