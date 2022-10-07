create table Department
(
Id int primary key,
DepartmentName nvarchar(50),
Location nvarchar(50),
DepartmentHead nvarchar(50)
)

create table Employees 
(
Id int primary key,
Name nvarchar(50),
Gender nvarchar(50),
Salary nvarchar(50),
DepartmentId int
)

insert into Employees (Id, Name, Gender, Salary, DepartmentId)
values (1, 'Tom', 'Male', 4000, 1)
insert into Employees (Id, Name, Gender, Salary, DepartmentId)
values (2, 'Pam', 'Female', 3000, 3)
insert into Employees (Id, Name, Gender, Salary, DepartmentId)
values (3, 'John', 'Male', 3500, 1)
insert into Employees (Id, Name, Gender, Salary, DepartmentId)
values (4, 'Sam', 'Male', 4500, 2)
insert into Employees (Id, Name, Gender, Salary, DepartmentId)
values (5, 'Todd', 'Male', 2800, 2)
insert into Employees (Id, Name, Gender, Salary, DepartmentId)
values (6, 'Ben', 'Male', 7000, 1)
insert into Employees (Id, Name, Gender, Salary, DepartmentId)
values (7, 'Sara', 'Female', 4800, 3)
insert into Employees (Id, Name, Gender, Salary, DepartmentId)
values (8, 'Valarie', 'Female', 5500, 1)
insert into Employees (Id, Name, Gender, Salary)
values (9, 'James', 'Male', 6500)
insert into Employees (Id, Name, Gender, Salary)
values (10, 'Russell', 'Male', 8800)

insert into Department (Id, DepartmentName, Location, DepartmentHead)
values (1, 'IT', 'London', 'Rick')
insert into Department (Id, DepartmentName, Location, DepartmentHead)
values (2, 'Payroll', 'Delhi', 'Ron')
insert into Department (Id, DepartmentName, Location, DepartmentHead)
values (3, 'HR', 'New York', 'Christie')
insert into Department (Id, DepartmentName, Location, DepartmentHead)
values (4, 'Otherb Department', 'Sydney', 'Cinderella')

select * from Employees
select * from Department

select Name, Gender, Salary, DepartmentName
from Employees
left join Department
on Employees.DepartmentId = DepartmentId

select SUM(cast(salary as int)) from Employees--arvutab kõik palgad kokku
select MIN(cast(salary as int)) from Employees--min palga saaja ja kui panen min asemel max, siis max palga saaja
select City, SUM(cast(salary as int))as TotalSalary from Employees group by City --kuupalga fond linnade lõikes

alter table Employees
add City nvarchar(30)

select City, Gender, SUM(cast(salary as int)) as TotalSalary from Employees group by City, Gender--toome soolise erilise päringusse
select city, gender, SUM(cast(salary as int)) as totalsalary from Employees group by city, Gender order by city--linnad on tähestikulises järjekorras
select gender, City, SUM(cast(salary as int)) as totalsalary from Employees group by city, Gender order by city--

select COUNT(*) from Employees--loeb ära, mitu inimest on nimekirjas, * asemele võib panna muid väärtusi

select gender, city, SUM(cast(salary as int)) as totalsalary, 
COUNT (Id) as [total employee(s)] 
from Employees 
group by Gender, city 
-- mitu töötajat on soo ja linna kaupa

select gender, city, SUM(cast(salary as int)) as totalsalary,
COUNT (Id) as [total employee(s)]
from Employees 
where Gender='Male'
group by Gender, city--kuvab ainult 

select gender, city, SUM(cast(salary as int)) as totalsalary, 
COUNT (Id) as [total employee(s)] 
from Employees 
group by Gender, city 
having Gender ='Female'--kuvab aind naised linnade kaupa

select* employees where sum(cast(salary as int)) > 4000

select gender, city, SUM(cast(salary as int)) as totalsalary, COUNT (Id) as [total employee(s)]
from Employees group by Gender, city
having SUM(cast(salary as int)) > 4000


--loome tabeli, milles hakatakse automaatselt nummerdama id-d
create table test1
(
Id int identity(1,1),
Value nvarchar(20)
)

insert into test1 values('X')

select * from test1

--kustutame veeru--
alter table employees 
drop column city

--inner join (kuvab neid kellel on departmentname väärtus)--
select name, gender, salary, departmentname
from Employees
inner join Department
on Employees.DepartmentId = Department.Id

--left join (kuidas saada kõik andmed employees kätte)--
select name, gender, salary, departmentname
from Employees
left join Department --võib kasutada ka left outer join--
on Employees.DepartmentId = Department.Id

--kuidas saada departmentname alla uus nimetus e antud juhul otherb department--
select name, gender, salary, Departmentname
from Employees
right outer join Department --right join--
on Employees.DepartmentId = Department.Id

--kuidas saada kõikide tabelite väärtused ühte päringusse--
select name, gender, salary, Departmentname
from Employees
full outer join department
on employees.departmentId = department.Id

--cross join võtab 2 allpool olevat tabelit kokku ja korrutab omavahel läbi--
select name, gender, salary, Departmentname
from Employees
cross join Department

--pärinu sisu--
select columnlist
from lefttable
jointype righttable
on joincondition

--inner join
select name, gender, salary, departmentname
from Employees
inner join Department
on Department.Id = Employees.DepartmentId

-- kuidas kuvada ainult isikud, kellel on departmentname NULL--
select name, gender, salary, Departmentname
from Employees
left join Department
on Employees.DepartmentId = Department.Id
where Employees.DepartmentId is null

--teise variandi--
select name, gender, salary, Departmentname
from Employees
left join Department
on Employees.DepartmentId = Department.Id
where Department.Id is null

--kuidas saame department tabelis oleva rea, kus on null--
select name, gender, salary, Departmentname
from Employees
right join Department
on Employees.DepartmentId = Department.Id
where Employees.DepartmentId is null

--full join (mõlema tabeli mitte-katuvate väärtustega read kuvab välja)--
select name, gender, salary, departmentname
from Employees
full join Department
on Employees.DepartmentId = Department.Id
where Employees.DepartmentId is null
or Department.Id is null

select * from Department

--saame muuta tabeli nimetust, algul vana siis uus--
sp_rename 'Department', 'Department1'
sp_rename 'Department1', 'Department'

--kasutame employees asemel lühendit e ja m--
select E.Name as employee, M.name as manager
from Employees E
left join Employees M
on E.ManagerId = M.Id

alter table employees
add ManagerId int

--inner join (kuvab ainult managerid all olevate isikute väärtused)--
select E.Name as employee, M.name as manager
from Employees E
inner join Employees M
on E.ManagerId = M.Id

--
select E.name as employee, M.name as manager
from Employees E
cross join Employees M

select ISNULL('ingvar', 'no manager') as manager

-- null asemel kuvab no managers--
select coalesce(null, 'no manager') as manager

--kui expression on õige siis paneb väärtuse, mida soovid või mõne teise väärtuse--
case when expression then '' else ''end

--nbeil kel ei ole ülemust, siis paneb neile no manager teksti--
select e.name as Employee, ISNULL(M.name, 'no manager') as manager
from Employees
left join Employees M
on E.ManagerId = M.Id

--teeme päringu kus kasutame casei--
select E.name as employee, case when M.name IS null then 'no manager'
else m.name end as manager
from Employees E
left join Employees	M
on E.managerId = M.Id

--lisame uued veerud--
alter table employees
add middlename nvarchar(30)
alter table employees
add lastname nvarchar(30)

select * from Employees

--lisame andmeid
update Employees
set firstname = 'tom', middlename = 'nick', lastname = 'jones'
where Id = 1
update Employees
set firstname = 'pam', middlename = null, lastname = 'anderson'
where Id = 2
update Employees
set firstname = 'john', middlename = null, lastname = null
where Id = 3
update Employees
set firstname = 'sam', middlename = null, lastname = 'smith'
where Id = 4
update Employees
set firstname = null , middlename = 'todd', lastname = null
where Id = 5
update Employees
set firstname = 'ben', middlename = 'ten', lastname = 'swen'
where Id = 6
update Employees
set firstname = 'sara', middlename = null, lastname = 'connor'
where Id = 7
update Employees
set firstname = 'valarie', middlename = 'balerine', lastname = null
where Id = 8
update Employees
set firstname = 'james', middlename = '007', lastname = 'bond'
where Id = 9
update Employees
set firstname = null, middlename = null, lastname = 'crowe'
where Id = 10

--igast reast võtab esimese täidetud lahtri--
select ID, coalesce(firstname, middlename, lastname) as name
from employees

--loome kaks tabelit--
create table indiancustomers
(
id int identity(1,1),
name nvarchar(25),
email nvarchar(25)
)

create table ukcustomers
(
id int identity(1,1),
name nvarchar(25),
email nvarchar(25)
)

--sisestame andmeid--
insert into indiancustomers (name, email)
values('Raj', 'R@R.com')
insert into indiancustomers (name, email)
values('Sam', 'S@S.com')
insert into ukcustomers (name, email)
values('Ben', 'B@B.com')
insert into ukcustomers (name, email)
values('Sam', 'S@S.com')

select * from indiancustomers
select * from ukcustomers

--kasutame unioni all--
select Id, name, email from indiancustomers
union all
select Id, name, email from ukcustomers

--korduvate väärtustega read pannakse ühte--
select Id, name, email from indiancustomers
union 
select Id, name, email from ukcustomers

--kuidas tulemust sorteerida nime järgi--
select Id, name, email from indiancustomers
union all
select Id, name, email from ukcustomers
order by name

--stored procudere--
create procedure spGetEmployees
as begin 
	select firstname, gender from Employees
end

--nüüd saab kasutada selle nimelist sp-d--
spGetEmployees
exec spGetEmployees
execute spGetEmployees

select * from Employees

create proc spgetemployeesbygenderanddepartment
@Gender nvarchar(20),
@DepartmentId int
as begin
	select firstname, gender, DepartmentId from Employees where Gender = @Gender
	and DepartmentId = @DepartmentId
end

--kui nüüd allolevat käsklust siis see nõuab genderi parameetrit--
spgetemployeesbygenderanddepartment
--õige--
spgetemployeesbygenderanddepartment 'Male' , 1

--niimoodi saab sp tahetud järjekorrast mööda minna kui ise paned muutujad paika--
spgetemployeesbygenderanddepartment @departmentid = 1, @gender = 'Male'

--saab vaadata sp sisu result vaates--
sp_helptext spgetemployeesbygenderanddepartment
sp_helptext sp_addlogin


--3 TUND-------------------------------------------------------------------------------------------------------------------------------------

--kuidas muuta sp'd ja võti peale, et teised ei saaks muuta
alter proc spgetemployeesbygenderanddepartment
@gender nvarchar(20),
@departmentid int
with encryption --paneb võtme peale
as begin 
	select firstname, gender, departmentid from Employees where gender = @gender and DepartmentId = @departmentid
