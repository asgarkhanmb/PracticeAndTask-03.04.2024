--use Course

--select * from Teachers

--create view getTeachersWithId
--as
--select *from Teachers where [Id]>2

--select * from getTeachersWithId

--create view getTeachersWithAge
--as
--select Top 2 * from Teachers where [Age]>18

--select * from getTeachersWithAge

create function dbo.sayHelloWorld()
returns nvarchar (50)
as
begin
    return 'Hello World'
end

declare @data nvarchar(30)=(select dbo.sayHelloWorld())

print @data

create function dbo.showText(@text nvarchar(50))
returns nvarchar(50)
as
begin
   return @text 
end

select dbo.showText('Hello world')

create function dbo.SumOfNums(@num1 int,@num2 int)
returns int
as
begin
   return @num1+@num2
end

declare @id int = (select dbo.SumOfNums(1,2))

select * from Teachers where [Id]=@id

create function dbo.getTeachersByAge(@age int)
returns int
as
begin
     declare @count int;
     select @count = COUNT(*)from Teachers where [Age]>@age
	 return @count;
end

select * from Teachers

select dbo.getTeachersByAge(18) as 'Teachers count'


create function dbo.getAllTeaachers()
returns table
as
return(select * from Teachers)

select * from dbo.getAllTeaachers()


create function dbo.searchTeachersByName(@searchText nvarchar(50))
returns table
as
return(
    select * from Teachers where [Name] like '%'+ @searchText + '%'
)

select * from dbo.searchTeachersByName('a')

select * from Teachers


create procedure usp_ShowText
as
begin
    print 'salamlar'
end

exec usp_ShowText

create procedure usp_ShowText2
@text nvarchar(50)
as
begin
    print @text
end


exec usp_ShowText2 'Salam'



create procedure usp_createTeacher
@name nvarchar (100),
@surname nvarchar(100),
@email nvarchar(200),
@age int
as
begin
     
	 insert into Teachers ([Name],[Surname],[Email],[Age])
     values(@name,@surname,@email,@age)
end


exec usp_createTeacher 'Fexriyye','Tagizade','fexriyye@gmail.com',21



select * from Teachers


create procedure usp_deleteTeahcerById
@id int
as
begin
    delete from Teachers where [Id]=@id
end

exec usp_deleteTeahcerById 4

select * from Teachers




create function dbo.getTeachersAvgAges(@id int)
returns int
as
begin
   declare @avgAge int;
   select @avgAge=AVG(Age) from Teachers where [Id] > @id
   return @avgAge
end


select dbo.getTeachersAvgAges(3)



create procedure usp_changeTeacherNameByCondition
@id int,
@name nvarchar (50)
as
begin
    declare @avgAge int=(select dbo.getTeachersAvgAges(@id))
	update Teachers 
	set[Name]=@name
	where [Age]> @avgAge
end

exec usp_changeTeacherNameByCondition 3,'XXX'

select * from Teachers order by [Age] asc

select GETDATE()

create table TeacherLogs(
[Id]int primary key identity(1,1),
[TeacherId]int,
[Operation]nvarchar(20),
[Date]datetime
)



create trigger trg_createTeacherLogs on Teachers
after insert
as
begin
     insert into  TeacherLogs([TeacherId],[Operation],[Date])
	 select [Id],'Insert',GETDATE() from inserted
end



exec usp_createTeacher 'Zeyqem','Ashurov','zeyqem@gmail.com',39



select * from TeacherLogs
select * from Teachers




create trigger trg_deleteTeacherLogs on Teachers
after delete
as
begin
     insert into  TeacherLogs([TeacherId],[Operation],[Date])
	 select [Id],'Delete',GETDATE() from deleted
end

exec usp_deleteTeahcerById 2

select * from Teachers


create trigger trg_updateTeacherLogs on Teachers
after update
as
begin
     insert into  TeacherLogs([TeacherId],[Operation],[Date])
	 select [Id],'Update',GETDATE() from deleted
end

