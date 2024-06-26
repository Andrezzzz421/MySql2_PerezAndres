use autorenta;

DELIMITER //

-- Procedimiento para registrar un alquiler
CREATE PROCEDURE registrar_alquiler(
    IN cliente_id INT, 
    IN vehiculo_id INT, 
    IN empleado_id INT, 
    IN sucursal_salida_id INT, 
    IN sucursal_llegada_id INT, 
    IN fecha_salida DATE, 
    IN fecha_llegada DATE, 
    IN fecha_esperada_llegada DATE, 
    IN valor_alquiler_semana DECIMAL(10, 2), 
    IN valor_alquiler_dia DECIMAL(10, 2), 
    IN porcentaje_descuento DECIMAL(5, 2), 
    IN valor_cotizado DECIMAL(10, 2), 
    IN valor_pagado DECIMAL(10, 2)
)
BEGIN
    INSERT INTO Alquiler (
        id_cliente, id_vehiculo, id_empleado, id_sucursal_salida, id_sucursal_llegada,
        fecha_salida, fecha_llegada, fecha_esperada_llegada, valor_alquiler_semana,
        valor_alquiler_dia, porcentaje_descuento, valor_cotizado, valor_pagado
    )
    VALUES (
        cliente_id, vehiculo_id, empleado_id, sucursal_salida_id, sucursal_llegada_id,
        fecha_salida, fecha_llegada, fecha_esperada_llegada, valor_alquiler_semana,
        valor_alquiler_dia, porcentaje_descuento, valor_cotizado, valor_pagado
    );
END //

-- Procedimiento para consultar vehículos
CREATE PROCEDURE consultar_vehiculos(
    IN tipo_vehiculo VARCHAR(50), 
    IN precio_minimo DECIMAL(10, 2), 
    IN precio_maximo DECIMAL(10, 2), 
    IN fecha_inicio DATE, 
    IN fecha_fin DATE
)
BEGIN
    SELECT v.*
    FROM Vehiculo v
    LEFT JOIN Alquiler a ON v.id_vehiculo = a.id_vehiculo
       AND ((a.fecha_salida BETWEEN fecha_inicio AND fecha_fin)
            OR (a.fecha_llegada BETWEEN fecha_inicio AND fecha_fin)
            OR (fecha_inicio BETWEEN a.fecha_salida AND a.fecha_llegada)
            OR (fecha_fin BETWEEN a.fecha_salida AND a.fecha_llegada))
    WHERE v.tipo_vehiculo = tipo_vehiculo
      AND a.id_alquiler IS NULL
      AND (v.valor_alquiler_semana BETWEEN precio_minimo AND precio_maximo
           OR v.valor_alquiler_dia BETWEEN precio_minimo AND precio_maximo);
END //

-- Función para historial de alquileres
CREATE FUNCTION historial_alquileres(cliente_id INT) 
RETURNS TEXT
BEGIN
    DECLARE resultado TEXT;
    SELECT
        GROUP_CONCAT(
            CONCAT('alquiler id: ', alq.id_alquiler,
                   ', fecha salida: ', alq.fecha_salida,
                   ', fecha llegada: ', alq.fecha_llegada,
                   ', vehículo: ', veh.placa,
                   ', empleado: ', emp.nombre,
                   ', valor cotizado: ', alq.valor_cotizado
            ) SEPARATOR '\n') INTO resultado
    FROM Alquiler alq
    JOIN Vehiculo veh ON alq.id_vehiculo = veh.id_vehiculo
    JOIN Empleado emp ON alq.id_empleado = emp.id_empleado
    WHERE alq.id_cliente = cliente_id;
    IF resultado IS NULL THEN
        SET resultado = 'no se encontraron alquileres para este cliente.';
    END IF;
    RETURN resultado;
END //

-- Procedimiento para insertar una sucursal
CREATE PROCEDURE insertar_sucursal(
    IN ciudad VARCHAR(100), 
    IN direccion VARCHAR(200), 
    IN telefono_fijo VARCHAR(20), 
    IN celular VARCHAR(20), 
    IN correo_electronico VARCHAR(100)
)
BEGIN
    INSERT INTO Sucursal (ciudad, direccion, telefono_fijo, celular, correo_electronico)
    VALUES (ciudad, direccion, telefono_fijo, celular, correo_electronico);
END //

-- Procedimiento para actualizar una sucursal
CREATE PROCEDURE actualizar_sucursal(
    IN sucursal_id INT, 
    IN ciudad VARCHAR(100), 
    IN direccion VARCHAR(200), 
    IN telefono_fijo VARCHAR(20), 
    IN celular VARCHAR(20), 
    IN correo_electronico VARCHAR(100)
)
BEGIN
    UPDATE Sucursal
    SET ciudad = ciudad, 
        direccion = direccion, 
        telefono_fijo = telefono_fijo, 
        celular = celular, 
        correo_electronico = correo_electronico
    WHERE id_sucursal = sucursal_id;
END //