end

select * from Employees

--sp tegemine--
create proc spgetemployeecountbygender
@gender nvarchar(20),
@employeecount int output
as begin
	select @employeecount = count(id) from Employees where Gender = @gender
end

--annab tulemuse, kus loendab ära vastavad read--
--prindib ka tulemuse kirja teel--

declare @totalcount int
execute spgetemployeecountbygender 'Male', @totalcount out
if (@totalcount is null)
	print '@totalcount is null'
else
	print '@totalcount is not null'
print @totalcount

select * from Employees

--mitu rida vastab nõuetele--

declare @totalcount int
execute spgetemployeecountbygender @employeecount = @totalcount out, @gender = 'male'
print @totalcount

--sp sisu vaatamine--

sp_help spgetemployeecountbygender

--tabeli info--
sp_help Employees

--kui soovid sp teksti näha--
sp_helptext spgetemployeecountbygender

--vaatame, millest sõltub see sp--
sp_depends spgetemployeecountbygender

--vaatame tabelit--
sp_depends Employees

--
create proc spgetnamebyid
@id int,
@firstname nvarchar(20) output
as begin 
	select @firstname = id, @firstname = firstname from Employees
end

--peaks andme tabeli ridade arvu--

create proc sptotalcount1
@totalcount int out
as begin
	select @totalcount = count(id) from Employees
end

--ei tööta--
declare @firstname nvarchar(20)
execute spgetnamebyid 3, @firstname out
print 'name =' + @firstname

--

sp_help spgetnamebyid

--mis id all on keegi nime järgi--

create proc spgetnamebyid1
@id int,
@firstname nvarchar(50) output
as begin
	select @firstname = firstname from Employees where id = @id
end

--annab tulemuse, kus id 1 real on keegi koos nimega

declare @firstname nvarchar(50)
execute spgetnamebyid1 3, @firstname out
print 'name of employee = ' + @firstname

--

create proc spgetnamebyid2
@id int
as begin
	return (select firstname from Employees where id = @id)
end

 --tuleb viga kuna küsisime inti aga 'tom' on sõne--
 
 declare @employeename nvarchar(50)
 execute @employeename =spgetnamebyid2 1
 print 'name of employee ' + @employeename

 --

create proc sptotalcount2
@totalcount int output
as begin
	select @totalcount = count(id) from Employees
end

declare @totalemployees int
execute sptotalcount2 @totalemployees output
select @totalemployees

--sisseehitatud stringi funktsioonid--
--konvertib ascii tähe väärtuse numbriks--

--kuvab numbri--
select ascii('a')

--kuvab a--
select char (075)

--prindime kogu tähestiku--
declare @start int
set @start = 97
WHILE(@start <= 122)
begin
	select char (@start)
	set @start = @start +1
end

--eemaldame tühjad kohad sulgudes--
select ltrim('   hello')
select rtrim('hello   ')

--tühikute eemaldamine veerust--
select ltrim(firstname) as firstname, middlename,lastname from employees
select * from Employees

--paremalt poolt tühjad stringid lõikab ära--
select rtrim('    hello     ')

--keerab kooloni sees olevad andmed vastupidiseks--
--vastavalt upper ja lower'ga saab muuta märkide suurust--
--reverse keerab kõik ümber--
select reverse(upper(ltrim(firstname))) as firstname, middlename, lower(lastname), 
rtrim(ltrim(firstname)) + ' ' + middlename + ' ' + lastname as fullname
from Employees

--näeb mitu tähte on sõnal ja loeb tühikud ka sisse--
select firstname, len((firstname)) as [totalcharacters] from Employees
--siin ei loe--
select firstname, len(ltrim(firstname)) as [totalcharacters] from Employees

--left, right, substring--

--võtab vasakult 4 tähte--
select left('abcdef', 4)
--paremalt 3--
select right('abcdef', 3)

--kuvab märgi asetust--
select charindex('@', 'sara@aaa.com')

--esimene nr näitab mitmendast alustab ja teine mitu nr loeb--
select substring('pam@bbb.com', 6, 7)

--@ märgist kuvab kolm tähte. viimase nr saab määrata pikkust--
select substring('pam@bbb.com', charindex('@', 'pam@bbb.com') + 1, 7)

--peale @ märki reguleerin tähemärkide pikkuse näitamist--
select substring('pam@bbb.com', charindex('@', 'pam@bbb.com') + 1, len('pam@bbb.com') - charindex('@', 'pam@bbb.com' ))

--
select substring (email, charindex('@', email) + 1, len(email) - charindex('@', email)) as emaildomain
from employees

alter table employees
add email nvarchar(20)

update Employees
set email = 'tom@aaa.com'
where id = 1
update Employees
set email = 'pam@bbb.com'
where id = 2
update Employees
set email = 'john@aaa.com'
where id = 3
update Employees
set email = 'sam@bbb.com'
where id = 4
update Employees
set email = 'todd@bbb.com'
where id = 5
update Employees
set email = 'ben@ccc.com'
where id = 6
update Employees
set email = 'sara@ccc.com'
where id = 7
update Employees
set email = 'Valarie@aaa.com'
where id = 8
update Employees
set email = 'James@bbb.com'
where id = 9
update Employees
set email = 'Russle@bbb.com'
where id = 10

select * from Employees

--lisame * märgiga teatud kohast--
select firstname, lastname, 
substring (email,1 ,2) + replicate('*',5) + --peale teist lisame viis tärni--
substring(email, charindex('@', email), len(email) - charindex('@', email)+1) as email  --kuni @ märgini e on dünaamiline--
from employees

--kolm korda näitab stringi--
select replicate('asd', 3)

--kuidas sisestada tühikut--
select space(5)

--tühikute arv kahe nime vahel--
select firstname + space(25) + lastname as fullname
from Employees

--PATINDEX--
--sama mis charindex aga saab kasutada wildcardi--
select email, PATINDEX('%@.com', email) as firstoccurance
from Employees
where PATINDEX('%@aaa.com', email) > 0  --leian kõik selle domeeni esindajad ja--
										--alates mitmendast märgist algab @--
--kõik .com on .net--
select email, replace(email, '.com', '.net') as convertedemail
from Employees

--soovin asendada peale inimest märki 3 tähte viie tärniga--
select firstname, lastname, email,
	stuff(email,2,3, '*****') as stuffedemail
from Employees

--
create table datetime
(
c_time time,
c_date date,
c_smalldatetime smalldatetime,
c_datetime datetime,
c_datetime2 datetime2,
c_datetimeoffset datetimeoffset
)
select * from datetime

--konkreetse masina kellaaeg--
select getdate(), 'getdate()'

--lisab info
insert into datetime 
values (getdate(),getdate(),getdate(),getdate(),getdate(),getdate())

--vahetab ära
update datetime set c_datetimeoffset = '2022-04-08 14:49:36.5000000 +10:00'
where c_datetimeoffset = '2022-04-08 14:49:36.5000000 +00:00'

--aja päring--
select CURRENT_TIMESTAMP, 'current_timestamp' --aja päring--
select SYSDATETIME(), 'sysdatetime' --täpsem aeg--
select SYSDATETIMEOFFSET(), 'SYSDATETIMEOFFSET' --täpne aeg koos ajalise nihkega utc suhtes--
select GETUTCDATE(), 'GETUTCDATE' --utc aeg--

select ISDATE('asd') --tagastab 0 kuna pole kuupäev--
select ISDATE(getdate()) --tagastab 1 kuna on--

select ISDATE('2022-04-08 14:49:36.5000000') --liiga palju komakohti--
select ISDATE('2022-04-08 14:49:36.500') --1--

select day(GETDATE()) --annab tänase päeva--
select day('01/31/2017') --annab tänase päeva numbri--
select day('31/1/2017') --peab olema õige järjestus--

select month(GETDATE()) --annab tänase kuu--
select month('01/31/2017') --annab tänase kuu numbri--

select year(GETDATE()) --annab tänase aasta--
select year('01/31/2017') --annab tänase aasta numbri--

select DATENAME(day, '2022-04-08 14:49:36.500') --annab selle päeva numbri--
select DATENAME(WEEKDAY, '2022-04-08 14:49:36.500') --annab selle päeva stringina (reede)--
select DATENAME(month, '2022-04-08 14:49:36.500') --annab selle kuu stringina--

table EmployeesWithDates
(
id nvarchar(2),
Name varchar(20),
DateOfBirth datetime
)

insert into EmployeesWithDates (id, Name, DateOfBirth)
values(1, 'Sam', '1980-12-30 00:00:00.000');
insert into EmployeesWithDates (id, Name, DateOfBirth)
values(2, 'Pam', '1982-09-01 12:02:36.260');
insert into EmployeesWithDates (id, Name, DateOfBirth)
values(3, 'John', '1985-08-22 12:03:30.370');
insert into EmployeesWithDates (id, Name, DateOfBirth)
values(4, 'Sara', '1979-11-29 12:59:30.670');
insert into EmployeesWithDates (id, Name, DateOfBirth)
values(5, 'mina', '2002-05-06 12:59:30.670');

--kuidas võtta ühest veerust andmeid ja selle abil luua uued veerud--
select Name, DateOfBirth, DATENAME(weekday, DateOfBirth) as [day], --võtab DoB veerust päeva ja kuvab nimetuse--
	MONTH(DateOfBirth) as MonthNumber, --vt DoB veerust kuupäeva ja kuvab kuu numbri--
	Datename(month, DateOfBirth) as [MonthName], --võtab veerust kuu ja kuvab sõnana--
	YEAR(DateOfBirth) as [Year] --võtab veerust aasta--
from EmployeesWithDates

select DATEPART(weekday, '2022-04-23 12:03:30.370') --kuvab 7 kuna ameerika--
select DATEPART(month, '2022-04-23 12:03:30.370') --kuvab kuu numbri--
select DATEadd(day, 20, '2022-04-23 12:03:30.370') --liidab stringis olevale kp 20 päeva juurde--
select DATEadd(day, -20, '2022-04-23 12:03:30.370') --lahutab 20 päeva--
select datediff(month, '11/30/2022', '01/30/2022') -- -10 päeva/kahe stringi vahe numbrina--
select datediff(year, '11/30/2020', '01/30/2022') -- kahe stringi vahe numbrina--

create function fnComputeAge(@DOB datetime)
returns nvarchar(50)
as begin
	declare @tempdate datetime, @years int, @months int, @days int
		select @tempdate = @DOB

		select @years = datediff(year, @tempdate, getdate()) - case when (month(@DOB) > month(getdate())) or (month(@DOB)
		= month(getdate()) and day(@DOB) > day(getdate())) then 1 else 0 end
		select @tempdate = DATEADD(year, @Years, @tempdate)

		select @months = DATEDIFF(month, @tempdate, getdate()) - case when day(@DOB) > day(getdate()) then 1 else 0 end
		select @tempdate = DATEDIFF(day, @tempdate, getdate())
	declare @Age nvarchar(50)
		set @Age = cast(@years as nvarchar(4)) + 'Years' + cast(@months as nvarchar(2)) + 'months' + cast(@days as nvarchar(2)) + 
		'days old'
	return @Age
