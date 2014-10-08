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
Classid int foreign key references tbClass(Classid),
SecurityLevel int
)
go


insert into tbUser(Firstname,Lastname,Username,Password,Classid,SecurityLevel)values
('Kevin','Coliat','Kevin1','Kevin1',0,3),('Doug','Jackson','Doug1','pass',0,2),('Nupur','Singh','Nupur1','Nupur1',0,1),
('Janry','Alex','Janry1','Janry1',1,1),('Adrian','Carter','Adrian1','Adrian1',0,1),
('Veberly','Carvalho','Veberly1','Veberly1',0,1)
go

create table tbQuizCategories(
Categoryid int primary key identity (0,1),
Categoryname varchar(60)
)
go

insert into tbQuizCategories(Categoryname)values
('Programming'),('Accounting'),('Management'),('Health Care'),('Law Assistant'),('Networking')

create table tbDifficulty(
Difficultyid int primary key identity(0,1),
Difficultyname varchar(60)
)
go

insert into tbDifficulty(Difficultyname)values
('Beginner'),('Intermediate'),('Advanced')
go

create table tbQuiz(
Quizid int primary key identity (0,1),
QuizTitle varchar(60),
QuizSubject varchar(60),
QuizCategory int foreign key references tbQuizCategories(Categoryid),
TimetoTake time,
Difficulty int foreign key references tbDifficulty(Difficultyid),
Content XML
--XMLfileLocation varchar(max)
)
go

insert into tbQuiz(QuizTitle,QuizSubject,QuizCategory,TimetoTake,Difficulty /*,XMLFileLocation*/)values
('Sample Title','PHP',0,'00:20:00',1)
go

create table tbResults(
Resultid int primary key identity (0,1),
Userid int foreign key references tbUser(Userid),
Quizid int foreign key references tbQuiz(Quizid), 
TotalScore decimal(10,5)
)
go

insert into tbResults(Userid,Quizid,TotalScore)values 
(2,0,85.50),(3,0,90.00),(4,0,70.95)

create table tbQuizTaken(
QuizTakenid int primary key identity(0,1),
Quizid int foreign key references tbQuiz(Quizid),
QuizClass int foreign key references tbClass(Classid)
)
go

insert into tbQuizTaken(Quizid,QuizClass)values
(0,0),(0,1),(0,2),(0,3),(0,4)
go

create table tbQuizTaker(
Takerid int primary key identity(0,1),
Quizid int foreign key references tbQuiz(Quizid),
Userid int foreign key references tbUser(Userid),
Status int,
)
go

--1-scheduled to take
--2-Rescheduled
--3-Not taken

insert into tbQuizTaker(Quizid,Userid,Status)values
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


--Loads students by Class
create procedure spGetStudents(
@Classid int,
@SecurityLevel int
)
as begin
	select * from tbUser where tbUser.Classid = @Classid and 
	tbUser.SecurityLevel =1 and tbUser.SecurityLevel = @SecurityLevel
end
go

--spGetStudents @Classid = 1, @SecurityLevel = 1

--select * from tbUser where tbUser.Classid = 1 


--Insert students
create procedure spInsertStudent(
@Firstname varchar(60),
@Lastname varchar(60),
@Username varchar(60),
@Password varchar(60),
@Classid int,
@SecurityLevel int
)
as begin
	insert into tbUser(Firstname,Lastname,Username,Password,Classid,SecurityLevel)values
					  (@Firstname,@Lastname,@Username,@Password,@Classid,@SecurityLevel)
end
go

--Update Students
create procedure spUpdateStudent(
@Userid int = null,
@Firstname varchar (60),
@Lastname varchar (60),
@Username varchar (60),
@Password varchar (60),
@Classid int,
@SecurityLevel int
)
as begin
update tbUser set Firstname =@Firstname, Lastname=@Lastname, Username=@Username, Password=@Password, 
		Classid=@Classid, SecurityLevel=@SecurityLevel
			 where tbUser.Userid = @Userid
end
go

--Delete Students

create procedure spDeleteStudent(
@Userid int = null
)
as begin
	delete from tbResults
	where tbResults.Userid = @Userid

	delete from tbQuizTaker
	where tbQuizTaker.Userid = @Userid

	delete from tbUser 
	where tbUser.Userid = @Userid
end
go

--spDeleteStudent @Userid=3
select * from tbUser