# Avance 1 — Cine Umbral

## Identidad de la empresa

- **Nombre:** Cine Umbral.
- **Enfoque de programación:** estrenos de distribución amplia, cine latinoamericano e independiente, y temporadas de repertorio. Algunas funciones incluyen cine-foros o conversatorios con actores y directores invitados.
- **Ciudad:** Bogotá, Colombia.
- **Modalidad de operación:** exhibición presencial en cuatro salas; venta en taquilla y precompra digital.
- **Capacidad estimada:** 240 espectadores, distribuidos en cuatro salas de 60 puestos.
- **Actores/directores registrados:** 30 registros iniciales previstos para el conjunto de prueba.
- **Particularidades del negocio:** la programación distingue proyecciones regulares de actividades especiales. Cuando participa un invitado, su contrato se asocia con esa persona y con la función concreta; una función puede tener varios invitados.
- **Logo:** [logotipo SVG](branding/logo-cine-umbral.svg) · [identidad visual](branding/README.md).

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
