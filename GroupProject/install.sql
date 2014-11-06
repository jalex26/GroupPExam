use master
go
drop database Exam
go
create database Exam
go
use Exam
go

create table tbCourse(
Courseid int primary key identity(0,1),
Coursename varchar(60)
)
go

insert into tbCourse(Coursename)values
('Software Developer'),('Network Engineering')
go

create table tbClass(
Classid int primary key identity (0,1),
Classname varchar(60),
Courseid int foreign key references tbCourse(Courseid)on delete cascade
)
go

insert into tbClass(Classname,Courseid)values
('SD18',0),('SD19',0),('SD20',0),('SD21',0),('SD22',0),
('NT03',1),('NT04',1)
go

create table tbDifficulty(
Difficultyid int primary key identity(0,1),
Difficultyname varchar(60)
)
go

insert into tbDifficulty(Difficultyname)values
('Beginner'),('Intermediate'),('Advanced')
go

create table tbUser(
Userid int primary key identity (0,1),
Firstname varchar(60),
Lastname varchar(60),
Password varchar(60),
Classid int foreign key references tbClass(Classid)on delete cascade,
SecurityLevel int,
UserPicture varchar(60),
Email varchar(60) Unique,
LostPass varchar(20)
)
go


insert into tbUser(Firstname,Lastname,Password,Classid,SecurityLevel,UserPicture,Email)values
('Kevin','Coliat','Kevin1',0,3,'kevin.jpg','kevin.coliat@robertsoncollege.net'),
('Doug','Jackson','pass',0,2,'SamplePicture2.jpg','Doug@yahoo.com'),
('Nupur','Singh','Nupur1',0,3,'Nupur.jpg','nupur.singh@robertsoncollege.net'),
('Janry','Alex','Janry1',1,1,'janry.jpg','janry.alex@robertsoncollege.net'),
('Adrian','Carter','Adrian1',2,1,'AdrianCarter2.jpg','adrian.carter@robertsoncollege.net'),
('Veberly','Carvalho','Veberly1',0,1,'veberly.jpg','veberly.carvalho@robertsoncollege.net'),
('OtherKevin','Coliat','Kevin1',1,1,'SamplePicture1.jpg','Kevin0@yahoo.com'),
('AnotherKevin','Coliat','Kevin1',1,1,'SamplePicture1.jpg','Kevin9@yahoo.com')
go
create table tbToken(
Tokenid int primary key identity (0,1),
TToken varchar(50),
TUserid int foreign key references tbUser(Userid)
)
go


create table tbQuizStatus(
StatusId int primary key identity (0,1),
StatusName varchar(10)
)

insert into tbQuizStatus values
('Offline'),		-- 0
('Online'),			--1 
('Completed')			--2

create table tbQuizStudentStatus(
StatusId int primary key identity (0,1),
StatusName varchar(10))

insert into tbQuizStudentStatus values
('Not taken'),		-- 0
('Incomplete'),			--1 
('Completed'),			--2
('Ongoing')				--3

----testing xml datatype here to save uploaded quizzes----plz don't delete yet// thanks Nupur
create table tbXMLQuizContent(
XMLQuizID int primary key,    --extracting it from the XML file    
Title varchar(60),
Subject varchar(60),
CourseID int foreign key references tbCourse(Courseid),
Time int,
DifficultyId int foreign key references tbDifficulty(Difficultyid),

)
go

create table tbQuizVersion(
Versionid int primary key identity (0,1),
Quizid int foreign key references tbXMLQuizContent(XMLQuizID),
Version int,
XmlFile xml
)
go
create table tbIssuedQuiz(		-- issued quiz and its statuses,
IssuedQuizId int primary key identity(0,1),
Versionid int foreign key references tbQuizVersion(Versionid), -- actual quiz, has XMLQUIzContent and Version
ClassId int foreign key references tbClass(Classid),		-- users who will take the test!
DateIssued date,
Mentorid int foreign key references tbUser(Userid),
QuizStatus int foreign key references tbQuizStatus(StatusId)
)

create table tbQuizStudent(			
QuizStudentid int primary key identity (0,1), -- just the id nothing else
IssuedQuizId int foreign key references tbIssuedQuiz(IssuedQuizId), 
Userid int foreign key references tbUser(Userid),  ---Student
XMLStudentResponse xml, 
Status int foreign key references tbQuizStudentStatus(StatusId),
Points decimal(5,2) null   -- results or number of correct responses by each student
)
go


