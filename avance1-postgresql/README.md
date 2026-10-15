# Avance 1 — Cine Bogotá

## Identidad de la empresa

- **Nombre:** Cine Bogotá.
- **Enfoque de programación del sistema:** Programación Orientada a Objetos (POO).
- **Ciudad:** Bogotá, Colombia.
- **Modalidad de operación:** una sede con proyección digital y formatos 3D y 4D; las ventas de boletería son registradas exclusivamente por el staff.
- **Capacidad estimada:** 2.000 espectadores en 20 salas de 100 puestos cada una.
- **Actores/directores registrados:** 30.
- **Particularidades del negocio:** Cine Bogotá fue fundada en Bogotá, Colombia, y cuenta con 50 años de trayectoria. Opera una única sede con 20 salas, cada una con capacidad para 100 personas. Ofrece proyección digital, 3D y 4D, y programa múltiples funciones para las películas en cartelera. Cada venta corresponde a un espectador y una función, contiene una o varias boletas individuales y debe ser registrada por un integrante del staff.
- **Logo:** [logotipo SVG](branding/logo-cine-bogota.svg) · [identidad visual](branding/README.md).

## Alcance del modelo

Se parte de las ocho entidades solicitadas y se amplía el modelo con **Pelicula** y **Boleta** para representar la programación y los asientos vendidos. **Tipo_Boleta** se conserva como catálogo independiente en el modelo relacional normalizado. También se incluyen catálogos y una tabla asociativa que permiten mantener los datos descriptivos y la relación muchos a muchos sin duplicarlos.

## Estructura del avance

- `modelo-er/`: diagrama entidad–relación.
- `modelo-relacional/`: modelo relacional en 3FN y documentación de claves y reglas.
- `scripts/`: scripts SQL del avance (01 a 05).
- `evidencias/`: capturas de la ejecución real de los scripts.
