# Modelo relacional — Cine Umbral

**Versión:** 1.1  
**Alcance:** ocho entidades obligatorias del Avance 1.  
**Motor previsto:** PostgreSQL.

## Convenciones

- **PK:** clave primaria; identifica de forma única cada fila.
- **FK:** clave foránea; referencia la PK de otra tabla. Se declara en la tabla del lado N.
- **UNIQUE:** restricción que impide repetir un valor o una combinación de valores.
- **NULL permitido:** valor opcional. En este modelo, solo `VENTAS.id_staff` puede quedar nulo para las ventas digitales.
- **Cardinalidad (pata de gallo):** círculo = opcional; barra = obligatorio; bifurcación = muchos. Las claves foráneas se almacenan en la tabla del lado N.
- Los nombres se muestran en mayúsculas para facilitar la lectura del modelo; PostgreSQL convierte identificadores sin comillas a minúsculas.

## Relaciones y atributos

### ACTORES_DIRECTORES
- **PK:** `id_talento BIGINT`.
- **Atributos:** `nombres VARCHAR(80)`, `apellidos VARCHAR(80)`, `tipo_talento VARCHAR(12)`, `pais_origen VARCHAR(60)`, `fecha_nacimiento DATE`, `correo VARCHAR(254)`.
- **Regla:** `tipo_talento` admite `ACTOR`, `DIRECTOR` o `AMBOS`.

### CONTRATOS
- **PK:** `id_contrato BIGINT`.
- **FK obligatoria:** `id_talento → ACTORES_DIRECTORES(id_talento)`.
- **UNIQUE:** `codigo_contrato VARCHAR(30)`.
- **Atributos:** `nombre_proyecto VARCHAR(160)`, `tipo_contrato VARCHAR(40)`, `fecha_firma DATE`, `fecha_inicio DATE`, `fecha_fin DATE`, `honorarios NUMERIC(12,2)`, `estado VARCHAR(15)`.
- **Restricciones:** honorarios no negativos; `fecha_fin` puede ser nula o igual/posterior a `fecha_inicio`; `fecha_firma ≤ fecha_inicio`.
- **Cardinalidad:** un talento puede relacionarse con cero o muchos contratos; cada contrato pertenece a un solo talento.

### SALAS
- **PK:** `id_sala BIGINT`.
- **UNIQUE:** `nombre VARCHAR(60)`.
- **Atributos:** `capacidad INTEGER`, `formato VARCHAR(30)`, `estado VARCHAR(15)`.
- **Restricción:** capacidad mayor que cero.

### FUNCIONES
- **PK:** `id_funcion BIGINT`.
- **FK obligatoria:** `id_sala → SALAS(id_sala)`.
- **UNIQUE compuesta:** `(id_sala, fecha_hora_inicio)`; evita dos funciones con la misma hora de inicio en una sala.
- **Atributos:** `titulo_obra VARCHAR(160)`, `fecha_hora_inicio TIMESTAMPTZ`, `duracion_minutos SMALLINT`, `idioma VARCHAR(40)`, `clasificacion VARCHAR(20)`, `precio_base NUMERIC(12,2)`, `estado VARCHAR(15)`.
- **Restricciones:** duración mayor que cero y precio base no negativo. La prevención de traslapes debe comprobar también la duración de las funciones.

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
| FUNCIONES | id_sala | SALAS | 1 sala : 0..N funciones |
| VENTAS | id_funcion | FUNCIONES | 1 función : 0..N ventas |
| VENTAS | id_espectador | ESPECTADORES | 1 espectador : 0..N ventas |
| VENTAS | id_tipo_boleta | TIPOS_BOLETA | 1 tipo : 0..N ventas |
| VENTAS | id_staff (nullable) | STAFF | 1 empleado : 0..N ventas; cada venta tiene 0..1 empleado |

## Verificación de tercera forma normal

1. **Primera forma normal (1FN):** cada atributo contiene un valor atómico; no se almacenan listas de asientos, personas o tipos en una columna.
2. **Segunda forma normal (2FN):** cada tabla tiene una PK simple; las restricciones únicas compuestas son claves candidatas y no originan dependencias parciales.
3. **Tercera forma normal (3FN):** los datos descriptivos dependen de la clave de su propia tabla. No se duplican nombres del talento en contratos, datos de salas en funciones ni datos de espectadores o tipos de boleta en ventas.
4. **Historial transaccional:** `VENTAS.precio_pagado` registra el importe cobrado y no copia el precio base ni el factor de la boleta.
5. **Datos derivados:** la capacidad pertenece a `SALAS`; los totales se calculan en las consultas, no se duplican en otras tablas.

## Decisiones y límites del alcance

- La guía exige exactamente estas ocho entidades y no incluye una tabla `PELICULAS`; por eso `FUNCIONES` conserva `titulo_obra`.
- Cine Umbral se define como un cine que únicamente exhibe películas comerciales. `ACTORES_DIRECTORES` y `CONTRATOS` se conservan para cumplir el conjunto de entidades obligatorio; esta decisión académica no debe interpretarse como una actividad operativa de producción o contratación de elenco.
- Cada venta se asocia con un espectador registrado.
- La unicidad de asiento se controla por función con `UNIQUE (id_funcion, asiento)`.
