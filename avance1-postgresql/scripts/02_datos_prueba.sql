BEGIN;

INSERT INTO Cargo_Staff (id_cargo_staff, nombre) VALUES
(1, 'Taquillero'), (2, 'Supervisor'), (3, 'Administrador');

INSERT INTO Estado_Staff (id_estado_staff, nombre) VALUES
(1, 'Activo'), (2, 'Inactivo');

INSERT INTO Tipo_Contrato (id_tipo_contrato, nombre) VALUES
(1, 'Indefinido'), (2, 'Término fijo'), (3, 'Temporal');

INSERT INTO Tipo_Documento (id_tipo_documento, nombre) VALUES
(1, 'Cédula de ciudadanía'), (2, 'Cédula de extranjería'), (3, 'Pasaporte');

INSERT INTO Metodo_Pago_Venta (id_metodo_pago, nombre) VALUES
(1, 'Efectivo'), (2, 'Tarjeta débito'), (3, 'Tarjeta crédito'), (4, 'Transferencia');

INSERT INTO Tipo_Boleta (id_tipo_boleta, nombre) VALUES
(1, 'General'), (2, 'Niño'), (3, 'Adulto mayor'), (4, 'Preferencial');

INSERT INTO Clasificacion_Pelicula (id_clasificacion_pelicula, nombre) VALUES
(1, 'Todo público'), (2, 'Mayores de 7 años'), (3, 'Mayores de 12 años'),
(4, 'Mayores de 15 años'), (5, 'Mayores de 18 años');

INSERT INTO Tipo_Sala (id_tipo_sala, nombre) VALUES
(1, 'Digital'), (2, '3D'), (3, '4D');

INSERT INTO Estado_Sala (id_estado_sala, nombre) VALUES
(1, 'Disponible'), (2, 'Mantenimiento'), (3, 'Fuera de servicio');

INSERT INTO Staff
(id_staff, id_cargo_staff, id_estado_staff, id_tipo_documento, primer_nombre, segundo_nombre, primer_apellido, segundo_apellido, numero_documento, correo)
VALUES
(1, 3, 1, 1, 'Laura', 'Marcela', 'Gómez', 'Ruiz', '100100001', 'laura.gomez@cineplus.co'),
(2, 2, 1, 1, 'Andrés', NULL, 'Martínez', 'López', '100100002', 'andres.martinez@cineplus.co'),
(3, 1, 1, 1, 'Daniela', 'Sofía', 'Rodríguez', 'Pérez', '100100003', 'daniela.rodriguez@cineplus.co'),
(4, 1, 1, 1, 'Juan', 'David', 'Hernández', 'Díaz', '100100004', 'juan.hernandez@cineplus.co'),
(5, 1, 1, 1, 'Valentina', NULL, 'Torres', 'Castro', '100100005', 'valentina.torres@cineplus.co');

INSERT INTO Contrato (id_contrato, id_staff, id_tipo_contrato, fecha_inicio, salario) VALUES
(1, 1, 1, '2022-02-01', 4200000.00),
(2, 2, 1, '2023-05-15', 3200000.00),
(3, 3, 2, '2025-01-10', 1900000.00),
(4, 4, 2, '2025-06-01', 1900000.00),
(5, 5, 3, '2026-01-15', 1850000.00);