------------------------STORED PROCEDURES-----------------------

create procedure spInsertXMLContent(
@xml xml
)
as declare
@QuizIdDuplicate int,
@getQuizVersionOccurence int
 begin
begin transaction
 set nocount on;
 -- check first for duplicates, if so then make a new version of it...
 ;WITH XMLNAMESPACES (N'urn:Question-Schema' as ns)
 select @QuizIdDuplicate = (select t.value('@QuizId','int') as XMLQuizID
 from
 @xml.nodes('/ns:Quiz')AS TempTable(t))

 if not EXISTS(select 1 from tbXMLQuizContent where XMLQuizID = @QuizIdDuplicate)
 begin
 --- insert if no duplicate quizid
 ;WITH XMLNAMESPACES (N'urn:Question-Schema' as ns)
 insert into tbXMLQuizContent
 select 
 t.value('@QuizId','int') as XMLQuizID,    --attribute from xml file
 t.value('(ns:Details/ns:Title/text())[1]','VARCHAR(60)') as Title,   
 t.value('(ns:Details/ns:Subject/text())[1]','VARCHAR(60)') as Subject,
 (select Courseid from tbCourse where Coursename in (t.value('(ns:Details/ns:Course/text())[1]','VARCHAR(60)'))) as CourseID,
 t.value('(ns:Details/ns:Time/text())[1]','int') as Time,   
 (select Difficultyid from tbDifficulty where Difficultyname in (t.value('(ns:Details/ns:Difficulty/text())[1]','VARCHAR(60)'))) as Difficulty  
 from
 @xml.nodes('/ns:Quiz')AS TempTable(t)
 --- and insert new quizversion, set to version 1, first version of quiz
 ;WITH XMLNAMESPACES (N'urn:Question-Schema' as ns)
 insert into tbQuizVersion(Quizid,Version,XmlFile)
 select
 t.value('@QuizId','int') as Quizid,
 1 as Version,
 @xml as XmlFile
 from
 @xml.nodes('/ns:Quiz')AS TempTable(t)
 end
 else --- if there is a version exists in the database, then addnew version and the path of xml file
	begin
 ---- insert into tbQuizVersion
 set @getQuizVersionOccurence = (select COUNT(Versionid) from tbQuizVersion where Quizid = @QuizIdDuplicate)
 set @getQuizVersionOccurence += 1;
 ;WITH XMLNAMESPACES (N'urn:Question-Schema' as ns)
 insert into tbQuizVersion(Quizid,Version,XmlFile)
 select
 t.value('@QuizId','int') as Quizid,
 @getQuizVersionOccurence as Version,
 @xml as XmlFile
 from
 @xml.nodes('/ns:Quiz') AS TempTable(t)
	end

 if @@ERROR != 0
        begin
            ROLLBACK TRANSACTION
			select 'error' as status
		end
else
	begin
        commit transaction
		select 'success' as status
    end