-- Procedimiento para registrar un vehículo
CREATE PROCEDURE registrar_vehiculo(
    IN tipo_vehiculo VARCHAR(50), 
    IN placa VARCHAR(20), 
    IN referencia VARCHAR(100), 
    IN modelo YEAR, 
    IN puertas INT, 
    IN capacidad INT, 
    IN sunroof BOOLEAN, 
    IN motor VARCHAR(50), 
    IN color VARCHAR(50)
)
BEGIN
    INSERT INTO Vehiculo (tipo_vehiculo, placa, referencia, modelo, puertas, capacidad, sunroof, motor, color)
    VALUES (tipo_vehiculo, placa, referencia, modelo, puertas, capacidad, sunroof, motor, color);
END //

-- Procedimiento para actualizar un vehículo
CREATE PROCEDURE actualizar_vehiculo(
    IN vehiculo_id INT, 
    IN tipo_vehiculo VARCHAR(50), 
    IN placa VARCHAR(20), 
    IN referencia VARCHAR(100), 
    IN modelo YEAR, 
    IN puertas INT, 
    IN capacidad INT, 
    IN sunroof BOOLEAN, 
    IN motor VARCHAR(50), 
    IN color VARCHAR(50)
)
BEGIN
    UPDATE Vehiculo
    SET tipo_vehiculo = tipo_vehiculo, 
        placa = placa, 
        referencia = referencia, 
        modelo = modelo, 
        puertas = puertas, 
        capacidad = capacidad, 
        sunroof = sunroof, 
        motor = motor, 
        color = color
    WHERE id_vehiculo = vehiculo_id;
END //

-- Procedimiento para registrar un cliente
CREATE PROCEDURE registrar_cliente(
    IN cedula VARCHAR(20), 
    IN nombres VARCHAR(100), 
    IN apellido1 VARCHAR(100), 
    IN apellido2 VARCHAR(100), 
    IN direccion VARCHAR(200), 
    IN ciudad_residencia VARCHAR(100), 
    IN celular VARCHAR(20), 
    IN correo_electronico VARCHAR(100)
)
BEGIN
    INSERT INTO Cliente (cedula, nombres, apellido1, apellido2, direccion, ciudad_residencia, celular, correo_electronico)
    VALUES (cedula, nombres, apellido1, apellido2, direccion, ciudad_residencia, celular, correo_electronico);
END //

-- Procedimiento para actualizar un cliente
CREATE PROCEDURE actualizar_cliente(
    IN cliente_id INT, 
    IN cedula VARCHAR(20), 
    IN nombres VARCHAR(100), 
    IN apellido1 VARCHAR(100), 
    IN apellido2 VARCHAR(100), 
    IN direccion VARCHAR(200), 
    IN ciudad_residencia VARCHAR(100), 
    IN celular VARCHAR(20), 
    IN correo_electronico VARCHAR(100)
)
BEGIN
    UPDATE Cliente
    SET cedula = cedula, 
        nombres = nombres, 
        apellido1 = apellido1, 
        apellido2 = apellido2, 
        direccion = direccion, 
        ciudad_residencia = ciudad_residencia, 
        celular = celular, 
        correo_electronico = correo_electronico
    WHERE id_cliente = cliente_id;
END //

-- Procedimiento para registrar un empleado
CREATE PROCEDURE registrar_empleado(
    IN id_sucursal INT, 
    IN cedula VARCHAR(20), 
    IN nombre VARCHAR(100), 
    IN apellido1 VARCHAR(100), 
    IN apellido2 VARCHAR(100), 
    IN direccion VARCHAR(200), 
    IN ciudad_residencia VARCHAR(100), 
    IN celular VARCHAR(20), 
    IN correo_electronico VARCHAR(100)
)
BEGIN
    INSERT INTO Empleado (id_sucursal, cedula, nombre, apellido1, apellido2, direccion, ciudad_residencia, celular, correo_electronico)
    VALUES (id_sucursal, cedula, nombre, apellido1, apellido2, direccion, ciudad_residencia, celular, correo_electronico);
END //

-- Procedimiento para actualizar un empleado
CREATE PROCEDURE actualizar_empleado(
    IN empleado_id INT, 
    IN id_sucursal INT, 
    IN cedula VARCHAR(20), 
    IN nombre VARCHAR(100), 
    IN apellido1 VARCHAR(100), 
    IN apellido2 VARCHAR(100), 
    IN direccion VARCHAR(200), 
    IN ciudad_residencia VARCHAR(100), 
    IN celular VARCHAR(20), 
    IN correo_electronico VARCHAR(100)
)
BEGIN
    UPDATE Empleado
    SET id_sucursal = id_sucursal, 
        cedula = cedula, 
        nombre = nombre, 
        apellido1 = apellido1, 
        apellido2 = apellido2, 
        direccion = direccion, 
        ciudad_residencia = ciudad_residencia, 
        celular = celular, 
        correo_electronico = correo_electronico
    WHERE id_empleado = empleado_id;
END //

DELIMITER ;
