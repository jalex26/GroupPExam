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
('Janry','Alex','Janry1','Janry1',1,1,'SamplePicture4.jpg','Janry@yahoo.com'),('Adrian','Carter','Adrian1','Adrian1',2,1,'SamplePicture5.jpg','Adrian@yahoo.com'),
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
FileLocation varchar(max),
xmlQuizid varchar(60)
--XMLfileLocation varchar(max)

)
go

insert into tbQuiz(QuizTitle,QuizSubject,Courseid,TimetoTake,Difficulty,FileLocation,xmlQuizid)values
('Sample Title','PHP',0,'00:20:00',1,'c:/','555'),('Sample Title Version 2','PHP',1,'00:20:00',1,'c:/','555'),
('Sample 3','PHP',0,'00:20:00',1,'c:/','44'),('Sample 4','PHP',1,'00:20:00',1,'c:/','33')

go
create table tbQuizVersion(
Versionid int primary key identity (0,1),
Quizid int foreign key references tbQuiz(Quizid),
Version int
)
go

insert into tbQuizVersion(Quizid,Version)values
(0,1),(1,2),(2,1),(3,1)

create table tbResults(
Resultid int primary key identity (0,1),
Userid int foreign key references tbUser(Userid),
Versionid int foreign key references tbQuizVersion(Versionid), 
Quizid int foreign key references tbQuiz(Quizid),
TotalScore decimal(10,5)
)
go

insert into tbResults(Userid,Versionid,Quizid,TotalScore)values 
(2,1,0,85.50),(3,1,0,90.00),(4,1,0,90.95),(5,1,0,99.9)

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
(1,2,1,1,'2014-01-26'),(1,3,2,1,'2014-03-14'),(1,4,3,1,'2014-05-13'),(1,5,3,1,'2014-07-01')
go

create table tbMultipleQuestions(
MultipleQuestionsid int primary key identity (0,1),
Question varchar(max),
Choice1 varchar(150),
Choice2 varchar(150),
Choice3 varchar(150),
Choice4 varchar(150),
Answer varchar(150),
--Quizid int foreign key references tbQuiz(Quizid),
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
Choices varchar(150),
Answers varchar(150),
--Quizid int foreign key references tbQuiz(Quizid),
Versionid int foreign key references tbQuizVersion(Versionid)
)
go

--Match the City with the Country
insert into tbMatchingQuestions(Question,Choices,Answers,Versionid)values
('London','France','Great Britain',1),
('Paris','Russia','France',1),
('Athens','Great Britain','Greece',1),
('Moscow','Spain','Russia',1),
('Madrid','Greece','Spain',1)
go

create table tbLongQuestions(
LongQuestionsid int primary key identity(0,1),
Question varchar(150),
Answer varchar(max),
--Quizid int foreign key references tbQuiz(Quizid),
Versionid int foreign key references tbQuizVersion(Versionid)
)
go

insert into tbLongQuestions(Question,Answer,Versionid)values
('What is Equilibrium?','State of stable conditions in which all significant factors remain more or less constant over a period, and there is little or no inherent tendency for change.',1),
('What is time?','Time is the fourth dimension and a measure in which events can be ordered from the past through the present into the future, and also the measure of durations of events and the intervals between them.',1),
('Why do we need sleep?','Sleep gives your body a rest and allows it to prepare for the next day.',1),
('Which has more power, love or fear?','Love. Fear will only have people obeying you until they can get away. Love will have people willing to die for each other and for you.',1),
('What is Science?','the intellectual and practical activity encompassing the systematic study of the structure and behavior of the physical and natural world through observation and experiment.',1)
go

create table tbMultipleAnswers(
MultipleAnswersid int primary key identity(0,1),
Userid int foreign key references tbUser(Userid),
MultipleQuestionsid int foreign key references tbMultipleQuestions(MultipleQuestionsid),
--Quizid int foreign key references tbQuiz(Quizid),
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
Quizid int foreign key references tbQuiz(Quizid),
UserAnswer varchar(150)
)
go

