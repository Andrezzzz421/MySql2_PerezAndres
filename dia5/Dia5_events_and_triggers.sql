-- ##############################
-- ###### DIA 5 - MySQL 2  ######
-- ##############################

USE `mysql2_dia5`;
select * from country;
select * from city;
-- Trigger para insertar o actualizar una ciudad en país con
-- la nueva población
delimiter //
create trigger after_city_insert_update
after insert on city
for each row
begin
    update country 
    set Population = Population + NEW.Population
    where Code = NEW.CountryCode;
end //
delimiter ;

-- Test
insert into city (Name,CountryCode,District,Population) 
values ("Artemis","AFG","Piso 6",1250000);

-- Trigger para insertar o actualizar una ciudad en país con
-- la nueva población después de haberse eliminado
delimiter //
create trigger after_city_delete
after delete on city
for each row
begin
    update country 
    set Population = Population - OLD.Population
    where Code = OLD.CountryCode;
end //
delimiter ;

select * from city where Name = "Artemis";
delete from city where ID=4080; 

-- Crear una tabla para auditoria de ciudad
CREATE TABLE IF NOT EXISTS city_audit (
    audit_id INT AUTO_INCREMENT PRIMARY KEY,
    city_id INT,
    action VARCHAR(10),
    old_population INT,
    new_population INT,
    change_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Trigger para auditoria de ciudades cuando se inserta
delimiter //
create trigger after_city_insert_audit
after insert on city
for each row
begin
    insert into city_audit(city_id,action,new_population)
    values (NEW.ID,'INSERT',NEW.Population);
end //
delimiter ;

-- Test
select * from city_audit;
insert into city (Name,CountryCode,District,Population) 
values ("Artemis","AFG","Piso 6",1250000);

-- Trigger para auditoria de ciudades cuando se inserta
delimiter //
create trigger after_city_update_audit
after update on city
for each row
begin
    insert into city_audit(city_id,action,old_population,new_population)
    values (OLD.ID,'UPDATE',OLD.Population,NEW.Population);
end //
delimiter ;
-- Test
update city set Population = 1550000 where ID=4081;
select * from city_audit;

-- EVENTOSSSS
-- CREACIÓN DE TABLA PARA BK DE CIUDADES
CREATE TABLE IF NOT EXISTS city_backup (
  ID int NOT NULL,
  Name char(35) NOT NULL,
  CountryCode char(3) NOT NULL,
  District char(20) NOT NULL,
  Population int NOT NULL,
  PRIMARY KEY (ID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

delimiter //
create event if not exists weekly_city_backup
on schedule every 1 week
Do
begin
    truncate table city_backup;
    insert into city_backup(ID,Name,CountryCode,District,Population)
    select ID,Name,CountryCode,District,Population from city;
end //
delimiter ;