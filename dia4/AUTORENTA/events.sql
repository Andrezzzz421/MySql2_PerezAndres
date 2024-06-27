use autorenta;

-- Trigger para asiganar la sucursal de manera automatica a los empleado que se vayan agregando
-- este trigger se usa con el procedimiento para ingresar un nuevo empleado ver(permisos_para_roles)
delimiter //
create trigger before_insert_empleado
before insert on Empleado
for each row
begin
    declare total_sucursales int;
    declare new_sucursal int;

    -- Obtener el número total de sucursales disponibles
    select COUNT(*) into total_sucursales from Sucursal;

    -- Generar un número aleatorio entre 1 y total_sucursales
    set new_sucursal = FLOOR(1 + RAND() * total_sucursales);

    -- Asignar la sucursal al nuevo empleado
    set new.id_sucursal = new_sucursal;
end //
delimiter ;


-- Esperar unos minutos para que el evento se ejecute y actualice el id_sucursal
select * from Empleado;
delete from Empleado
where cedula = '9876543210';
-- Evento para Limpiar Alquileres Antiguos:
delimiter //
create event limpiar_alquileres_antiguos
on schedule every 1 day
do
begin
    delete from Alquiler
    where fecha_llegada < DATE_SUB(CURDATE(), interval 5 year);
end //
DELIMITER ;

alter event limpiar_alquileres_antiguos
on schedule every 1 minute;

-- Esperar un par de minutos y luego verificar si los registros antiguos se han eliminado
select * from Alquiler where fecha_llegada < DATE_SUB(CURDATE(), interval 5 year);
show events;
show triggers;