end
go
spInsertXMLContent @xml = '<?xml version="1.0" encoding="utf-8"?><Quiz QuizId="111230123" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns="urn:Question-Schema"><Details><Title>testtitle</Title><Subject>tsubh</Subject><Course>Software Developer</Course><Time>15</Time><Difficulty>Intermediate</Difficulty></Details><Questions><MultipleChoice><Question ID="1"><Questi>what is?</Questi><Options><Option>a</Option><Option Correct="yes">b</Option><Option>c</Option><Option>d</Option></Options></Question></MultipleChoice><FillBlanks /><TrueFalse /><longAnswer /></Questions></Quiz>'
go
spInsertXMLContent @xml = '<?xml version="1.0" encoding="utf-8"?><Quiz QuizId="111230123" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns="urn:Question-Schema"><Details><Title>testtitle</Title><Subject>tsubh</Subject><Course>Software Developer</Course><Time>25</Time><Difficulty>Intermediate</Difficulty></Details><Questions><MultipleChoice><Question ID="1"><Questi>what is?</Questi><Options><Option>a</Option><Option Correct="yes">b</Option><Option>c</Option><Option>d</Option></Options></Question></MultipleChoice><FillBlanks /><TrueFalse /><longAnswer /></Questions></Quiz>'
go
spInsertXMLContent @xml = '<?xml version="1.0" encoding="utf-8"?><Quiz QuizId="9999" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns="urn:Question-Schema"><Details><Title>testNetwork</Title><Subject>tsubh</Subject><Course>Network Engineering</Course><Time>31</Time><Difficulty>Intermediate</Difficulty></Details><Questions><MultipleChoice><Question ID="1"><Questi>what is?</Questi><Options><Option>a</Option><Option Correct="yes">b</Option><Option>c</Option><Option>d</Option></Options></Question></MultipleChoice><FillBlanks /><TrueFalse /><longAnswer /></Questions></Quiz>'
go
spInsertXMLContent @xml = '<?xml version="1.0"?><Quiz QuizId="570748" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns="urn:Question-Schema"><Details><Title>Yow </Title><Subject>YowS</Subject><Course>Software Developer</Course><Time>31</Time><Difficulty>Intermediate</Difficulty></Details><Questions><MultipleChoice><Question ID="1"><Questi>What is ?</Questi><Options><Option>a</Option><Option>3b</Option><Option Correct="yes">4x</Option><Option>5a</Option></Options></Question><Question ID="2"><Questi>Who is</Questi><Options><Option Correct="yes">zxcasd</Option><Option>4asdasd</Option><Option>5qwe</Option><Option>6asda</Option></Options></Question><Question ID="3"><Questi>What kind of?</Questi><Options><Option>4zxc</Option><Option>5asd</Option><Option Correct="yes">6qw</Option><Option>7qe</Option></Options></Question><Question ID="4"><Questi>Where is?</Questi><Options><Option>1asd</Option><Option>2xzcasd</Option><Option Correct="yes">3asd</Option><Option>5qwe</Option></Options></Question><Question ID="5"><Questi>add ?</Questi><Options><Option Correct="yes">sad</Option><Option>asd</Option><Option>qw</Option><Option>qeqwe</Option></Options></Question></MultipleChoice><FillBlanks /><TrueFalse /><longAnswer /></Questions></Quiz>'
go
select * from tbXMLQuizContent
select * from tbCourse
select * from tbQuizVersion
select * from tbUser
go
-----------------------------PROCEDURES-----------------------------------------


create procedure spGetQuizAndInfo(
@versionid int
)
as begin
select XMLQuizID,Title,Subject,CourseID,Time,DifficultyId,XmlFile from tbXMLQuizContent,tbQuizVersion where XMLQuizID in (select top 1 Quizid from tbQuizVersion where Versionid = @versionid) and tbXMLQuizContent.XMLQuizID=tbQuizVersion.Quizid and tbQuizVersion.Versionid =@versionid
end
go
-- spGetQuizAndInfo @versionid=1
go
--Login
create procedure spLogin(
@Email varchar(60),
@Password varchar(60)
)
as begin
	select * from tbUser where tbUser.Email = @Email and tbUser.Password = @Password
end
go

create procedure spIssueNewQuiz(
@Versionid int,
@Mentorid int,
@ClassId int
)
as begin
begin transaction

if not EXISTS(select * from tbIssuedQuiz where Versionid = @Versionid and ClassId = @ClassId)
	begin
	begin transaction
		if EXISTS (select * from tbUser where SecurityLevel != 1 and Userid = @Mentorid)
			begin
			insert into tbIssuedQuiz values(@Versionid,@ClassId,GETDATE(),@Mentorid,0)
			select @@IDENTITY as IssuedQuizId
			end
		else
		begin
			select 'Insufficient Level' status
		end
	commit transaction
	end
else
	begin
	select 'TestExists' as status
	end

 if @@ERROR != 0
        begin
            ROLLBACK TRANSACTION
			select 'error' as status
		end
else
	begin
        commit transaction
		select 'success' as status
    end
end
go

create procedure spIssueNewQuizStudent(
@IssuedQuizId int,
@UserId int,
@XMLStudentResponse xml
)
as
 begin