end

--kasutaja vanus--
select Id, Name, DateOfBirth, dbo.fnComputeAge(DateOfBirth) as Age from EmployeesWithDates

select dbo.fnComputeAge('11/11/2014')

--nr peale dob muutujat näitab, mismoodi seda kuvada--
select Id, Name, dateOfBirth,
convert(nvarchar, DateOfBirth, 108) as ConvertedDOB
from EmployeesWithDates

select Id, Name, Name + ' - ' + cast(Id as nvarchar) as [Name-Id] from EmployeesWithDates
select CAST(getdate() as date) -- tänane kp--
select convert(date, getdate()) -- tänane kp--

--matemaatilised funktsioonid--

select abs(-101.5) --miinus võetakse ära--
select CEILING(15.2) --tagastab suurema läheb suuremaks--
select CEILING(-15.2) --tagastab väiksema, läheb suuremaks--
select FLOOR(15.2) --vastupidi--
select FLOOR(-15.2)
select power(2, 4) --2 astmes 4--
select SQUARE(3) --ruut--
select SQRT(81) --ruutjuur--

select RAND(1) --random--
select floor(rand()*100) --korrutab 100 suvalise arvu--

declare @counter int 
set @counter = 1
while (@counter <= 10)
	begin
		print floor(rand()*100)
		set @counter = @counter +1
end

select round(850.556, 2)		--ümardab kaks kohta peale koma--
select round(850.556, 2, 1)		--ümardab allapoole--
select round(850.556, 1)		--ümardab üles üks koht peale koma--
select round(850.556, 1, 1)		--ümardab alla--
select round(850.556, -2)		--ümardab täisnr üles--
select round(850.556, -1)		--ümardab täisnr alla--


create function CalculateAge (@DOB date)
returns int
as begin
declare @Age int

set @Age =DATEDIFF(year, @DOB, GETDATE()) - 
	case
		when (month(@DOB) > month(GETDATE())) or
			(month(@DOB) > month(getdate()) and day(@DOB) > day(getdate()))
		then 1
		else 0
		end
	return @Age
end

execute CalculateAge '10/08/2020'

--arvutab välja kui vana on isik ja võtab arvesse kuud ja päevad--
--antud juhul näitab kõiki, kes on üle 36--
select Id, Name, dbo.CalculateAge(DateOfBirth) as Age from EmployeesWithDates
where dbo.CalculateAge(DateOfBirth) > 20

--inline table valued functions--

alter table EmployeesWithDates
add DepartmentId int
alter table EmployeesWithDates
add Gender nvarchar(10)

select * from EmployeesWithDates

update EmployeesWithDates set Gender = 'Male', DepartmentId = 1 
where Id = 1
update EmployeesWithDates set Gender = 'Female', DepartmentId = 2
where Id = 2
update EmployeesWithDates set Gender = 'Male', DepartmentId = 1
where Id = 3
update EmployeesWithDates set Gender = 'Female', DepartmentId = 3
where Id = 4

insert into EmployeesWithDates (Id, Name, DateOfBirth, DepartmentId, Gender)
values (5, 'Todd', '1978-11-29 12:59:30.670', 1, 'Male')

--scalare function annab mingis vahemikus andmeid, aga inline table values
--ei kasuta begin ja end funktsioone. scalar annab väärtused ja inline tabeli--
create function fn_EmployeesByGender(@Gender nvarchar(10))
returns table
as 
return(select Id, Name, DateOfBirth, DepartmentId, Gender
	from EmployeesWithDates
	where Gender = @Gender)

--kõik female töötajad--
select * from fn_EmployeesByGender('Female')

select * from fn_EmployeesByGender('Female')
where name = 'Pam' --where abil saab täpsustada--

select * from Department

--kahest erinevast tabelist andmete võtmine ja kuvamine--
select Name, Gender, DepartmentName
from fn_EmployeesByGender('Male') E
join Department D on D.Id = E.DepartmentId

--multi-table statement--

create function fn_GetEmployees()
returns table as
return (Select Id, Name, cast(DateOfBirth as date) 
	as DOB
	from EmployeesWithDates)


--multi-state puhul peab defineerima uue tabeli veerud koos muutujatega--
create function fn_MS_GetEmployees()
returns @Table Table (Id int, Name nvarchar(20), DOB date)
as begin
	insert into @Table
	select Id, Name, Cast(DateOfBirth as date) from EmployeesWithDates

	return
end

select * from fn_MS_GetEmployees()

--inline tabeli funktsioonid on paremini töötamas kuna käsitletakse vaatena multi puhul
--on pm tegemist store proceduriga ja kulutab ressurssi rohkem--

update fn_GetEmployees() set Name = 'Sam1' where Id = 1 --saab muuta andmeid--
update fn_MS_GetEmployees() set Name = 'Sam1' where Id = 1 --ei saa muuta andmeid multistate puhul--

--deterministic ja non-deterministic--

select count(*) from EmployeesWithDates
select square(3) --kõik tehte märgid on deterministic funktsioonid. sinna kuuluvad veel sum, avg, square--

--non-deterministic--
select getdate()
sellect current_timestamp
select rand() --see funktsioon saab olla mõlemas kategoorias, oleneb kas sulgudes on üks või ei--

--loome funktsiooni--
create function fn_NameById(@Id int)
returns nvarchar(30)
as begin
	return (select name from EmployeesWithDates where Id = @Id)
end

select dbo.fn_GetNameById(4)

drop table EmployeesWithDates

create table EmployeesWithDates
(
Id int primary key,
Name nvarchar(20) NULL,
DateOfBirth datetime NULL,
Gender nvarchar(10) NULL,
DepartmentId int NULL
)

insert into EmployeesWithDates values(1, 'Sam', '1980-12-30 00:00:00.000', 'Male',1)
insert into EmployeesWithDates values(2, 'Pam', '1982-09-01 12:02:36.260', 'Female', 2)
insert into EmployeesWithDates values(3, 'John', '1985-08-22 12:03:30.370', 'Male', 1)
insert into EmployeesWithDates values(4, 'Sara', '1979-11-29 12:59:30.670', 'Female', 3)
insert into EmployeesWithDates values(5, 'Todd', '1978-11-29 12:59:30.670', 'Male', 1)

create function fn_GetEmployeeNameById(@Id int)
returns nvarchar(20)
as begin
	return(select Name from EmployeesWithDates where Id = @Id)
end

sp_helptext fn_GetEmployeeNameById

--peale seda ei näe funktsiooni sisu--
alter function fn_GetEmployeeNameById(@Id int)
returns nvarchar(20)
with encryption
as begin
	return(select Name from EmployeesWithDates where Id = @Id)
end

--muudame olevat funktsiooni--
alter function dbo.fn_GetEmployeeNameById(@Id int)
returns nvarchar(20)
with schemabinding
as begin
	return(select Name from dbo.EmployeesWithDates where Id = @Id)
end

--ei sa ära kustutada--
drop table dbo.EmployeesWithDates

------------------------------------------------

--# MÄRGI ette panemisel saame aru, et tegemist on temp tableiga--
--seda tabelit saab ainult selles päringus avada--
create table #PersonDetail(Id int, Name nvarchar(20))

insert into #PersonDetail values(1, 'Mike')
insert into #PersonDetail values(2, 'John')
insert into #PersonDetail values(3, 'Todd')

select * from #PersonDetail

select Name from sysobjects
where Name like '#PersonDetail%'

--kustuta temp table--

drop table #PersonDetail

create proc spCreateLocalTempTable
as begin
create table #PersonDetails(Id int, Name varchar(20))

insert into #PersonDetails values(1, 'Mike')
insert into #PersonDetails values(2, 'John')
insert into #PersonDetails values(3, 'Todd')

end

exec spCreateLocalTempTable

--globaalse temptable tegemine--

create table ##PersonDetails(Id int, Name varchar(20))

--index--

create table EmployeeWithSalary
(
Id int primary key,
Name nvarchar(20),
Salary int,
Gender nvarchar(20)
)

insert into EmployeeWithSalary values (1, 'Sam', 2500, 'Male')
insert into EmployeeWithSalary values (2, 'Pam', 6500, 'Female')
insert into EmployeeWithSalary values (3, 'John', 4500, 'Male')
insert into EmployeeWithSalary values (4, 'Sara', 5500, 'Female')
insert into EmployeeWithSalary values (5, 'Todd', 3100, 'Male')

select * from EmployeeWithSalary
where Salary > 5000 and Salary < 7000

--loome indeksi, mis asetab palga kahanevasse järjestusse--

create index IX_EmployeeSalary
on EmployeeWithSalary (Salary asc)

--saame teada, et mis selle tabeli primaarvõti ja indeks--
EXEC sys.sp_helpindex @objname = 'EmaployeeWithSalary'

--saame vaadata tabelit koos selle sisuga--


-- indeksi kustutamine--
drop index EmployeeWithSalary.IX_EmployeeSalary

---indeksi tüübid--
--1. klastrites olevad
--2. mitte klastris
--3. unikaalsed
--4. filtreeritud
--5. XML
--6. täistekst
--7. ruumiline
--8. veerusäilitav
--9. veergude indeksid
--10. välja arvatud veergudega indeksid

--klastris olev index määrab ära tabelis oleva füüsilist järjestust
--ja selle tulemusel saab tabelis olla ainult üks klastreeritud indeks--

drop table EmployeeWithSalary

create table EmployeeCity
(
Id int primary key,
Name nvarchar(20),
Salary int,
Gender nvarchar(20),
City nvarchar(20)
)

exec sp_helpindex EmployeeCity

--andmete järjestuse loovad klastris olevad indeksid ja kasutab selleks id numbrit--
--põhjus, miks antud juhul kasutab Idd, tuleneb primaarvõtmest--
insert into EmployeeCity values (3, 'John', 4500, 'Male', 'New York')
insert into EmployeeCity values (1, 'Sam', 2500, 'Male', 'London')
insert into EmployeeCity values (4, 'Sara', 5500, 'Female', 'Tokyo')
insert into EmployeeCity values (5, 'Todd', 3100, 'Male', 'Toronto')
insert into EmployeeCity values (2, 'Pam', 6500, 'Female', 'Sydney')

--klastris olevad indeksid dikrteerivad andmete järjestuse tabelis ja seda saab klastrite puhul ainult üks--
select * from EmployeeCity

create clustered index IX_EmployeeCity_Name
on EmployeeCity(Name)

