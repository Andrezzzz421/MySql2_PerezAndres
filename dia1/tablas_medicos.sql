create database medicos;

use medicos;

create table Medicos (
    ID_Medico int primary key auto_increment ,
    Nombre varchar(100) not null,
    Dirección varchar(200) not null,
    Teléfono varchar(15),
    Población varchar(100),
    Provincia varchar(100),
    Código_Postal varchar(10),
    NIF varchar(20),
    Número_Seguridad_Social varchar(20),
    Número_Colegiado varchar(20),
    Tipo enum('titular', 'interino', 'sustituto') not null
);

create table Horario_Consultas (
    ID_Horario int primary key auto_increment ,
    ID_Medico int not null,
    Dia_Semana enum('Lunes', 'Martes', 'Miércoles', 'Jueves', 'Viernes', 'Sábado', 'Domingo') not null,
    Hora_Inicio TIME not null,
    Hora_Fin TIME not null,
  foreign key (ID_Medico) references Medicos(ID_Medico)
);

create table Sustituciones (
    ID_Sustitucion int primary key auto_increment ,
    ID_Medico int not null,
    Fecha_Alta date not null,
    Fecha_Baja date not null,
   foreign key (ID_Medico) references Medicos(ID_Medico)
);

create table Empleados (
    ID_Empleado int primary key auto_increment ,
    Nombre varchar(100) not null,
    Dirección varchar(200) not null,
    Teléfono varchar(15),
    Población varchar(100),
    Provincia varchar(100),
    Código_Postal varchar(10),
    NIF varchar(20),
    Número_Seguridad_Social varchar(20),
    Tipo enum('ATS', 'ATS_de_zona', 'auxiliar_de_enfermería', 'celador', 'administrativo') not null
);

create table Vacaciones (
    ID_Vacacion int primary key auto_increment ,
    ID_Medico int,
    ID_Empleado int,
    Fecha_Inicio date not null,
    Fecha_Fin date not null,
    Estado enum('planificadas', 'disfrutadas') not null,
   foreign key (ID_Medico) references Medicos(ID_Medico),
   foreign key (ID_Empleado) references Empleados(ID_Empleado)
);

create table Pacientes (
    ID_Paciente int primary key auto_increment ,
    ID_Medico int not null,
    Nombre varchar(100) not null,
    Dirección varchar(200) not null,
    Teléfono varchar(15),
    Código_Postal varchar(10),
    NIF varchar(20),
    Número_Seguridad_Social varchar(20),
   foreign key (ID_Medico) references Medicos(ID_Medico)
);

show tables;