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
('Kevin','Coliat','Kevin1','Kevin1',3),('Doug','Jackson','Doug1','pass',2),('Nupur','Singh','Nupur1','Nupur1',1),
('Janry','Alex','Janry1','Janry1',1),('Adrian','Carter','Adrian1','Adrian1',1),
('Veberly','Carvalho','Veberly1','Veberly1',1)
go

create table tbExamCategories(
Categoryid int primary key identity (0,1),
Categoryname varchar(60)
)
go

insert into tbExamCategories(Categoryname)values
('Programming'),('Accounting'),('Management'),('Health Care'),('Law Assistant'),('Networking')

create table tbDifficulty(
Difficultyid int primary key identity(0,1),
Difficultyname varchar(60)
)
go

insert into tbDifficulty(Difficultyname)values
('Begginer'),('Intermediate'),('Advanced')
go

create table tbExams(
Examid int primary key identity (0,1),
ExamTitle varchar(60),
ExamSubject varchar(60),
ExamCategory int foreign key references tbExamCategories(Categoryid),
TimetoTake time,
Difficulty int foreign key references tbDifficulty(Difficultyid)
--XMLfileLocation varchar(max)
)
go

insert into tbExams(ExamTitle,ExamSubject,ExamCategory,TimetoTake,Difficulty /*,XMLFileLocation*/)values
('Sample Title','PHP',0,'00:20:00',1)
go

create table tbResults(
Resultid int primary key identity (0,1),
Userid int foreign key references tbUser(Userid),
Examid int foreign key references tbExams(Examid),
TotalScore decimal(10,5)
)
go

insert into tbResults(Userid,Examid,TotalScore)values 
(2,0,85.50),(3,0,90.00),(4,0,70.95)

create table tbExamTaken(
ExamTakenid int primary key identity(0,1),
Examid int foreign key references tbExams(Examid),
ExamClass int foreign key references tbClass(Classid)
)
go

insert into tbExamTaken(Examid,ExamClass)values
(0,0),(0,1),(0,2),(0,3),(0,4)
go

create table tbExamTaker(
Takerid int primary key identity(0,1),
Examid int foreign key references tbExams(Examid),
Userid int foreign key references tbUser(Userid),
Status int,
)
go

--1-scheduled to take
--2-Rescheduled
--3-Not taken

insert into tbExamTaker(Examid,Userid,Status)values
(0,2,1),(0,3,2),(0,4,3)
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
	insert into tbFailedLoginAttempt(tbFailedLoginAttempt.Username, tbFailedLoginAttempt.Password,DateAttempted)values
									(@Username,@Password,GETDATE())
end 
go


--select * from tbClass,tbDifficulty,tbExamCategories,tbExams,tbExamTaken,tbExamTaker,tbResults,tbUser