INSERT INTO Actor_Director (id_actor_director, primer_nombre, segundo_nombre, primer_apellido, segundo_apellido, rol, nacionalidad, correo) VALUES
(1, 'Sofía', 'Isabel', 'Ramírez', 'Vargas', 'Actor', 'Colombia', 'sofia.ramirez@example.com'),
(2, 'Mateo', NULL, 'Cárdenas', 'Ruiz', 'Actor', 'Colombia', 'mateo.cardenas@example.com'),
(3, 'Valeria', 'Lucía', 'Moreno', 'Gil', 'Director', 'Colombia', 'valeria.moreno@example.com'),
(4, 'Samuel', NULL, 'Herrera', 'Castro', 'Actor', 'México', 'samuel.herrera@example.com'),
(5, 'Isabella', 'María', 'Rojas', 'Pineda', 'Actor', 'Colombia', 'isabella.rojas@example.com'),
(6, 'Daniel', NULL, 'Navarro', 'León', 'Director', 'España', 'daniel.navarro@example.com'),
(7, 'Mariana', 'Paola', 'Silva', 'Mendoza', 'Actor', 'Argentina', 'mariana.silva@example.com'),
(8, 'Sebastián', NULL, 'Ortega', 'Cruz', 'Actor', 'Colombia', 'sebastian.ortega@example.com'),
(9, 'Camila', 'Andrea', 'Vega', 'Salazar', 'Director', 'Chile', 'camila.vega@example.com'),
(10, 'Nicolás', NULL, 'Molina', 'Reyes', 'Actor', 'México', 'nicolas.molina@example.com'),
(11, 'Gabriela', 'Elena', 'Castillo', 'Lara', 'Actor', 'Colombia', 'gabriela.castillo@example.com'),
(12, 'Tomás', NULL, 'Aguilar', 'Soto', 'Director', 'España', 'tomas.aguilar@example.com'),
(13, 'Luciana', 'Isabel', 'Peña', 'Acosta', 'Actor', 'Colombia', 'luciana.pena@example.com'),
(14, 'Emiliano', NULL, 'Navarrete', 'Ríos', 'Actor', 'México', 'emiliano.navarrete@example.com'),
(15, 'Julieta', 'Fernanda', 'Campos', 'Mejía', 'Director', 'Argentina', 'julieta.campos@example.com'),
(16, 'Thiago', NULL, 'Fuentes', 'Romero', 'Actor', 'Chile', 'thiago.fuentes@example.com'),
(17, 'Antonella', 'María', 'Pardo', 'Luna', 'Actor', 'Colombia', 'antonella.pardo@example.com'),
(18, 'Gabriel', NULL, 'Méndez', 'Ibarra', 'Director', 'México', 'gabriel.mendez@example.com'),
(19, 'Manuela', 'Sofía', 'Cortés', 'Núñez', 'Actor', 'Colombia', 'manuela.cortes@example.com'),
(20, 'Alejandro', NULL, 'Reyes', 'Montoya', 'Actor', 'España', 'alejandro.reyes@example.com'),
(21, 'Renata', 'Isabel', 'Duarte', 'Vidal', 'Director', 'Argentina', 'renata.duarte@example.com'),
(22, 'Benjamín', NULL, 'Ocampo', 'Prieto', 'Actor', 'Colombia', 'benjamin.ocampo@example.com'),
(23, 'Paula', 'Andrea', 'Londoño', 'Cañas', 'Actor', 'Colombia', 'paula.londono@example.com'),
(24, 'Joaquín', NULL, 'Salinas', 'Bravo', 'Director', 'Chile', 'joaquin.salinas@example.com'),
(25, 'Mía', 'Valentina', 'Cabrera', 'Roldán', 'Actor', 'México', 'mia.cabrera@example.com'),
(26, 'Esteban', NULL, 'Correa', 'Mora', 'Actor', 'Colombia', 'esteban.correa@example.com'),
(27, 'Abril', 'Lucía', 'Serrano', 'Paz', 'Director', 'España', 'abril.serrano@example.com'),
(28, 'Maximiliano', NULL, 'Patiño', 'Arias', 'Actor', 'Colombia', 'maximiliano.patino@example.com'),
(29, 'Elisa', 'María', 'Bustos', 'Quintero', 'Actor', 'Argentina', 'elisa.bustos@example.com'),
(30, 'Franco', NULL, 'Beltrán', 'Suárez', 'Director', 'Colombia', 'franco.beltran@example.com');

