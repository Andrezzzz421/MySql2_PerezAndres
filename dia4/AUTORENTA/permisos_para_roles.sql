use autorenta;

-- procedimientos empleado
-- insertar Sucursal
-- aqui el empleado podra agregar una surcursal nueva
delimiter //
create procedure insertar_sucursal (
    in p_ciudad varchar(100),
    in p_direccion varchar(200),
    in p_telefono_fijo varchar(20),
    in p_celular varchar(20),
    in p_correo_electronico varchar(100)
)
begin
    insert into Sucursal (ciudad, direccion, telefono_fijo, celular, correo_electronico)
    values (p_ciudad, p_direccion, p_telefono_fijo, p_celular, p_correo_electronico);
end //
delimiter ;
call insertar_sucursal('Bogotá', 'Av. Siempre Viva 123', '1234567', '3001234567', 'bogota@autorenta.com');
select * from Sucursal;

-- Actualizar Sucursal
-- aqui el empleado podra actualizar una surcursal nueva

delimiter //
create procedure actualizar_sucursal (
    in p_id_sucursal int,
    in p_ciudad varchar(100),
    in p_direccion varchar(200),
    in p_telefono_fijo varchar(20),
    in p_celular varchar(20),
    in p_correo_electronico varchar(100)
)
begin
    update Sucursal
    set ciudad = p_ciudad,
        direccion = p_direccion,
        telefono_fijo = p_telefono_fijo,
        celular = p_celular,
        correo_electronico = p_correo_electronico
    where id_sucursal = p_id_sucursal;
end //
delimiter ;
call actualizar_sucursal(6, 'cucuta', 'calle Falsa 123', '7654321', '3101234567', 'nueva.bogota@autorenta.com');
select * from Sucursal;

-- Registrar Vehículo
-- aqui el empleado podra registrar un vehiculo
delimiter //
create procedure registrar_vehiculo (
    in p_tipo_vehiculo varchar(50),
    in p_placa varchar(20),
    in p_referencia varchar(100),
    in p_modelo year,
    in p_puertas int,
    in p_capacidad int,
    in p_sunroof boolean,
    in p_motor varchar(50),
    in p_color varchar(50)
)
begin
    insert into Vehiculo (tipo_vehiculo, placa, referencia, modelo, puertas, capacidad, sunroof, motor, color)
    values (p_tipo_vehiculo, p_placa, p_referencia, p_modelo, p_puertas, p_capacidad, p_sunroof, p_motor, p_color);
end //
delimiter ;
call registrar_vehiculo('Sedan', 'ABC123', 'Toyota Corolla', 2020, 4, 5, 0, '1.8L', 'Rojo');

-- Actualizar Vehículo
-- aqui el empleado podra actualizar un vehiculo
delimiter //
create procedure actualizar_vehiculo (
    in p_id_vehiculo int,
    in p_tipo_vehiculo varchar(50),
    in p_placa varchar(20),
    in p_referencia varchar(100),
    in p_modelo year,
    in p_puertas int,
    in p_capacidad int,
    in p_sunroof boolean,
    in p_motor varchar(50),
    in p_color varchar(50)
)
begin
    update Vehiculo
    set tipo_vehiculo = p_tipo_vehiculo,
        placa = p_placa,
        referencia = p_referencia,
        modelo = p_modelo,
        puertas = p_puertas,
        capacidad = p_capacidad,
        sunroof = p_sunroof,
        motor = p_motor,
        color = p_color
    where id_vehiculo = p_id_vehiculo;
end //
delimiter ;
call actualizar_vehiculo(101, 'SUV', 'DEF456', 'Toyota RAV4', 2021, 5, 7, 1, '2.5L', 'Negro');
select * from Vehiculo where id_vehiculo = 101;

-- procedimientos administrador
-- Registrar Empleado
-- Aqui en administrador prodar registrar a un nuevo dato de algun empleado
-- este procedimiento tambien usa el trigger para asignar la sucursal de manera automatica
delimiter //
create procedure registrar_empleado (
    in p_cedula varchar(20),
    in p_nombre varchar(100),
    in p_apellido1 varchar(100),
    in p_apellido2 varchar(100),
    in p_direccion varchar(200),
    in p_ciudad_residencia varchar(100),
    in p_celular varchar(20),
    in p_correo_electronico varchar(100)
)
begin
    insert into Empleado (cedula, nombre, apellido1, apellido2, direccion, ciudad_residencia, celular, correo_electronico)
    values (p_cedula, p_nombre, p_apellido1, p_apellido2, p_direccion, p_ciudad_residencia, p_celular, p_correo_electronico);
end //
delimiter ;

CALL registrar_empleado('21544621', 'pepito', 'alcachofa', 'ramirez', 'nose', 'cucuta', '1231123', 'pepito@autorenta.com');
select * from Empleado where id_sucursal = 1;

