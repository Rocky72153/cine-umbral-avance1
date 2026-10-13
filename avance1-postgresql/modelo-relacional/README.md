# Modelo relacional en tercera forma normal · Cine Umbral

El diagrama presenta las ocho tablas, sus atributos, claves primarias, claves foráneas y restricciones únicas. La documentación complementaria especifica tipos previstos para PostgreSQL, reglas de integridad y la justificación de 3FN.

Las relaciones usan pata de gallo: círculo para opcionalidad, barra para obligatoriedad y bifurcación para muchos. Las claves foráneas están en la tabla del lado N.

![Diagrama del modelo relacional 3FN de Cine Umbral](modelo-relacional-3fn.svg)

- [Abrir el diagrama SVG](modelo-relacional-3fn.svg)
- [Editar la fuente en draw.io](modelo-relacional-3fn.drawio)
- [Consultar relaciones, restricciones y justificación 3FN](modelo-relacional-3fn.md)

## Decisiones del modelo

- Se conservan exactamente las ocho entidades solicitadas en la guía.
- `FUNCIONES.tipo_funcion` distingue proyecciones regulares, cineforos y conversatorios.
- Cada fila de `CONTRATOS` vincula un talento con una función. La clave única `(id_talento, id_funcion)` evita duplicar la misma participación; una función puede tener varios contratos para sus invitados.
- `VENTAS` representa una boleta y un asiento para una función; `precio_pagado` conserva el importe histórico cobrado.
- `VENTAS.id_staff` es opcional para permitir ventas digitales.
- `FUNCIONES` conserva el título de la obra porque el alcance exigido no incluye una tabla `PELICULAS`.