insert into tbMatchingAnswers(MatchingQuestionsid,Userid,Quizid,UserAnswer)values
(0,4,1,'Great Britain'),(1,4,1,'France'),(2,4,1,'Greece'),(3,4,1,'Russia'),(4,4,1,'Spain')
go

create table tbLongAnswers(
LongAnswersid int primary key identity (0,1),
Userid int foreign key references tbUser(Userid),
LongQuestionsid int foreign key references  tbLongQuestions(LongQuestionsid),
Quizid int foreign key references tbQuiz(Quizid),
UserAnswer varchar(max)
)
go

insert into tbLongAnswers(Userid,LongQuestionsid,Quizid,UserAnswer)values
(5,0,1,'State of stable conditions in which all significant factors remain more or less constant over a period, and there is little or no inherent tendency for change.'),
(5,1,1,'Time is the fourth dimension and a measure in which events can be ordered from the past through the present into the future, and also the measure of durations of events and the intervals between them.'),
(5,2,1,'Sleep gives your body a rest and allows it to prepare for the next day.'),
(5,3,1,'Love. Fear will only have people obeying you until they can get away. Love will have people willing to die for each other and for you.'),
(5,4,1,'the intellectual and practical activity encompassing the systematic study of the structure and behavior of the physical and natural world through observation and experiment.')
go

--Failed Login Attempts
create table tbFailedLoginAttempt(
Username varchar(60),
Password varchar(60),
DateAttempted date
)
go

insert into tbFailedLoginAttempt(Username,Password,DateAttempted)values
('Geoffrey','Smith','01-12-2014'),
('Ian','Morgan','02-24-2014'),
('Katie','Hunter','06-16-2014'),
('Elmer','Sherman','06-25-2014'),
('Isabel','Holland','07-03-2014'),
('Andrea','Barrett','07-08-2014'),
('Whitney','Woods','07-10-2014'),
('Abraham','Washington','08-13-2013'),
('Sophia','Roy','08-14-2013'),
('Lester','Tran','04-06-2014'),
('Tasha','Nguyen','04-15-2014'),
('Desiree','Mcbride','04-20-2014'),
('Melody','Allison','05-13-2014'),
('Lee','Hopkins','05-20-2014'),
('Irving','Evans','05-26-2014')
go

<<<<<<< HEAD
----testing xml datatype here to save uploaded quizzes----plz don't delete yet// thanks Nupur
create table tbXMLQuizContent(
QuizId int primary key,    --extract it from the XML file
Title varchar(60),
Subject varchar(60),
Course varchar(60),
Time int,
Difficulty varchar(20)
)
go

create table tbXMLtest(
XMLContent varchar(max)
)
go

create table tbMultipleChoice(
QuestionID int primary key identity (1,1),
XMLQuestionID int,    -- get this id from xml file
Question varchar(255),
OptionOne varchar(60),
OptionTwo varchar(60),
OptionThree varchar(60),
OptionFour varchar(60),
CorrectAnswer varchar(20) null,
QuizId int foreign key references tbXMLQuizContent(QuizId)
)
go

------------------------STORED PROCEDURES-----------------------

create procedure spinsertXMLContent(
@xml xml
)
as begin
 set nocount on;
 insert into tbXMLQuizContent
 select 
-- t.value('@QuizId','int') as XMLQuizID,    --attribute from xml file
 t.value('(@QuizId)[1]','int') as QuizId,
 t.value('(Title/text())[1]','VARCHAR(60)') as Title,   
 t.value('(Subject/text())[1]','VARCHAR(60)') as Subject,   
 t.value('(Course/text())[1]','VARCHAR(60)') as Course,   
 t.value('(Time/text())[1]','int') as Time,   
 t.value('(Difficulty/text())[1]','VARCHAR(60)') as Difficulty   
 from
 @xml.nodes('/Quiz/Details')AS TempTable(t)
