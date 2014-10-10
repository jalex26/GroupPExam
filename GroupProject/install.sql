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

create table tbCourse(
Courseid int primary key identity(0,1),
Coursename varchar(60)
)
go

insert into tbCourse(Coursename)values
('Software Development'),('Networking')
go

create table tbClass(
Classid int primary key identity (0,1),
Classname varchar(60),
Courseid int foreign key references tbCourse(Courseid)on delete cascade
)
go

insert into tbClass(Classname,Courseid)values
('SD18',0),('SD19',0),('SD20',0),('SD21',0),('SD22',0)
go

create table tbUser(
Userid int primary key identity (0,1),
Firstname varchar(60),
Lastname varchar(60),
Username varchar(60),
Password varchar(60),
Classid int foreign key references tbClass(Classid)on delete cascade,
SecurityLevel int,
UserPicture varchar(60),
Email varchar(60)
)
go


insert into tbUser(Firstname,Lastname,Username,Password,Classid,SecurityLevel,UserPicture,Email)values
('Kevin','Coliat','Kevin1','Kevin1',0,3,'SamplePicture1.jpg','Kevin@yahoo.com'),('Doug','Jackson','Doug1','pass',0,2,'SamplePicture2.jpg','Doug@yahoo.com'),
('Nupur','Singh','Nupur1','Nupur1',0,1,'SamplePicture3.jpg','Nupur@yahoo.com'),
('Janry','Alex','Janry1','Janry1',1,1,'SamplePicture4.jpg','Janry@yahoo.com'),('Adrian','Carter','Adrian1','Adrian1',0,1,'SamplePicture5.jpg','Adrian@yahoo.com'),
('Veberly','Carvalho','Veberly1','Veberly1',0,1,'SamplePicture6.jpg','Veberly@yahoo.com')
go

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
Courseid int foreign key references tbCourse(Courseid) on delete cascade,
TimetoTake time,
Difficulty int foreign key references tbDifficulty(Difficultyid),
Content XML
--XMLfileLocation varchar(max)
)
go

insert into tbQuiz(QuizTitle,QuizSubject,Courseid,TimetoTake,Difficulty /*Content*/ /*,XMLFileLocation*/)values
('Sample Title','PHP',0,'00:20:00',1)
go

create table tbQuizVersion(
Versionid int primary key identity (0,1),
Quizid int foreign key references tbQuiz(Quizid),
Version int
)
go

insert into tbQuizVersion(Quizid,Version)values
(0,1),(0,1),(0,1)

create table tbResults(
Resultid int primary key identity (0,1),
Userid int foreign key references tbUser(Userid),
Versionid int foreign key references tbQuizVersion(Versionid), 
TotalScore decimal(10,5)
)
go

insert into tbResults(Userid,Versionid,TotalScore)values 
(2,0,85.50),(3,0,90.00),(4,0,70.95)

--create table tbQuizTaken(
--QuizTakenid int primary key identity(0,1),
--Quizid int foreign key references tbQuiz(Quizid),
--QuizClass int foreign key references tbClass(Classid)
--)
--go

--insert into tbQuizTaken(Quizid,QuizClass)values
--(0,0),(0,1),(0,2),(0,3),(0,4)
--go

create table tbQuizTaker(
Takerid int primary key identity(0,1),
Quizid int foreign key references tbQuiz(Quizid),
Userid int foreign key references tbUser(Userid),
Status int,
Versionid int foreign key references tbQuizVersion(Versionid),
DateAndTime Datetime
)
go

--1-scheduled to take
--2-Rescheduled
--3-Not taken

insert into tbQuizTaker(Quizid,Userid,Status,Versionid,DateAndTime)values
(0,2,1,0,'2014-01-26'),(0,3,2,0,'2014-03-14'),(0,4,3,0,'2014-05-13')
go

create table tbMultipleQuestions(
MultipleQuestionsid int primary key identity (0,1),
Question varchar(max),
Choice1 varchar(150),
Choice2 varchar(150),
Choice3 varchar(150),
Choice4 varchar(150),
Answer varchar(150),
Versionid int foreign key references tbQuizVersion(Versionid)
)
go

insert into tbMultipleQuestions(Question,Choice1,Choice2,Choice3,Choice4,Answer,Versionid)values
('What is the capital of Canada?','Montreal','Ontario','Ottawa','Winnipeg','Ottawa',1),
('How old is the legal age to drink in Canada?','17','18','19','20','18',1),
('How many colors are there in a rainbow?','4','6','9','7','7',1),
('When is Remembrance Day celebrated?','July 1st','October 1st','November 11th','December 25th','November 11th',1),
('How many sides are there in an Octagon','6','12','4','8','8',1)
go

create table tbMatchingQuestions(
MatchingQuestionsid int primary key identity(0,1),
Question varchar(150),
Answers varchar(150),
Versionid int foreign key references tbQuizVersion(Versionid)
)
go

--Match the City with the Country
insert into tbMatchingQuestions(Question,Answers,Versionid)values
('London','Great Britain',1),
('Paris','France',1),
('Athens','Greece',1),
('Moscow','Russia',1),
('Madrid','Spain',1)
go

