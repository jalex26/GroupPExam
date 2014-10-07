use master
go
drop database Exam
go
create database Exam
go
use Exam
go

create table tbLogin(
Username varchar(60),
Password varchar(60),
SecurityLevel int 
)
go

create table tbClass(
Classid int primary key identity (0,1),
Classname varchar(60)
)
go

insert into tbClass(Classname)values
('SD18'),('SD19'),('SD20'),('SD21'),('SD22')
go

create table tbUser(
Userid int primary key identity (0,1),
Firstname varchar(60),
Lastname varchar(60),
Username varchar(60),
Password varchar(60),
SecurityLevel int
)
go

insert into tbUser(Firstname,Lastname,Username,Password,SecurityLevel)values
('Kevin','Coliat','Kevin1','Kevin1',2),('Nupur','Singh','Nupur1','Nupur1',1),
('Janry','Alex','Janry1','Janry1',1),('Adrian','Carter','Adrian1','Adrian1',1),
('Veberly','Carvalho','Veberly1','Veberly1',1)
go

--Login
create procedure spLogin(
@Username varchar(60),
@Password varchar(60)
)
as begin
	select * from tbUser where tbUser.Username = @Username and tbUser.Password = @Password
end
go



-- Collects all the Failed Login Attempts
create procedure spFailedLoginAttempts(
@Username varchar(60) = null,
@Password varchar(60) = null
)
as begin 
	insert into tbFailedLoginAttempt(tbFailedLoginAttempt.Username, tbFailedLoginAttempt.Password,DateAttempted)values  /*, tbFailedLoginAttempt.DateAttempted*/
									(@Username,@Password,GETDATE())
	--where tbFailedLoginAttempt.Username = @Username and tbFailedLoginAttempt.Password= @Password and tbFailedLoginAttempt.DateAttempted=@DateAttempted
end 
go
--Loads the Failed Login Attempts
create procedure spLoadFailedLoginAttempts
as begin
	select tbFailedLoginAttempt.Username, tbFailedLoginAttempt.Password,tbFailedLoginAttempt.DateAttempted
	from tbFailedLoginAttempt
end
go