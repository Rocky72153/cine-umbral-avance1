# Modelo relacional — Cine Bogotá

**Motor previsto:** PostgreSQL.  
**Alcance:** ocho entidades base, las ampliaciones Pelicula y Boleta, catálogos normalizados y una tabla asociativa.

## Convenciones

- **PK:** clave primaria.
- **FK:** clave foránea almacenada en la tabla del lado muchos.
- **UNIQUE:** valor o combinación de valores que no se debe repetir.
- **Obligatoriedad:** toda Venta debe tener un id_staff; cada operación de boletería la registra un empleado.
- Los nombres de tablas se escriben en singular en este modelo.

## Entidades base y ampliaciones

### Actor_Director

- **PK:** id_actor_director.
- **Atributos:** primer_nombre, segundo_nombre, primer_apellido, segundo_apellido, rol, nacionalidad.
- **Regla:** rol identifica la participación como actor, director o ambas. La relación con Pelicula es muchos a muchos y se resuelve mediante Actor_Director_Pelicula.

### Contrato

- **PK:** id_contrato.
- **FK:** id_staff → Staff; id_tipo_contrato → Tipo_Contrato.
- **Atributos:** fecha_inicio, salario.
- **Regla:** registra el contrato laboral de una persona del staff. No se vincula con Actor_Director ni con Pelicula.

### Sala

- **PK:** id_sala.
- **FK:** id_estado_sala → Estado_Sala; id_tipo_sala → Tipo_Sala.
- **Atributo:** capacidad.
- **Reglas:** la capacidad debe ser mayor que cero; el estado y tipo se obtienen de sus catálogos.

### Funcion

- **PK:** id_funcion.
- **FK:** id_pelicula → Pelicula; id_sala → Sala.
- **Atributos:** fecha, hora_inicio, hora_fin.
- **Reglas:** la hora final debe ser posterior a la inicial. Las funciones de una misma sala no deben traslaparse.

### Tipo_Boleta

- **PK:** id_tipo_boleta.
- **Atributo:** nombre.
- **Regla:** mantiene las categorías disponibles, por ejemplo general o preferencial. Cada boleta referencia un tipo.

### Venta

- **PK:** id_venta.
- **FK:** id_staff → Staff (obligatoria); id_funcion → Funcion; id_espectador → Espectador; id_metodo_pago → Metodo_Pago_Venta.
- **Atributos:** fecha TIMESTAMP, monto_total DECIMAL(10,2).
- **Regla:** una venta pertenece a un espectador y a una función. id_staff es obligatorio; Cine no admite ventas sin registro por parte del staff. El procedimiento calcula monto_total sumando los precios redondeados de las boletas y lo guarda junto con el encabezado. Cualquier operación posterior que modifique boletas debe mantener sincronizado ese resumen.

### Espectador

- **PK:** id_espectador.
- **FK:** id_tipo_documento → Tipo_Documento.
- **Atributos:** primer_nombre, segundo_nombre, primer_apellido, segundo_apellido, numero_documento, correo.
- **Regla:** la combinación de tipo y número de documento identifica de manera única al espectador.

### Staff

- **PK:** id_staff.
- **FK:** id_cargo_staff → Cargo_Staff; id_estado_staff → Estado_Staff; id_tipo_documento → Tipo_Documento.
- **Atributos:** primer_nombre, segundo_nombre, primer_apellido, segundo_apellido, numero_documento, correo.
- **Regla:** la combinación de tipo y número de documento identifica de manera única al empleado. El nombre de tipo de documento se obtiene del catálogo y no se repite como atributo.

### Pelicula

- **PK:** id_pelicula.
- **FK:** id_clasificacion_pelicula → Clasificacion_Pelicula.
- **Atributos:** titulo, duracion, anio, pais_origen.
- **Regla:** una película puede tener muchas funciones y la función referencia una sola película.

### Boleta

- **PK:** id_boleta.
- **FK:** id_venta → Venta; id_tipo_boleta → Tipo_Boleta.
- **Atributos:** precio, numero_asiento.
- **Regla:** representa una unidad vendida y un asiento concreto. El precio conserva el valor cobrado para esa boleta.

## Catálogos y tabla asociativa

Tipo_Boleta es una de las ocho entidades base y se mantiene como catálogo con clave primaria id_tipo_boleta y atributo nombre. Los ocho catálogos complementarios tienen cada uno una clave primaria id y un atributo nombre:

- **Cargo_Staff:** clasifica cargos del personal.
- **Estado_Staff:** estados posibles del personal.
- **Tipo_Documento:** tipos de identificación.
- **Metodo_Pago_Venta:** medios de pago.
- **Tipo_Contrato:** modalidades de contrato laboral.
- **Clasificacion_Pelicula:** clasificación de las películas.
- **Tipo_Sala:** tipos de sala.
- **Estado_Sala:** estados operativos de las salas.

**Actor_Director_Pelicula** resuelve la relación muchos a muchos entre Actor_Director y Pelicula. Su clave primaria compuesta está formada por id_actor_director e id_pelicula; ambas columnas son además claves foráneas.

## Relaciones y cardinalidades

| Relación | Cardinalidad |
|---|---|
| Staff — Contrato | Un staff puede tener varios contratos; cada contrato corresponde a un staff. |
| Tipo_Contrato — Contrato | Un tipo puede clasificar varios contratos; cada contrato tiene un tipo. |
| Staff — Venta | Un staff puede registrar varias ventas; cada venta tiene un staff. |
| Espectador — Venta | Un espectador puede realizar varias ventas; cada venta corresponde a un espectador. |
| Funcion — Venta | Una función puede aparecer en varias ventas; cada venta corresponde a una función. |
| Venta — Boleta | Una venta contiene una o varias boletas; cada boleta pertenece a una venta. |
| Tipo_Boleta — Boleta | Un tipo puede clasificar varias boletas; cada boleta tiene un tipo. |
| Pelicula — Funcion | Una película puede presentarse en varias funciones; cada función presenta una película. |
| Sala — Funcion | Una sala puede alojar varias funciones; cada función se realiza en una sala. |
| Actor_Director — Pelicula | Relación muchos a muchos resuelta por Actor_Director_Pelicula. |

Los catálogos restantes tienen una relación uno a muchos con su tabla de uso: Cargo_Staff con Staff, Estado_Staff con Staff, Tipo_Documento con Staff y Espectador, Metodo_Pago_Venta con Venta, Clasificacion_Pelicula con Pelicula, y Tipo_Sala y Estado_Sala con Sala.

## Parámetros de operación

- Cine Bogotá opera una sede con 20 salas y 100 puestos por sala, para una capacidad de 2.000 personas. La carga de datos debe reflejar estas cantidades.
- Tipo_Sala identifica la modalidad disponible en cada sala (digital, 3D o 4D), de acuerdo con el inventario del cine.
- El conjunto de prueba registra 30 actores/directores.

## Reglas de integridad del negocio

- No se repite el número de documento para el mismo tipo de documento en Staff ni en Espectador.
- Una boleta no puede vender un asiento ya vendido para la misma función. Como Funcion se obtiene desde Venta y no se duplica en Boleta, esta regla requiere una validación transaccional que compare la función y el asiento de las boletas existentes.
- El precio de una boleta, el salario y la capacidad no pueden ser negativos; la capacidad debe ser mayor que cero.
- Las funciones de una sala no deben traslaparse.
- Las claves foráneas impiden registrar ventas, contratos, funciones o boletas con referencias inexistentes.

El enfoque de programación del sistema se establece como Programación Orientada a Objetos (POO); es un criterio de desarrollo de software y no altera las entidades ni las relaciones del modelo de datos.

## Justificación de tercera forma normal

1. **Primera forma normal (1FN):** los nombres se separan en campos atómicos y cada fila de Boleta contiene un solo asiento.
2. **Segunda forma normal (2FN):** las tablas con clave simple dependen de su clave completa. En la tabla asociativa, la clave es la pareja de identificadores y no se almacenan atributos que dependan solo de uno de ellos.
3. **Tercera forma normal (3FN):** los datos descriptivos se mantienen en sus catálogos. Staff y Espectador guardan la FK del tipo de documento, no el nombre del tipo. Los cargos, estados, métodos de pago, clasificaciones y tipos se consultan desde sus tablas.
4. **Resumen transaccional:** el esquema actual persiste Venta.monto_total. El procedimiento lo calcula a partir de los precios de Boleta en la misma llamada; las operaciones posteriores sobre el detalle deben mantener el valor sincronizado.
5. **Historial:** el precio aplicado se conserva en Boleta para mantener el valor cobrado aunque cambie la definición o tarifa del tipo de boleta.
