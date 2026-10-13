# Avance 1 — Cine Umbral

## Identidad de la empresa

- **Nombre:** Cine Umbral.
- **Enfoque de programación:** exhibición de películas comerciales, con énfasis en estrenos, títulos de amplia distribución y temporadas de repertorio comercial.
- **Ciudad:** Bogotá, Colombia.
- **Modalidad de operación:** exhibición presencial en cuatro salas; venta en taquilla y precompra digital.
- **Capacidad estimada:** 240 espectadores, distribuidos en cuatro salas de 60 puestos.
- **Actores/directores registrados:** 30 registros iniciales previstos para el conjunto de prueba, conforme al requisito académico.
- **Particularidades del negocio:** estrenos, funciones dobladas y subtituladas, maratones de franquicias y horarios diferenciados por sala.
- **Logo:** [logotipo SVG](branding/logo-cine-umbral.svg) · [identidad visual](branding/README.md).

**Nota de alcance:** las entidades `ACTORES_DIRECTORES` y `CONTRATOS` se mantienen porque la guía exige exactamente ocho entidades. Su inclusión no cambia el enfoque operativo del cine, que se limita a exhibir películas comerciales.

## Estructura del avance

```text
avance1-postgresql/
├── branding/
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

- `branding/`: identidad visual y logotipo vectorial.
- `modelo-er/`: diagrama entidad–relación en SVG y fuente editable de draw.io.
- `modelo-relacional/`: modelo en 3FN en SVG y fuente editable de draw.io, con documentación de claves y restricciones.
- `scripts/`: archivos SQL del proyecto; su implementación corresponde a los integrantes asignados.
- `evidencias/`: destinada a capturas de la ejecución real en PostgreSQL.
