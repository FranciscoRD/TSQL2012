use TSQL2012;

/*---------------------------------------------------------------
                            Leccion 01
---------------------------------------------------------------*/

-- Aunque T-SQL puede inferir la Tabla sin indicar el esquema
-- este puede generar confucion, siempre usar esquemas
select empid, firstname, lastname
from hr.Employees;

-- Usando alias de tablas, sin comando AS
-- Menor Legibilidad
select e.empid, e.firstname, e.lastname
from hr.employees e;

-- Usando alias de tablas con el indicador AS
-- Mayor Legibilidad
select e.empid, e.firstname, e.lastname
from hr.Employees as e;

-- Usando alias en Select sin indicador AS
-- Menor Legibilidad
select empid, firstname nombre, lastname apellido
from hr.Employees;
    
    -- No usar porque si falta una coma puede generar un error en interpretacion
    -- aqui el firstname se le asigna el alias de lastname
    select empid, firstname lastname
    from hr.Employees;

-- Usando alias en Select con =
-- Menor Legibilidad
-- No usar
select empid, nombre = firstname, apelido = lastname
from hr.Employees;

-- Usando alias en Select con indicador AS
-- Mayor Legibilidad, opcion Preferida
select empid as employeeid, firstname, lastname
from hr.Employees;

    -- Util cuando el nombre de una columna no se genera por las condiciones
    select empid, firstname + N' ' + lastname
    from hr.Employees;

    -- 
    select empid, firstname + N' ' + lastname as fullname
    from hr.Employees;

-- Eliminando Duplicados con Distinct
select distinct country, region, city
from hr.Employees;

-- T-SQl solo necesita Select
-- Estandar Sql requiere Select y From
select 10 as col1, 'ABC' as col2;

-- Delimitador " "
-- Estandar SQL
select *
from "hr"."employees";

-- Delimitador [ ]
-- Propio de T-SQL
select *
from [hr].[employees];

-- Ejercicio 01. Escribir una consulta simple y aplicando alias
select shipperid, companyname, phone
from sales.Shippers;

    -- 
    select S.shipperid, companyname, phone
    from sales.Shippers as S;

-- Ejercicio 02. Usando alias e identificadores delimitados
select s.shipperid, companyname, phone as phone number
from sales.Shippers as s;

    -- 
    select s.shipperid, companyname, phone as [phone number]
    from sales.Shippers as s;

/*---------------------------------------------------------------
                            Leccion 02
---------------------------------------------------------------*/