create database autorenta;
use autorenta;

create table Sucursal (
    id_sucursal int primary key auto_increment,
    ciudad varchar(100) not null ,
    direccion varchar(200) not null ,
    telefono_fijo varchar(20),
    celular varchar(20),
    correo_electronico varchar(100)
);

create table Empleado (
    id_empleado int primary key auto_increment,
    id_sucursal int ,
    cedula varchar(20) unique not null ,
    nombre varchar(100) not null ,
    apellido1 varchar(100) not null ,
    apellido2 varchar(100),
    direccion varchar(200),
    ciudad_residencia varchar(100),
    celular varchar(20),
    correo_electronico varchar(100),
    foreign key (id_sucursal) references Sucursal(id_sucursal)
);

create table Cliente (
    id_cliente int primary key auto_increment,
    cedula varchar(20) unique not null ,
    nombres varchar(100) not null ,
    apellido1 varchar(100) not null ,
    apellido2 varchar(100),
    direccion varchar(200),
    ciudad_residencia varchar(100),
    celular varchar(20),
    correo_electronico varchar(100)
);

create table Vehiculo (
    id_vehiculo int primary key auto_increment,
    tipo_vehiculo varchar(50) not null ,
    placa varchar(20) unique not null ,
    referencia varchar(100),
    modelo year,
    puertas int ,
    capacidad int ,
    sunroof boolean,
    motor varchar(50),
    color varchar(50)
);

create table Alquiler (
    id_alquiler int primary key auto_increment,
    id_vehiculo int ,
    id_cliente int ,
    id_empleado int ,
    id_sucursal_salida int ,
    id_sucursal_llegada int ,
    fecha_salida date,
    fecha_llegada date,
    fecha_esperada_llegada date,
    valor_alquiler_semana decimal(10, 2),
    valor_alquiler_dia decimal(10, 2),
    porcentaje_descuento decimal(5, 2),
    valor_cotizado decimal(10, 2),
    valor_pagado decimal(10, 2),
    foreign key (id_vehiculo) references Vehiculo(id_vehiculo),
    foreign key (id_cliente) references Cliente(id_cliente),
    foreign key (id_empleado) references Empleado(id_empleado),
    foreign key (id_sucursal_salida) references Sucursal(id_sucursal),
    foreign key (id_sucursal_llegada) references Sucursal(id_sucursal)
);