--annab veateate, et tabelis saab olla ainult üks klastris olev index
--kui soovid uut indexit luua, siis kustuta olemasolev--

--saame luua ainult ühe klastris oleva indeksi tabeli peale--
--klastris olev indeks on analoogne telefoni suunakoodile--

--loome composite indeksi--
--enne tuleb kõik teised klustris olevad indeksid ära kustutada--

create clustered index IX_EmployeeCity_Gender_Salary
on EmployeeCity(Gender desc, Salary asc)
--kui select teeb päringu tabelile siis peaksid nägema andmeid, mis on järjestatud selliselt--
--esimeseks võetakse Gender kahanevas järjekorras ja siis Salary tõusvas järjestuses--

select * from EmployeeCity

--mitte klastris olev indeks--

create nonclustered index IX_EmployeeCity_Name
on EmployeeCity(Name)

--teeme päringu tabelile--

select * from EmployeeCity

--erinevused kahe indexi vahel:--
--1. ainult üks klastris olev indeks saab olla tahvli peale, mitte klastris olevaid saab olla mitu--
--2. klastris olevad indeksid on kiiremad kuna indeks peab tagasi viitama tabelile--
-- juhul kui selekteeritud veerg ei ole olemas indeksis--
--3. klastris olev indeks määratleb ära tabeliridade salvestusjärjestuse ja ei nõua lisa ruumi
-- samas mitte kklastris olevad indeksid on salvestatud tabelist eraldi ja nõuab lisaruumi--

create table EmployeeFirstName
(
	Id int primary key,
	FirstName nvarchar(20),
	LastName nvarchar(20),
	Salary int,
	Gender nvarchar(20),
	City nvarchar(20)
)

exec sp_helpindex EmployeeFirstName

--ei saa sisestada kahte samasuguse id väärtusega rida
insert into EmployeeFirstName values (1, 'Mike', 'Sandoz', 4500, 'Male', 'New York') 
insert into EmployeeFirstName values (1, 'John', 'Menco', 2500, 'Male', 'London') 

--
drop index EmployeeFirstName.PK__Employee__3214EC07D28EC8EB
--kui käivitad ülevalpool oleva koodi, siis tuleb veateade,
--et SQL server kasutab unique indeksit jõustamaks väärtuste unikaalsust ja primaarvõtit--
--koodika unikaalseid indekseid ei saa kustutada, aga käsitsi saab--

--sisestame uuesti kaks koodirida andmeid--
insert into EmployeeFirstName values (1, 'Mike', 'Sandoz', 4500, 'Male', 'New York') 
insert into EmployeeFirstName values (1, 'John', 'Menco', 2500, 'Male', 'London') 

--unikaalset indeksid kasutatakse kindlustamaks väärtuse unikaalsust--
--mõlemat tüüpi indeksid saavad olla unikaalsed

create unique nonclustered index UIX_Employee_FirstName_LastName
on EmployeeFirstName(FirstName, LastName)
--alguses annab veateate, et mike sandozst on kaks korda
--kustutame tabeli ja sisestame andmed uuesti--
--ei saa lisada mitte-klastris olevat indeksit, kui ei ole unikaalseid andmeid--
update EmployeeFirstName
set Id = 2
where Id = 1

select * from EmployeeFirstName

insert into EmployeeFirstName values (1, 'Mike', 'Sandoz', 4500, 'Male', 'New York') 
insert into EmployeeFirstName values (2, 'John', 'Menco', 2500, 'Male', 'London') 
--lisame unikaalse piirangu--

alter table EmployeeFirstName
add constraint UQ_EmployeeFirstName_City
unique nonclustered(City)

--ei luba tabelis väärtustega uut Londonit
insert into EmployeeFirstName values (3, 'John', 'Menco', 3500, 'Male', 'London') 

--saab vaadata indeksite nimekirja 
exec sp_helpconstraint EmployeeFirstName

--1. Vaikimisi primaarvõti loob unikaalse klastris oleva indeksi, samas unikaalne piirang loob
--	 unikaalse mitte-klastris oleva indeksi
--2. Unikaalset indeksit või piirangut ei saa luua olemasolevasse tabelisse, kui tabel juba sisaldab
--	 väärtusi võtmeveerus
--3. Vaikimisi korduvaid väärtuseid ei ole veerus lubatud, kui peaks olema unikaalne indeks või piirang.
--	 nt. kui tahad sisestada 10 rida andmeid, millest 5 sisaldavad lprfuvaid andmeid, siis kõik 10
--   lüüakse tagasi. kui soovin ainult 5 rea tagasi lükkamist ja ülejäänud 5 rea sisestamist , siis selleks 
--   kasutatakse IGNORE_DUP_KEY
--   näide:
create unique index IX_EmployeeFirstName
on EmployeeFirstName(City)
with ignore_dup_key

insert into EmployeeFirstName values (2, 'John', 'Menco', 2500, 'Male', 'London') 
insert into EmployeeFirstName values (4, 'John', 'Menco', 2123, 'Male', 'London1') 
insert into EmployeeFirstName values (4, 'John', 'Menco', 2220, 'Male', 'London1') 
--enne ignore käsku oleks kõik kolm rida tagasi lükatud, aga nüüd läks keskmine rida läbi,
--kuna linna nimi oli unikaalne--

--view on salvestatud SQL päring. seda saab käsitleda ka virtuaalse tabelina--

select FirstName, Salary, Gender, DepartmentName
from Employees
join Department
on Employees.DepartmentId = Department.Id 


select FirstName, Salary, Gender, DepartmentId
from Employees

--loome view--

create view vEmployeesByDepartment
as
select FirstName, Salary, Gender, DepartmentName
from Employees
join Department
on Employees.DepartmentId = Department.Id 

--view päringu esile kutsumine--
select * from vEmployeesByDepartment

--view ei salvesta andmeid vaikimisi seda tasub võtta, kui salvestatud virtuaalse tabelina--

--milleks vaja:--
--saab kasutada andmebaasi skeemi keerukuse lihtsustamiseks, mitte IT-inimesele--
--piiratud ligipääs andmetele, ei näe kõiki veerge--

--teeme veeru, kus näeb ainult töötajaid--
create view vITEmployeesByDepartment
as
select FirstName, Salary, Gender, DepartmentName
from Employees
join Department
on Employees.DepartmentId = Department.Id 
where Department.DepartmentName = 'IT'
--ülevalpool olevat päringut saab liigitada reataseme turvalisuse alla-- 
--tahan ainult näidata IT osakonna töötajaid--

select* from vITEmployeesByDepartment

--veeru taseme turvalisus--
--peale selecti määratled veergude näitamise ära--
create view vEmployeesByDepartmentSalaryNoShow
as
select FirstName, Gender, DepartmentName
from Employees
join Department
on Employees.DepartmentId = Department.Id 

select* from vEmployeesByDepartmentSalaryNoShow

--saab kasutada esitlemaks koondandmeid ja üksikasjalike andmeid--
--view, mis tagastab summeeritud andmeid--
create view vEmployeesCountByDepartment
as
select DepartmentName, count(Employees.Id) as TotalEmployees
from Employees
join Department
on Employees.DepartmentId = Department.Id 
group by DepartmentName

select* from vEmployeesCountByDepartment

--kui soovid vaadata view sisu--
sp_helptext vEmployeesCountByDepartment
--muuta--
alter view vEmployeesCountByDepartment
--kustutada--
drop view vEmployeesCountByDepartment

--view uuendused--
--saab uuendada andmeid--

--teeme andmete uuenduse, aga enne teeme view--
update vEmployeesDataExceptSalary
set [FirstName] = 'Tom' where Id = 2

create view vEmployeesDataExceptSalary
as 
select Employees.Id, FirstName, Gender, DepartmentId
from Employees

--kustutame ja sisestame andmeid--

delete from vEmployeesDataExceptSalary where Id = 2
insert into vEmployeesDataExceptSalary (Id, Gender, DepartmentId, FirstName)
values(2, 'Female', 2, 'Pam')

--indekseeritud view--

--MS SQLs on indekseeritud view nime all ja Oracles materjaliseeritud view--
create table Product
(
Id int primary key, 
Name nvarchar(20),
UnitPrice int
)

insert into Product values (1, 'Books', 20)
insert into Product values (2, 'Pens', 14)
insert into Product values (3, 'Pencils', 11)
insert into Product values (4, 'Clips', 10)

create table ProductSales
(
Id int, 
QuantitySold int
)

insert into ProductSales values(1,10)
insert into ProductSales values(3,23)
insert into ProductSales values(4,21)
insert into ProductSales values(2,12)
insert into ProductSales values(1,13)
insert into ProductSales values(3,12)
insert into ProductSales values(4,13)
insert into ProductSales values(1,11)
insert into ProductSales values(2,12)
insert into ProductSales values(1,14)

--loome view, mis annab meile veerud TotalSales ja TotalTransaction

create view vTotalSalesByProduct
with schemabinding
as 
select Name, 
sum(isnull((QuantitySold * UnitPrice), 0)) as TotalSales,
count_big(*) as TotalTransactions
from dbo.ProductSales
join dbo.Product
on dbo.Product.Id = dbo.ProductSales.Id
Group by Name

--kui soovid luua indeksi view sisse, siis peab järgima teatud reegleid--
--1. view tuleb luua kus schemabindinguga--
--2. kui lisafunktsioon select list viitab väljendile ja selle tulemuseks võib olla NULL, siis asendusväärtus
--   peaks olema täpsustatud. Antud juhul kasutasime ISNULL funktsiooni asendamaks NULL väärtust.--
--3. kui GroupBy on täpsustatud, siis view select list üeab sisaldama COUNT_BIG(*) väljendit--
--4. Baastabelis view peaksid olema viidatud kaheosalise nimega e antud juhul dbo.Product = dbo.ProductSales--

---------------------------------------------------

create unique clustered index UIX_vTotalSalesByProduct_Name
on vTotalSalesByProduct(Name)
--paneb selle view tähestikulisse järjestusse--

--view piirang--

create view vEmployeeDetails
@Gender nvarchar(20)
as
Select Id, FirstName, Gender, DepartmentId
from Employees
where Gender = @Gender

--vaatesse ei saa kaasa panna parameetreid ehk antud juhul Gender

create function fnEmployeeDetails(@Gender nvarchar (20))
returns table
as return
(select Id, FirstName,Gender, DepartmentId
from Employees where Gender = @Gender)

--funktsiooni esile kutsumine koos parameetriga--
select * from fnEmployeeDetails('male')

--order by kasutamine--

create view vEmployeeDetailsSorted
as
select Id, FirstName, Gender, DepartmentId
from Employees
order by Id

--TEMP TABLE kasutamine--

create table ##TestTempTable(Id int, FirstName varchar(20), Gender nvarchar(10))