INSERT INTO Espectador (id_espectador, id_tipo_documento, primer_nombre, segundo_nombre, primer_apellido, segundo_apellido, numero_documento, correo) VALUES
(1, 1, 'Ana', 'María', 'García', 'López', '200200001', 'espectador01@example.com'),
(2, 1, 'Carlos', NULL, 'Pérez', 'Ramírez', '200200002', 'espectador02@example.com'),
(3, 1, 'Luisa', 'Fernanda', 'Martínez', 'Díaz', '200200003', 'espectador03@example.com'),
(4, 1, 'Andrés', NULL, 'Rodríguez', 'Gómez', '200200004', 'espectador04@example.com'),
(5, 1, 'Natalia', 'Sofía', 'López', 'Castro', '200200005', 'espectador05@example.com'),
(6, 1, 'Felipe', NULL, 'Hernández', 'Ruiz', '200200006', 'espectador06@example.com'),
(7, 1, 'Sara', 'Isabel', 'Torres', 'Moreno', '200200007', 'espectador07@example.com'),
(8, 2, 'David', NULL, 'Vargas', 'Rojas', '200200008', 'espectador08@example.com'),
(9, 1, 'Manuela', 'Alejandra', 'Jiménez', 'Pardo', '200200009', 'espectador09@example.com'),
(10, 1, 'Miguel', NULL, 'Castillo', 'Reyes', '200200010', 'espectador10@example.com'),
(11, 1, 'Juliana', 'Paola', 'Cruz', 'Mendoza', '200200011', 'espectador11@example.com'),
(12, 1, 'Santiago', NULL, 'Ortiz', 'Vega', '200200012', 'espectador12@example.com'),
(13, 1, 'Gabriela', 'Lucía', 'Suárez', 'Herrera', '200200013', 'espectador13@example.com'),
(14, 1, 'Juan', NULL, 'Romero', 'Silva', '200200014', 'espectador14@example.com'),
(15, 1, 'Mariana', 'Isabel', 'Navarro', 'León', '200200015', 'espectador15@example.com'),
(16, 2, 'Nicolás', NULL, 'Mora', 'Acosta', '200200016', 'espectador16@example.com'),
(17, 1, 'Valentina', 'Andrea', 'Ríos', 'Peña', '200200017', 'espectador17@example.com'),
(18, 1, 'Samuel', NULL, 'Cárdenas', 'Ocampo', '200200018', 'espectador18@example.com'),
(19, 1, 'Isabella', 'Sofía', 'Mejía', 'Fuentes', '200200019', 'espectador19@example.com'),
(20, 1, 'Tomás', NULL, 'Salazar', 'Duarte', '200200020', 'espectador20@example.com'),
(21, 1, 'Camila', 'Fernanda', 'Prieto', 'Cortés', '200200021', 'espectador21@example.com'),
(22, 1, 'Emilio', NULL, 'Pineda', 'Aguilar', '200200022', 'espectador22@example.com'),
(23, 1, 'Daniela', 'María', 'Molina', 'Campos', '200200023', 'espectador23@example.com'),
(24, 2, 'Sebastián', NULL, 'Luna', 'Cabrera', '200200024', 'espectador24@example.com'),
(25, 1, 'Paula', 'Andrea', 'Arias', 'Serrano', '200200025', 'espectador25@example.com'),
(26, 1, 'Mateo', NULL, 'Vidal', 'Correa', '200200026', 'espectador26@example.com'),
(27, 1, 'Antonella', 'Isabel', 'Quintero', 'Bustos', '200200027', 'espectador27@example.com'),
(28, 1, 'Joaquín', NULL, 'Beltrán', 'Patiño', '200200028', 'espectador28@example.com'),
(29, 1, 'Renata', 'Lucía', 'Montoya', 'Soto', '200200029', 'espectador29@example.com'),
(30, 1, 'Esteban', NULL, 'Núñez', 'Navarrete', '200200030', 'espectador30@example.com');

INSERT INTO Pelicula (id_pelicula, id_clasificacion_pelicula, titulo, duracion, anio, pais_origen) VALUES
(1, 1, 'La ciudad de los sueños', 110, 2022, 'Colombia'),
(2, 3, 'Misión en la montaña', 125, 2021, 'Estados Unidos'),
(3, 2, 'El último viaje', 98, 2020, 'España'),
(4, 1, 'Planeta azul', 105, 2024, 'Reino Unido'),
(5, 4, 'La casa del bosque', 115, 2023, 'México'),
(6, 3, 'Código secreto', 130, 2025, 'Colombia'),
(7, 1, 'Amigos para siempre', 95, 2019, 'Argentina'),
(8, 2, 'La órbita perdida', 122, 2026, 'Canadá'),
(9, 5, 'Sombras de medianoche', 108, 2022, 'Chile'),
(10, 3, 'Aventura en el tiempo', 118, 2024, 'Colombia');

