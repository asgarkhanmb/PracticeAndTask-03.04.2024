create database Course
use Course

create table Students(
[Id]int primary key identity(1,1),
[Name] nvarchar(50),
[Surname]nvarchar(50),
[Age]int,
[Email]nvarchar(100),
[Address]nvarchar(100)
)

select * from Students

create procedure usp_createStudent
@name nvarchar (100),
@surname nvarchar(100),
@email nvarchar(200),
@age int,
@address nvarchar(100)
as
begin
     
	 insert into Students([Name],[Surname],[Email],[Age],[Address])
     values(@name,@surname,@email,@age,@address)
end


exec usp_createStudent 'Esgerxan','Bayramov','esgerxan@gmail.com',26,'Yasamal'
exec usp_createStudent 'Bahruz','Eliyev','behruz@gmail.com',28,'Kurdaxani'
exec usp_createStudent 'Reshad','Agayev','resad@gmail.com',21,'Neftciler'
exec usp_createStudent 'Aykhan','Agayev','aykhan@gmail.com',24,'Samaxinka'
exec usp_createStudent 'Hacixan','Hacixanov','hacixan@gmail.com',19,'Yasamal'


select * from Students

create procedure usp_deleteStudentById
@id int
as
begin
    delete from Students where [Id]=@id
end

exec usp_deleteStudentById 3


create table StudentArchives(
[Id]int primary key identity(1,1),
[StudentId]int,
[Operation]nvarchar(20),
[Date]datetime
)


create trigger trg_deleteStudentArchives on Students
after delete
as
begin
     insert into  StudentArchives([StudentId],[Operation],[Date])
	 select [Id],'Deleted',GETDATE() from deleted
end

select * from StudentArchives
select * from Students



exec usp_deleteStudentById 4

select * from StudentArchives
select * from Students