begin transaction

	--set @getxml = (select tbQuizVersion.XmlFile from tbIssuedQuiz
	--join tbQuizVersion on tbQuizVersion.Versionid = tbIssuedQuiz.Versionid
	--where tbIssuedQuiz.IssuedQuizId = @IssuedQuizId)

	--;WITH XMLNAMESPACES (N'urn:Question-Schema' as ns)
	--(select @xmlMultipleCount = (select @getxml.value('count(/ns:Quiz/ns:Questions/ns:MultipleChoice/ns:Question)','int') as Count))
	--select @getxml as XML, @xmlMultipleCount as MultipleCount
	
	if not EXISTS(select * from tbQuizStudent where IssuedQuizId = @IssuedQuizId and Userid = @UserId and Status != 0)
	begin
		insert into tbQuizStudent values (@IssuedQuizId,@UserId,@XMLStudentResponse,0,null)
	end
	else
	begin
		update tbQuizStudent set XMLStudentResponse = @XMLStudentResponse where IssuedQuizId = @IssuedQuizId and Userid = @UserId
	end
 if @@ERROR != 0
        begin
            ROLLBACK TRANSACTION
			select 'error' as status
		end
else
	begin
        commit transaction
		select 'success' as status
    end
end
go
create procedure spStartQuiz(
@IssuedQuizId int
)
as begin
if EXISTS(select * from tbIssuedQuiz where IssuedQuizId=@IssuedQuizId and QuizStatus != 1)
	begin
	update tbIssuedQuiz set QuizStatus = 1 where IssuedQuizId = @IssuedQuizId
	select 'Activated' as status
	end
else
begin
	select 'error' as status
end
end

go
create procedure spStartQuizStudent (
@UserId int,
@QuizStudentId int
)
as declare
@IssuedQuizId int = -1
begin
begin tran
set @IssuedQuizId = (select IssuedQuizId from tbQuizStudent where Userid = @UserId and QuizStudentid = @QuizStudentId)
select @IssuedQuizId as QUizId

if EXISTS(select * from tbIssuedQuiz where @IssuedQuizId != -1 and IssuedQuizId = @IssuedQuizId and QuizStatus = 1) -- The IssuedQuiz status must be active first
begin
	if EXISTS(select * from tbQuizStudent where Userid = @UserId and QuizStudentid = @QuizStudentId)
	begin
	update tbQuizStudent set Status= 3 where Userid = @UserId and QuizStudentid = @QuizStudentId
	select XMLStudentResponse from tbQuizStudent where Userid = @UserId and QuizStudentid = @QuizStudentId
	end
	else
	begin
	select 'invalid Quiz' as status
	end
end
else
begin
select 'QuizNotActive' as status
end
if @@ERROR != 0
        begin
            ROLLBACK TRANSACTION
			select 'error' as status
		end
else
	begin
        commit transaction
		select 'success' as status
    end
end

go
-- spIssueNewQuizStudent @IssuedQuizId=0, @UserId = 3
go
spIssueNewQuiz @Versionid = 0, @ClassId = 1, @Mentorid =0
select * from tbQuizStatus 
select * from tbIssuedQuiz
select * from tbQuizStudent
select * from tbUser
select * from tbQuizStudentStatus
select * from tbQuizVersion
select * from tbXMLQuizContent

insert into tbQuizStudent values (0,7,'<?xml version="1.0"?><Quiz QuizId="570748" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns="urn:Question-Schema"><Details><Title>Yow </Title><Subject>YowS</Subject><Course>Software Developer</Course><Time>31</Time><Difficulty>Intermediate</Difficulty></Details><Questions><MultipleChoice><Question ID="1"><Questi>What is ?</Questi><Options><Option>a</Option><Option>3b</Option><Option Correct="yes">4x</Option><Option>5a</Option></Options></Question><Question ID="2"><Questi>Who is</Questi><Options><Option Correct="yes">zxcasd</Option><Option>4asdasd</Option><Option>5qwe</Option><Option>6asda</Option></Options></Question><Question ID="3"><Questi>What kind of?</Questi><Options><Option>4zxc</Option><Option>5asd</Option><Option Correct="yes">6qw</Option><Option>7qe</Option></Options></Question><Question ID="4"><Questi>Where is?</Questi><Options><Option>1asd</Option><Option>2xzcasd</Option><Option Correct="yes">3asd</Option><Option>5qwe</Option></Options></Question><Question ID="5"><Questi>add ?</Questi><Options><Option Correct="yes">sad</Option><Option>asd</Option><Option>qw</Option><Option>qeqwe</Option></Options></Question></MultipleChoice><FillBlanks /><TrueFalse /><longAnswer /></Questions></Quiz>',0,null)
-- spStartQuiz @IssuedQuizId = 0
-- spStartQuizStudent @UserId= 7,@QuizStudentId= 0
go

