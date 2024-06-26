use autorenta;

-- Crear usuarios
CREATE USER 'empleado'@'localhost' IDENTIFIED BY 'empleado123';
CREATE USER 'administrador'@'localhost' IDENTIFIED BY 'administrador123';
CREATE USER 'cliente'@'localhost' IDENTIFIED BY 'cliente123';

-- Permisos para el usuario 'cliente'
GRANT EXECUTE ON FUNCTION AutoRental.historial_alquileres TO 'cliente'@'localhost';
GRANT EXECUTE ON PROCEDURE AutoRental.registrar_alquiler TO 'cliente'@'localhost';
GRANT EXECUTE ON PROCEDURE AutoRental.consultar_vehiculos TO 'cliente'@'localhost';

-- Permisos para el usuario 'empleado'
GRANT EXECUTE ON PROCEDURE AutoRental.insertar_sucursal TO 'empleado'@'localhost';
GRANT EXECUTE ON PROCEDURE AutoRental.actualizar_sucursal TO 'empleado'@'localhost';
GRANT EXECUTE ON PROCEDURE AutoRental.registrar_vehiculo TO 'empleado'@'localhost';
GRANT EXECUTE ON PROCEDURE AutoRental.actualizar_vehiculo TO 'empleado'@'localhost';
GRANT EXECUTE ON PROCEDURE AutoRental.registrar_cliente TO 'empleado'@'localhost';
GRANT EXECUTE ON PROCEDURE AutoRental.actualizar_cliente TO 'empleado'@'localhost';

-- Permisos para el usuario 'director'
GRANT EXECUTE ON PROCEDURE AutoRental.registrar_empleado TO 'director'@'localhost';
GRANT EXECUTE ON PROCEDURE AutoRental.actualizar_empleado TO 'director'@'localhost';

-- Mostrar permisos del usuario 'cliente'
SHOW GRANTS FOR 'cliente'@'localhost';