-- Actualizar Empleado
-- Aqui en administrador prodar actualizar cualquier dato de algun empleado
delimiter //
create procedure actualizar_empleado (
    in p_id_empleado int,
    in p_id_sucursal int,
    in p_cedula varchar(20),
    in p_nombre varchar(100),
    in p_apellido1 varchar(100),
    in p_apellido2 varchar(100),
    in p_direccion varchar(200),
    in p_ciudad_residencia varchar(100),
    in p_celular varchar(20),
    in p_correo_electronico varchar(100)
)
begin
    update Empleado
    set id_sucursal = p_id_sucursal,
        cedula = p_cedula,
        nombre = p_nombre,
        apellido1 = p_apellido1,
        apellido2 = p_apellido2,
        direccion = p_direccion,
        ciudad_residencia = p_ciudad_residencia,
        celular = p_celular,
        correo_electronico = p_correo_electronico
    where id_empleado = p_id_empleado;
end //
delimiter ;
call actualizar_empleado(101, 1, '0987654321', 'María', 'López', 'Ramírez', 'calle 789 #10-11', 'Medellín', '3107654321', 'maria.lopez@autorenta.com');
select * from Empleado where id_sucursal = 1;

-- procedimientos clientes

-- Consulta de Disponibilidad de Vehículos
-- aqui el cliente podra ver la disponibilidad de los vehiculos
delimiter //
create procedure consultar_disponibilidad_vehiculos (
    in tipo_vehiculo varchar(50),
    in precio_min decimal(10, 2),
    in precio_max decimal(10, 2),
    in fecha_inicio date,
    in fecha_fin date
)
begin
    select v.*
    from Vehiculo v
    where v.tipo_vehiculo = tipo_vehiculo
      and v.id_vehiculo not in (
          select a.id_vehiculo
          from Alquiler a
          where (a.fecha_salida between fecha_inicio and fecha_fin)
             or (a.fecha_llegada between fecha_inicio and fecha_fin)
             or (fecha_inicio between a.fecha_salida and a.fecha_llegada)
             or (fecha_fin between a.fecha_salida and a.fecha_llegada)
      )
      and exists (
          select 1
          from Alquiler a2
          where a2.id_vehiculo = v.id_vehiculo
            and a2.valor_alquiler_semana between precio_min and precio_max
      );
end //
delimiter ;
call consultar_disponibilidad_vehiculos('sedán', 200.00, 500.00, '2024-07-01', '2024-07-10');

-- Consulta de Historial de Alquileres
-- aqui podra ver el historial de alquileres el cliente
delimiter //
create function historial_alquileres (cliente_id int) 
returns text deterministic
begin
    declare resultado text;
    select
        GROUP_ConCAT(
            ConCAT(
                'Alquiler ID: ', a.id_alquiler,
                ', Fecha Salida: ', a.fecha_salida,
                ', Fecha Llegada: ', a.fecha_llegada,
                ', Vehículo: ', v.placa,
                ', Empleado: ', e.nombre,
                ', Valor Cotizado: ', a.valor_cotizado
            ) separator '\n'
        ) into resultado
    from Alquiler a
    join Vehiculo v on a.id_vehiculo = v.id_vehiculo
    join Empleado e on a.id_empleado = e.id_empleado
    where a.id_cliente = cliente_id;
    if resultado is null then
        set resultado = 'No se encontraron alquileres para este cliente.';
    end if;
    return resultado;
end //
delimiter ;
select historial_alquileres(1);

-- Alquiar de Vehículos
-- en este procedimiento que es para los clientes
-- el cliente registrara un alquiler
delimiter //
create procedure registrar_alquiler (
    in p_id_vehiculo int,
    in p_id_cliente int,
    in p_id_empleado int,
    in p_id_sucursal_salida int,
    in p_id_sucursal_llegada int,
    in p_fecha_salida date,
    in p_fecha_llegada date,
    in p_fecha_esperada_llegada date,
    in p_valor_alquiler_semana decimal(10, 2),
    in p_valor_alquiler_dia decimal(10, 2),
    in p_porcentaje_descuento decimal(5, 2),
    in p_valor_cotizado decimal(10, 2),
    in p_valor_pagado decimal(10, 2)
)
begin
    declare exit Handler for sqlexception
    begin
        rollback;
        select 'Su alquiler fallo.' as message;
    end;

    START transaction;

    insert into Alquiler (
        id_vehiculo, id_cliente, id_empleado, id_sucursal_salida, id_sucursal_llegada,
        fecha_salida, fecha_llegada, fecha_esperada_llegada,
        valor_alquiler_semana, valor_alquiler_dia, porcentaje_descuento,
        valor_cotizado, valor_pagado
    ) values (
        p_id_vehiculo, p_id_cliente, p_id_empleado, p_id_sucursal_salida, p_id_sucursal_llegada,
        p_fecha_salida, p_fecha_llegada, p_fecha_esperada_llegada,
        p_valor_alquiler_semana, p_valor_alquiler_dia, p_porcentaje_descuento,
        p_valor_cotizado, p_valor_pagado
    );

    commit;

    select 'Su alquiler fue exitoso.' AS message;
end //
delimiter ;
call registrar_alquiler(1, 1, 1, 1, 2, '2024-07-01', '2024-07-08', '2024-07-07', 150.00, 25.00, 5.00, 200.00, 200.00);
select * from Alquiler
where id_vehiculo = 1
  and id_cliente = 1
  and fecha_salida = '2024-07-01'
  and fecha_llegada = '2024-07-08';