create table tbLongQuestions(
LongQuestionsid int primary key identity(0,1),
Question varchar(150),
Versionid int foreign key references tbQuizVersion(Versionid)
)
go

insert into tbLongQuestions(Question,Versionid)values
('What is Equilibrium?',1),
('What is time?',1),
('Why do we need sleep?',1),
('Which has more power, love or fear?',1),
('What is Science?',1)
go

create table tbMultipleAnswers(
MultipleAnswersid int primary key identity(0,1),
Userid int foreign key references tbUser(Userid),
MultipleQuestionsid int foreign key references tbMultipleQuestions(MultipleQuestionsid),
UserAnswer varchar(150)
)
go

insert into tbMultipleAnswers(Userid,MultipleQuestionsid,UserAnswer)values
(3,0,'Ottawa'),(3,1,'17'),(3,2,'7'),(3,3,'November 11th'),(3,4,'8')
go

create table tbMatchingAnswers(
MatchingAnswersid int primary key identity(0,1),
MatchingQuestionsid int foreign key references tbMatchingQuestions(MatchingQuestionsid),
Userid int foreign key references tbUser(Userid),
UserAnswer varchar(150)
)
go

insert into tbMatchingAnswers(MatchingQuestionsid,Userid,UserAnswer)values
(0,4,'Great Britain'),(1,4,'France'),(2,4,'Greece'),(3,4,'Russia'),(4,4,'Spain')
go

create table tbLongAnswers(
LongAnswersid int primary key identity (0,1),
Userid int foreign key references tbUser(Userid),
LongQuestionsid int foreign key references  tbLongQuestions(LongQuestionsid),
UserAnswer varchar(max)
)
go

insert into tbLongAnswers(Userid,LongQuestionsid,UserAnswer)values
(5,0,'State of stable conditions in which all significant factors remain more or less constant over a period, and there is little or no inherent tendency for change.'),
(5,1,'Time is the fourth dimension and a measure in which events can be ordered from the past through the present into the future, and also the measure of durations of events and the intervals between them.'),
(5,2,'Sleep gives your body a rest and allows it to prepare for the next day.'),
(5,3,'Love. Fear will only have people obeying you until they can get away. Love will have people willing to die for each other and for you.'),
(5,4,'the intellectual and practical activity encompassing the systematic study of the structure and behavior of the physical and natural world through observation and experiment.')
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
	select './Pictures/' + UserPicture as UserPicture,Firstname, Lastname,Username,Password,Classid,SecurityLevel,Email
    from tbUser where tbUser.Classid = @Classid and 
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

--Difficulty
create procedure spGetDifficulty(
@Difficultyid int = null
)
as begin
	select * from tbDifficulty where tbDifficulty.Difficultyid = @Difficultyid
end 
go

create procedure spInsertDifficulty(
@Difficultyname varchar(60)
)
as begin
	insert into tbDifficulty(Difficultyname)values
				(@Difficultyname)
end
go

create procedure spUpdateDifficulty(
@Difficultyid int = null,
@Difficultyname varchar(60)
)
as begin
	update tbDifficulty set Difficultyname = @Difficultyname
	where Difficultyid =@Difficultyid
end 
go

create procedure spDeleteDifficulty(
@Difficultyid int = null
)
as begin 
	delete from tbQuiz
	where tbQuiz.Difficulty =@Difficultyid

	delete from tbDifficulty 
	where tbDifficulty.Difficultyid = @Difficultyid
	
	delete from tbQuiz
	where tbQuiz.Difficulty = @Difficultyid
end 
go


--spDeleteDifficulty @Difficulty=1
--select * from tbDifficulty

--Loads Class
create procedure spGetClass(
@Classid int = null
)
as begin
	select * from tbClass where tbClass.Classid = @Classid
end
go

--spGetClass @Classid = 1

--select * from tbClass where tbClass.Classid = 1 


----Insert Class
create procedure spInsertClass(
@Classname varchar(60),
@Courseid int

)
as begin
	insert into tbClass(Classname,Courseid)values
					  (@Classname,@Courseid)
end
go

--Update Class
create procedure spUpdateClass(
@Classid int = null,
@Classname varchar (60),
@Courseid int
)
as begin
update tbClass set Classname =@Classname, Courseid=@Courseid
			 where tbClass.Classid = @Classid
end
go

--spUpdateClass @
--Delete Class

create procedure spDeleteClass(
@Classid int
)
as begin
	
	delete from tbClass 
	where tbClass.Classid = @Classid
end
go


--spDeleteClass @Classid=0

create procedure spGetCourse(
@Courseid int
)
as begin 
	select * from tbCourse where Courseid= @Courseid
end
go

create procedure spInsertCourse(
@Coursename varchar(60)
)
as begin 
	insert into tbCourse (Coursename) values
						 (@Coursename)
end
go

create procedure spUpdateCourse(
@Courseid int = null,
@Coursename varchar(60)
)
as begin
	update tbCourse set Coursename = @Coursename 
	where Courseid=@Courseid
end
go

create procedure spDeleteCourse(
@Courseid int
)
as begin 
	delete from tbCourse 
	where tbCourse.Courseid =@Courseid
end 
go


