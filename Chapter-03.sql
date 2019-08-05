use TSQL2012;

/*---------------------------------------------------------------
                            Leccion 01
---------------------------------------------------------------*/
-- 
select empid, firstname, lastname, country, region, city
from hr.employees
where country = N'USA';

-- 
select empid, firstname, lastname, country, region, city
from hr.Employees
where region = N'WA';

-- 
select empid, firstname, lastname, country, region, city
from hr.Employees
where region <> N'WA';

-- Uso de Is Null
select empid, firstname, lastname, country, region, city
from hr.Employees
where region <> N'WA'
    or region is null;

-- Aceptando valores de entrada pero no tomando en cuenta nulos
declare @dt as DATETIME = '20060103 00:00:00.000'
select orderid, orderdate, empid
from sales.orders
where shippeddate = @dt;

-- Aceptando valores y tomando en cuenta nulos
declare @dt2 as DATETIME = '20060710'
select orderid, orderdate, empid, shippeddate
from sales.Orders
where coalesce(shippeddate,'19000101') = coalesce(@dt2,'19000101');

    -- Probando si se usa un valor nulo
    select orderid, orderdate, empid, shippeddate
    from sales.Orders
    where coalesce(shippeddate,'19000101') = coalesce(null,'19000101');

    -- Optimizado basado en argumento de busqueda
    declare @dt3 as DATETIME = '20060710'
    select orderid, orderdate, empid
    from Sales.orders
    where shippeddate = @dt3
        or (shippeddate is null and @dt3 is null);

    -- Optimizando basado en search arguemtn y usando nulo
    declare @dt4 as DATETIME = null
    select orderid, orderdate, empid
    from Sales.orders
    where shippeddate = @dt4
        or (shippeddate is null and @dt4 is null);

-- Combinando Predicados
select *
from hr.employees
where not region = N'WA'
    or region is null;

-- Filtrado de datos de tipo caracter
select empid, firstname, lastname
from hr.Employees
where lastname = 'Davis';

-- Siempre usar N'' ya que la conversion implicita de tipo daña rendimiento
select empid, firstname, lastname
from hr.Employees
where lastname = N'Davis';

-- Usando Like
-- Acepta expresiones regulares
-- Tener cuidado cuando se inicia con una expresion y no un valor conocido
-- Afecta Indices '%ABC%'
-- NO afecta Indices 'ABC%' 
select empid, firstname, lastname
from hr.employees
where lastname like N'D%';

-- Filtrando Fechas y Tiempo
-- Devuelve Diciembre
select orderid, orderdate, empid, custid, month(orderdate)
from sales.orders
where orderdate = '02/12/07';

    -- Procurar formato neutral de fecha
    -- Devuelve Febrero
    select orderid,orderdate,empid,custid, month(orderdate)
    from sales.orders
    where orderdate = '20070212';

-- Devido a la manipulacion de la condicion este no es argumento de busqueda
select orderid, orderdate, empid, custid
from sales.orders
where year(orderdate) = 2007 and month(orderdate) = 2;

    -- De esta manera se obtiene indexacion
    select orderid, orderdate, empid, custid
    from sales.orders
    where orderdate >= '20070201' and orderdate >= '20070301';

    -- Evitar Between ya que puede redondear a la fecha siguiente
    -- Aqui se redondea la fecha al 1ro de marzo
    select orderid, orderdate, empid, custid
    from sales.Orders
    where orderdate between '20070201' and '20070228 23:59:59.999';

-- Ejercicio 01. Usar la clausula where para filtrar las columnas nulas
select orderid, orderdate, shippeddate
from sales.Orders
where shippeddate is NULL;

    -- De esta manera al evaluar nulo contra nulo se obtiene incierto
    select orderid, orderdate, shippeddate
    from sales.Orders
    where shippeddate = null;

-- Ejercicio 02. Usar la clausula where para filtrar un rango de fechas
select orderid, orderdate, custid, empid
from sales.Orders
where orderdate >= '20080211' and orderdate < '20080213';

    -- 
    select orderid, orderdate, custid, empid
    from sales.orders
    where orderdate between '20080211' and '20080212';

    -- 
    SELECT orderid, orderdate, custid, empid
    FROM Sales.Orders
    WHERE orderdate BETWEEN '20080211' AND '20080212 23:59:59.999';

/*---------------------------------------------------------------
                            Leccion 02
---------------------------------------------------------------*/




/*---------------------------------------------------------------
                            Leccion 03
---------------------------------------------------------------*/