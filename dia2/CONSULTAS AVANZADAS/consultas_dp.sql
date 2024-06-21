	use edificios;
	-- #############################
	-- ######### CONSULTAS #########
	-- #############################
	-- Consultas sobre una tabla

	-- 1.Lista el primer apellido de todos los empleados.
    delimiter //
    create procedure eje1()
    begin
    	select apellido1
		from empleado;
    end //
    delimiter ;	
    call eje1();
	
	-- 2.Lista el primer apellido de los empleados eliminando los apellidos que estén repetidos.
    delimiter //
    create procedure eje2()
    begin
		select distinct apellido1
		from empleado;
    end //
    delimiter ;
call eje2();

	-- 3.Lista todas las columnas de la tabla empleado.
    delimiter //
    create procedure eje3()
    begin
		select *
		from empleado;
    end //
    delimiter ;
    call eje3();

	-- 4.Lista el nombre y los apellidos de todos los empleados.
    delimiter //
    create procedure eje4()
    begin
		select nombre, apellido1 as apellido, apellido2 as segundo_apellido
		from empleado;
    end //
    delimiter ;
    call eje4();
    
	-- 5.Lista el identificador de los departamentos de los empleados que aparecen en la tabla empleado
    delimiter //
    create procedure eje5()
    begin
		select id_departamento 
		from empleado;
    end //
    delimiter ;
call eje5();

	-- 6.Lista el identificador de los departamentos de los empleados que aparecen
	-- en la tabla empleado, eliminando los identificadores que aparecen repetidos.
    delimiter //
    create procedure eje6()
    begin
    	select distinct id_departamento
		from empleado;
    end //
    delimiter ;
    call eje6();

	-- 7.Lista el nombre y apellidos de los empleados en una única columna.
    delimiter //
    create procedure eje7()
    begin
    	select CONCAT(nombre, ' ', apellido1, ' ', apellido2) as nombre_completo 
		from empleado;
    end //
    delimiter ;
call eje7();

	-- 8.Lista el nombre y apellidos de los empleados en una única columna,
	-- convirtiendo todos los caracteres en mayúscula.
    delimiter //
    create procedure eje8()
    begin
    	select ucase(concat(nombre, ' ', apellido1, '' , apellido2)) as nombre_completo
		from empleado;
    end //
    delimiter ;
call eje8();

	-- 9.Lista el nombre y apellidos de los empleados en una única columna,
	-- convirtiendo todos los caracteres en minúscula.
    delimiter //
    create procedure eje9()
    begin
    	select lower(concat(nombre, ' ', apellido1, ' ' , apellido2)) as nombre_complete
		from empleado;
    end //
    delimiter ;
call eje9();

	-- 10.Lista el identificador de los empleados junto al nif, pero el nif deberá
	-- aparecer en dos columnas, una mostrará únicamente los dígitos del nif y la
	-- otra la letra.
    delimiter //
    create procedure eje10()
    begin
    	select id, 
		left(nif, LENGTH(nif) - 1) as nif_digitos, 
		right(nif, 1) as nif_letra 
		from empleado;
    end //
    delimiter ;
call eje10();

	-- 11.Lista el nombre de cada departamento y el valor del presupuesto actual del
	-- que dispone. Para calcular este dato tendrá que restar al valor del
	-- presupuesto inicial (columna presupuesto) los gastos que se han generado
	-- (columna gastos). Tenga en cuenta que en algunos casos pueden existir
	-- valores negativos. Utilice un alias apropiado para la nueva columna columna
	-- que está calculando.
delimiter //

create procedure eje11()
begin
    select nombre as Nombre_Departamento,
           case 
               when (presupuesto - gastos) >= 0 then (presupuesto - gastos)
               else 0
           end as Presupuesto_Disponible,
           case 
               when (presupuesto - gastos) < 0 then (presupuesto - gastos)
               else 0
           end as Presupuesto_Negativo
    from departamento;
