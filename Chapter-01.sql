use TSQL2012;
/*---------------------------------------------------------------
                            Leccion 01
---------------------------------------------------------------*/
-- Paises de los empleados
select country
from hr.Employees;

-- Paises de los empleados sin duplicados de registros
select DISTINCT country
from hr.Employees;

-- Devolucion de datos sin orden, derivado de la manera
-- en que SQServer accede a la informacion
select empid, lastname
from hr.Employees;

-- Devolucion de datos en orden basado en columna definida empid
select empid,lastname
from hr.Employees
order by empid;

-- Devolucion de datos en orden basado en referencia posicional de
-- la columna 1 (orderid), NO RECOMENDADA
select empid,lastname
from hr.Employees
order by 1;

-- Concatenacion en select, forma no 
-- relacional (Ausencia de nombre de columna)
select empid, firstname + ' ' + lastname
from hr.Employees;

-- Concatenacion en select, forma relacional (Todas las columnas tienen nombre)
select empid,firstname +' '+lastname as fullname
from hr.Employees;

-- Ejercicio 01. Identificando elementos no relacionales
select custid, YEAR(orderdate)
from Sales.Orders
order by 1,2;

-- Ejercicio 02. Haciendo la consulta anterior Relacional
select distinct custid, year(orderdate) as orderyear
from sales.Orders;

/*---------------------------------------------------------------
                            Leccion 02
---------------------------------------------------------------*/
-- 
select shipperid,phone,companyname
from sales.shippers;

-- Full Query
select country, year(hiredate) as yearhired, count(*) as numemployees
from hr.Employees
where hiredate >= '20030101'
group by country,year(hiredate)
having count(*)>1
order by country, yearhired desc;

    -- Fase 1. Identificando los datos sobre los que se trabajara
    select empid, hiredate,country
    from hr.Employees;
    
    -- Fase 2. Definiendo las condiciones
    select empid, hiredate, country
    from hr.Employees
    where year(hiredate) >= 2003;

    select empid, hiredate, country
    from hr.Employees
    where hiredate >= '20030101';
    
    -- Fase 3. Agrupar columnas en la clausula group by
    select country,  year(hiredate), empid, hiredate
    from hr.Employees
    where hiredate >= '20030101'
    group by country, year(hiredate), empid, hiredate
    order by 1;
    
    -- Fase 4. Filtrando elementos basados en Having
    select country,  year(hiredate)
    from hr.Employees
    where hiredate >= '20030101'
    group by country, year(hiredate)
    having count(*)>1;
    
    -- Fase 5. Procesando la clausula Select
    select country, year(hiredate) as yearhired, count(*) as numemployees
    from hr.Employees
    where hiredate >= '20030101'
    group by country, year(hiredate)
    having count(*) > 1;
    
    -- Fase 6. Asegurando el orden de los datos
    select country, year(hiredate) as yearhired, count(*) as numemployees
    from hr.Employees
    where hiredate >= '20030101'
    group by country, year(hiredate)
    having count(*) > 1
    order by yearhired;

-- Ejercicio 01. Resolviendo un problema con group by
select custid, orderid
from sales.Orders
group by custid;
    
    --
    select custid, Max(orderid) as maxorderid
    from sales.Orders
    group by custid;

-- Ejercicio 02. Resolviendo un problema con alias
select shipperid, sum(freight) as totalfreight
from sales.Orders
where freight > 20000.00
group by shipperid;
    
    -- No funciona porque se usa en having la referencia del select 
    select shipperid, sum(freight) as totalfreight
    from sales.orders
    group by shipperid
    having  totalfreight > 20000.00

    -- 
    select shipperid, sum(freight) as totalfreight
    from sales.Orders
    group by shipperid
    having sum(freight)>20000.00