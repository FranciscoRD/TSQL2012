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
order by 1
-- Concatenacion en select, forma no 
-- relacional (Ausencia de nombre de columna)
select empid, firstname + ' ' + lastname
from hr.Employees
-- Concatenacion en select, forma relacional (Todas las columnas tienen nombre)
select empid,firstname +' '+lastname as fullname
from hr.Employees
-- Ejercicio 01. Identificando elementos no relacionales
select custid, YEAR(orderdate)
from Sales.Orders
order by 1,2
-- Ejercicio 02. Haciendo la consulta anterior Relacional
select distinct custid, year(orderdate) as orderyear
from sales.Orders
/*---------------------------------------------------------------
                            Leccion 02
---------------------------------------------------------------*/