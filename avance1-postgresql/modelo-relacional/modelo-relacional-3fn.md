# Modelo relacional — Cine Umbral

**Versión:** 1.2  
**Alcance:** ocho entidades obligatorias del Avance 1.  
**Motor previsto:** PostgreSQL.

## Convenciones

- **PK:** clave primaria; identifica de forma única cada fila.
- **FK:** clave foránea; referencia la PK de otra tabla. Se declara en la tabla del lado N.
- **UNIQUE:** restricción que impide repetir un valor o una combinación de valores.
- **NULL permitido:** solo `VENTAS.id_staff` puede quedar nulo para las ventas digitales.
- **Cardinalidad (pata de gallo):** círculo = opcional; barra = obligatorio; bifurcación = muchos. Las claves foráneas se almacenan en la tabla del lado N.
- Los nombres se muestran en mayúsculas para facilitar la lectura del modelo; PostgreSQL convierte identificadores sin comillas a minúsculas.

## Relaciones y atributos

### ACTORES_DIRECTORES
- **PK:** `id_talento BIGINT`.
- **Atributos:** `nombres VARCHAR(80)`, `apellidos VARCHAR(80)`, `tipo_talento VARCHAR(12)`, `pais_origen VARCHAR(60)`, `fecha_nacimiento DATE`, `correo VARCHAR(254)`.
- **Regla:** `tipo_talento` admite `ACTOR`, `DIRECTOR` o `AMBOS`. Se registra aquí el talento invitado a actividades especiales.

### CONTRATOS
- **PK:** `id_contrato BIGINT`.
- **FK obligatorias:** `id_talento → ACTORES_DIRECTORES(id_talento)` y `id_funcion → FUNCIONES(id_funcion)`.
- **UNIQUE:** `codigo_contrato VARCHAR(30)` y `(id_talento, id_funcion)`; la segunda restricción admite un único contrato por invitado y función.
- **Atributos:** `objeto_contrato VARCHAR(180)`, `tipo_contrato VARCHAR(40)`, `fecha_firma DATE`, `honorarios NUMERIC(12,2)`, `estado VARCHAR(15)`.
- **Restricción:** honorarios no negativos.
- **Cardinalidades:** cada contrato pertenece a un talento y una función; cada talento y cada función puede tener cero o muchos contratos.

### SALAS
- **PK:** `id_sala BIGINT`.
- **UNIQUE:** `nombre VARCHAR(60)`.
- **Atributos:** `capacidad INTEGER`, `formato VARCHAR(30)`, `estado VARCHAR(15)`.
- **Restricción:** capacidad mayor que cero.

### FUNCIONES
- **PK:** `id_funcion BIGINT`.
- **FK obligatoria:** `id_sala → SALAS(id_sala)`.
- **UNIQUE compuesta:** `(id_sala, fecha_hora_inicio)`; evita dos funciones con la misma hora de inicio en una sala.
- **Atributos:** `titulo_obra VARCHAR(160)`, `fecha_hora_inicio TIMESTAMPTZ`, `duracion_minutos SMALLINT`, `idioma VARCHAR(40)`, `clasificacion VARCHAR(20)`, `precio_base NUMERIC(12,2)`, `estado VARCHAR(15)`, `tipo_funcion VARCHAR(20)`.
- **Restricciones:** duración mayor que cero y precio base no negativo. `tipo_funcion` distingue `PROYECCION`, `CINEFORO` y `CONVERSATORIO`. La prevención de traslapes debe comprobar también la duración de las funciones.

### TIPOS_BOLETA
- **PK:** `id_tipo_boleta BIGINT`.
- **UNIQUE:** `nombre VARCHAR(60)`.
- **Atributos:** `descripcion VARCHAR(180)`, `factor_precio NUMERIC(5,2)`, `activo BOOLEAN`.
- **Restricción:** factor de precio mayor que cero.

### ESPECTADORES
- **PK:** `id_espectador BIGINT`.
- **UNIQUE compuesta:** `(tipo_documento, numero_documento)`.
- **Atributos:** `tipo_documento VARCHAR(20)`, `numero_documento VARCHAR(30)`, `nombres VARCHAR(80)`, `apellidos VARCHAR(80)`, `correo VARCHAR(254)`, `telefono VARCHAR(30)`, `fecha_nacimiento DATE`.
- **Cardinalidad:** un espectador puede tener cero o muchas ventas; cada venta corresponde a un espectador.