end
go

create procedure spTEST(
@xml varchar(max)
)
as begin
insert into tbXMLtest(XMLContent) values
                     (@xml)
end
go

=======
-----------------------------PROCEDURES-----------------------------------------
>>>>>>> origin/master

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

-----------SELECTS------------

--Loads students by Class
create procedure spGetStudents(
@Classid int = null,
@SecurityLevel int 
)
as begin
	select './Pictures/' + UserPicture as UserPicture,Userid,Firstname, Lastname,Username,Password,Classid,SecurityLevel,Email
    from tbUser where tbUser.Classid = isnull(Classid, @Classid) and 
	tbUser.SecurityLevel =1 and tbUser.SecurityLevel = @SecurityLevel
end
go

create procedure spGetStudents2(
@Classid int = null,
@SecurityLevel int 
)
as begin
	select './Pictures/' + UserPicture as UserPicture,Userid,Lastname + ', ' + Firstname as Studentname,Username,Password,Classid,SecurityLevel,Email
    from tbUser where tbUser.Classid = isnull(Classid, @Classid) and 
	tbUser.SecurityLevel =1 and tbUser.SecurityLevel = @SecurityLevel
end
go

create procedure spGetStudents3(
@Classid int,
@SecurityLevel int 
)
as begin
	select './Pictures/' + UserPicture as UserPicture,Userid,Lastname + ', ' + Firstname as Studentname,Username,Password,Classid,SecurityLevel,Email
    from tbUser where tbUser.Classid = @Classid and 
	tbUser.SecurityLevel =1 and tbUser.SecurityLevel = @SecurityLevel
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

--Loads Class
create procedure spLoadClass
as begin
	select * from tbClass
end
go

--Loads Class
create procedure spGetClass(
@Classid int = null
)
as begin
	select * from tbClass where tbClass.Classid = @Classid
end
go

--Loads Course by Courseid
create procedure spGetCourse(
@Courseid int
)
as begin 
	select * from tbCourse where Courseid= @Courseid
end
go

--Load Course by Classid
create procedure spLoadCourse(
@Classid int
)
as begin
	select Courseid from tbClass where Classid=@Classid
end	
go

--Load Quiz
create procedure spLoadQuiz
as begin 
	select * from tbQuiz
end 
go

--Load Quiz by Courseid
create procedure spLoadQuiz2(
@Courseid int
)
as begin 
	select * from tbQuiz where Courseid=@Courseid
end 
go

--Load Quiz by Quizid
create procedure spLoadQuiz5(
@Quizid int
)
as begin 
	select * from tbQuiz,tbDifficulty,tbQuizVersion where tbQuiz.Quizid = @Quizid and tbDifficulty.Difficultyid = tbQuiz.Difficulty and tbQuiz.Quizid = tbQuizVersion.Quizid
end 
go

--Loads Quiz
create procedure spLoadQuiz4
as begin
	select * from tbQuiz, tbQuizVersion where tbQuiz.Quizid = tbQuizVersion.Quizid
end
go

--Loads Quiz by xmlQuizid and Version
create procedure spLoadQuiz3(
@xmlQuizid varchar(60),
@Version int
)
as begin 
	select * from tbQuiz,tbQuizVersion,tbDifficulty where tbQuiz.Quizid = tbQuizVersion.Quizid and 
	tbQuiz.xmlQuizid = @xmlQuizid and tbQuizVersion.Version = @Version and tbDifficulty.Difficultyid = tbQuiz.Difficulty
end
go


--Loads Version
create procedure spLoadVersion
as begin 
	select * from tbQuizVersion
end 
go

--Loads the Quiz 
create procedure spViewQuiz
as begin 
	select tbQuiz.Quizid,QuizTitle,QuizSubject,Courseid,TimetoTake,Difficulty,FileLocation, Version from tbQuiz,tbQuizVersion
	where tbQuiz.Quizid = tbQuizVersion.Quizid
	
