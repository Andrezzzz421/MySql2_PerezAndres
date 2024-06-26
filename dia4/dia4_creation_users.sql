show databases;
-- ################################
-- ######## DIA 4 - MySQL 2########
-- ################################
create database mysql2_dia4;
use mysql2_dia4;

-- Creacion de usuarios con acceso en cualquier parte
create user 'camper'@'%'  identified by 'campus2023';
-- #####################################- contraseña
-- revisar permisos de x usuario
show grants for 'camper'@'%'; 

create table persona(
id int primary key, 
nombre varchar(255), 
apellido varchar(255)
 );
insert into persona (id, nombre , apellido)values(1,'Juan','Perez');
insert into persona (id, nombre , apellido)values(2,'Andres','Pastrana');
insert into persona (id, nombre , apellido)values(3,'Pedro','Gómez');
insert into persona (id, nombre , apellido)values(4,'Camilo','Gonzales');
insert into persona (id, nombre , apellido)values(5,'Stiven','Maldonado');
insert into persona (id, nombre , apellido)values(6,'Ardila','Perez');
insert into persona (id, nombre , apellido)values(7,'Ruben','Gomez');
insert into persona (id, nombre , apellido)values(8,'Andres','Portilla');
insert into persona (id, nombre , apellido)values(9,'Miguel','Carvajal');
insert into persona (id, nombre , apellido)values(10,'Andrea','Gómez');

-- Asignar permisos a x usuario para que acceda a la tabla persona de y
-- base de datos
grant select on mysql2_dia4.persona to 'camper'@'%';

-- Añadir permisos para hacer crud
grant update, insert, delete on mysql2_dia4.persona to 'camper'@'%';
-- Refrescar permisos de la BBDD
flush privileges;

-- Crear otra tablas
create table persona2(
id int primary key, 
nombre varchar(255), 
apellido varchar(255)
 );
 
-- Otras insercciones
insert into persona2 (id, nombre , apellido)values(1,'Andres','Perez');
insert into persona2 (id, nombre , apellido)values(2,'Juan','Pastrana');
insert into persona2 (id, nombre , apellido)values(3,'Camilo','Gómez');
insert into persona2 (id, nombre , apellido)values(4,'Pedro','Gonzales');
insert into persona2 (id, nombre , apellido)values(5,'Ardila','Maldonado');
insert into persona2 (id, nombre , apellido)values(6,'Stiven','Perez');
insert into persona2 (id, nombre , apellido)values(7,'Andres','Gomez');
insert into persona2 (id, nombre , apellido)values(8,'Rubes','Portilla');
insert into persona2 (id, nombre , apellido)values(9,'Andrea','Carvajal');
insert into persona2 (id, nombre , apellido)values(10,'Miguel','Gómez');

-- Denegar todos lo permisos
-- revoke all on *.* from 'camper'@'%';

-- Craer limite para que solamente se hagan x consultas por hora

alter  user 'camper'@'%' with MAX_QUERIES_PER_HOUR 5;
flush privileges;

-- Revisar los limites o permisos que tiene un usuario
-- a nivel de motor
select *from mysql.user where host = '%';

-- eliminar usuarios
-- drop user 'deivid'@'%';

-- solo poner permisos para que consulte una
-- x base de datos, una y tabla y una z columna
grant select (nombre) on mysql2_dia4.persona to 'camper'@'%';