end //
delimiter ;
call eje11();

	-- 12.Lista el nombre de los departamentos y el valor del presupuesto actual
	-- ordenado de forma ascendente.
    delimiter //
    create procedure eje12()
    begin
    	select nombre, presupuesto - gastos as presupuesto_actual
		from departamento
		order by presupuesto_actual asc;
    end //
    delimiter ;
    call eje12();

	-- 13.Lista el nombre de todos los departamentos ordenados de forma
	-- ascendente.
    delimiter //
    create procedure eje13()
    begin
    	select nombre
		from departamento
		order by nombre asc;
    end //
    delimiter ;
    call eje13();

	-- 14.Lista el nombre de todos los departamentos ordenados de forma
	-- descendente.
    delimiter //
    create procedure eje14()
    begin
    	select nombre
		from departamento
		order by nombre desc;
    end //
    delimiter ;
call eje14();

	-- 15.Lista los apellidos y el nombre de todos los empleados, ordenados de forma
	-- alfabética tendiendo en cuenta en primer lugar sus apellidos y luego su
	-- nombre.
    delimiter //
    create procedure eje15()
    begin
    	select apellido1 as apellido, apellido2 as segundo_apellido , nombre 
		from empleado
		order by apellido1, apellido2, nombre;
    end //
    delimiter ;
    call eje15();

	-- 16.Devuelve una lista con el nombre y el presupuesto, de los 3 departamentos
	-- que tienen mayor presupuesto.
    delimiter //
    create procedure eje16()
    begin
    	select nombre, presupuesto 
		from departamento 
		order by presupuesto desc
		limit 3;
    end //
    delimiter ;
    call eje16();

	-- 17.Devuelve una lista con el nombre y el presupuesto, de los 3 departamentos
	-- que tienen menor presupuesto.
    delimiter //
    create procedure eje17()
    begin
    	select nombre, presupuesto
		from departamento
		order by presupuesto asc
		limit 3;
    end //
    delimiter ;
    call eje17();

	-- 18.Devuelve una lista con el nombre y el gasto, de los 2 departamentos que
	-- tienen mayor gasto.
    delimiter //
    create procedure eje18()
    begin 
    	select nombre, presupuesto
		from departamento
		order by presupuesto desc
		limit 2;
    end //
    delimiter ;
    call eje18();

	-- 19.Devuelve una lista con el nombre y el gasto, de los 2 departamentos que
	-- tienen menor gasto.
    delimiter //
    create procedure eje19()
    begin
    	select nombre, presupuesto
		from departamento
		order by presupuesto asc
		limit 2;
    end //
    delimiter ;
    call eje19();

	-- 20.Devuelve una lista con 5 filas a partir de la tercera fila de la tabla empleado. La
	-- tercera fila se debe incluir en la respuesta. La respuesta debe incluir todas las
	-- columnas de la tabla empleado.
    delimiter //
    create procedure eje20()
    begin
    	select * 
		from empleado 
		limit 2, 5;
    end //
	delimiter ;
