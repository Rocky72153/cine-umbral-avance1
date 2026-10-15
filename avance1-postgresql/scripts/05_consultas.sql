--  Consulta de las funciones programadas
SELECT p.titulo,
  c.nombre AS clasificacion,
  p.duracion AS duracion_en_minutos,
  f.fecha,f.hora_inicio,f.hora_fin,s.id_sala,
  ts.nombre AS tipo_de_sala
FROM Funcion f
JOIN Pelicula p ON p.id_pelicula = f.id_pelicula
JOIN Clasificacion_Pelicula c ON c.id_clasificacion_pelicula = p.id_clasificacion_pelicula
JOIN Sala s ON s.id_sala = f.id_sala
JOIN Tipo_Sala ts ON ts.id_tipo_sala = s.id_tipo_sala
ORDER BY f.fecha, f.hora_inicio, s.id_sala;
 -- Consulta de asientos disponibles teniendo en cuenta la función
SELECT f.id_funcion,
  p.titulo,f.fecha,f.hora_inicio,s.id_sala,s.capacidad,
  COUNT(b.id_boleta) AS asientos_vendidos,
  s.capacidad - COUNT(b.id_boleta) AS asientos_disponibles
FROM Funcion f
JOIN Pelicula p ON p.id_pelicula = f.id_pelicula
JOIN Sala s ON s.id_sala = f.id_sala
LEFT JOIN Venta v ON v.id_funcion = f.id_funcion
LEFT JOIN Boleta b ON b.id_venta = v.id_venta
GROUP BY f.id_funcion, p.titulo, f.fecha, f.hora_inicio, s.id_sala, s.capacidad
ORDER BY f.fecha, f.hora_inicio;
-- Consulta de salas sin funciones (disponibles) en una fecha especifica 
SELECT s.id_sala,
  ts.nombre AS tipo_sala,
  es.nombre AS estado_sala,
  s.capacidad
FROM Sala s
JOIN Tipo_Sala ts ON ts.id_tipo_sala = s.id_tipo_sala
JOIN Estado_Sala es ON es.id_estado_sala = s.id_estado_sala
WHERE s.id_sala NOT IN (
  SELECT f.id_sala
  FROM Funcion f
  WHERE f.fecha = '2026-10-18'
)
ORDER BY s.id_sala;