INSERT INTO Actor_Director_Pelicula (id_actor_director, id_pelicula) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10),
(11, 1),
(12, 2),
(13, 3),
(14, 4),
(15, 5),
(16, 6),
(17, 7),
(18, 8),
(19, 9),
(20, 10),
(21, 1),
(22, 2),
(23, 3),
(24, 4),
(25, 5),
(26, 6),
(27, 7),
(28, 8),
(29, 9),
(30, 10);
INSERT INTO Sala (id_sala, id_estado_sala, id_tipo_sala, capacidad) VALUES
(1, 1, 1, 100),
(2, 1, 1, 100),
(3, 1, 1, 100),
(4, 1, 1, 100),
(5, 1, 1, 100),
(6, 1, 1, 100),
(7, 1, 1, 100),
(8, 1, 1, 100),
(9, 1, 1, 100),
(10, 1, 1, 100),
(11, 1, 2, 100),
(12, 1, 2, 100),
(13, 1, 2, 100),
(14, 1, 2, 100),
(15, 1, 2, 100),
(16, 1, 2, 100),
(17, 1, 3, 100),
(18, 1, 3, 100),
(19, 1, 3, 100),
(20, 1, 3, 100);

INSERT INTO Funcion (id_funcion, id_pelicula, id_sala, fecha, hora_inicio, hora_fin) VALUES
(1, 1, 1, '2026-10-16', '10:00:00', '12:00:00'),
(2, 2, 2, '2026-10-16', '13:00:00', '15:00:00'),
(3, 3, 3, '2026-10-16', '16:00:00', '18:00:00'),
(4, 4, 4, '2026-10-16', '19:00:00', '21:00:00'),
(5, 5, 5, '2026-10-16', '10:00:00', '12:00:00'),
(6, 6, 6, '2026-10-16', '13:00:00', '15:00:00'),
(7, 7, 7, '2026-10-16', '16:00:00', '18:00:00'),
(8, 8, 8, '2026-10-16', '19:00:00', '21:00:00'),
(9, 9, 9, '2026-10-16', '10:00:00', '12:00:00'),
(10, 10, 10, '2026-10-16', '13:00:00', '15:00:00'),
(11, 1, 11, '2026-10-17', '10:00:00', '12:00:00'),
(12, 2, 12, '2026-10-17', '13:00:00', '15:00:00'),
(13, 3, 13, '2026-10-17', '16:00:00', '18:00:00'),
(14, 4, 14, '2026-10-17', '19:00:00', '21:00:00'),
(15, 5, 15, '2026-10-17', '10:00:00', '12:00:00'),
(16, 6, 16, '2026-10-17', '13:00:00', '15:00:00'),
(17, 7, 17, '2026-10-17', '16:00:00', '18:00:00'),
(18, 8, 18, '2026-10-17', '19:00:00', '21:00:00'),
(19, 9, 19, '2026-10-17', '10:00:00', '12:00:00'),
(20, 10, 20, '2026-10-17', '13:00:00', '15:00:00'),
(21, 1, 1, '2026-10-18', '10:00:00', '12:00:00'),
(22, 2, 2, '2026-10-18', '13:00:00', '15:00:00'),
(23, 3, 3, '2026-10-18', '16:00:00', '18:00:00'),
(24, 4, 4, '2026-10-18', '19:00:00', '21:00:00'),
(25, 5, 5, '2026-10-18', '10:00:00', '12:00:00'),
(26, 6, 6, '2026-10-18', '13:00:00', '15:00:00'),
(27, 7, 7, '2026-10-18', '16:00:00', '18:00:00'),
(28, 8, 8, '2026-10-18', '19:00:00', '21:00:00'),
(29, 9, 9, '2026-10-18', '10:00:00', '12:00:00'),
(30, 10, 10, '2026-10-18', '13:00:00', '15:00:00');

