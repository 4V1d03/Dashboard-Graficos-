
Create proc DashboardDatos
@Total_Ventas float out,
@Total_Productos int out,
@Total_Categorias int out,
@Total_Marcas int out,
@Total_Empleados int out,
@Total_Proveedores int out,
@Total_Clientes int out
as
set @Total_Ventas =(select SUM(TOTAL) 'Total_Ventas' from VENTAS) --suma total de ventas
set @Total_Productos = (select COUNT(ID) 'Total_Productos' from PRODUCTOS) --cantidad total de productos
set @Total_Categorias=(select count(ID) 'Total_Categorias' from CATEGORIAS) --cantidad total de categorias
set @Total_Marcas=(select COUNT(ID) 'Total_Marcas' from MARCAS) --Cantidad Total de marcas
set @Total_Empleados=(select count(ID) 'Total_Empleados' from EMPLEADOS)
set @Total_Proveedores=(select count(ID) 'Total_Proveedores' from PROVEEDORES)
set @Total_Clientes=(select count(ID) 'Total_Clientes' from CLIENTES)
go

--5 Productos mas vendidos
create proc productosMasVendidos
as
select top 5 c.CATEGORIA+' '+m.MARCA+' '+p.DESCRIPCION AS Producto , COUNT(ID_PRODUCTO) as CantidadVendida
from DETALLE_VENTA dv
join PRODUCTOS p on p.ID = dv.ID_PRODUCTO
join CATEGORIAS c on c.ID = p.ID_CATEGORIA
join MARCAS m on m.ID = p.ID_MARCA
group by DV.ID_PRODUCTO, c.CATEGORIA+' '+m.MARCA+' '+p.DESCRIPCION
order by COUNT(ID_PRODUCTO) desc
go

--Cantidad de productos por categoria
create proc produxCategoria
as
select c.CATEGORIA, COUNT(ID_CATEGORIA) as CantidadTotal
from PRODUCTOS p 
join CATEGORIAS c on c.ID = p.ID_CATEGORIA
group by ID_CATEGORIA, c.CATEGORIA 
order by COUNT(2)
go