create procedure spGetIssuedQuizByMentor (
@Userid int
)
as begin
if EXISTS(select * from tbUser where Userid= @Userid and SecurityLevel != 1)
begin
	select * from tbIssuedQuiz
	join tbClass on tbClass.Classid = tbIssuedQuiz.ClassId
	join tbQuizVersion on tbQuizVersion.Versionid = tbIssuedQuiz.Versionid
	join tbQuizStatus on tbQuizStatus.StatusId = tbIssuedQuiz.QuizStatus
	join tbXMLQuizContent on tbXMLQuizContent.XMLQuizID = tbQuizVersion.Quizid
	join tbCourse on tbCourse.Courseid = tbXMLQuizContent.CourseID
	where tbIssuedQuiz.Mentorid = @Userid
	 end
end
go
spGetIssuedQuizByMentor @Userid= 0
go

create procedure getIssuedQuizDetails(
@IssuedQuizId int
)
as begin
select IssuedQuizId,Classname,Title,Time,QuizStatus,StatusName from tbIssuedQuiz
join tbQuizVersion on tbQuizVersion.Versionid = tbIssuedQuiz.Versionid
join tbClass on tbClass.Classid = tbIssuedQuiz.ClassId
join tbQuizStatus on tbQuizStatus.StatusId = tbIssuedQuiz.QuizStatus
join tbXMLQuizContent on tbXMLQuizContent.XMLQuizID = tbQuizVersion.Quizid

 where IssuedQuizId = @IssuedQuizId
end
go

go
create procedure spForgotPassword(
@EmailAddress varchar (50)
)
as declare
@message varchar (50),
@Token varchar (50)='notExists'
begin
begin transaction
if Exists (select 1 from tbUser where Email = @EmailAddress)
begin 
while not Exists (select 1 from tbUser where LostPass = @Token)
begin 
SELECT @Token = (select char(rand()*26+65)+char(rand()*26+65)+char(rand()*26+65)
+char(rand()*26+65)+char(rand()*26+65)+char(rand()*26+65)
+char(rand()*26+65)+char(rand()*26+65)+char(rand()*26+65)
+char(rand()*26+65)+char(rand()*26+65)+char(rand()*26+65)
+char(rand()*26+65)+char(rand()*26+65)+char(rand()*26+65))
update tbUser set LostPass=@Token where Email=@EmailAddress
set @Message = 'CheckMail'
end
end
else
begin
set @Message = 'EmailInvalid'
end
if @@ERROR != 0
begin
ROLLBACK TRANSACTION
select @Message as message
end
else 
begin
commit transaction
select @Message as message, @Token as Token
end
end
go
--spCheckToken @Token= 'COSNMXEDEEDMSAK'
create procedure spCheckToken(
@Token varchar(20)
)
as begin
if exists(select 1 from tbUser where LostPass=@Token)
begin
select 'true' as exist
end
else
begin
select 'false' as exist
end
end
go

--spChangePass @Token='UMZSWKHAOMWHWVC', @NewPass = 'new'
go
create procedure spChangePassWord(
@Token varchar(20),
@NewPass varchar(60)
)
as declare
@message varchar(60)
 begin
begin transaction
if Exists(select 1 from tbUser where LostPass = @Token)
begin
	update tbUser set password=@NewPass, LostPass=null where LostPass=@Token
	set @message = 'success'
end
else
begin
	set @message='invalid token'
end
if @@ERROR != 0
        begin
            ROLLBACK TRANSACTION
			select @message as message
		end
else 
	begin
        commit transaction
		select @message as message
    end
end
go
create procedure spGetStudentInfo(
@Userid int 
)
as
begin
select Userid,'./Pictures/' + UserPicture as UserPicture,Firstname,Lastname,Classid,Email 
from tbUser
where Userid = @Userid
end
go


go
create procedure spGetStudents(
@Classid int = null,
@Userid int = null
)
as begin
	select './Pictures/' + UserPicture as UserPicture,
	Userid,Lastname, Classname, Coursename,
	Firstname,Password, tbClass.Classid, SecurityLevel,Email
    from  tbUser, tbCourse, tbClass 
	where tbUser.Classid = isnull(@Classid, tbUser.Classid) and 
	      tbUser.Userid = isnull(@Userid, tbUser.Userid) and
	      tbUser.Classid = tbClass.Classid and
		  tbClass.Courseid = tbCourse.Courseid and
		  tbUser.SecurityLevel = 1
	    
