use autorenta;

-- Consulta de disponibilidad de vehículos para alquiler por tipo de vehículo, rango de
-- precios de alquiler y fechas de disponibilidad.
SELECT v.*
FROM Vehiculo v
WHERE v.tipo_vehiculo = 'tipo_deseado'
  AND v.valor_alquiler_semana BETWEEN precio_minimo AND precio_maximo
  AND v.id_vehiculo NOT IN (
      SELECT a.id_vehiculo
      FROM Alquiler a
      WHERE (fecha_salida BETWEEN 'fecha_inicio' AND 'fecha_fin')
         OR (fecha_llegada BETWEEN 'fecha_inicio' AND 'fecha_fin')
         OR ('fecha_inicio' BETWEEN fecha_salida AND fecha_llegada)
         OR ('fecha_fin' BETWEEN fecha_salida AND fecha_llegada)
  );
  -- historial de alquileres
  SELECT a.id_alquiler, c.nombres AS nombre_cliente, c.apellido1 AS apellido_cliente,
       e.nombre AS nombre_empleado, e.apellido1 AS apellido_empleado,
       s_salida.ciudad AS ciudad_salida, s_llegada.ciudad AS ciudad_llegada,
       v.tipo_vehiculo, v.placa, v.referencia, v.modelo, v.color,
       a.fecha_salida, a.fecha_llegada, a.fecha_esperada_llegada,
       a.valor_alquiler_semana, a.valor_alquiler_dia, a.porcentaje_descuento,
       a.valor_cotizado, a.valor_pagado
FROM Alquiler a
JOIN Cliente c ON a.id_cliente = c.id_cliente
JOIN Empleado e ON a.id_empleado = e.id_empleado
JOIN Sucursal s_salida ON a.id_sucursal_salida = s_salida.id_sucursal
JOIN Sucursal s_llegada ON a.id_sucursal_llegada = s_llegada.id_sucursal
JOIN Vehiculo v ON a.id_vehiculo = v.id_vehiculo
ORDER BY a.fecha_salida DESC;


