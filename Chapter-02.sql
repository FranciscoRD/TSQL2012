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

-- Float es impreciso
declare @f as float = '29545428.022495'
select cast(@f as numeric(28,14)) as value;

-- Cast requiere tipos similares
-- Aqui falla no se puede convertir cadena a enter
select cast('abc' as int);

-- Try_Cast retorna nulo en conversion de tipos diferentes
select try_cast('abc' as int);

-- Cast
select cast(1.0 as int);

-- Convert
select convert(date,'1/2/2012',101), month('1/2/2012');

-- Parse
select parse('1/2/2012' as date using 'en-us');

-- Conversion Implicita, de Varchar a Int 
select 1 + '1';

-- Valores retornados son en base a los tipos usados
-- Division de enteros genera un resultado entero por defecto
select 5/2;

    -- Resultado de tipo float,
    -- Conversion explicita de 5 a float
    -- Conversion implicita de 2 a float
    select cast(5 as float) / 2;

    -- Resultado float
    -- Conversion explicita de 5 a float
    -- Conversion explicita de 2 a float
    select cast(5 as float) / cast(2 as float);

-- Obtener fechas
-- GetDate() es especifico de T-SQL
-- current_timestamp es la version estandar
-- sysdatetime() retorna valor de tipo datetime2
-- sysdatetimeoffset() retorna un valor de tipo datetimeoffset
select getdate();
select current_timestamp;
select getutcdate();
select sysdatetime();
select sysutcdatetime();
select sysdatetimeoffset();

-- Extraer valores de fehas
select datepart(year, '20181201'), datepart(month,'20181201'), datepart(day, '20181201');
select datename(year,'20181201'), datename(month,'20181201'),datename(day,'20181201');

-- Construir Fechas
select datefromparts(2012,12,01);
select datetime2fromparts(2012,12,01,00,00,00,00,00);
select datetimefromparts(2012,12,01,00,00,00,00);
select datetimeoffsetfromparts(2012,12,01,00,00,00,00,00,00,00)
select smalldatetimefromparts(2012,12,01,00,00);
select timefromparts(23,59,59,00,00);
select eomonth(getdate());

-- Agregando fechas
-- Con numeros positivos en dateadd se suman a la fecha indicada
-- Con numeros negativos se restan a la fecha ndicada
select dateadd(year,2,getdate()), dateadd(month,2,getdate()), dateadd(day,2,getdate());
select dateadd(year,-2,getdate()), dateadd(month,-2,getdate()), dateadd(day,-2,getdate());

-- Diferencia entre fechas
-- Devuelve fechas positivas si fecha menor es colocada de primero y despues fecha mayor
-- Devuelve fechas negativas si fecha mayor es colocada de primero y despues fecha menor
select datediff(day,'20180112','20181201'), datediff(year,'20180112','20181201'), datediff(month,'20180112','20181201');
select datediff(day,'20181201','20180112'), datediff(year,'20181201','20180112'), datediff(month,'20181201','20180112');

-- Offset
select switchoffset(sysdatetimeoffset(),'-08:00');
select todatetimeoffset('20130212 14:00:00.0000000','-08:00');

-- Concatenacion
-- Si un valor es nulo los valores concatenados se vuelven todos nulos
select empid, country, region, city,
    country + N',' + region + N',' + city as location
from hr.employees;

-- Concatenacion, manejo de nullos con Coalesce
select empid, country, region, city,
    country + coalesce(N',' + region, N'') + N',' + city as location
from hr.employees;

-- Concatenacion con Concat
-- Concat transforma nulos en cadenas vacias
select empid, country, region, city,
    concat(country, N',' + region,N',' + city) as location
from hr.Employees;

-- Extraccion de cadenas
select substring('Hola',1,2);
select left('Hola',2);
select right('Hola',2);

-- Posicion de un caracter especifico
-- Si no existe en la cadena retorna 0
select charindex('o','Hola');

-- Extraccion de cadena y posicion de caracter
declare @fullname as VARCHAR(30) = 'Francisco-Donaire'
select left(@fullname, charindex('-',@fullname) -1) as Nombre,
    substring(@fullname,charindex('-',@fullname) + 1,50) as Apellido;

-- Longitud de Cadena
-- Len cuenta la cantidad de caracteres, si la cadena contiene solo espcios vacios retorna 0
-- Len solo cuenta espacios vacios si estan a la izq de un caracter o en medio de ellos
-- Len no cuenta espacios en blancos si estan a la derecha del ultimo caracter
-- DataLength cuenta espacios en blancos
select len(N'xyz ');
select datalength(' ');

-- Alteracion de Cadenas
select replace('.1.2.3','.','/');
select replicate('0',10);

-- Stuff inserta una cadena (4to argumento) en un posicion dada (2do argumento)
-- Despues elmina la cantidad de caracteres especificados (3er argumento)
-- Si el 3er argumento es 0 solo inserta la nueva cadena
select stuff('Camaleon',5,5,'-');
select stuff('Camaleon',5,0,'-');

-- Formateo de Cadena
select upper('hola');
select lower('HOLA');
select ltrim('   3 espacios antes del tres, borrados');
select rtrim('3 espacios despues del punto, borrados.   ');
select format(1759,'0000000000');

-- Case
-- Forma Simple
select productid, productname, unitprice, discontinued,
    case discontinued
        when 0 then 'No'
        when 1 then 'yes'
        else 'Unknown'
    end as discontinued_desc
from production.products;

    -- Searched Case
    select productid, productname, unitprice,
        case
            when unitprice < 20.00 then 'Low'
            when unitprice < 40.00 then 'Medium'
            when unitprice >= 40.00 then 'High'
            else 'Unknown'
        end as pricerange
    from production.products;

-- Isnull
-- Isnull es limitado y no estandar. Evitar
declare 
    @x as varchar(3)= null,
    @y as varchar(10) = '1234567890';
select coalesce(@x,@y) as [coalesce], isnull(@x,@y) as [Isnul];

-- Ejercicio 01. AQplicar concatenacion de cadenas y usar funciones Date y Time
select empid, firstname + ' ' + lastname as fullname,
    year(birthdate) as birthyear
from hr.employees

    -- Concat y Funciones de Fecha
    select empid, concat(firstname,' ',lastname) as fullname,
        datepart(year,birthdate) as birthyear
    from hr.employees

-- Ejercicio 02. Usando funciones adicionales de Date y Time
select eomonth(getdate()) as 'Dia final del mes actual';

    -- 
    select eomonth(sysdatetime()) as end_of_current_month;

--
select datefromparts(year(getdate()),12,31) as end_of_current_year;

-- Ejercicio 03. Usando Cadenas y Funciones de Conversion
select productid, format(productid,'0000000000') as 'ProductId'
from production.products;

    --
    select productid, 
        right(replicate('0',10) + cast(productid as varchar(10)),10) as str_productid
    from Production.Products;

    --
    select productid,
        format(productid,'d10') as str_productid
    from Production.Products;