insert into ##TestTempTable values(101, 'Martin', 'Male')
insert into ##TestTempTable values(102, 'Joy', 'Female')
insert into ##TestTempTable values(103, 'Pam', 'Female')
insert into ##TestTempTable values(104, 'James', 'Male')

--sisestame andmed--

create view vOnTempTable
as
select Id, FirstName, Gender
from ##TestTempTable

--TRIGGERS--

--DML triggers--
--kokku kolm: DML, DDL, LOGON--

--trigger on eriliik stored procedure'ist, mis automaatselt käivitub, kui mingi tegevus peaks
--andmebaasis aset leidma--

--DML - data manipulation languange--
--insert, update, delete--

--DML triggereid saab klasifitseerida kahte tüüpi:
--1. after trigger(for trigger)
--2. instead of trigger (selmet trigger või selle asemel trigger)

--after trigger käivitub peale sündmust, kui kuskil on tehtud insert, update ja delete--

--kasutame Employees tabelit--

--loome uue tabeli--

create table EmployeeAudit
(
Id int identity(1, 1) primary key,
AuditData nvarchar(1000)
)

--peale iga töötaja sisestamist tahame teada saada töötaja Id'd, päeva ning aega(millal sisestati)--

--kõik andmed tulevad EmployeeAudit tabelisse--

create trigger trEmployeeForInsert
on Employees
for insert
as begin
Declare @Id int
select @Id = Id from inserted
insert into EmployeeAudit
values ('New employee with Id = ' + cast(@Id as nvarchar(5))+ ' is added at ' + cast(getdate() as nvarchar(20)))
end

select * from Employees

insert into Employees values (11, 'Male', 3000, 1, 3, 'Bob', 'Blob', 'Bomb', 'bob@bomb.com')

select * from EmployeeAudit

--delete trigger--

create trigger trEmployeeForDelete
on Employees
for delete
as begin
	declare @Id int
	select @Id = Id from deleted

	inserted into EmployeeAudit
	values('An existing employee with Id = '+cast(@Id as nvarchar(5)) + ' is deleted at '+
	cast(GETDATE() as nvarchar(20)))
end

delete from Employees where Id = 11

select * from EmployeeAudit 

--update trigger