end
go

create procedure spGetUsers(
@Classid int = null,
@Userid int = null
)
as begin
	select './Pictures/' + UserPicture as UserPicture,
	Userid,Lastname, Classname, Coursename,
	Firstname,Password, tbClass.Classid, SecurityLevel,Email
    from  tbUser, tbCourse, tbClass 
	where tbUser.Classid = isnull(@Classid, tbUser.Classid) and 
	      tbUser.Userid = isnull(@Userid, tbUser.Userid) and
	      tbUser.Classid = tbClass.Classid and
		  tbClass.Courseid = tbCourse.Courseid
	    
end
go


create procedure spLoadAllStudentClass(
@Classid int
)
as begin
select './Pictures/' + UserPicture as UserPicture,
	Userid,Lastname + ', ' + Firstname as Studentname, Classname, Coursename,
	Firstname,Password, tbClass.Classid, SecurityLevel,Email
    from  tbUser, tbCourse, tbClass 
	where tbUser.Classid = isnull(tbUser.Classid, @Classid) and 
	      tbUser.Classid = tbClass.Classid and
		  tbClass.Courseid = tbCourse.Courseid and
	      tbUser.SecurityLevel = 1 -- students 
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
create procedure spLoadClass(
@CourseId int = null
)
as begin
	select tbClass.Classid, tbClass.Classname, Coursename
	from tbClass, tbCourse
	--left join tbCourse on tbCourse.Courseid = @CourseId
	where tbClass.Courseid = @CourseId and
	      tbclass.Courseid = tbCourse.Courseid
end
go
-- spLoadClass @CourseId = 1
go

--Loads Class
create procedure spGetClass(
@Classid int = null
)
as begin
	select * from tbClass
	 where Classid = isnull(@Classid, Classid)
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
create procedure spLoadCourse
as begin
	select * from tbCourse
end	
go

go

create procedure spLoadQuizes(
@Courseid int
)
as begin
	select XMLQuizID,Title,Subject,tbXMLQuizContent.CourseID,Time,DifficultyId from tbXMLQuizContent
	left join tbCourse on tbCourse.Courseid = tbXMLQuizContent.CourseID
	where tbXMLQuizContent.CourseID = @Courseid
end

go
-- spLoadQuizes @Courseid = 0;
go


--Load Quiz get it from versioning table and join it on tbXMLcontent
create procedure spLoadQuiz
as begin 
	select * from tbXMLQuizContent, tbQuizVersion
	where tbXMLQuizContent.XMLQuizID = tbQuizVersion.Quizid
end 
go

--Load Quiz by Courseid
create procedure spLoadQuiz2(
@Courseid int
)
as begin 
	select * from tbXMLQuizContent where tbXMLQuizContent.CourseID =@Courseid
end 
go

--Load Quiz by Quizid
create procedure spLoadQuiz5(
@Quizid int
)
as begin 
	select * from tbXMLQuizContent,tbDifficulty,tbQuizVersion 
	where tbXMLQuizContent.XMLQuizID = @Quizid and 
	tbDifficulty.Difficultyid = tbXMLQuizContent.DifficultyId and 
	tbXMLQuizContent.XMLQuizID = tbQuizVersion.Quizid
end 
go

--Loads Quiz
create procedure spLoadQuiz4
as begin
	select * from tbXMLQuizContent, tbQuizVersion 
	where tbXMLQuizContent.XMLQuizID = tbQuizVersion.Quizid
end
go
--Loads Version
create procedure spLoadVersion(
@QuizId int
)
as begin 
	select * from tbQuizVersion where Quizid = @QuizId
end 
go
spLoadVersion @QuizId = 111230123
go

--Loads the Quiz 
create procedure spViewQuiz
as begin 
	select tbXMLQuizContent.XMLQuizID, tbXMLQuizContent.Subject, tbXMLQuizContent.Time,
	       tbXMLQuizContent.Title,
	       tbXMLQuizContent.DifficultyId, tbQuizVersion.Version, tbQuizVersion.Versionid,
		   tbDifficulty.Difficultyname
	from tbXMLQuizContent,tbQuizVersion, tbDifficulty
	where tbXMLQuizContent.XMLQuizID = tbQuizVersion.Quizid and
	      tbXMLQuizContent.DifficultyId = tbDifficulty.Difficultyid
	
