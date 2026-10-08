# Avance 1 — Cine Umbral

## Identidad de la empresa

- **Nombre:** Cine Umbral.
- **Enfoque de programación:** cine independiente y latinoamericano, cine de autor y ciclos temáticos curados.
- **Ciudad:** Bogotá, Colombia.
- **Modalidad de operación:** exhibición presencial en cuatro salas; venta en taquilla y precompra digital.
- **Capacidad estimada:** 240 espectadores, distribuidos en cuatro salas de 60 puestos.
- **Actores/directores registrados:** 30 registros iniciales contemplados para el conjunto de prueba.
- **Particularidades del negocio:** cine-foros, temporadas de cine clásico e independiente y conversatorios con realizadores locales.
- **Logo:** [logotipo SVG](branding/logo-cine-umbral.svg) · [identidad visual](branding/README.md).

## Estructura solicitada

```text
avance1-postgresql/
├── modelo-er/
├── modelo-relacional/
├── scripts/
│   ├── 01_creacion_tablas.sql
│   ├── 02_datos_prueba.sql
│   ├── 03_triggers.sql
│   ├── 04_procedimientos.sql
│   └── 05_consultas.sql
└── evidencias/
```

- `modelo-er/`: diagrama ER en SVG y fuente editable de draw.io.
- `modelo-relacional/`: modelo en 3FN en SVG y fuente editable de draw.io, con su documentación.
- `scripts/`: contiene los cinco archivos SQL con los nombres requeridos.
- `evidencias/`: destinada a capturas de la ejecución real de cada script. Las capturas se agregan una vez ejecutados los scripts en PostgreSQL.
- `branding/`: recurso complementario con el logotipo solicitado para la identidad de la empresa.