INSERT INTO Venta (id_venta, id_staff, id_funcion, id_espectador, id_metodo_pago, monto_total, fecha) VALUES
(1, 1, 1, 1, 1, 18000.00, '2026-10-14 10:00:00'),
(2, 2, 2, 2, 2, 14000.00, '2026-10-14 10:20:00'),
(3, 3, 3, 3, 3, 12000.00, '2026-10-14 10:40:00'),
(4, 4, 4, 4, 4, 25000.00, '2026-10-14 11:00:00'),
(5, 5, 5, 5, 1, 18000.00, '2026-10-14 11:20:00'),
(6, 1, 6, 6, 2, 14000.00, '2026-10-14 11:40:00'),
(7, 2, 7, 7, 3, 12000.00, '2026-10-14 12:00:00'),
(8, 3, 8, 8, 4, 25000.00, '2026-10-14 12:20:00'),
(9, 4, 9, 9, 1, 18000.00, '2026-10-14 12:40:00'),
(10, 5, 10, 10, 2, 14000.00, '2026-10-14 13:00:00'),
(11, 1, 11, 11, 3, 12000.00, '2026-10-14 13:20:00'),
(12, 2, 12, 12, 4, 25000.00, '2026-10-14 13:40:00'),
(13, 3, 13, 13, 1, 18000.00, '2026-10-14 14:00:00'),
(14, 4, 14, 14, 2, 14000.00, '2026-10-14 14:20:00'),
(15, 5, 15, 15, 3, 12000.00, '2026-10-14 14:40:00'),
(16, 1, 16, 16, 4, 25000.00, '2026-10-14 15:00:00'),
(17, 2, 17, 17, 1, 18000.00, '2026-10-14 15:20:00'),
(18, 3, 18, 18, 2, 14000.00, '2026-10-14 15:40:00'),
(19, 4, 19, 19, 3, 12000.00, '2026-10-14 16:00:00'),
(20, 5, 20, 20, 4, 25000.00, '2026-10-14 16:20:00'),
(21, 1, 21, 21, 1, 18000.00, '2026-10-14 16:40:00'),
(22, 2, 22, 22, 2, 14000.00, '2026-10-14 17:00:00'),
(23, 3, 23, 23, 3, 12000.00, '2026-10-14 17:20:00'),
(24, 4, 24, 24, 4, 25000.00, '2026-10-14 17:40:00'),
(25, 5, 25, 25, 1, 18000.00, '2026-10-14 18:00:00'),
(26, 1, 26, 26, 2, 14000.00, '2026-10-14 18:20:00'),
(27, 2, 27, 27, 3, 12000.00, '2026-10-14 18:40:00'),
(28, 3, 28, 28, 4, 25000.00, '2026-10-14 19:00:00'),
(29, 4, 29, 29, 1, 18000.00, '2026-10-14 19:20:00'),
(30, 5, 30, 30, 2, 14000.00, '2026-10-14 19:40:00');

INSERT INTO Boleta (id_boleta, id_venta, id_tipo_boleta, precio, numero_asiento) VALUES
(1, 1, 1, 18000.00, 'A01'),
(2, 2, 2, 14000.00, 'B01'),
(3, 3, 3, 12000.00, 'C01'),
(4, 4, 4, 25000.00, 'D01'),
(5, 5, 1, 18000.00, 'E01'),
(6, 6, 2, 14000.00, 'F01'),
(7, 7, 3, 12000.00, 'G01'),
(8, 8, 4, 25000.00, 'H01'),
(9, 9, 1, 18000.00, 'I01'),
(10, 10, 2, 14000.00, 'J01'),
(11, 11, 3, 12000.00, 'A02'),
(12, 12, 4, 25000.00, 'B02'),
(13, 13, 1, 18000.00, 'C02'),
(14, 14, 2, 14000.00, 'D02'),
(15, 15, 3, 12000.00, 'E02'),
(16, 16, 4, 25000.00, 'F02'),
(17, 17, 1, 18000.00, 'G02'),
(18, 18, 2, 14000.00, 'H02'),
(19, 19, 3, 12000.00, 'I02'),
(20, 20, 4, 25000.00, 'J02'),
(21, 21, 1, 18000.00, 'A03'),
(22, 22, 2, 14000.00, 'B03'),
(23, 23, 3, 12000.00, 'C03'),
(24, 24, 4, 25000.00, 'D03'),
(25, 25, 1, 18000.00, 'E03'),
(26, 26, 2, 14000.00, 'F03'),
(27, 27, 3, 12000.00, 'G03'),
(28, 28, 4, 25000.00, 'H03'),
(29, 29, 1, 18000.00, 'I03'),
(30, 30, 2, 14000.00, 'J03');