### STAFF
- **PK:** `id_staff BIGINT`.
- **UNIQUE compuesta:** `(tipo_documento, numero_documento)`.
- **Atributos:** `tipo_documento VARCHAR(20)`, `numero_documento VARCHAR(30)`, `nombres VARCHAR(80)`, `apellidos VARCHAR(80)`, `cargo VARCHAR(60)`, `correo VARCHAR(254)`, `fecha_ingreso DATE`, `activo BOOLEAN`.
- **Cardinalidad:** un empleado puede registrar cero o muchas ventas. Una venta puede tener cero o un empleado registrador.

### VENTAS
- **PK:** `id_venta BIGINT`.
- **FK obligatorias:** `id_funcion → FUNCIONES(id_funcion)`, `id_espectador → ESPECTADORES(id_espectador)`, `id_tipo_boleta → TIPOS_BOLETA(id_tipo_boleta)`.
- **FK opcional:** `id_staff → STAFF(id_staff)`; se permite nulo para las ventas digitales.
- **UNIQUE compuesta:** `(id_funcion, asiento)`; evita vender dos veces el mismo asiento para una función.
- **Atributos:** `fecha_hora_venta TIMESTAMPTZ`, `asiento VARCHAR(12)`, `precio_pagado NUMERIC(12,2)`, `estado VARCHAR(15)`.
- **Regla:** cada fila representa una boleta para un único asiento y función; una compra con varios asientos genera varias filas. `precio_pagado` conserva el valor histórico efectivamente cobrado.

## Resumen de claves foráneas

| Tabla hija | Columna | Tabla referenciada | Cardinalidad |
|---|---|---|---|
| CONTRATOS | id_talento | ACTORES_DIRECTORES | 1 talento : 0..N contratos |
| CONTRATOS | id_funcion | FUNCIONES | 1 función : 0..N contratos |
| FUNCIONES | id_sala | SALAS | 1 sala : 0..N funciones |
| VENTAS | id_funcion | FUNCIONES | 1 función : 0..N ventas |
| VENTAS | id_espectador | ESPECTADORES | 1 espectador : 0..N ventas |
| VENTAS | id_tipo_boleta | TIPOS_BOLETA | 1 tipo : 0..N ventas |
| VENTAS | id_staff (nullable) | STAFF | 1 empleado : 0..N ventas; cada venta tiene 0..1 empleado |

## Verificación de tercera forma normal

1. **Primera forma normal (1FN):** cada atributo contiene un valor atómico; no se almacenan listas de asientos, personas o tipos en una columna.
2. **Segunda forma normal (2FN):** cada tabla tiene una PK simple; las restricciones únicas compuestas son claves candidatas y no originan dependencias parciales.
3. **Tercera forma normal (3FN):** los datos descriptivos dependen de la clave de su propia tabla. Los nombres del talento no se repiten en contratos; el título y la fecha de la función se consultan desde `FUNCIONES`, y la sala desde `SALAS`.
4. **Historial transaccional:** `VENTAS.precio_pagado` registra el importe cobrado y no copia el precio base ni el factor de la boleta.
5. **Datos derivados:** la capacidad pertenece a `SALAS`; los totales se calculan en las consultas, no se duplican en otras tablas.

## Decisiones del modelo

- La guía exige exactamente estas ocho entidades y no incluye una tabla `PELICULAS`; por eso `FUNCIONES` conserva `titulo_obra`.
- `FUNCIONES.tipo_funcion` diferencia la proyección regular de las actividades con invitados: cineforo y conversatorio.
- `CONTRATOS` representa la participación de un actor o director invitado en una función programada; no representa producción de la película. Cada contrato se liga a un talento y una función. Una función puede tener varios invitados, con un contrato por persona.
- La fecha de la actividad y el título de la obra se mantienen solo en `FUNCIONES`; así no se repiten en `CONTRATOS`.
- Cada venta se asocia con un espectador registrado y un tipo de boleta.
- La unicidad de asiento se controla por función con `UNIQUE (id_funcion, asiento)`.
