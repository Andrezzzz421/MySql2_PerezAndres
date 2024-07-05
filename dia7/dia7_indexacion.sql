use jardineria;

-- 1.Escribe una consulta que permita agrupar los clientes de todos los empleados
-- cuyo puesto sea responsable de ventas. Se requiere que la consulta muestre:
-- Nombre del cliente, teléfono, la ciudad, nombre y primer apellido del responsable
-- de ventas y su email.
create index idx_empleado_puesto on empleado(puesto);
create index idx_cliente_codigo_empleado_rep_ventas on cliente(codigo_empleado_rep_ventas);

select c.nombre_cliente, c.telefono, c.ciudad, e.nombre as nombre_responsable, e.apellido1 as apellido_responsable, e.email
from cliente c
join empleado e on c.codigo_empleado_rep_ventas = e.codigo_empleado
where e.puesto = 'Representante Ventas';

-- 2.Se necesita obtener los registros de los pedidos entre el 15 de marzo del 2009 y
-- el 15 de julio del 2009, para todos los clientes que sean de la ciudad de
-- Sotogrande. Se requiere mostrar el código del pedido, la fecha del pedido, fecha
-- de entrega, estado, los comentarios y el condigo del cliente que realizo dicho
-- pedido.
create index idx_cliente_ciudad on cliente(ciudad);
create index idx_pedido_fecha_pedido on pedido(fecha_pedido);

select p.codigo_pedido, p.fecha_pedido, p.fecha_entrega, p.estado, p.comentarios, p.codigo_cliente
from pedido p
join cliente c on p.codigo_cliente = c.codigo_cliente
where c.ciudad = 'Sotogrande' and p.fecha_pedido between '2009-03-15' and '2009-07-15';

-- 3.Se desea obtener los productos cuya gama pertenezca a las frutas y que el
-- roveedor sea Frutas Talaveras S.A, se desea mostrar el código, nombre,
-- descripción, cantidad en stock, y su precio con 10% de descuento, de igual forma
-- se pide la cantidad en los distintos pedidos que se han hecho.
create index idx_producto_gama on producto(gama);
create index idx_producto_proveedor on producto(proveedor);

select p.codigo_producto, p.nombre, p.descripcion, p.cantidad_en_stock, p.precio_venta * 0.1 as precio_con_descuento,IFNULL(SUM(dp.cantidad), 0) as cantidad_en_pedidos
from producto p
left join detalle_pedido dp on p.codigo_producto = dp.codigo_producto
where p.gama = 'Frutales' and p.proveedor = 'Frutales Talavera S.A'
group by p.codigo_producto, p.nombre, p.descripcion, p.cantidad_en_stock, p.precio_venta;