create trigger trEmployeeForUpdate
on Employees
for update
as begin
	--muutujate deklareerimine--
	declare @Id int
	declare @OldGender nvarchar(20), @NewGender nvarchar(20)
	declare @OldSalary int, @NewSalary int
	declare @OldDepartmentId int, @NewDepartmentId int
	declare @OldManagerId int, @NewManagerId int
	declare @OldFirstName nvarchar(20), @NewFirstName nvarchar(20)
	declare @OldMiddleName nvarchar(20), @NewMiddleName nvarchar(20)
	declare @OldLastName nvarchar(20), @NewLastName nvarchar(20)
	declare @OldEmail nvarchar(20), @NewEmail nvarchar(20)

	--muutuja kuhu läheb lõpptekst--
	declare @AuditString nvarchar(1000)

	--laeb kõik uuendatud andmed temp table alla--
	select * into #TempTable
	from inserted

	--käib läbi kõik andmed temp table'is--
	while(exists(select Id from #TempTable))
	begin
		set @AuditString = ''

		--selekteerib esimese rea andmedtemp table'ist--
		select top 1 @Id = Id, @NewGender = Gender, @NewSalary = Salary, @NewDepartmentId = DepartmentId, 
		@NewManagerId = ManagerId, @NewFirstName = FirstName, @NewMiddleName = MiddleName, @NewLastName = LastName,
		@NewEmail = Email
		from #TempTable
		--võtab vanad andmed kustutatud tabelist--
		select @OldGender = Gender, @OldSalary = Salary, @OldDepartmentId = DepartmentId, @OldManagerId = ManagerId,
		@OldFirstName = FirstName, @OldMiddleName = MiddleName, @OldLastName = LastName, @OldEmail = Email
		from deleted where Id = @Id

		--loob auditi stringi dünaamiliselt--
		set @AuditString = 'Employee with Id= '+cast(@Id as nvarchar(20))+'changed'
		if (@OldGender <> @NewGender)
			set @AuditString = @AuditString + ' Gender from '+@OldGender +' to '+@NewGender

		if (@OldSalary <> @NewSalary)
			set @AuditString = @AuditString + ' Gender from '+cast(@OldSalary as nvarchar(20))+ ' to '+ cast(@NewSalary as nvarchar(20))

		if (@OldDepartmentId <> @NewDepartmentId)
			set @AuditString = @AuditString + ' Gender from '+cast(@OldDepartmentId as nvarchar(20))+ ' to '+ cast(@NewDepartmentId as nvarchar(20))

		if (@OldManagerId <> @NewManagerId)
			set @AuditString = @AuditString + ' Gender from '+cast(@OldManagerId as nvarchar(20)) +' to '+ cast(@NewManagerId as nvarchar(20))

		if (@OldFirstName <> @NewFirstName)
			set @AuditString = @AuditString + ' Gender from '+@OldFirstName +' to '+@NewFirstName

		if (@OldMiddleName <> @NewMiddleName)
			set @AuditString = @AuditString + ' Gender from '+@OldMiddleName +' to '+@NewMiddleName

		if (@OldLastName <> @NewLastName)
			set @AuditString = @AuditString + ' Gender from '+@OldLastName +' to '+@NewLastName

		if (@OldEmail <> @NewEmail)
			set @AuditString = @AuditString + ' Gender from '+@OldEmail +' to '+@NewEmail

		insert into dbo.EmployeeAudit values (@AuditString)
		--kustutab temp table'ist rea, et saaksime liikuda uue rea juurde--
		delete from #TempTable where Id = @Id
	end
end

update Employees set FirstName = 'Bob123', Salary=3000, MiddleName = 'test456'
where Id=10

select*from Employees
select*from EmployeeAudit

--instead of trigger--

create table Employee
(
Id int primary key,
FirstName nvarchar(20),
Gender nvarchar(20),
DepartmentId int,
)

insert into Employee values(1, 'John', 'Male', 3)
insert into Employee values(2, 'Mike', 'Male', 2)
insert into Employee values(3, 'Pam', 'Female', 1)
insert into Employee values(4, 'Todd', 'Male', 4)
insert into Employee values(5, 'Sara', 'Female', 1)
insert into Employee values(6, 'Ben', 'Male', 3)

select * from Employee

create view vEmployeeDetails
as
select Employee.Id, FirstName, Gender, DepartmentName
from Employee
join Department
on Employee.DepartmentId = Department.Id

select * from vEmployeeDetails

insert into vEmployeeDetails values(7, 'Valarie', 'Female', 'IT')
--tuleb veateade--
--nüüd vaatame kuidas saab instead of triggeriga seda probleemi lahendada--

create trigger tr_EmployeeDetails_InstedOfInsert
on vEmployeeDetails
instead of insert 
as begin
declare @DeptId int

	select @DeptId = dbo.Department.Id
	from Department
	join inserted
	on inserted.DepartmentName = Department.DepartmentHead

	if(@DeptId is null)
		begin
		raiserror('Invalid department name. Statement terminated.', 16, 1)
		return
	end

--update Employee set DepartmentId = @DeptId
--from inserted
--join Employee.Id = inserted.Id
--end

insert into dbo.Employee(Id, FirstName, Gender, DepartmentId)
select Id, FirstName, Gender, @DeptId
from inserted
end

--raiserror funktsioon--
--selle eesmärk on tuua välja veateade, kui DepartmentName veerus eiole  väärtust ja ei klapi uue sisestatud väärtustega--
--esimene pn parameeter on veateate sisu, teine on veataseme nr (nr 16 näitab vigu), kolmas on olek--

delete from Employee where Id = 7

update vEmployeeDetails
set FirstName = 'Johny', DepartmentName = 'IT'
where Id = 1
--ei saa uuendada andmeid kuna mitu tabelit on sellest mõjutatud--

update vEmployeeDetails
set DepartmentName = 'IT'
where Id = 1

select * from vEmployeeDetails

create trigger tr_vEmployeeDetails_IsteadOfUpdate
on vEmployeeDetails
instead of update
as begin
	if(UPDATE(Id))
	begin
		raiserror('Id cannot be changed', 16, 1)
		return
	end

	if(update(DepartmentName))
	begin
		declare @DeptId int
		select @DeptId = Department.Id
		from Department
		join inserted
		on inserted.DepartmentName = Department.DepartmentName

		if (@DeptId is null)
		begin
			raiserror('Invalid department name', 16,1)
			return
		end

		update Employee set DepartmentId = @DeptId
		from inserted
		join Employee
		on Employee.Id = inserted.Id
	end

	if(update(Gender))
	begin
		update Employee set Gender = inserted.Gender
		from inserted
		join Employee
		on Employee.Id = inserted.Id
	end

	if(update(FirstName))
	begin
		update Employee set FirstName = inserted.FirstName
		from inserted
		join Employee
		on Employee.Id = inserted.Id
	end
end

update Employee set FirstName = 'John', Gender='Male', DepartmentId =3
where Id = 1


---------------------------

create view vEmployeeCount
as
select DepartmentId, DepartmentName, count(*) as TotalEmployees
from Employee
join Department
on Employee.DepartmentId = Department.Id
group by DepartmentName, DepartmentId

select * from vEmployeeCount

--näitab ära oskonnad, kus töötajaid on 2tk või rohkem--
select DepartmentName, TotalEmployees from vEmployeeCount
where TotalEmployees >= 2

select DepartmentName, DepartmentId, count(*) as TotalEmployees
into #TempEmployeeCount
from Employee
join Department
on Employee.DepartmentId = Department.Id
group by DepartmentName, DepartmentId 

select * from #TempEmployeeCount

select DepartmentName, DepartmentId
from #TempEmployeeCount
where TotalEmployees >= 2

create trigger trEmployeeDetails_InstedOfDelete
on vEmployeeDetails
instead of delete
as begin
delete Employee
from Employee
join deleted
on Employee.Id = deleted.Id
end

--teha ise kustutamine tabelis--

--delete from dbo.vEmployeeDetails(Gender)
--select Gender
--from Employee
--end

create view vEmployeeDetails_InsteadOfDelete
as
select Employee.Id, FirstName, Gender, DepartmentName 
from Employee
join Department
on Employee.DepartmentId = Department.Id

delete from dbo.vEmployeeDetails where Id = 1

--päritud tabelid ja cte--

--cte tähendab common table expression--

select * from Employee

--cte--

with EmployeeCount(DepartmentName, DepartmentId, TotalEmployees)
as
	(
	select DepartmentName, DepartmentId, COUNT(*) as TotalEmployees
	from Employee
	join Department
	on Employee.DepartmentId = Department.Id
	group by DepartmentName, DepartmentId
	)
select DepartmentName, TotalEmployees
from EmployeeCount
where TotalEmployees >=2

--cte'd võivad sarnaneda temp table'ga--
--sarnane päritud tabelile ja ei ole salvestatud objektina
--ning kestab päringu ulatuses--

--päritud tabel--

select DepartmentName, TotalEmployees
from
(
select DepartmentName, DepartmentId, COUNT(*) as TotalEmployees
from Employee
join Department
on Employee.DepartmentId= Department.Id
group by DepartmentName, DepartmentId
)
as EmployeeCount
where TotalEmployees >=2

--mitu cte'd järjest--

with EmployeeCountBy_Payroll_IT_Dept(DepartmentName, Total)
as
(
	select DepartmentName, COUNT(Employee.Id) as TotalEmployees
	from Employee
	join Department
	on Employee.DepartmentId=Department.Id
	where DepartmentName in ('Payroll', 'IT')
	group by DepartmentName
),
--peale kome panemist saad uue cte juurde lisada--
EmployeesCountBy_HR_Admin_Dept(DepartmentName, Total)
as
(
	select DepartmentName, COUNT(Employee.Id) as TotalEmployees
	from Employee
	join Department
	on Employee.DepartmentId = Department.Id
	group by DepartmentName
)
--kui on kaks cte'd, siis unioni abil ühendab päringu--
select * from EmployeesCountBy_HR_Admin_Dept
union
select * from EmployeeCountBy_Payroll_IT_Dept

--
with EmployeeCount(DepartmentId, TotalEmployees)
as
	(
	select DepartmentId, count(*) as TotalEmployees
	from Employee
	group by DepartmentId
	)
--select 'Hello'
--üeale cte'd peab kohe tulema käsklus select, insert, update või delete--
--kui proovid midagi muud, siis tuleb veateade--
select DepartmentName, TotalEmployees
from Department
join EmployeeCount
on Department.Id = EmployeeCount.DepartmentId
order by TotalEmployees

--uuendamine cte's--

--loome lihtsa cte--

with Employees_Name_Gender
as
(
	select Id, FirstName, Gender from Employee
)
select * from Employees_Name_Gender

--uuendame andmeid--

with Employees_Name_Gender
as
(
	select Id, FirstName, Gender from Employee
)
update Employees_Name_Gender set Gender = 'Female' where Id = 1

select * from Employee

--kasutame join'i cte tegemisel
with EmployeesByDepartment
as
(
select Employee.Id, FirstName, Gender, DepartmentName
from Employee
join Department
on Department.Id = Employee.DepartmentId
)
select * from EmployeesByDepartment

---kasutame join'i ja muudame m'lemas tabelis andmeid--

with EmployeesByDepartment
as
(
select Employee.Id, FirstName, Gender, DepartmentName
from Employee
join Department
on Department.Id = Employee.DepartmentId
)
update EmployeesByDepartment set Gender = 'Female' where Id = 1
)

---kasutame join'i ja muudame m'lemas tabelis andmeid--

with EmployeesByDepartment
as
(
select Employee.Id, FirstName, Gender, DepartmentName
from Employee
join Department
on Department.Id = Employee.DepartmentId
)
update EmployeesByDepartment set Gender = 'Male', DepartmentName = 'IT'
where Id = 1

--ei luba mitmes tabelis korraga muuta--

with EmployeesByDepartment
as
(
select Employee.Id, FirstName, Gender, DepartmentName
from Employee
join Department
on Department.Id = Employee.DepartmentId
)
update EmployeesByDepartment set DepartmentName = 'IT'
where Id = 1

--kokkuvõtte--
--1. kui cte baseerub ühel tabelil, siis uuendus töötab--
--2. kui cte baseerub mitmel tabelil, siis tuleb veateade--
--3. kui cte baseerub mitmel tabelil ja tahame muuta ainult üht, siisuuendus saab tehtud--

--korduv cte--

--cte, mis iseendale viitab, kutsutakse korduvaks cte'ks kui tahad näidata andmeid hierarhiliselt--

select * from Employee

truncate table Employee

insert into Employee values (1, 'Tom',null, 2)
insert into Employee values (2, 'Josh',null, null)
insert into Employee values (3, 'Mike',null, 2)
insert into Employee values (4, 'John',null, 3)
insert into Employee values (5, 'Pam',null, 1)
insert into Employee values (6, 'Mary',null, 3)
insert into Employee values (7, 'James',null, 1)
insert into Employee values (8, 'Sam',null, 5)
insert into Employee values (9, 'Simon',null, 1)

--self join ja kuvada null veeu asemel super boss--

select Emp.FirstName as [Employee Name],
ISNULL(Manager.FirstName, 'Super Boss') as [Manager Name]
from dbo.Employee Emp
left join Employee Manager
on Emp.ManagerId = Manager.Id

with EmployeesCTE(Id, FirstName, ManagerId, [Level])
as
(
	select Employee.Id, FirstName, ManagerId, 1
	from Employee
	where ManagerId is null

	union all

	select Employee.Id, Employee.FirstName,
	Employee.ManagerId, EmployeesCTE.[Level] +1
	from Employee
	join EmployeesCTE
	on Employee.ManagerId=EmployeesCTE.Id
)
select EmpCTE.FirstName as Employee, isnull(MgrCTE.FirstName, 'Super Boss') as Manager, EmpCTE.[Level]
from EmployeesCTE EmpCTE
left join EmployeesCTE MgrCTE
on EmpCTE.ManagerId = MgrCTE.Id

---pivot--

create table ProductSales
(
SalesAgent nvarchar(50),
SalesCountry nvarchar(50),
SalesAmount int
)

insert into ProductSales values('Tom', 'UK', 200)
insert into ProductSales values('John', 'US', 180)
insert into ProductSales values('John', 'UK', 260)
insert into ProductSales values('David', 'India', 450)
insert into ProductSales values('Tom', 'India', 350)

insert into ProductSales values('David', 'US', 200)
insert into ProductSales values('Tom', 'US', 130)
insert into ProductSales values('John', 'India', 540)
insert into ProductSales values('John', 'UK', 120)
insert into ProductSales values('David', 'UK', 220)

insert into ProductSales values('John', 'UK', 420)
insert into ProductSales values('David', 'US', 320)
insert into ProductSales values('Tom', 'US', 340)
insert into ProductSales values('Tom', 'UK', 660)
insert into ProductSales values('John', 'India', 430)

insert into ProductSales values('David', 'India', 230)
insert into ProductSales values('David', 'India', 280)
insert into ProductSales values('Tom', 'UK', 480)
insert into ProductSales values('John', 'UK', 360)
insert into ProductSales values('David', 'UK', 140)

---

select SalesCountry, SalesAgent, sum(SalesAmount) as Total
from ProductSales
group by SalesCountry, SalesAgent
order by SalesCountry, SalesAgent

--pivot näide--

select SalesAgent, India, US, UK
from ProductSales
pivot
(
sum(SalesAmount) for SalesCountry in([India], [US], [UK])
)
as PivotTable

---päring muudab unikaalsete veergude väärtust (India, US, UK) SalesCountry veeus omaette veergudeks
---koos veergude SalesAmount liitmisega--

create table ProductSalesWithId
(
Id int primary key,
SalesAgent nvarchar(50),
SalesCountry nvarchar(50),
SalesAmount int
)

insert into ProductSalesWithId values(1,'Tom', 'UK', 200)
insert into ProductSalesWithId values(2,'John', 'US', 180)
insert into ProductSalesWithId values(3,'John', 'UK', 260)
insert into ProductSalesWithId values(4,'David', 'India', 450)
insert into ProductSalesWithId values(5,'Tom', 'India', 350)

insert into ProductSalesWithId values(6,'David', 'US', 200)
insert into ProductSalesWithId values(7,'Tom', 'US', 130)
insert into ProductSalesWithId values(8,'John', 'India', 540)
insert into ProductSalesWithId values(9,'John', 'UK', 120)
insert into ProductSalesWithId values(10,'David', 'UK', 220)

insert into ProductSalesWithId values(11,'John', 'UK', 420)
insert into ProductSalesWithId values(12,'David', 'US', 320)
insert into ProductSalesWithId values(13,'Tom', 'US', 340)
insert into ProductSalesWithId values(14,'Tom', 'UK', 660)
insert into ProductSalesWithId values(15,'John', 'India', 430)

insert into ProductSalesWithId values(16,'David', 'India', 230)
insert into ProductSalesWithId values(17,'David', 'India', 280)
insert into ProductSalesWithId values(18,'Tom', 'UK', 480)
insert into ProductSalesWithId values(19,'John', 'UK', 360)
insert into ProductSalesWithId values(20,'David', 'UK', 140)

select India, US, UK
from ProductSalesWithId
pivot
(
sum(SalesAmount) for SalesCountry in ([India],[US],[UK])
)
as PivotTable

--põhjuseks on id olemas olu, mida võetakse arvesse pööramise ja grupeerimise järgi--

select SalesAgent, India, US, UK
from 
(
	select SalesAgent, SalesCountry, SalesAmount from ProductSalesWithId
)
as SourceTable
pivot
(
sum(SalesAmount) for SalesCountry in (India, US, UK)
)
as PivotTable
------
SELECT Id, fromagent,countryoragent
FROM  
    (
	SELECT Id, SalesAgent, SalesCountry, SalesAmount from ProductSalesWithId
	)   
    as alias  
UNPIVOT  
(  
    countryoragent FOR fromagent IN (SalesAgent, SalesCountry)  
) 
AS pivotasi 

--------------------------------------------

--transaction--

--transaction jälgib järgmisi samme:--
--1. selle algus--
--2. käivitab DB käske--
--3. kontrollib vigu. kui on viga siis taastab algse oleku--

create table MailingAddress
(
Id int not null primary key,
EmployeeNumber int,
Housenumber nvarchar(50),
StreetAddress nvarchar(50),
City nvarchar(10),
Postalcode nvarchar(20)
)

insert into MailingAddress values(1, 101, '#10', 'King Street', 'Londoon', 'CR27DW')

create table PhysicalAddress
(
Id int not null primary key,
EmployeeNumber int,
Housenumber nvarchar(50),
StreetAddress nvarchar(50),
City nvarchar(10),
Postalcode nvarchar(20)
)

insert into PhysicalAddress values(1, 101, '#10', 'King Street', 'Londoon', 'CR27DW')

create proc spUpdateAddress
as begin
	begin try
		begin transaction
			update MailingAddress set City='LONDON'
			where MailingAddress.Id = 1 and EmployeeNumber= 101

			update PhysicalAddress set City = 'LONDON'
			where PhysicalAddress.Id = 1 and EmployeeNumber = 101

		commit transaction
	end try
	begin catch
		rollback tran
	end catch
end

--käivitame sp--
spUpdateAddress

select*from MailingAddress
select * from PhysicalAddress

--muudame--
alter proc spUpdateAddress
as begin
	begin try
		begin transaction
			update MailingAddress set City='LONDON 12'
			where MailingAddress.Id = 1 and EmployeeNumber= 101

			update PhysicalAddress set City = 'LONDON LONDON'
			where PhysicalAddress.Id = 1 and EmployeeNumber = 101

		commit transaction
	end try
	begin catch
		rollback tran
	end catch
end

select*from MailingAddress
select * from PhysicalAddress

--kui teine uuendus ei lähe läbi, siis esimene ei lähe ka läbi--
--kõik uuendused peavad läbi minema--

--transaction ACID test--

--educas transaction peab läbima ACID testi:--
-- A-atomic e aatomlikus--
-- C-consistent e järjepidevus--
-- I-isolated e isoleeritud--
-- D-durable e vastupidav--

-- ATOMIC - kõik tehingud transactionis on kas edukalt täidetud või need lükatakse tagasi
--		nt mõlemad käsud peavad alati õnnestuma andmebaas teeb sellisel juhul:
--		võtab esimese update'i tagasi ja veeretab selle algasendis e taastab algsed andmed--

-- CONSISTENT - kõik transactioni puudutavad andmed jäetakse loogiliselt järjepidevasse olekusse
--		nt kui laos saadaval olevate esemete hulka vähendatakse, siis tabelis peab olema vastav kanne.
--		inventuur ei saa lihtsalt kaduda--

-- ISOLATED - transaction peab andmeid mõjutama, sekkumata teistesse samaaegsetesse transactionitesse.
--			  see takistab andmete muutmist, mis põhinevad sidumata tabelitel
--		nt muudatused kirjas, mis hiljem tagasi muudetakse. enamik DBd kasutavad tehingute isoleerimise
--		säilitamiseks lukustamist--

-- DURABLE - kui muudatus on tehtud, siis see on püsiv. kui süsteemiviga või voolukatkestus ilmneb enne
--			 käskude komplekti valmimist, siis tühistatakse need käsud ja andmed taastatakse algsesse
--			 olekusse. taastamine toimub peale süsteemi taaskäivitamist.

-- subquieries--

-- tabel tühjaks--
truncate table Product
truncate table ProductSales

create table Product
(
Id int identity primary key,
Name nvarchar(50),
Description nvarchar(250)
)

create table ProductSales
(
Id int primary key identity,
ProductId int foreign key references Product(Id),
UnitPrice int,
QuantitySold int
)

insert into Product values ('TV', '52 inch black color LCT TV') 
insert into Product values ('Laptop', 'Very thin black color laptop') 
insert into Product values ('Desktop', 'HP high performance desktop') 

insert into ProductSales values (3, 450, 5)
insert into ProductSales values (2, 250, 7)
insert into ProductSales values (3, 450, 4)
insert into ProductSales values (3, 450, 9)

select*from ProductSales
select* from Product

--kirjutame päringu, mis annab infot müümata toodetest--
select Id, Name, Description
from Product
where Id not in(select distinct ProductId from ProductSales)

--enamus juhtudel saab subqueriet asendada JOINiga--
--teeme sama päringu JOINiga--
select Product.Id, Name, Description
from Product
left join ProductSales
on Product.Id = ProductSales.ProductId
where ProductSales.ProductId is null

--teeme subquiery, kus kasutame selecti. kirjutame päringu, kus saame teada name ja totalquantity
--veeru andmed--
select Name, 
(select sum(QuantitySold)from ProductSales where ProductId = Product.Id)
as TotalQuantity
from Product
order by Name

--sama tulemus JOINiga--
select Name, sum(QuantitySold) as TotalQuantity
from Product
left join ProductSales
on Product.Id = ProductSales.ProductId
group by Name
order by Name

--subqueryt saab subquery sisse panna--
--subqueryid on alati sulgudes ja neid nimetatakse sisemisteks päringuteks--

-- rohkete andmetega testimise tabel --

truncate table Product
truncate table ProductSales

--sisestame näidisandmed product tabelisse--
declare @Id int
set @Id = 1
while(@Id <= 300000)
begin
	insert into Product values('Product - ' + cast(@Id as nvarchar(20)), 
	'Product - ' + cast(@Id as nvarchar(20)) +'Description')

	print @Id
	set @Id = @Id + 1
end

declare @RandomProductId int 
declare @RandomUnitPrice int 
declare @RandomQuantitySold int 

--productId--
declare @LowerLimitForProductId int
declare @UpperLimitForProductId int

set @LowerLimitForProductId = 1
set @UpperLimitForProductId = 100000

--unitprice--
declare @LowerLimitForUnitPrice int
declare @UpperLimitForUnitPrice int

set @LowerLimitForUnitPrice = 1
set @UpperLimitForUnitPrice = 100

--quantity sold--
declare @LowerLimitForQuantitySold int
declare @UpperLimitForQuantitySold int

set @LowerLimitForQuantitySold = 1
set @UpperLimitForQuantitySold = 100

declare @Counter int
set @Counter = 1

while(@Counter <= 450000)
begin
	select @RandomProductId = round(((@UpperLimitForProductId - 
	@LowerLimitForProductId)*rand() + @LowerLimitForProductId), 0)

	select @RandomUnitPrice = round(((@UpperLimitForUnitPrice - 
	@LowerLimitForUnitPrice)*rand() + @LowerLimitForUnitPrice), 0)

	select @RandomQuantitySold = round(((@UpperLimitForQuantitySold -
	@LowerLimitForQuantitySold)*rand() + @LowerLimitForQuantitySold), 0)

	insert into ProductSales
	values (@RandomProductId, @RandomUnitPrice, @RandomQuantitySold)

	print @Counter
	set @Counter = @Counter +1
end

select * from Product
select*from ProductSales

--võrdleme subquerit ja joini--

select Id, Name, Description
from Product
where Id in
(
select Product.Id from ProductSales
)
--1 sekund--

--teeme cache puhtaks, et uut päringut ei oleks kuskile vahemällu salvestatud--
checkpoint;
go
dbcc DROPCLEANBUFFERS; --puhastab päringu cache--
go
dbcc FREEPROCCACHE --puhastab täitva planeeritud cache--
go

--teeme sama tabeli peale inner join päringu
select distinct Product.Id, Name, Description
from Product
inner join ProductSales
on Product.Id = ProductSales.ProductId
--2 sekundit--

--teeme cache puhtaks--

select Id, Name, Description
from Product
where not exists(select*from ProductSales where ProductId=Product.Id)
--2 sekundiga--
--teeme cache puhtaks--

--kasutame joini--
select Product.Id, Name,Description
from Product
left join ProductSales
on Product.Id = ProductSales.ProductId
where ProductSales.ProductId is null
--201000 2 sekundiga--

--- kursorid ---

-- realtsioonilised DBde haldussüsteemid saavad väga hästi hakkama SETSiga. 
-- SETS lubab mitut päringut kombineerida üheks tulemuseks. sinna alla käivad UNION, INTERSECT ja EXCEPT--

update ProductSales set UnitPrice=50 where ProductSales.ProductId= 101

--kui on vaja andmeid töödelda, siis kõige parem oleks kasutada cursoreid.
--samas on need jõudlusele halvad ja võiks võimalusel vältida. soovitav oleks kasutada joini.--

--cursorid jagunevad omakorda neljaks:
--1. forward-only e edasi-ainult
--2. static e staatilised
--3. keyset e võtmetele seadistatud
--4. dynamic e dünaamiline--

--cursori näide--
if the ProductName = 'Product - 55', set UnitPrice to 55

--------------------------
declare @ProductId int
--deklareerime cursorid--
declare ProductIdCursor cursor for
select ProductId from ProductSales
--open avaldusega täidab select avaldust ja sisestab tulemuse--
open ProductIdCursor

fetch next from ProductIdCursor into @ProductId
--kui tulemuses on veel ridu, siis @@FETCH_STATUS on 0--
while(@@FETCH_STATUS = 0)
begin
	declare @ProductName nvarchar(50)
	select @ProductName = Name from Product where Id=@ProductId

	if(@ProductName='Product - 55')
	begin
		update ProductSales set ProductSales.UnitPrice= 55 where ProductId = @ProductId
	end

	else if(@ProductName='Product - 65')
	begin
		update ProductSales set ProductSales.UnitPrice= 65 where ProductId = @ProductId
	end

	else if(@ProductName ='Product - 1000')
	begin
		update ProductSales set ProductSales.UnitPrice= 1000 where ProductId = @ProductId
	end

	fetch next from ProductIdCursor into @ProductId
end
--vabastab rea seadistuse--
close ProductIdCursor
--vabastab ressursid, mis on seotud cursoriga--
deallocate ProductIdCursor

select Name, UnitPrice
from Product join
ProductSales on Product.Id = ProductSales.ProductId
where (Name='Producr - 55' or Name= 'Product - 65' or Name='Product - 1000')

--asendame cursorid joiniga--

update ProductSales
set UnitPrice= 
	case
		when Name = 'Product - 55' Then 155
		when Name = 'Product - 65' Then 165
		when Name like 'Product - 1000' Then 10001
	end
from ProductSales
join Product
on Product.Id = ProductSales.ProductId
where Name = 'Product - 55' or Name = 'Product - 65' or 
	  Name like 'Product - 1000'

--vaatame tulemust--
select Name, UnitPrice
from Product join
ProductSales on Product.Id = ProductSales.ProductId
where (Name='Product - 55' or Name= 'Product - 65' or Name='Product - 1000')

--------------9 tund--------------

--tabelite info--

--nimekiri tabelitest--
select * from SYSOBJECTS where xtype = 'S'

select*from sys.tables

--nimekiri tabelitest ja view'dest--
select*from INFORMATION_SCHEMA.TABLES

--kui soovid erinevaid objekti tüüpe vaadata siis kasuta xtype süntaksit--
select distinct XTYPE from sysobjects

--IT - internal table--
--P - stored procedure--
--PK - primary key constant--
--S - system table--
--SQ - service queue--
--U - user table--
--V - view--

--skriptide uuesti käivitamine--

create table Employee
(
Id int primary key,
FirstName varchar(30),
ManagerId int
)

--annab teada, kas selle nimega tabel on juba olemas--
if not exists (select*from INFORMATION_SCHEMA.TABLES where TABLE_NAME = 'Employee')
begin 
	create table Employee
	(
	Id int primary key,
	FirstName varchar(30),
	ManagerId int
	)
	print 'Table Employee created'
	end
	else
	begin
		print 'Table Employee already exists'
end

--saab kasutada ka sisse ehitatud funktsiooni: OBJECT_ID()--
if OBJECT_ID('Employee') is null
begin
	print 'Table created'
end
else
begin
	print 'Table already exists'
end

--tahame sama nimega tabeli ära kustutada ja siis uuesti luua--
if OBJECT_ID('Employee') is not null
begin
	drop table Employee
end
create table Employee
	(
	Id int primary key,
	FirstName varchar(30),
	ManagerId int
	)

alter table Employee
add Email nvarchar(50)

--kuidas teha uuesti käivitatavaks veeru kontrollimist ja loomist--
if not exists(select*from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'Email' and TABLE_NAME = 'Employee'and 
TABLE_SCHEMA = 'dbo')
begin
	alter table Employee
	add Email nvarchar(40)
end
else
begin
	print 'Coloumn already exists'
end

--kontrollime, kas mingi nimega veerg on olemas--
if COL_LENGTH('Employee', 'Email') is not null
begin
	print 'Column already exists'
end
else
begin
	print 'Column does not exist'
end

---ühendamine/merge---
--tutvustati aastal 2008, mis lubab teha sisestamist, uuendamist ja kustutamist--
--ei pea kasutama mitut käsku--

--merge puhul peab olema vähemalt kaks tabelit--
--1. source table--
--2. target table--

--ühendab sihttabeli lähtetabeliga ja kasutab mõlemas tabelis ühist veergu--
--koodinäide--
merge [TARGET] as T
using [SOURCE] as S
	ON [JOIN_CONDITIONS]
when matched then
	[UPDATE_STATMENT]
when not matched by target then
	[INSERT_STATEMENT]
when not matched by source then
	[DELETE STATEMENT]

create table StudentSource
(
Id int primary key,
FirstName nvarchar(20)
)

insert into StudentSource values (1, 'Mike')
insert into StudentSource values (2, 'Sara')
go 

create table StudentTarget
(
Id int primary key,
FirstName nvarchar(20)
)

insert into StudentTarget values (1, 'Mike M')
insert into StudentTarget values (3, 'John')
go

--1. kui leitakse klappiv rida, siis StudentTarget tabel on uuendatud--
--2. kui read on StudentSource tabelis olemas, aga neid ei ole StudentTarget'is, siis puuduolevad read sisestatakse--
--3. kui read on olemas StudentTarget'is, aga mitte StudentSource'is, siis StudentTargettabelis read kustutatakse ära--
merge StudentTarget as T
using StudentSource as S
on T.Id = S.Id
when matched then
	update set T.FirstName = S.FirstName
when not matched by target then
	insert(Id, FirstName) values(S.Id, S.FirstName)
when not matched by source then
	delete;

select *from StudentTarget
select*from StudentSource

--tabelid sisust tühjaks--
truncate table StudentTarget
truncate table StudentSource

insert into StudentTarget values (1, 'Mike M')
insert into StudentTarget values (3, 'John')
go
insert into StudentSource values (1, 'Mike')
insert into StudentSource values (2, 'Sara')
go

merge StudentTarget as T 
using StudentSource as S
on T.Id = S.Id
when matched then
	update set T.FirstName = S.FirstName
when not matched by target then
	insert (Id, FirstName) values (S.Id, S.FirstName);


---transactisioonid---
--mis see on?--
--on rühm käske, mis siis muudavad db's salvestatuid andmeid. tehingut käsitletakse ühe tööüksusena. kas kõik käsud 
--õnnestuvad või mitte. kui üks tehing selles ebaõnnestub, siis kõik juba muudetud andmed muudetakse tagasi.--

create table Account
(
Id int primary key,
AccountName nvarchar(20),
Balance int
)
insert into Account values(1, 'Mark', 1000)
insert into Account values(2, 'Mary', 1000)

--transaction tagab, et mõlemad uuendatavad käsud saavad tehtud--
begin try
	begin transaction
		update Account set Balance = Balance - 100 where Id=1
		update Account set Balance = Balance + 100 where Id=2
	commit transaction
	print 'Transaction commited'
end try
begin catch
	rollback tran
	print 'Transaction rolled back'
end catch

select*from Account

--levinumad probleemid--
--1. Dirty read e. must lugemine--
--2. Lost Updates e. kadunud uuendused--
--3. Nonrepeatable reads e. kordumatud lugemised--
--4. Phantom read e. fantoom lugemine--

--kõik probleemid lahendaks ära, kui lubaksite igal ajal korraga ühel kasutajal ühe tehingu teha. selle tulemusel kõik 
--tehingud satuvad järjekorda ja neil võib tekkitada vajadus kaua oodata, enne kui võimalus tehingut teha saabub.--

--kui lubada samaaegselt kõik tehingud ära teha, siis see omakorda tekitab probleeme.--
--probleemi lahendamiseks pakub sql server erinevaid tehinguisolatsiooni tasemeid, et tasakaalustada samaaegsuse 
--andmete CRUD(create, read, update ja delete) probleeme:--
--1. read uncommited e lugemine pole teostatud--
--2. read commited e lugemine tehtud--
--3. repeatable read e korduv lugemine--
--4. snapshot e kuvatõmmis--
--5. serializable e serialiseerimine--

--igale juhtumile tuleb läheneda juhtumipõhiselt--
--mida vähem valet lugemist tuleb, seda aeglasem--

--dirty read näide--
create table Inventory
(
Id int identity primary key,
Product nvarchar(20),
ItemsInStock int
)
go
insert into Inventory values ('Iphone', 10)
select*from Inventory

--esimene transaction--
begin tran
update Inventory set ItemsInStock = 9 where Id=1
--kliendile tuleb arve--
waitfor delay '00:00:15'
--ebapiisav saldo jääk, teen rollbacki--
rollback tran
--samal ajal käivitan selle--
--teine transaction--
set tran isolation level read uncommitted
select*from Inventory where Id=1

--nüüd panen selle käskluse tööle 
select *from Inventory(nolock)where Id=1

--muutsin esimese käsuga 9 iphonei peale, aga ikka on 10 tükki--

--lost update probleem--
select*from Inventory

set tran isolation level repeatable read
--transaction 1--
begin tran 
declare @ItemsInStock int

select @ItemsInStock=ItemsInStock
from Inventory where Id =1

waitfor delay'00:00:10'
set @ItemsInStock = @ItemsInStock -1

update Inventory
set ItemsInStock = @ItemsInStock where Id=1

print @ItemsInStock

commit transaction

--samal ajal panen teise tran tööle teisest päringust

waitfor delay '00:00:01'
set @ItemsInStock = @ItemsInStock -2

update Inventory
set ItemsInStock=@ItemsInStock where Id=2

print @ItemsInStock

commit tran

--non repeatable read näide--

--see juhtub kui üks transaction loeb samu andmeid kaks korda ja teine transaction uuendab neid andmeid
--esimese ja teise käsu vahel esimese transactioni jooksutamise ajal--

--esimene tran--
set tran isolation level repeatable read
begin tran 
select ItemsInStock from Inventory where Id=1

waitfor delay '00:00:10'

select ItemsInStock from Inventory where Id=1
commit tran

--selle probleemi lahendamiseks kasutatakse tran1 ees set tran isolation level repeatable read--

--phantom reads--

insert into Employee values (1, 'Mark')
insert into Employee values (3, 'Sara')
insert into Employee values (100, 'Mary')

--tran1--
set tran isolation level serializable
begin tran
select*from Employee where Id between 1 and 3

waitfor delay '00:00:10'
select*from Employee where Id between 1 and 3
commit tran

--panen kohe teise trani tööle--
select *from

truncate table Employee
--vastuseks tuleb mark ja sara. marcust ei näita aga peaks--
--erinevus korduvlugemisega ja serialiseerimisega: korduv lugemine hoiab ära ainult kordumatud lugemised,
--serialiseerimine hoiab ära kordumatud lugemised ja phantom rea probleemid--
--isolatsioonitase tagab, et ühe tehingu loetud andmed ei takistaks muid transactioneid.--

-- 10.06 tund

-- L�in uue andmebaasi
create database CSV_Import

-- importisin csv faili Tasks->Import Flat File

--db valimine
use CSV_Import

select * from Andmed

-- 1. Id tuleb sisestada koodiga, aga esimeseks veeruks v�ib teha ilma koodita.
-- luua id veerg
alter table Andmed
add Id int not null identity primary key

-- 2. Muuda veerud: Nimi nvarchar(25), Linn nvarchar(25), Aadress nvarchar(30), Telefon nvarchar(12) ja Sugu varchar(1) peale.
-- muudan andmet��pe
alter table Andmed
alter column Nimi nvarchar(25)
alter table Andmed
alter column Linn nvarchar(25)
alter table Andmed
alter column Aadress nvarchar(30)
alter table Andmed
alter column Telefon nvarchar(12)
alter table Andmed
alter column Sugu varchar(1)

-- 3. Muuta k�ik P?rnu ja p?rnu vastavalt P�rnu ja p�rnu-ks. Kui kirjutate koodiga, siis panna tingimusele vastamise stringi 'Prnu' v�i 'prnu'.
-- k�igepealt otsin need v�lja et vaadata, collate k�sk et oleks suur/v�iket�hetundlik
select * from Andmed where Linn COLLATE Latin1_General_CS_AS like 'Prnu'
-- siis uuendan andmed
update Andmed 
Set Linn = 'P�rnu'
where Linn COLLATE Latin1_General_CS_AS like 'Prnu'

update Andmed 
Set Linn = 'p�rnu'
where Linn COLLATE Latin1_General_CS_AS like 'prnu'

-- 4. K�ikide inimeste nimed, mis sisaldavad k t�hte
select Nimi from Andmed where Nimi like '%k%'

-- 5. Kuva inimeste loetelu, kellel puudub nimi
select * from Andmed where Nimi is NULL

-- 6. K�ik mehed, kes elavad P�rnus
select * from Andmed where (Sugu like 'm' and Linn like 'p�rnu')

-- 7. K�ik kirjed, kus aadressid puuduvad
select * from Andmed where Aadress is NULL

-- 8. Kirjed, kus telefon puudub
select * from Andmed where Telefon is NULL

-- 9. Inimesed kelle palganumber on 0.
select * from Andmed where Palk = 0

-- 10. Inimesed, kelle palganumber on 0 v�i kelle palga kohal on t�hi koht
select * from Andmed where (Palk = 0 or Palk is NULL)

-- 11. Inimesed, kes elavad linnades mille nimi sisaldab�-� m�rki
select * from Andmed where Linn like '%-%'

-- 12. Inimesed, kes on s�ndinud vahemikus 01.01.1982 kuni 01.01.1992
select * from Andmed where S_nniaeg between '01.01.1982' and '01.01.1992'

-- 13. Inimesed, kes on s�ndinud enne 1900-12-31
select * from Andmed where S_nniaeg < '1900-12-31'

-- 14. 10 k�ige nooremat inimest
select top 10 * from Andmed order by S_nniaeg 

-- 15. K�ikide t��tajate palgafond arvutada kokku
select sum(cast(Palk as int)) as Palgafond from Andmed

-- 16. Linnade kaupa palgafond kokku arvutada
select Linn, sum(Palk) as Palgafond from Andmed group by Linn