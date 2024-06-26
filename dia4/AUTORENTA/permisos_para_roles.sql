use autorenta;

-- procedimientos sucursales
-- Insertar Sucursal
DELIMITER //
CREATE PROCEDURE insertar_sucursal (
    IN p_ciudad VARCHAR(100),
    IN p_direccion VARCHAR(200),
    IN p_telefono_fijo VARCHAR(20),
    IN p_celular VARCHAR(20),
    IN p_correo_electronico VARCHAR(100)
)
BEGIN
    INSERT INTO Sucursal (ciudad, direccion, telefono_fijo, celular, correo_electronico)
    VALUES (p_ciudad, p_direccion, p_telefono_fijo, p_celular, p_correo_electronico);
END //
DELIMITER ;

-- Actualizar Sucursal
DELIMITER //
CREATE PROCEDURE actualizar_sucursal (
    IN p_id_sucursal INT,
    IN p_ciudad VARCHAR(100),
    IN p_direccion VARCHAR(200),
    IN p_telefono_fijo VARCHAR(20),
    IN p_celular VARCHAR(20),
    IN p_correo_electronico VARCHAR(100)
)
BEGIN
    UPDATE Sucursal
    SET ciudad = p_ciudad,
        direccion = p_direccion,
        telefono_fijo = p_telefono_fijo,
        celular = p_celular,
        correo_electronico = p_correo_electronico
    WHERE id_sucursal = p_id_sucursal;
END //
DELIMITER ;

-- procedimientos vehiculos
-- Registrar Vehículo
DELIMITER //
CREATE PROCEDURE registrar_vehiculo (
    IN p_tipo_vehiculo VARCHAR(50),
    IN p_placa VARCHAR(20),
    IN p_referencia VARCHAR(100),
    IN p_modelo YEAR,
    IN p_puertas INT,
    IN p_capacidad INT,
    IN p_sunroof BOOLEAN,
    IN p_motor VARCHAR(50),
    IN p_color VARCHAR(50)
)
BEGIN
    INSERT INTO Vehiculo (tipo_vehiculo, placa, referencia, modelo, puertas, capacidad, sunroof, motor, color)
    VALUES (p_tipo_vehiculo, p_placa, p_referencia, p_modelo, p_puertas, p_capacidad, p_sunroof, p_motor, p_color);
END //
DELIMITER ;

-- Actualizar Vehículo
DELIMITER //
CREATE PROCEDURE actualizar_vehiculo (
    IN p_id_vehiculo INT,
    IN p_tipo_vehiculo VARCHAR(50),
    IN p_placa VARCHAR(20),
    IN p_referencia VARCHAR(100),
    IN p_modelo YEAR,
    IN p_puertas INT,
    IN p_capacidad INT,
    IN p_sunroof BOOLEAN,
    IN p_motor VARCHAR(50),
    IN p_color VARCHAR(50)
)
BEGIN
    UPDATE Vehiculo
    SET tipo_vehiculo = p_tipo_vehiculo,
        placa = p_placa,
        referencia = p_referencia,
        modelo = p_modelo,
        puertas = p_puertas,
        capacidad = p_capacidad,
        sunroof = p_sunroof,
        motor = p_motor,
        color = p_color
    WHERE id_vehiculo = p_id_vehiculo;
END //
DELIMITER ;

-- procedimientos empleados
-- Registrar Empleado
DELIMITER //
CREATE PROCEDURE registrar_empleado (
    IN p_id_sucursal INT,
    IN p_cedula VARCHAR(20),
    IN p_nombre VARCHAR(100),
    IN p_apellido1 VARCHAR(100),
    IN p_apellido2 VARCHAR(100),
    IN p_direccion VARCHAR(200),
    IN p_ciudad_residencia VARCHAR(100),
    IN p_celular VARCHAR(20),
    IN p_correo_electronico VARCHAR(100)
)
BEGIN
    INSERT INTO Empleado (id_sucursal, cedula, nombre, apellido1, apellido2, direccion, ciudad_residencia, celular, correo_electronico)
    VALUES (p_id_sucursal, p_cedula, p_nombre, p_apellido1, p_apellido2, p_direccion, p_ciudad_residencia, p_celular, p_correo_electronico);
END //
DELIMITER ;

-- Actualizar Empleado
DELIMITER //
CREATE PROCEDURE actualizar_empleado (
    IN p_id_empleado INT,
    IN p_id_sucursal INT,
    IN p_cedula VARCHAR(20),
    IN p_nombre VARCHAR(100),
    IN p_apellido1 VARCHAR(100),
    IN p_apellido2 VARCHAR(100),
    IN p_direccion VARCHAR(200),
    IN p_ciudad_residencia VARCHAR(100),
    IN p_celular VARCHAR(20),
    IN p_correo_electronico VARCHAR(100)
)
BEGIN
    UPDATE Empleado
    SET id_sucursal = p_id_sucursal,
        cedula = p_cedula,
        nombre = p_nombre,
        apellido1 = p_apellido1,
        apellido2 = p_apellido2,
        direccion = p_direccion,
        ciudad_residencia = p_ciudad_residencia,
        celular = p_celular,
        correo_electronico = p_correo_electronico
    WHERE id_empleado = p_id_empleado;
