# Avance 1 — Cine Umbral

## Identidad de la empresa

- **Nombre:** Cine Umbral.
- **Enfoque de programación:** estrenos de distribución amplia, cine latinoamericano e independiente, y temporadas de repertorio. Algunas funciones pueden incluir cineforos o conversatorios.
- **Ciudad:** Bogotá, Colombia.
- **Modalidad de operación:** exhibición presencial en cuatro salas, con venta en taquilla y precompra digital.
- **Capacidad estimada:** 240 espectadores, distribuidos en cuatro salas de 60 puestos.
- **Actores/directores registrados:** 30 registros iniciales previstos para los datos de prueba.
- **Particularidades del negocio:** cada función programa una película en una sala. Actores y directores se vinculan con las películas en una relación muchos a muchos. Los contratos representan la relación laboral entre el cine y su staff. Una venta corresponde a un espectador y a una función, y puede contener varias boletas, una por asiento. La venta digital puede no tener un empleado asociado.
- **Logo:** [logotipo SVG](branding/logo-cine-umbral.svg) · [identidad visual](branding/README.md).

## Alcance del modelo

Se parte de las ocho entidades solicitadas y se amplía el modelo con **Pelicula** y **Boleta** para representar la programación y los asientos vendidos. **Tipo_Boleta** se conserva como catálogo independiente en el modelo relacional normalizado. También se incluyen catálogos y una tabla asociativa que permiten mantener los datos descriptivos y la relación muchos a muchos sin duplicarlos.

## Estructura del avance

- `branding/`: identidad visual y logotipo vectorial.
- `modelo-er/`: diagrama entidad–relación.
- `modelo-relacional/`: modelo relacional en 3FN y documentación de claves y reglas.
- `scripts/`: scripts SQL del avance (01 a 05).
- `evidencias/`: capturas de la ejecución real de los scripts.