end 
go

--Loads Questions for the (Mentor side)
create procedure spLoadQuestions
as begin
	select Question,Choice1,Choice2,Choice3,Choice4,Answer from tbMultipleQuestions
	select Question,Answers from tbMatchingQuestions
	select Question,Answer from tbLongQuestions
end
go

--Loads the Quiz Result (User side)
create procedure spViewQuizResults(
@Userid int
)

as begin 
	select * from tbResults,tbQuiz
	where tbResults.Userid=@Userid and tbQuiz.Quizid = tbResults.Quizid
end 
go

--Loads the Quiz Result of all students
create procedure spViewQuizResults2

as begin 
	select * from tbResults 
	
end 
go

--Loads Pending Quiz (student side)
 create procedure spViewPendingQuiz2(
 @Userid int
 )
as begin 
	select * from tbQuizTaker,tbQuiz,tbDifficulty,tbQuizVersion
	where tbQuizTaker.Quizid = tbQuiz.Quizid and Userid=@Userid and tbQuiz.Difficulty = tbDifficulty.Difficultyid and tbQuizTaker.Versionid = tbQuizVersion.Versionid
	
end 
go

--Loads Multiple Choice,Matching,and Long Questions into QuizForm
create procedure spQuizForm(
@xmlQuizid varchar(60),
@Version varchar(60)
)
as begin
	select Question,Choice1,Choice2,Choice3,Choice4 from tbMultipleQuestions,tbQuizVersion,tbQuiz
	where tbMultipleQuestions.Versionid = tbQuizVersion.Versionid and tbQuiz.Quizid = tbQuizVersion.Quizid and tbQuizVersion.Version = @Version and 
			tbQuiz.xmlQuizid = @xmlQuizid
	
	select Question,Choices from tbMatchingQuestions,tbQuizVersion,tbQuiz 
	where tbMatchingQuestions.Versionid = tbQuizVersion.Versionid and tbQuiz.Quizid = tbQuizVersion.Quizid and tbQuizVersion.Version=@Version and
		  tbQuiz.xmlQuizid = @xmlQuizid
	
	select Question from tbLongQuestions,tbQuizVersion,tbQuiz
	where tbLongQuestions.Versionid = tbQuizVersion.Versionid and tbQuiz.Quizid = tbQuizVersion.Quizid and tbQuizVersion.Version = @Version and 
		  tbQuiz.xmlQuizid = @xmlQuizid
end
go
--spQuizForm @xmlQuizid= 555, @Version=2

--------------INSERTS-----------------

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

--Insert Difficulty
create procedure spInsertDifficulty(
@Difficultyname varchar(60)
)
as begin
	insert into tbDifficulty(Difficultyname)values
				(@Difficultyname)
end
go

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

--Insert Course
create procedure spInsertCourse(
@Coursename varchar(60)
)
as begin 
	insert into tbCourse (Coursename) values
						 (@Coursename)
end
go

----------------UPDATES-------------

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

--Update Difficulty
create procedure spUpdateDifficulty(
@Difficultyid int = null,
@Difficultyname varchar(60)
)
as begin
	update tbDifficulty set Difficultyname = @Difficultyname
	where Difficultyid =@Difficultyid
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

--Update Course
create procedure spUpdateCourse(
@Courseid int = null,
@Coursename varchar(60)
)
as begin
	update tbCourse set Coursename = @Coursename 
	where Courseid=@Courseid
end
go


-----------------DELETES----------------

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

--Delete Difficulty
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

--Delete Class
create procedure spDeleteClass(
@Classid int
)
as begin
	
	delete from tbClass 
	where tbClass.Classid = @Classid
end
go

--Delete Course
create procedure spDeleteCourse(
@Courseid int
)
as begin 
	delete from tbCourse 
	where tbCourse.Courseid =@Courseid
end 
go


