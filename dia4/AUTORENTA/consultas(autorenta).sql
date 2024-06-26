use autorenta;

-- Consulta de disponibilidad de vehículos para alquiler por tipo de vehículo, rango de
-- precios de alquiler y fechas de disponibilidad.
delimiter //
create procedure disponibilidad()
begin
	select v.*
	from Vehiculo v
	left join Alquiler a on v.id_vehiculo = a.id_vehiculo
		and ((a.fecha_salida between 'fecha_inicio' and 'fecha_fin')
			or (a.fecha_llegada between 'fecha_inicio' and 'fecha_fin')
			or ('fecha_inicio' between a.fecha_salida and a.fecha_llegada)
			or ('fecha_fin' between a.fecha_salida and a.fecha_llegada))
	where v.id_vehiculo is null;
end //
delimiter ;
call disponibilidad();

  -- historial de alquileres
  delimiter //
  create procedure historia_alqui()
  begin
    select a.id_alquiler, c.nombres AS nombre_cliente, c.apellido1 AS apellido_cliente,
       e.nombre AS nombre_empleado, e.apellido1 AS apellido_empleado,
       s_salida.ciudad AS ciudad_salida, s_llegada.ciudad AS ciudad_llegada,
       v.tipo_vehiculo, v.placa, v.referencia, v.modelo, v.color,
       a.fecha_salida, a.fecha_llegada, a.fecha_esperada_llegada,
       a.valor_alquiler_semana, a.valor_alquiler_dia, a.porcentaje_descuento,
       a.valor_cotizado, a.valor_pagado
from Alquiler a
join Cliente c on a.id_cliente = c.id_cliente
join Empleado e on a.id_empleado = e.id_empleado
join Sucursal s_salida on a.id_sucursal_salida = s_salida.id_sucursal
join Sucursal s_llegada on a.id_sucursal_llegada = s_llegada.id_sucursal
join Vehiculo v on a.id_vehiculo = v.id_vehiculo
order by a.fecha_salida desc;
  end //
delimiter ;
call historia_alqui();
