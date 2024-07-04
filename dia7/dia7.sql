-- #####################################
-- ########## DIA 7 - MySQL 2 ##########
-- #####################################

USE `mysql2_dia5`;

-- subconsulta escalar : Toda subconsulta que devuelve un solo valor (fila y columna)
-- EJ: devuelva el nombre del pais con la mayor poblacion
select Name
from country
where Population = (select max(Population) from country);

-- subconsulta de columba unica: Devuelve una columna de multiples filas
-- EJ: Encuentre los nombre de todas las ciudades en los paises
-- que tienen un area mayor a 1000000 km2
Select name 
from city
where CountryCode in (Select Code From country where SurfaceArea > 1000000);

-- subconsultas de multiples columnas: devuelve multiples columnas de multiples filas
-- EJ; Encontrar las ciudades que tengan la misma poblacion y distrito 
-- que cualquier ciudad del pais. 'USA'
select name, CountryCode,District,Population
from city
where (District,Population) in (select District,Population from
city where CountryCode = 'USA');

-- Subconsultas correlacionada : depende de la consulta externa para 
-- EJ: Liste las ciudades con una poblacion mayor que el promedio de la 
-- poblacion de las ciudades en el mismo pais
Select Name, CountryCode, Population
from city c1
where Population > (select avg(Population)from city c2 where c1.CountryCode
= c2.CountryCode);

-- Subconsulta Multiple:
-- Ej; listar las ciudades que tengan la misma poblacion que la capital del pais
-- JPN(japon)
select name
from city
where Population = (Select Population from city where ID =
(select Capital from country where code ='JPN'));

-- INDEXACION
select * from city;

-- crear indice en la columna 'name' de city
create index idx_city_name on city(Name);
select * from city; 
select name from city;

-- crear indice compuesto de las columnas 'Distric' y 'Population'
create index idx_city_district_population on city(District, Population);

-- transacciones 
-- son secuencias de uno o mas operaciones sql, las cuales son ejecutadas como
-- una unica unidad de trabajo. En otras palabras, las transacciones
-- aseguran que todas las operaciones se realice de manera correcta antes
-- de ser ejecutadas en la bbdd real, buscando cumplir con las propiedades
-- ACID.(ATOMICIDAD, CONSISTENCIA, AISLAMIENTO, DURABILIDAD).

-- PRIMER PASO: INICIAR LAT TRANSACCION
start transaction;
-- segundo paso: Hacer comandos
-- Actualizar la poblacion de la ciudad de 'New York'
update city
set population = 9000000
where name = 'New York';

select * from city where name = 'New York';

-- Tercer paso: si quiero que los cmabios se mantenga pongo COMMIT, sino
-- revierto mis cambios con ROLLBACK.
commit;
rollback;