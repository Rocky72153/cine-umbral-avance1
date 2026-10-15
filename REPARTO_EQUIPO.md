# Distribución del equipo según los commits de GitHub

**Proyecto:** Cine Bogotá  
**Repositorio:** [Rocky72153/cine-umbral-avance1](https://github.com/Rocky72153/cine-umbral-avance1)  
**Equipo:** cuatro integrantes  
**Criterio:** distribución reconstruida a partir de los autores, mensajes y archivos modificados en el historial de la rama `main`, revisado el 15 de octubre de 2026. Los commits permiten identificar aportes técnicos; no demuestran por sí solos quién ejecutó pruebas manuales ni quién redactó partes que no estén registradas en Git.

## Reparto observado

| Integrante / cuenta de GitHub | Aportes comprobables en el historial | Archivos o entregables relacionados |
|---|---|---|
| **Juan Sebastian Morales Forero** (`Rocky72153`) | Documentación de las reglas de operación; ajustes a la documentación del modelo ER y del modelo relacional; implementación de los procedimientos almacenados para registrar ventas, generar reportes y actualizar el estado de salas. | `avance1-postgresql/README.md`, `modelo-er/README.md`, `modelo-relacional/`, `scripts/04_procedimientos.sql`; commits de modelado y procedimientos. |
| **Jenny Alejandra Gómez López** (`AlejandraGomezL`) | Implementación y corrección de triggers para horarios de funciones y capacidad de salas; triggers de control de estado del staff y validación del correo del espectador; creación de las tres consultas de negocio y commits de evidencias de consultas y de dos triggers. | `avance1-postgresql/scripts/03_triggers.sql`, `avance1-postgresql/scripts/05_consultas.sql`, `avance1-postgresql/evidencias/`. |
| **Camila Castro Alfonso** (`milacastroa`) | Preparación de los datos de prueba; incorporación de triggers de validación en varias tablas; actualización del documento de reparto. | `avance1-postgresql/scripts/02_datos_prueba.sql`, `avance1-postgresql/scripts/03_triggers.sql`, `REPARTO_EQUIPO.md`. |
| **Integrante con cuenta `RAC0ONN`** (nombre completo por confirmar) | Creación del esquema de tablas y aportes al modelo entidad–relación y al modelo relacional, incluyendo archivos de diagramas y documentación asociada. | `avance1-postgresql/scripts/01_creacion_tablas.sql`, `avance1-postgresql/modelo-er/`, `avance1-postgresql/modelo-relacional/`. |

## Commits de referencia

Los siguientes commits ilustran los aportes anteriores. La lista es representativa, no un inventario exhaustivo.

- **Juan Sebastian Morales Forero (`Rocky72153`)**
  - [Modelado del proyecto](https://github.com/Rocky72153/cine-umbral-avance1/commit/1c1641485eccf3d12eb2e5e45f107abe45cc16b8).
  - [Procedimientos de ventas, reportes y salas](https://github.com/Rocky72153/cine-umbral-avance1/commit/93ea486e778db1b6437e2275952cdf90a944979b).
- **Jenny Alejandra Gómez López (`AlejandraGomezL`)**
  - [Corrección de triggers de función y sala](https://github.com/Rocky72153/cine-umbral-avance1/commit/0045402dbd79ff80c18ac4776c503b7e11677a18).
  - [Triggers de staff y espectador](https://github.com/Rocky72153/cine-umbral-avance1/commit/38a0a111d503c8a471a4d5b50895127670ee6903).
  - [Consultas de funciones, asientos y salas](https://github.com/Rocky72153/cine-umbral-avance1/commit/1187d40be4b975e9835b94b35c899119173de8a6).
  - [Evidencias de consultas](https://github.com/Rocky72153/cine-umbral-avance1/commit/359f5bf0d3b2d1149e1335c31361537cd4f78943).
- **Camila Castro Alfonso (`milacastroa`)**
  - [Datos de prueba](https://github.com/Rocky72153/cine-umbral-avance1/commit/29bd7f438ec70c19c90e76d0f5400c83041d1438).
  - [Triggers de validación en varias tablas](https://github.com/Rocky72153/cine-umbral-avance1/commit/c57bc86f1dee335069cd66ebe563d030da5b3ac8).
- **Amelia Camila Merchan Albarracin (`RAC0ONN`)**
  - [Creación de tablas](https://github.com/Rocky72153/cine-umbral-avance1/commit/d686950c33187429d59171c8124ffca5fe844358).
  - [Modelo entidad–relación](https://github.com/Rocky72153/cine-umbral-avance1/commit/5a2928c483340af48927d67e2146f80df8d47411).
  - [Modelo relacional](https://github.com/Rocky72153/cine-umbral-avance1/commit/7914ff4906aea885c5e754d7f2a94c8960addbd5).

## Responsabilidades para el cierre

Esta sección diferencia el trabajo ya observado de las tareas que todavía deben confirmarse o completarse. No debe interpretarse como prueba de que una tarea pendiente ya se ejecutó.

- **Juan Sebastian Morales Forero:** coordinar la integración, mantener consistente el nombre del proyecto en la documentación, y revisar los procedimientos y el informe final.
- **Jenny Alejandra Gómez López:** comprobar los triggers y las consultas en PostgreSQL, guardar evidencias reproducibles y documentar las reglas de negocio.
- **Camila Castro Alfonso:** verificar las cantidades y coherencia de los datos de prueba, probar los triggers aportados y documentar los resultados.
- **Amelia Camila Merchan Albarracin (`RAC0ONN`):** revisar las tablas y diagramas, y verificar que el modelo y el SQL coincidan.

## Lista de control de entrega

- [ ] Confirmar que el nombre de portada se escriba exactamente como lo exige la universidad: Amelia Camila Merchan Albarracin.
- [ ] Verificar que cada integrante tenga al menos un commit significativo hecho desde su propia cuenta.
- [ ] Ejecutar los cinco scripts en PostgreSQL y guardar capturas reales de los resultados.
- [ ] Incluir en el PDF la portada con **Cine Bogotá**, los cuatro nombres completos, la fecha y el tamaño del grupo.
- [ ] Explicar cada trigger, procedimiento y consulta con su regla o propósito de negocio.
- [ ] Incorporar el PDF final al repositorio o confirmar el mecanismo de entrega indicado por el curso.