END //
DELIMITER ;

-- procedimientos clientes
-- Consulta de Disponibilidad de Vehículos
DELIMITER //
CREATE PROCEDURE consultar_disponibilidad_vehiculos (
    IN tipo_vehiculo VARCHAR(50),
    IN precio_min DECIMAL(10, 2),
    IN precio_max DECIMAL(10, 2),
    IN fecha_inicio DATE,
    IN fecha_fin DATE
)
BEGIN
    SELECT v.*
    FROM Vehiculo v
    WHERE v.tipo_vehiculo = tipo_vehiculo
      AND v.id_vehiculo NOT IN (
          SELECT a.id_vehiculo
          FROM Alquiler a
          WHERE (a.fecha_salida BETWEEN fecha_inicio AND fecha_fin)
             OR (a.fecha_llegada BETWEEN fecha_inicio AND fecha_fin)
             OR (fecha_inicio BETWEEN a.fecha_salida AND a.fecha_llegada)
             OR (fecha_fin BETWEEN a.fecha_salida AND a.fecha_llegada)
      )
      AND EXISTS (
          SELECT 1
          FROM Alquiler a2
          WHERE a2.id_vehiculo = v.id_vehiculo
            AND a2.valor_alquiler_semana BETWEEN precio_min AND precio_max
      );
END //
DELIMITER ;

CALL consultar_disponibilidad_vehiculos('sedán', 200.00, 500.00, '2024-07-01', '2024-07-10');

-- Consulta de Historial de Alquileres
DELIMITER //
CREATE FUNCTION historial_alquileres (cliente_id INT) 
RETURNS TEXT DETERMINISTIC
BEGIN
    DECLARE resultado TEXT;
    SELECT
        GROUP_CONCAT(
            CONCAT(
                'Alquiler ID: ', a.id_alquiler,
                ', Fecha Salida: ', a.fecha_salida,
                ', Fecha Llegada: ', a.fecha_llegada,
                ', Vehículo: ', v.placa,
                ', Empleado: ', e.nombre,
                ', Valor Cotizado: ', a.valor_cotizado
            ) SEPARATOR '\n'
        ) INTO resultado
    FROM Alquiler a
    JOIN Vehiculo v ON a.id_vehiculo = v.id_vehiculo
    JOIN Empleado e ON a.id_empleado = e.id_empleado
    WHERE a.id_cliente = cliente_id;
    IF resultado IS NULL THEN
        SET resultado = 'No se encontraron alquileres para este cliente.';
    END IF;
    RETURN resultado;
END //
DELIMITER ;
select historial_alquileres(1);

-- Alquiar de Vehículos
DELIMITER //
CREATE PROCEDURE registrar_alquiler (
    IN p_id_vehiculo INT,
    IN p_id_cliente INT,
    IN p_id_empleado INT,
    IN p_id_sucursal_salida INT,
    IN p_id_sucursal_llegada INT,
    IN p_fecha_salida DATE,
    IN p_fecha_llegada DATE,
    IN p_fecha_esperada_llegada DATE,
    IN p_valor_alquiler_semana DECIMAL(10, 2),
    IN p_valor_alquiler_dia DECIMAL(10, 2),
    IN p_porcentaje_descuento DECIMAL(5, 2),
    IN p_valor_cotizado DECIMAL(10, 2),
    IN p_valor_pagado DECIMAL(10, 2)
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SELECT 'Su alquiler fallo.' AS message;
    END;

    START TRANSACTION;

    INSERT INTO Alquiler (
        id_vehiculo, id_cliente, id_empleado, id_sucursal_salida, id_sucursal_llegada,
        fecha_salida, fecha_llegada, fecha_esperada_llegada,
        valor_alquiler_semana, valor_alquiler_dia, porcentaje_descuento,
        valor_cotizado, valor_pagado
    ) VALUES (
        p_id_vehiculo, p_id_cliente, p_id_empleado, p_id_sucursal_salida, p_id_sucursal_llegada,
        p_fecha_salida, p_fecha_llegada, p_fecha_esperada_llegada,
        p_valor_alquiler_semana, p_valor_alquiler_dia, p_porcentaje_descuento,
        p_valor_cotizado, p_valor_pagado
    );

    COMMIT;

    SELECT 'Su alquiler fue exitoso.' AS message;
END //
DELIMITER ;
CALL registrar_alquiler(1, 1, 1, 1, 2, '2024-07-01', '2024-07-08', '2024-07-07', 150.00, 25.00, 5.00, 200.00, 200.00);
SELECT * FROM Alquiler
WHERE id_vehiculo = 1
  AND id_cliente = 1
  AND fecha_salida = '2024-07-01'
  AND fecha_llegada = '2024-07-08';

-- procedimientos para cliente sirve falta el resto