SELECT setval(pg_get_serial_sequence('cargo_staff', 'id_cargo_staff'), COALESCE((SELECT MAX(id_cargo_staff) FROM cargo_staff), 1), true);
SELECT setval(pg_get_serial_sequence('estado_staff', 'id_estado_staff'), COALESCE((SELECT MAX(id_estado_staff) FROM estado_staff), 1), true);
SELECT setval(pg_get_serial_sequence('tipo_contrato', 'id_tipo_contrato'), COALESCE((SELECT MAX(id_tipo_contrato) FROM tipo_contrato), 1), true);
SELECT setval(pg_get_serial_sequence('tipo_documento', 'id_tipo_documento'), COALESCE((SELECT MAX(id_tipo_documento) FROM tipo_documento), 1), true);
SELECT setval(pg_get_serial_sequence('metodo_pago_venta', 'id_metodo_pago'), COALESCE((SELECT MAX(id_metodo_pago) FROM metodo_pago_venta), 1), true);
SELECT setval(pg_get_serial_sequence('tipo_boleta', 'id_tipo_boleta'), COALESCE((SELECT MAX(id_tipo_boleta) FROM tipo_boleta), 1), true);
SELECT setval(pg_get_serial_sequence('clasificacion_pelicula', 'id_clasificacion_pelicula'), COALESCE((SELECT MAX(id_clasificacion_pelicula) FROM clasificacion_pelicula), 1), true);
SELECT setval(pg_get_serial_sequence('tipo_sala', 'id_tipo_sala'), COALESCE((SELECT MAX(id_tipo_sala) FROM tipo_sala), 1), true);
SELECT setval(pg_get_serial_sequence('estado_sala', 'id_estado_sala'), COALESCE((SELECT MAX(id_estado_sala) FROM estado_sala), 1), true);
SELECT setval(pg_get_serial_sequence('staff', 'id_staff'), COALESCE((SELECT MAX(id_staff) FROM staff), 1), true);
SELECT setval(pg_get_serial_sequence('contrato', 'id_contrato'), COALESCE((SELECT MAX(id_contrato) FROM contrato), 1), true);
SELECT setval(pg_get_serial_sequence('espectador', 'id_espectador'), COALESCE((SELECT MAX(id_espectador) FROM espectador), 1), true);
SELECT setval(pg_get_serial_sequence('actor_director', 'id_actor_director'), COALESCE((SELECT MAX(id_actor_director) FROM actor_director), 1), true);
SELECT setval(pg_get_serial_sequence('pelicula', 'id_pelicula'), COALESCE((SELECT MAX(id_pelicula) FROM pelicula), 1), true);
SELECT setval(pg_get_serial_sequence('sala', 'id_sala'), COALESCE((SELECT MAX(id_sala) FROM sala), 1), true);
SELECT setval(pg_get_serial_sequence('funcion', 'id_funcion'), COALESCE((SELECT MAX(id_funcion) FROM funcion), 1), true);
SELECT setval(pg_get_serial_sequence('venta', 'id_venta'), COALESCE((SELECT MAX(id_venta) FROM venta), 1), true);
SELECT setval(pg_get_serial_sequence('boleta', 'id_boleta'), COALESCE((SELECT MAX(id_boleta) FROM boleta), 1), true);

COMMIT;