call eje20();

	-- 21.Devuelve una lista con el nombre de los departamentos y el presupuesto, de
	-- aquellos que tienen un presupuesto mayor o igual a 150000 euros.
    delimiter //
    create procedure eje21()
    begin
    	select nombre, presupuesto
		from departamento
		where presupuesto >= 150000;
    end //
    delimiter ;
    call eje21();

	-- 22.Devuelve una lista con el nombre de los departamentos y el gasto, de
	-- aquellos que tienen menos de 5000 euros de gastos.
    delimiter //
    create procedure eje22()
    begin
    	select nombre, presupuesto
		from departamento
		where presupuesto < 5000;
    end //
    delimiter ;
    call eje22();

	-- 23.Devuelve una lista con el nombre de los departamentos y el presupuesto, de
	-- aquellos que tienen un presupuesto entre 100000 y 200000 euros. Sin
	-- utilizar el operador BETWEEN.
    delimiter //
    create procedure eje23()
    begin
    	select nombre, presupuesto 
		from departamento 
		where presupuesto >= 100000 and presupuesto <= 200000;
    end //
    delimiter ;
    call eje23();

	-- 24.Devuelve una lista con el nombre de los departamentos que no tienen un
	-- presupuesto entre 100000 y 200000 euros. Sin utilizar el operador BETWEEN.
    delimiter //
    create procedure eje24()
    begin
    	select nombre, presupuesto
		from departamento
		where presupuesto < 100000 or presupuesto > 200000;
    end //
    delimiter ;
    call eje24();

	-- 25.Devuelve una lista con el nombre de los departamentos que tienen un
	-- presupuesto entre 100000 y 200000 euros. Utilizando el operador BETWEEN.
    delimiter //
    create procedure eje25()
    begin
    	select nombre 
		from departamento 
		where presupuesto between 100000 and 200000;
    end //
    delimiter ;
    call eje25();

	-- 26.Devuelve una lista con el nombre de los departamentos que no tienen un
	-- presupuesto entre 100000 y 200000 euros. Utilizando el operador BETWEEN.
    delimiter //
    create procedure eje26()
    begin
    	select nombre
		from departamento 
		where presupuesto not between 100000 and 200000;
    end //
    delimiter ;
    call eje26();

	-- 27.Devuelve una lista con el nombre de los departamentos, gastos y
	-- presupuesto, de aquellos departamentos donde los gastos sean mayores
	-- que el presupuesto del que disponen.
    delimiter //
    create procedure eje27()
    begin
    	select nombre, gastos, presupuesto 
		from departamento 
		where gastos > presupuesto;
    end //
    delimiter ;
    call eje27();

	-- 28.Devuelve una lista con el nombre de los departamentos, gastos y
	-- presupuesto, de aquellos departamentos donde los gastos sean menores
	-- que el presupuesto del que disponen.
    delimiter //
    create procedure eje28()
    begin
    	select nombre, gastos, presupuesto
		from departamento
		where gastos < presupuesto;
    end //
    delimiter ;
    call eje28();

	-- 29.Devuelve una lista con el nombre de los departamentos, gastos y
	-- presupuesto, de aquellos departamentos donde los gastos sean iguales al
	-- presupuesto del que disponen.
    delimiter //
    create procedure eje29()
    begin
    	select nombre, gastos, presupuesto
		from departamento
		where gastos = presupuesto;
    end //
    delimiter ;
    call eje29();

	-- 30.Lista todos los datos de los empleados cuyo segundo apellido sea NULL.
    delimiter //
    create procedure eje30()
    begin 
    	select *
		from empleado
		where apellido2 is null;
    end //
    delimiter ;
    call eje30();

-- 31.Lista todos los datos de los empleados cuyo segundo apellido no sea NULL.
delimiter //
create procedure eje31()
begin
	select *
	from empleado
	where apellido2 is not null;
end //
delimiter ;
call eje31();

-- 32. Lista todos los datos de los empleados cuyo segundo apellido sea López.
delimiter //
create procedure eje32()
begin
	select *
    from empleado
    where apellido2 = 'López';
end //
delimiter ;
call eje32();

-- 33.Lista todos los datos de los empleados cuyo segundo apellido
-- sea Díaz o Moreno. Sin utilizar el operador IN.
delimiter //
create procedure eje33()
begin
	select *
    from empleado
    where apellido2 = 'Díaz' or apellido2 = 'Moreno';
end //
delimiter ;
call eje33();

-- 34.Lista todos los datos de los empleados cuyo segundo apellido
-- sea Díaz o Moreno. Utilizando el operador IN.
delimiter //
create procedure eje34()
begin
	select *
    from empleado
    where apellido2 in ('Díaz', 'Moreno');
end //
delimiter ;
call eje34();

-- 35.Lista los nombres, apellidos y nif de los empleados que trabajan en el
-- departamento 3.
delimiter //
create procedure eje35()
begin
	select nombre, apellido1, apellido2, nif
    from empleado
    where id_departamento = 3;
end //
delimiter ;
call eje35();

-- 36.Lista los nombres, apellidos y nif de los empleados que trabajan en los
-- departamentos 2, 4 o 5.
delimiter // 
create procedure eje36()
begin
	select nombre, apellido1, apellido2, nif
    from empleado
    where id_departamento in (2,4,5);
end //
delimiter ;
call eje36();

drop procedure eje36;
-- ##############################################
-- # Consultas multitabla (Composición interna) #
-- ##############################################
-- 1.Devuelve un listado con los empleados y los datos de los departamentos
-- donde trabaja cada uno.
delimiter //
create procedure ejer1()
begin
    select e.id as empleado_id, e.nif, e.nombre as empleado_nombre, e.apellido1, e.apellido2, 
           d.id as departamento_id, d.nombre as departamento_nombre, d.presupuesto, d.gastos
    from empleado e
    join departamento d on e.id_departamento = d.id;
end //
delimiter ;
call ejer1();
