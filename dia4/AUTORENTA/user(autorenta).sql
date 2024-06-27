use autorenta;

-- Crear usuarios
create user 'empleado'@'localhost' identified  by 'empleado123';
create user 'cliente'@'localhost' identified  by 'cliente123';

-- Permisos para el usuario 'cliente'
grant execute on function autorenta.historial_alquileres to 'cliente'@'localhost';
grant execute on procedure autorenta.registrar_alquiler to 'cliente'@'localhost';
grant execute on procedure autorenta.consultar_disponibilidad_vehiculos to 'cliente'@'localhost';

-- Permisos para el usuario 'empleado'
grant execute on procedure autorenta.insertar_sucursal to 'empleado'@'localhost';
grant execute on procedure autorenta.actualizar_sucursal to 'empleado'@'localhost';
grant execute on procedure autorenta.registrar_vehiculo to 'empleado'@'localhost';
grant execute on procedure autorenta.actualizar_vehiculo to 'empleado'@'localhost';
grant execute on procedure autorenta.registrar_empleado to 'empleado'@'localhost';
grant execute on procedure autorenta.actualizar_empleado to 'empleado'@'localhost';

-- Mostrar permisos del usuario 'cliente'
show grants for 'administrador'@'localhost';

flush privileges;