end 
go


--Loads the Quiz Result (User side)
create procedure spViewQuizResults(
@Userid int
)

as begin 
	select * from tbQuizVersion, tbQuizStudent, tbIssuedQuiz 
	where tbQuizStudent.QuizStudentid = @Userid and
	      tbQuizVersion.Versionid = tbIssuedQuiz.Versionid and
		  tbIssuedQuiz.IssuedQuizId = tbQuizStudent.IssuedQuizId
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
	select * from tbQuizStudent,tbXMLQuizContent,tbDifficulty, tbIssuedQuiz
	where  Userid=@Userid and
	       tbQuizStudent.IssuedQuizId = tbIssuedQuiz.IssuedQuizId and	      
	      tbXMLQuizContent.DifficultyId = tbDifficulty.Difficultyid
	end 
go

--spViewPendingQuiz2 @Userid=3
create procedure spInsertStudent(
@Firstname varchar(60),
@Lastname varchar(60),
@Password varchar(60),
@Classid int,
@SecurityLevel int
)
as begin
	insert into tbUser(Firstname,Lastname,Password,Classid,SecurityLevel)values
					  (@Firstname,@Lastname,@Password,@Classid,@SecurityLevel)
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

--Update Users
create procedure spUpdateUser(
@Userid int,
@Firstname varchar (60),
@Lastname varchar (60),
@Password varchar (60),
@Email varchar (60),
@Classid int,
@SecurityLevel int
)
as begin
update tbUser set Firstname =@Firstname, Lastname=@Lastname, Password=@Password, 
		Classid=@Classid, SecurityLevel=@SecurityLevel, Email = @Email
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

    delete from tbQuizStudent
	where tbQuizStudent.Userid = @Userid

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


----------------Settings-------------

--Update---
create procedure spUpdateSettings(
@Userid int = null,
@Firstname varchar (60),
@Lastname varchar (60),
@Password varchar (60),
@Classid int,
@SecurityLevel int
)
as begin
update tbUser set Firstname =@Firstname, Lastname=@Lastname, Password=@Password, 
		Classid=@Classid, SecurityLevel=@SecurityLevel
			 where tbUser.Userid = @Userid
end
go

create procedure spGetXml
as begin
select * from tbQuizVersion
end
go

---------------------------------------------------

create table tbTestSample(
TestSampleid int primary key identity(0,1),
XMLQuiz xml
)
go

insert into tbTestSample(XMLQuiz)values
('<Quiz xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns="urn:Question-Schema" QuizId="111230123">
  <?xml-stylesheet type="text/xsl" href="Quiz.xsl"?>
  <Details>
    <Title>testtitle</Title>
    <Subject>tsubh</Subject>
    <Course>Software Developer</Course>
    <Time>25</Time>
    <Difficulty>Intermediate</Difficulty>
  </Details>
  <Questions>
    <MultipleChoice>
      <Question ID="1">
        <Questi>What is the fastest mammal?</Questi>
        <Options>
          <Option>a.Lion </Option>
          <Option Correct="yes">b. Cheetah</Option>
          <Option>c. Kangaroo</Option>
          <Option>d. Turtle</Option>
        </Options>
      </Question>
	  <Question ID="2">
        <Questi>Whats up?</Questi>
        <Options>
          <Option>a. Good</Option>
          <Option Correct="yes">b. Great</Option>
          <Option>c. Bad</Option>
          <Option>d. Not feeling well</Option>
        </Options>
      </Question>
	  <Question ID="3">
        <Questi>Whats your name?</Questi>
        <Options>
          <Option>a. Kevin</Option>
          <Option Correct="yes">b. Janry</Option>
          <Option>c. Bebz</Option>
          <Option>d. Adrian</Option>
        </Options>
      </Question>
    </MultipleChoice>
    <FillBlanks />
    <TrueFalse />
    <longAnswer />
  </Questions>
</Quiz>')

go

select * from tbTestSample
go
create procedure spGetTestSample
as begin
	select * from tbTestSample
end 
go