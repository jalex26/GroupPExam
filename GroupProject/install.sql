use master
go
drop database Exam
go
create database Exam
go
use Exam
go

create table SD18EXAM_tbCourse(
Courseid int primary key identity(0,1),
Coursename varchar(60)
)
go
insert into SD18EXAM_tbCourse(Coursename)values
 ('Software and Database Developer'),('Accounting Specialist'),('Administrative Professional'),
 ('Business Administration'),('Casino / Resort / Event Coordinator'),('Legal Assistant'),
 ('Travel Counsellor'),('Veterinary Office Assistant'),('Network Engineering'),
 ('Enhanced Health Care Aide'),('Health Care Aide '),('Massage Therapy '),
('Medical Laboratory Assistant'),('Medical Office Assistant'),('Nursing Assistant'),
('Pharmacy Technician')
go

create table SD18EXAM_tbClass(
Classid int primary key identity (0,1),
Classname varchar(60),
Courseid int foreign key references SD18EXAM_tbCourse(Courseid)on delete cascade
)
go

insert into SD18EXAM_tbClass(Classname,Courseid)values
('SD18',0),('SD19',0),('SD20',0),
('AS01',1),('AS02',1),('AS03',1),
('AP12',2),('AP13',2),('AP14',2),
('BA23',3),('BA24',3),('BA25',3),
('CREC01',4),('CREC02',4),('CREC03',4),
('LA10',5),('LA11',5),('LA12',5),
('TC002',6),('TC003',6),('TC004',6),
('VOA1',7),('VOA2',7),('VOA3',7),
('NA001',8),('NA002',8),('NA003',8),
('EHCA31',9),('EHCA32',9),('EHCA3',9),
('HCA07',10),('HCA08',10),('HCA09',10),
('MT03',11),('MT04',11),('MT05',11),
('MLA022',12),('MLA023',12),('MLA024',12),
('MOA11',13),('MOA12',13),('MOA14',13),
('NA15',14),('NA16',14),('NA17',14),
('PT007',15),('PT008',15),('PT009',15)
go

create table SD18EXAM_tbDifficulty(
Difficultyid int primary key identity(0,1),
Difficultyname varchar(60)
)
go

insert into SD18EXAM_tbDifficulty(Difficultyname)values
('Beginner'),('Intermediate'),('Advanced')
go

create table SD18EXAM_tbUser(
Userid int primary key identity (0,1),
Firstname varchar(60),
Lastname varchar(60),
Password varchar(60),
Classid int foreign key references SD18EXAM_tbClass(Classid)on delete cascade null,
SecurityLevel int,
UserPicture varchar(60) null,
Email varchar(60) Unique,
LostPass varchar(20) null
)
go

insert into SD18EXAM_tbUser(Firstname,Lastname,Password,Classid,SecurityLevel,UserPicture,Email)values
('Kevin','Coliat','Kevin1',0,3,'kevin.jpg','kevin.coliat@robertsoncollege.net'),
('Doug','Jackson','pass',0,2,'SamplePicture2.jpg','Doug@yahoo.com'),
('Scott','Wachal','pass',0,2,'SamplePicture2.jpg','Scott@yahoo.com'),
('Jane','Doe','pass',0,9,'SamplePicture2.jpg','Jane@yahoo.com'),
('Nupur','Singh','Nupur1',0,3,'Nupur.jpg','nupur.singh@robertsoncollege.net'),
('Janry','Alex','Janry1',0,1,'janry.jpg','janry.alex@robertsoncollege.net'),
('Adrian','Carter','Adrian1',0,3,'AdrianCarter2.jpg','adrian.carter@robertsoncollege.net'),
('Veberly','Carvalho','Veberly1',0,1,'veberly.jpg','veberly.carvalho@robertsoncollege.net'),
('Samuel','Gear','Samuel1',1,1,'Samuel.jpg','Samuel.Gear@robertsoncollege.net'),
('Nathaniel','Bosman','Nathaniel',1,1,'SamplePicture1.jpg','Nathaniel@robertsoncollege.net'),
('Micheala','Amor','Micheala1',1,1,'SamplePicture1.jpg','Micheala@robertsoncollege.net'),
('Bella','De Rosa','Bella1',2,1,'Bella.jpg','Bela@robertsoncollege.net'),
('James','Smith','James1',2,1,'James.jpg','James.Smith@robertsoncollege.net'),
('Arnold','De Gusman','Arnold1',2,1,'Arnold.jpg','Arnold@robertsoncollege.net'),
('Jenifer','Tiamzon','Jenifer1',3,1,'Jenifer.jpg','Jenifer@robertsoncollege.net'),
('Monica','Ybanez','Monica1',3,1,'Moinca.jpg','Monica@robertsoncollege.net'),
('Elizabeth','Ramsay','Elizabeth1',3,1,'Elizabeth.jpg','Elizabeth@robertsoncollege.net'),
('Zevy','Gordon','Zevy1',4,1,'Zevy.jpg','Zevy@robertsoncollege.net'),
('Daniel','Wawazaki','Daniel1',4,1,'Daniel.jpg','Daniel@robertsoncollege.net'),
('Corazon','Zilva','Corazon1',4,1,'Corazon.jpg','Corazon@robertsoncollege.net'),
('Lulaby','Camaron1','Lulaby1',5,1,'Camaron.jpg','Camaron@robertsoncollege.net'),
('Stephanie','Stephanie','Stephanie1',5,1,'Stephanie.jpg','Stephanie@robertsoncollege.net'),
('Jackson','Switz','Jackson1',5,1,'Jackson.jpg','Jackson@robertsoncollege.net'),
('Bernard','Wisk','Bernard1',6,1,'Bernard.jpg','Bernard@robertsoncollege.net'),
('Ariala','Wisdom','Wisdom1',6,1,'Ariala.jpg','Ariala@robertsoncollege.net'),
('Jinky','Swamm','Jinky1',6,1,'Jinky.jpg','Jinky@robertsoncollege.net'),
('Ricky','Salvador','Ricky1',7,1,'Ricky.jpg','Ricky@robertsoncollege.net'),
('Roxanne','Cornejo','Roxanne1',7,1,'Roxanne.jpg','Roxanne@robertsoncollege.net'),
('Dave','Jones','Dave1',7,1,'dave.jpg','dave.alex@robertsoncollege.net'),
('Steven','De','Seven1',8,1,'Steven.jpg','Steven@robertsoncollege.net'),
('Clariza','Winx','Clariza1',8,1,'Clariza.jpg','Clariza@robertsoncollege.net'),
('Janelle','Hawla','Janelle1',8,1,'Janelle.jpg','Janelle@robertsoncollege.net'),
('Joshua','Mayer','Joshua',9,1,'Joshua.jpg','Joshua@robertsoncollege.net'),
('Melanie','Strong','Melanie1',9,1,'Melanie.jpg','Melanie@robertsoncollege.net'),
('Allysha','Bell','Allysha1',9,1,'Allysha.jpg','Allysha@robertsoncollege.net'),
('Alexis','Sandra','Alexis1',10,1,'Alexis.jpg','Alexis@robertsoncollege.net'),
('Scott','Anderson','Scott1',10,1,'Scott.jpg','Scott@robertsoncollege.net'),
('Cassandra','Morlin','Cassandra1',10,1,'Cassandra.jpg','Cassandra@robertsoncollege.net'),
('RoseMarie','','RoseMarie1',11,1,'RoseMarie.jpg','RoseMarie@robertsoncollege.net'),
('Andrew','Ong','Andrew1',11,1,'Andrew.jpg','Andrew.Ong@robertsoncollege.net'),
('Jezel','De Jesus','Jezel1',12,1,'Jezel.jpg','Jezel@robertsoncollege.net'),
('Rogelio','Bentura','Rogelio1',12,1,'Rogelio.jpg','Rogelio@robertsoncollege.net'),
('Rosalie','Zamora','Rosalie1',13,1,'Rosalie.jpg','Rosalie@robertsoncollege.net'),
('JhonMark','Escouzora','JhonMark1',13,1,'JhonMark.jpg','JhonMark@robertsoncollege.net'),
('Kenneth','Cacerez','Kenneth1',14,1,'Kenneth.jpg','Kenneth@robertsoncollege.net'),
('Albert','Morello','Albert1',14,1,'Albert.jpg','Albert@robertsoncollege.net'),
('Claire','Tabat','Claire1',15,1,'Claire.jpg','Claire@robertsoncollege.net'),
('Benmarie','Salhay','Benmarie1',15,1,'Benmarie.jpg','Benmarie@robertsoncollege.net'),
('Cherry','Priolo','Cherry1',16,1,'Cherry.jpg','Cherry@robertsoncollege.net'),
('Stanley','Smith','Stanley1',16,1,'Stanley.jpg','Stanley@robertsoncollege.net'),
('Erwin','Gomes','Erwin1',17,1,'Erwin.jpg','Erwin@robertsoncollege.net'),
('Mary Grace','Arby','Mary Grace1',17,1,'Mary Grace.jpg','MG@robertsoncollege.net'),
('Samantha','Hauwla','Samantha1',18,1,'Samantha.jpg','Samantha@robertsoncollege.net'),

('Emmanuel','Tse','Emmanuel1',18,1,'Emmanuel.jpg','Emmanuel@robertsoncollege.net'),
('Ermilindo','Zeleste','Ermilindo1',19,1,'Ermilindo.jpg','Ermilindo@robertsoncollege.net'),
('Romeo','Maxin','Romeo1',19,1,'Romeo.jpg','Romeo@robertsoncollege.net'),
('Bea','Alonzo','Bea1',20,1,'Bea.jpg','Bea@robertsoncollege.net'),
('Gregory','Wayye','Gregory1',20,1,'Gregory.jpg','Gregory@robertsoncollege.net'),
('Juliana','Lee','Juliana1',21,1,'Juliana.jpg','Juliana@robertsoncollege.net'),
('Roldan','Rosales','Roldan1',21,1,'Roldan.jpg','Roldan@robertsoncollege.net'),
('Jimmy','Ebreo','Jimmy1',22,1,'Jimmy.jpg','Jimmy@robertsoncollege.net'),
('Gerald','Anderson','Gerald1',22,1,'Gerald.jpg','Gerald@robertsoncollege.net'),
('Ferky','De Gusman','Ferky1',23,1,'Ferky.jpg','Ferky@robertsoncollege.net'),
('Christiana','Winx','Christiana1',23,1,'Christiana.jpg','Christiana@robertsoncollege.net'),
('Sharon','Cuneta','Sharon1',24,1,'Sharon.jpg','Sharon@robertsoncollege.net'),
('Omar','Gonzales','Omar1',24,1,'Omar.jpg','Omar@robertsoncollege.net'),
('Jerry','Benitez','Jerry',25,1,'Jerry.jpg','Jerry@robertsoncollege.net'),
('Susana','Oz','Susana',25,1,'Susana.jpg','Susana@robertsoncollege.net'),
('Betty','Lukes','Betty1',26,1,'Betty.jpg','Betty@robertsoncollege.net'),
('Antonnete','Mega','Antonnete1',26,1,'Antonnete.jpg','Antonnete@robertsoncollege.net'),
('Cora','Miles','Cora1',27,1,'Cora.jpg','Cora@robertsoncollege.net'),
('Tiana','Smith','Tiana1',27,1,'Tiana.jpg','Tiana@robertsoncollege.net'),
('Coriene','Gustillo','Coriene1',28,1,'Coriene.jpg','Coriene@robertsoncollege.net'),
('Meldred','Castillo','Meldred1',28,1,'Meldred.jpg','Meldred@robertsoncollege.net'),
('Murry','Quinto','Murry1',29,1,'Murry.jpg','Murry@robertsoncollege.net'),
('Queenie','Palparan','Queenie1',29,1,'Queenie.jpg','Queenie@robertsoncollege.net'),
('Sheena','Beast','Sheena1',30,1,'Sheena.jpg','Sheena@robertsoncollege.net'),
('Aron','Ali','Aron1',31,1,'Aron.jpg','Aron@robertsoncollege.net'),
('Adam','Ayle','Adam1',32,1,'Adam.jpg','Adam@robertsoncollege.net'),
('Mac','Isla','Mac1',33,1,'Mac.jpg','Mac@robertsoncollege.net'),
('Letti','Dizon','Dawn1',34,1,'Dawn.jpg','Dawn@robertsoncollege.net'),
('Monette','Colada','Monette1',35,1,'Monnete.jpg','Monette@robertsoncollege.net'),
('Rhose','Pesquera','Rose1',36,1,'Rose.jpg','Rose@robertsoncollege.net'),
('Ijein','Beton','Ijein1',37,1,'Ijein.jpg','Ijein@robertsoncollege.net'),
('Rachelle','Bautista','Rachelle1',38,1,'Rachelle.jpg','Rachelle@robertsoncollege.net'),
('Butch','Portento','Butch1',39,1,'Butch.jpg','Butch@robertsoncollege.net'),
('Aileen Tolentino','Aileen','Aileen1',40,1,'Aileen.jpg','Aileen@robertsoncollege.net'),
('Cassey','Ordonez','Cassey1',41,1,'Cassey.jpg','Cassey@robertsoncollege.net'),
('Chito','	Corea','Chito1',42,1,'Chito.jpg','Chito@robertsoncollege.net'),
('Marisa','Galzote','Marisa1',43,1,'Marisa.jpg','Marisa@robertsoncollege.net'),
('Jayson','Del Rosario','Jayson1',44,1,'Jayson.jpg','Jayson@robertsoncollege.net'),
('Mary Ann','Reymundo','Mary Ann1',45,1,'Marry Ann.jpg','MaryAnn@robertsoncollege.net'),
('Elenn',' Dizon','Elenn1',45,1,'Elenn.jpg','Elenn@robertsoncollege.net'),
('Andrea','Zoom','Andrea1',46,1,'Andrea.jpg','Andrea@robertsoncollege.net'),
('Judy ann','	Santos','Judy Ann1',46,1,'Judy Ann.jpg','JudyAnn@robertsoncollege.net'),
('Regine','Velasques','Regine1',47,1,'Regine.jpg','Regine@robertsoncollege.net'),
('Patrick','Garcia','Patrick1',47,1,'Patrick.jpg','Patrick@robertsoncollege.net')

go

create table SD18EXAM_tbMentorCourse(
MentorCourseID int primary key identity(0,1),
Mentorid int foreign key references SD18EXAM_tbUser(Userid),
CourseID int foreign key references SD18EXAM_tbCourse(Courseid)
)
go

insert into SD18EXAM_tbMentorCourse (MentorID, CourseID) values
(1, 0), (2, 1), (3,3)

create table SD18EXAM_tbToken(
Tokenid int primary key identity (0,1),
TToken varchar(50),
TUserid int foreign key references SD18EXAM_tbUser(Userid)
)
go


create table SD18EXAM_tbQuizStatus(
StatusId int primary key identity (0,1),
StatusName varchar(10)
)

insert into SD18EXAM_tbQuizStatus values
('Offline'),		-- 0
('Online'),			--1 
('Completed')			--2

create table SD18EXAM_tbQuizStudentStatus(
StatusId int primary key identity (0,1),
StatusName varchar(10))

insert into SD18EXAM_tbQuizStudentStatus values
('Not taken'),		-- 0
('Incomplete'),			--1 
('Completed'),			--2
('Ongoing')				--3

----testing xml datatype here to save uploaded quizzes----plz don't delete yet// thanks Nupur
create table SD18EXAM_tbXMLQuizContent(
XMLQuizID int primary key,    --extracting it from the XML file    
Title varchar(60),
Subject varchar(60),
CourseID int foreign key references SD18EXAM_tbCourse(Courseid),
Time int,
DifficultyId int foreign key references SD18EXAM_tbDifficulty(Difficultyid),

)
go

create table SD18EXAM_tbQuizVersion(
Versionid int primary key identity (0,1),
Quizid int foreign key references SD18EXAM_tbXMLQuizContent(XMLQuizID),
Version int,
XmlFile xml
)
go
create table SD18EXAM_tbIssuedQuiz(		-- issued quiz and its statuses,
IssuedQuizId int primary key identity(0,1),
Versionid int foreign key references SD18EXAM_tbQuizVersion(Versionid), -- actual quiz, has XMLQUIzContent and Version
ClassId int foreign key references SD18EXAM_tbClass(Classid),		-- users who will take the test!
DateIssued date,
Mentorid int foreign key references SD18EXAM_tbUser(Userid),
QuizStatus int foreign key references SD18EXAM_tbQuizStatus(StatusId)
)

--insert into SD18EXAM_tbIssuedQuiz (Versionid, ClassId, DateIssued, Mentorid, QuizStatus) values
--(1,1,'2014-08-23',1,0),
--(1,2,'2014-09-12',2,1),
--(2,3,'2014-09-28',2,2),
--(2,4,'2014-09-29',2,2)
--go

create table SD18EXAM_tbQuizStudent(			
QuizStudentid int primary key identity (0,1), -- just the id nothing else
IssuedQuizId int foreign key references SD18EXAM_tbIssuedQuiz(IssuedQuizId), 
Userid int foreign key references SD18EXAM_tbUser(Userid),  ---Student
XMLStudentResponse xml, 
Status int foreign key references SD18EXAM_tbQuizStudentStatus(StatusId),
Points decimal(5,2) null   -- results or number of correct responses by each student
)
go


------------------------STORED PROCEDURES-----------------------

create procedure SD18EXAM_spInsertXMLContent(
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

 if not EXISTS(select 1 from SD18EXAM_tbXMLQuizContent where XMLQuizID = @QuizIdDuplicate)
 begin
 --- insert if no duplicate quizid
 ;WITH XMLNAMESPACES (N'urn:Question-Schema' as ns)
 insert into SD18EXAM_tbXMLQuizContent
 select 
 t.value('@QuizId','int') as XMLQuizID,    --attribute from xml file
 t.value('(ns:Details/ns:Title/text())[1]','VARCHAR(60)') as Title,   
 t.value('(ns:Details/ns:Subject/text())[1]','VARCHAR(60)') as Subject,
 (select Courseid from SD18EXAM_tbCourse where Coursename in (t.value('(ns:Details/ns:Course/text())[1]','VARCHAR(60)'))) as CourseID,
 t.value('(ns:Details/ns:Time/text())[1]','int') as Time,   
 (select Difficultyid from SD18EXAM_tbDifficulty where Difficultyname in (t.value('(ns:Details/ns:Difficulty/text())[1]','VARCHAR(60)'))) as Difficulty  
 from
 @xml.nodes('/ns:Quiz')AS TempTable(t)
 --- and insert new quizversion, set to version 1, first version of quiz
 ;WITH XMLNAMESPACES (N'urn:Question-Schema' as ns)
 insert into SD18EXAM_tbQuizVersion(Quizid,Version,XmlFile)
 select
 t.value('@QuizId','int') as Quizid,
 1 as Version,
 @xml as XmlFile
 from
 @xml.nodes('/ns:Quiz')AS TempTable(t)
 end
 else --- if there is a version exists in the database, then addnew version and the path of xml file
	begin
 ---- insert into SD18EXAM_tbQuizVersion
 set @getQuizVersionOccurence = (select COUNT(Versionid) from SD18EXAM_tbQuizVersion where Quizid = @QuizIdDuplicate)
 set @getQuizVersionOccurence += 1;
 ;WITH XMLNAMESPACES (N'urn:Question-Schema' as ns)
 insert into SD18EXAM_tbQuizVersion(Quizid,Version,XmlFile)
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
SD18EXAM_spInsertXMLContent @xml = '<?xml version="1.0" encoding="utf-8"?><Quiz QuizId="111230123" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns="urn:Question-Schema"><Details><Title>testtitle</Title><Subject>tsubh</Subject><Course>Software and Database Developer</Course><Time>15</Time><Difficulty>Intermediate</Difficulty></Details><Questions><MultipleChoice><Question ID="1"><Questi>what is?</Questi><Options><Option>a</Option><Option Correct="yes">b</Option><Option>c</Option><Option>d</Option></Options></Question></MultipleChoice><FillBlanks /><TrueFalse /></Questions></Quiz>'
go
select * from SD18EXAM_tbDifficulty
select * from SD18EXAM_tbXMLQuizContent
select * from SD18EXAM_tbCourse
select * from SD18EXAM_tbQuizVersion
go
 SD18EXAM_spInsertXMLContent @xml = '<?xml version="1.0"?><Quiz QuizId="516992" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns="urn:Question-Schema"><Details><Title>NewTestData</Title><Subject>LOL</Subject><Course>Software and Database Developer</Course><Time>31</Time><Difficulty>Advanced</Difficulty></Details><Questions><MultipleChoice><Question ID="1"><Questi>a1</Questi><Options><Option>a</Option><Option>b</Option><Option Correct="yes">c</Option><Option>d</Option></Options></Question><Question ID="2"><Questi>a2</Questi><Options><Option>b</Option><Option>a</Option><Option Correct="yes">a</Option><Option>se</Option></Options></Question><Question ID="3"><Questi>a4</Questi><Options><Option Correct="yes">123</Option><Option>123as</Option><Option>dase</Option><Option>weq</Option></Options></Question><Question ID="4"><Questi>a4</Questi><Options><Option>aa</Option><Option Correct="yes">raa</Option><Option>qwesa</Option><Option>12</Option></Options></Question><Question ID="5"><Questi>a5</Questi><Options><Option>31</Option><Option>115</Option><Option>2as</Option><Option Correct="yes">eaqe</Option></Options></Question></MultipleChoice><FillBlanks><Question ID="6"><Questi>123 + 1 =________________ </Questi><Options><Option Correct="yes">124</Option><Option Correct="yes">1</Option><Option>-1</Option><Option>-45</Option></Options></Question><Question ID="7"><Questi> ________________ is good</Questi><Options><Option Correct="yes">God</Option><Option>waesd</Option><Option>zxc</Option><Option>ad</Option><Option>zxczda</Option></Options></Question></FillBlanks><TrueFalse><Question ID="8"><Questi>true is correct</Questi><Answer>True</Answer></Question><Question ID="9"><Questi>false is correct</Questi><Answer>False</Answer></Question><Question ID="10"><Questi>true?</Questi><Answer>True</Answer></Question></TrueFalse></Questions></Quiz>'
go
SD18EXAM_spInsertXMLContent @xml = '<?xml version="1.0" encoding="utf-8"?><Quiz QuizId="111230123" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns="urn:Question-Schema"><Details><Title>testtitle</Title><Subject>tsubh</Subject><Course>Software and Database Developer</Course><Time>25</Time><Difficulty>Intermediate</Difficulty></Details><Questions><MultipleChoice><Question ID="1"><Questi>what is?</Questi><Options><Option>a</Option><Option Correct="yes">b</Option><Option>c</Option><Option>d</Option></Options></Question></MultipleChoice><FillBlanks /><TrueFalse /><FillBlanks /></Questions></Quiz>'
go
SD18EXAM_spInsertXMLContent @xml = '<?xml version="1.0" encoding="utf-8"?><Quiz QuizId="9999" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns="urn:Question-Schema"><Details><Title>testNetwork</Title><Subject>tsubh</Subject><Course>Network Engineering</Course><Time>31</Time><Difficulty>Intermediate</Difficulty></Details><Questions><MultipleChoice><Question ID="1"><Questi>what is?</Questi><Options><Option>a</Option><Option Correct="yes">b</Option><Option>c</Option><Option>d</Option></Options></Question></MultipleChoice><FillBlanks /><TrueFalse /><FillBlanks /></Questions></Quiz>'
go
SD18EXAM_spInsertXMLContent @xml = '<?xml version="1.0"?><Quiz QuizId="570748" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns="urn:Question-Schema"><Details><Title>Yow </Title><Subject>YowS</Subject><Course>Software and Database Developer</Course><Time>31</Time><Difficulty>Intermediate</Difficulty></Details><Questions><MultipleChoice><Question ID="1"><Questi>What is ?</Questi><Options><Option>a</Option><Option>3b</Option><Option Correct="yes">4x</Option><Option>5a</Option></Options></Question><Question ID="2"><Questi>Who is</Questi><Options><Option Correct="yes">zxcasd</Option><Option>4asdasd</Option><Option>5qwe</Option><Option>6asda</Option></Options></Question><Question ID="3"><Questi>What kind of?</Questi><Options><Option>4zxc</Option><Option>5asd</Option><Option Correct="yes">6qw</Option><Option>7qe</Option></Options></Question><Question ID="4"><Questi>Where is?</Questi><Options><Option>1asd</Option><Option>2xzcasd</Option><Option Correct="yes">3asd</Option><Option>5qwe</Option></Options></Question><Question ID="5"><Questi>add ?</Questi><Options><Option Correct="yes">sad</Option><Option>asd</Option><Option>qw</Option><Option>qeqwe</Option></Options></Question></MultipleChoice><FillBlanks /><TrueFalse><Question ID="6"><Questi>true is correct</Questi><Answer>True</Answer></Question><Question ID="7"><Questi>false is correct</Questi><Answer>False</Answer></Question></TrueFalse><FillBlanks><Question ID="8"><Questi> ________________  is the most amazing thing in the world.</Questi><Options><Option Correct="yes">Love</Option><Option Correct="yes">Boots</Option><Option>Money</Option><Option>Weed</Option></Options></Question></FillBlanks></Questions></Quiz>'
go
SD18EXAM_spInsertXMLContent @xml ='<?xml version="1.0"?><Quiz QuizId="249747" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns="urn:Question-Schema"><Details><Title>test2</Title><Subject>test2</Subject><Course>Software and Database Developer</Course><Time>31</Time><Difficulty>Intermediate</Difficulty></Details><Questions><MultipleChoice><Question ID="1"><Questi>test2</Questi><Options><Option>test2</Option><Option>test2</Option><Option>test2</Option><Option Correct="yes">tewst</Option></Options></Question><Question ID="2"><Questi>xzcase</Questi><Options><Option Correct="yes">asdqweqweqw</Option><Option>asdase</Option><Option>eas</Option><Option>dqwe</Option></Options></Question></MultipleChoice><FillBlanks /><TrueFalse /><FillBlanks /></Questions></Quiz>'
go
select * from SD18EXAM_tbXMLQuizContent
select * from SD18EXAM_tbCourse
select * from SD18EXAM_tbQuizVersion
select * from SD18EXAM_tbUser
go
-----------------------------PROCEDURES-----------------------------------------


create procedure SD18EXAM_spGetQuizAndInfo(
@versionid int
)
as begin
select XMLQuizID,Title,Subject,CourseID,Time,DifficultyId,XmlFile from SD18EXAM_tbXMLQuizContent,SD18EXAM_tbQuizVersion where XMLQuizID in (select top 1 Quizid from SD18EXAM_tbQuizVersion where Versionid = @versionid) and SD18EXAM_tbXMLQuizContent.XMLQuizID=SD18EXAM_tbQuizVersion.Quizid and SD18EXAM_tbQuizVersion.Versionid =@versionid
end
go
-- SD18EXAM_spGetQuizAndInfo @versionid=1
go
--Login
create procedure SD18EXAM_spLogin(
@Email varchar(60),
@Password varchar(60)
)
as begin
	select * from SD18EXAM_tbUser where SD18EXAM_tbUser.Email = @Email and SD18EXAM_tbUser.Password = @Password
end
go

create procedure SD18EXAM_spIssueNewQuiz(
@Versionid int,
@Mentorid int,
@ClassId int
)
as begin
begin transaction

if not EXISTS(select * from SD18EXAM_tbIssuedQuiz where Versionid = @Versionid and ClassId = @ClassId)
	begin
	begin transaction
		if EXISTS (select * from SD18EXAM_tbUser where SecurityLevel != 1 and Userid = @Mentorid)
			begin
			insert into SD18EXAM_tbIssuedQuiz values(@Versionid,@ClassId,GETDATE(),@Mentorid,0)
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

create procedure SD18EXAM_spIssueNewQuizStudent(
@IssuedQuizId int,
@UserId int,
@XMLStudentResponse xml
)
as
 begin
begin transaction

	--set @getxml = (select SD18EXAM_tbQuizVersion.XmlFile from SD18EXAM_tbIssuedQuiz
	--join SD18EXAM_tbQuizVersion on SD18EXAM_tbQuizVersion.Versionid = SD18EXAM_tbIssuedQuiz.Versionid
	--where SD18EXAM_tbIssuedQuiz.IssuedQuizId = @IssuedQuizId)

	--;WITH XMLNAMESPACES (N'urn:Question-Schema' as ns)
	--(select @xmlMultipleCount = (select @getxml.value('count(/ns:Quiz/ns:Questions/ns:MultipleChoice/ns:Question)','int') as Count))
	--select @getxml as XML, @xmlMultipleCount as MultipleCount
	
	if not EXISTS(select * from SD18EXAM_tbQuizStudent where IssuedQuizId = @IssuedQuizId and Userid = @UserId and Status != 0)
	begin
		insert into SD18EXAM_tbQuizStudent values (@IssuedQuizId,@UserId,@XMLStudentResponse,0,null)
	end
	else
	begin
		update SD18EXAM_tbQuizStudent set XMLStudentResponse = @XMLStudentResponse where IssuedQuizId = @IssuedQuizId and Userid = @UserId
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
create procedure SD18EXAM_spStartQuiz(
@IssuedQuizId int
)
as begin
if EXISTS(select * from SD18EXAM_tbIssuedQuiz where IssuedQuizId=@IssuedQuizId and QuizStatus != 1)
	begin
	update SD18EXAM_tbIssuedQuiz set QuizStatus = 1 where IssuedQuizId = @IssuedQuizId
	select 'Activated' as status
	end
else
begin
	select 'error' as status
end
end

select * from SD18EXAM_tbQuizStudent
go
create procedure SD18EXAM_spStartQuizStudent (
@UserId int,
@QuizStudentId int
)
as declare
@IssuedQuizId int = -1
begin
begin tran
set @IssuedQuizId = (select IssuedQuizId from SD18EXAM_tbQuizStudent where Userid = @UserId and QuizStudentid = @QuizStudentId)

if EXISTS(select * from SD18EXAM_tbIssuedQuiz where @IssuedQuizId != -1 and IssuedQuizId = @IssuedQuizId and QuizStatus = 1) -- The IssuedQuiz status must be active first
begin
	if EXISTS(select * from SD18EXAM_tbQuizStudent where Userid = @UserId and QuizStudentid = @QuizStudentId)
	begin
	update SD18EXAM_tbQuizStudent set Status= 3 where Userid = @UserId and QuizStudentid = @QuizStudentId
	select XMLStudentResponse from SD18EXAM_tbQuizStudent where Userid = @UserId and QuizStudentid = @QuizStudentId
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
-- SD18EXAM_spIssueNewQuizStudent @IssuedQuizId=0, @UserId = 3
go
SD18EXAM_spIssueNewQuiz @Versionid = 0, @ClassId = 1, @Mentorid =0
select * from SD18EXAM_tbQuizStatus 
select * from SD18EXAM_tbIssuedQuiz
select * from SD18EXAM_tbQuizStudent
select * from SD18EXAM_tbUser
select * from SD18EXAM_tbQuizStudentStatus
select * from SD18EXAM_tbQuizVersion
select * from SD18EXAM_tbXMLQuizContent
select * from SD18EXAM_tbClass
--SD18EXAM_spLoadAllStudentClass @Classid=0

insert into SD18EXAM_tbQuizStudent values (0,9,'<?xml version="1.0"?><Quiz QuizId="570748" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns="urn:Question-Schema"><Details><Title>Yow </Title><Subject>YowS</Subject><Course>Software and Database Developer</Course><Time>31</Time><Difficulty>Intermediate</Difficulty></Details><Questions><MultipleChoice><Question ID="1"><Questi>What is ?</Questi><Options><Option>a</Option><Option>3b</Option><Option Correct="yes">4x</Option><Option>5a</Option></Options></Question><Question ID="2"><Questi>Who is</Questi><Options><Option Correct="yes">zxcasd</Option><Option>4asdasd</Option><Option>5qwe</Option><Option>6asda</Option></Options></Question><Question ID="3"><Questi>What kind of?</Questi><Options><Option>4zxc</Option><Option>5asd</Option><Option Correct="yes">6qw</Option><Option>7qe</Option></Options></Question><Question ID="4"><Questi>Where is?</Questi><Options><Option>1asd</Option><Option>2xzcasd</Option><Option Correct="yes">3asd</Option><Option>5qwe</Option></Options></Question><Question ID="5"><Questi>add ?</Questi><Options><Option Correct="yes">sad</Option><Option>asd</Option><Option>qw</Option><Option>qeqwe</Option></Options></Question></MultipleChoice><FillBlanks /><TrueFalse><Question ID="6"><Questi>true is correct</Questi><Answer>True</Answer></Question><Question ID="7"><Questi>false is correct</Questi><Answer>False</Answer></Question></TrueFalse><FillBlanks><Question ID="8"><Questi> ________________  is the most amazing thing in the world.</Questi><Options><Option Correct="yes">Love</Option><Option Correct="yes">Boots</Option><Option>Money</Option><Option>Weed</Option></Options></Question></FillBlanks></Questions></Quiz>',0,null)
go
insert into SD18EXAM_tbQuizStudent values (0,8,'<?xml version="1.0"?><Quiz QuizId="570748" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns="urn:Question-Schema"><Details><Title>Yow </Title><Subject>YowS</Subject><Course>Software and Database Developer</Course><Time>31</Time><Difficulty>Intermediate</Difficulty></Details><Questions><MultipleChoice><Question ID="1"><Questi>What is ?</Questi><Options><Option>a</Option><Option>3b</Option><Option Correct="yes">4x</Option><Option>5a</Option></Options></Question><Question ID="2"><Questi>Who is</Questi><Options><Option Correct="yes">zxcasd</Option><Option>4asdasd</Option><Option>5qwe</Option><Option>6asda</Option></Options></Question><Question ID="3"><Questi>What kind of?</Questi><Options><Option>4zxc</Option><Option>5asd</Option><Option Correct="yes">6qw</Option><Option>7qe</Option></Options></Question><Question ID="4"><Questi>Where is?</Questi><Options><Option>1asd</Option><Option>2xzcasd</Option><Option Correct="yes">3asd</Option><Option>5qwe</Option></Options></Question><Question ID="5"><Questi>add ?</Questi><Options><Option Correct="yes">sad</Option><Option>asd</Option><Option>qw</Option><Option>qeqwe</Option></Options></Question></MultipleChoice><FillBlanks /><TrueFalse><Question ID="6"><Questi>true is correct</Questi><Answer>True</Answer></Question><Question ID="7"><Questi>false is correct</Questi><Answer>False</Answer></Question></TrueFalse><FillBlanks><Question ID="8"><Questi> ________________  is the most amazing thing in the world.</Questi><Options><Option Correct="yes">Love</Option><Option Correct="yes">Boots</Option><Option>Money</Option><Option>Weed</Option></Options></Question></FillBlanks></Questions></Quiz>',0,null)

go
create procedure SD18EXAM_spGetQuizStudentByStudent(
@UserId int
)
as begin
if Exists(select * from SD18EXAM_tbQuizStudent where Userid = @UserId and IssuedQuizId in (select IssuedQuizId from SD18EXAM_tbIssuedQuiz where QuizStatus = 1) ) -- ongoing
	begin
		select QuizStudentid,Title,Subject, Time from SD18EXAM_tbQuizStudent
		join SD18EXAM_tbIssuedQuiz on SD18EXAM_tbIssuedQuiz.IssuedQuizId = SD18EXAM_tbQuizStudent.IssuedQuizId
		join SD18EXAM_tbQuizVersion on SD18EXAM_tbQuizVersion.Versionid = SD18EXAM_tbIssuedQuiz.Versionid
		join SD18EXAM_tbXMLQuizContent on SD18EXAM_tbXMLQuizContent.XMLQuizID = SD18EXAM_tbQuizVersion.Quizid
		where Userid = @UserId and SD18EXAM_tbIssuedQuiz.QuizStatus = 1
	end
else
	begin
	select 'Empty' status
	end
end
go
-- SD18EXAM_spStartQuiz @IssuedQuizId = 1
-- SD18EXAM_spGetQuizStudentByStudent @UserId=9
-- SD18EXAM_spStartQuizStudent @UserId= 8,@QuizStudentId= 1
-- SD18EXAM_spStartQuizStudent @UserId= 9,@QuizStudentId= 0
select * from SD18EXAM_tbQuizStudent
select * from SD18EXAM_tbUser
select * from SD18EXAM_tbXMLQuizContent
select * from SD18EXAM_tbQuizVersion
select * from SD18EXAM_tbIssuedQuiz

go
create procedure SD18EXAM_spUpdateQuizStudent(
@Userid int,
@XMLStudentResponse xml,
@QuizStudentid int,
@Points decimal(5,2)
)
as begin
if((select Status from SD18EXAM_tbQuizStudent where Userid=@Userid and QuizStudentid=@QuizStudentid) != 2)
	begin
		update SD18EXAM_tbQuizStudent set XMLStudentResponse = @XMLStudentResponse, Points=@Points where Userid=@Userid and QuizStudentid = @QuizStudentid
	end
end
go

create procedure SD18EXAM_spGetIssuedQuizByMentor (
@Userid int = null
)
as begin
if EXISTS(select * from SD18EXAM_tbUser where Userid= @Userid and SecurityLevel != 1)
begin
	select * from SD18EXAM_tbIssuedQuiz
	join SD18EXAM_tbClass on SD18EXAM_tbClass.Classid = SD18EXAM_tbIssuedQuiz.ClassId
	join SD18EXAM_tbQuizVersion on SD18EXAM_tbQuizVersion.Versionid = SD18EXAM_tbIssuedQuiz.Versionid
	join SD18EXAM_tbQuizStatus on SD18EXAM_tbQuizStatus.StatusId = SD18EXAM_tbIssuedQuiz.QuizStatus
	join SD18EXAM_tbXMLQuizContent on SD18EXAM_tbXMLQuizContent.XMLQuizID = SD18EXAM_tbQuizVersion.Quizid
	join SD18EXAM_tbCourse on SD18EXAM_tbCourse.Courseid = SD18EXAM_tbXMLQuizContent.CourseID
	where SD18EXAM_tbIssuedQuiz.Mentorid = isnull(@Userid, SD18EXAM_tbIssuedQuiz.Mentorid)
	end
end
go
SD18EXAM_spGetIssuedQuizByMentor @Userid= 0
go

create procedure SD18EXAM_spgetIssuedQuizDetails(
@IssuedQuizId int
)
as begin
select IssuedQuizId,Classname,Title,Time,QuizStatus,StatusName from SD18EXAM_tbIssuedQuiz
join SD18EXAM_tbQuizVersion on SD18EXAM_tbQuizVersion.Versionid = SD18EXAM_tbIssuedQuiz.Versionid
join SD18EXAM_tbClass on SD18EXAM_tbClass.Classid = SD18EXAM_tbIssuedQuiz.ClassId
join SD18EXAM_tbQuizStatus on SD18EXAM_tbQuizStatus.StatusId = SD18EXAM_tbIssuedQuiz.QuizStatus
join SD18EXAM_tbXMLQuizContent on SD18EXAM_tbXMLQuizContent.XMLQuizID = SD18EXAM_tbQuizVersion.Quizid

 where IssuedQuizId = @IssuedQuizId
end
go

go
create procedure SD18EXAM_spForgotPassword(
@EmailAddress varchar (50)
)
as declare
@message varchar (50),
@Token varchar (50)='notExists'
begin
begin transaction
if Exists (select 1 from SD18EXAM_tbUser where Email = @EmailAddress)
begin 
while not Exists (select 1 from SD18EXAM_tbUser where LostPass = @Token)
begin 
SELECT @Token = (select char(rand()*26+65)+char(rand()*26+65)+char(rand()*26+65)
+char(rand()*26+65)+char(rand()*26+65)+char(rand()*26+65)
+char(rand()*26+65)+char(rand()*26+65)+char(rand()*26+65)
+char(rand()*26+65)+char(rand()*26+65)+char(rand()*26+65)
+char(rand()*26+65)+char(rand()*26+65)+char(rand()*26+65))
update SD18EXAM_tbUser set LostPass=@Token where Email=@EmailAddress
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
--SD18EXAM_spCheckToken @Token= 'COSNMXEDEEDMSAK'
create procedure SD18EXAM_spCheckToken(
@Token varchar(20)
)
as begin
if exists(select 1 from SD18EXAM_tbUser where LostPass=@Token)
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
create procedure SD18EXAM_spChangePassWord(
@Token varchar(20),
@NewPass varchar(60)
)
as declare
@message varchar(60)
 begin
begin transaction
if Exists(select 1 from SD18EXAM_tbUser where LostPass = @Token)
begin
	update SD18EXAM_tbUser set password=@NewPass, LostPass=null where LostPass=@Token
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
create procedure SD18EXAM_spGetStudentInfo(
@Userid int 
)
as
begin
select Userid,'./Pictures/' + UserPicture as UserPicture,Firstname,Lastname,Classid,Email 
from SD18EXAM_tbUser
where Userid = @Userid
end
go
go
create procedure SD18EXAM_spGetStudents(
@Classid int = null,
@Userid int = null
)
as begin
	select './Pictures/' + UserPicture as UserPicture,
	Userid,Lastname, Classname, Coursename,
	Firstname,Password, SD18EXAM_tbClass.Classid, SecurityLevel,Email
    from  SD18EXAM_tbUser, SD18EXAM_tbCourse, SD18EXAM_tbClass 
	where SD18EXAM_tbUser.Classid = isnull(@Classid, SD18EXAM_tbUser.Classid) and 
	      SD18EXAM_tbUser.Userid = isnull(@Userid, SD18EXAM_tbUser.Userid) and
	      SD18EXAM_tbUser.Classid = SD18EXAM_tbClass.Classid and
		  SD18EXAM_tbClass.Courseid = SD18EXAM_tbCourse.Courseid and
		  SD18EXAM_tbUser.SecurityLevel = 1
	    
end
go

create procedure SD18EXAM_spGetUsers(
@Classid int = null,
@Userid int = null,
@Courseid int = null
)
as begin
	select './Pictures/' + UserPicture as UserPicture,
	Userid,Lastname, Classname, Coursename,
	Firstname,Password, SD18EXAM_tbClass.Classid, SecurityLevel,Email
    from  SD18EXAM_tbUser, SD18EXAM_tbCourse, SD18EXAM_tbClass 
	where SD18EXAM_tbUser.Classid = isnull(@Classid, SD18EXAM_tbUser.Classid) and 
	      SD18EXAM_tbUser.Userid = isnull(@Userid, SD18EXAM_tbUser.Userid) and
	      SD18EXAM_tbUser.Classid = SD18EXAM_tbClass.Classid and
		  SD18EXAM_tbClass.Courseid = SD18EXAM_tbCourse.Courseid
	    
end
go
create procedure SD18EXAM_spLoadAllStudentClass(
@Classid int
)
as begin
select './Pictures/' + UserPicture as UserPicture,
	Userid,Lastname + ', ' + Firstname as Studentname, Classname, Coursename,
	Firstname,Password, SD18EXAM_tbClass.Classid, SecurityLevel,Email
    from  SD18EXAM_tbUser, SD18EXAM_tbCourse, SD18EXAM_tbClass 
	where SD18EXAM_tbUser.Classid = isnull(@Classid, SD18EXAM_tbUser.Classid) and 
	      SD18EXAM_tbUser.Classid = SD18EXAM_tbClass.Classid and
		  SD18EXAM_tbClass.Courseid = SD18EXAM_tbCourse.Courseid and
	      SD18EXAM_tbUser.SecurityLevel = 1 -- students 
end
go

--Difficulty
create procedure SD18EXAM_spGetDifficulty(
@Difficultyid int = null
)
as begin
	select * from SD18EXAM_tbDifficulty where SD18EXAM_tbDifficulty.Difficultyid = @Difficultyid
end 
go

--Loads Class
create procedure SD18EXAM_spLoadClass(
@CourseId int = null
)
as begin
	select SD18EXAM_tbClass.Classid, SD18EXAM_tbClass.Classname, Coursename
	from SD18EXAM_tbClass, SD18EXAM_tbCourse
	--left join SD18EXAM_tbCourse on SD18EXAM_tbCourse.Courseid = @CourseId
	where SD18EXAM_tbClass.Courseid = @CourseId and
	      SD18EXAM_tbClass.Courseid = SD18EXAM_tbCourse.Courseid
end
go
-- SD18EXAM_spLoadClass @CourseId = 1
go

--Loads Class
create procedure SD18EXAM_spGetClass(
@Classid int = null,
@Courseid int = null
)
as begin
	select * from SD18EXAM_tbClass
	 where Classid = isnull(@Classid, Classid) and
	       Courseid = isnull (@Courseid, Courseid)
end
go

--Loads Course by Courseid
create procedure SD18EXAM_spGetCourse(
@Courseid int = null
)
as begin 
	select * from SD18EXAM_tbCourse where Courseid= isnull(@Courseid, Courseid)
end
go

--Load Course by Classid
create procedure SD18EXAM_spLoadCourse
as begin
	select * from SD18EXAM_tbCourse
end	
go

go

create procedure SD18EXAM_spLoadQuizes(
@Courseid int = null
)
as
begin
 if(@Courseid is not null and @Courseid != -1)
	begin
	select XMLQuizID,Title,Subject,SD18EXAM_tbXMLQuizContent.CourseID,Time,DifficultyId from SD18EXAM_tbXMLQuizContent
	left join SD18EXAM_tbCourse on SD18EXAM_tbCourse.Courseid = SD18EXAM_tbXMLQuizContent.CourseID
	where SD18EXAM_tbXMLQuizContent.CourseID = @Courseid
	end

end

go
select * from SD18EXAM_tbXMLQuizContent
-- SD18EXAM_spLoadQuizes @Courseid = 0;
go


--Load Quiz get it from versioning table and join it on tbXMLcontent
create procedure SD18EXAM_spLoadQuiz
as begin 
	select * from SD18EXAM_tbXMLQuizContent, SD18EXAM_tbQuizVersion
	where SD18EXAM_tbXMLQuizContent.XMLQuizID = SD18EXAM_tbQuizVersion.Quizid
end 
go

--Load Quiz by Courseid
create procedure SD18EXAM_spLoadQuiz2(
@Courseid int
)
as begin 
	select * from SD18EXAM_tbXMLQuizContent where SD18EXAM_tbXMLQuizContent.CourseID =@Courseid
end 
go

--Load Quiz by Quizid
create procedure SD18EXAM_spLoadQuiz5(
@Quizid int
)
as begin 
	select * from SD18EXAM_tbXMLQuizContent,SD18EXAM_tbDifficulty,SD18EXAM_tbQuizVersion 
	where SD18EXAM_tbXMLQuizContent.XMLQuizID = @Quizid and 
	SD18EXAM_tbDifficulty.Difficultyid = SD18EXAM_tbXMLQuizContent.DifficultyId and 
	SD18EXAM_tbXMLQuizContent.XMLQuizID = SD18EXAM_tbQuizVersion.Quizid
end 
go

--Loads Quiz
create procedure SD18EXAM_spLoadQuiz4
as begin
	select * from SD18EXAM_tbXMLQuizContent, SD18EXAM_tbQuizVersion 
	where SD18EXAM_tbXMLQuizContent.XMLQuizID = SD18EXAM_tbQuizVersion.Quizid
end
go
--Loads Version
create procedure SD18EXAM_spLoadVersion(
@QuizId int
)
as begin 
	select * from SD18EXAM_tbQuizVersion where Quizid = @QuizId
end 
go
SD18EXAM_spLoadVersion @QuizId = 111230123
go

--Loads the Quiz 
create procedure SD18EXAM_spViewQuiz
as begin 
	select SD18EXAM_tbXMLQuizContent.XMLQuizID, SD18EXAM_tbXMLQuizContent.Subject, SD18EXAM_tbXMLQuizContent.Time,
	       SD18EXAM_tbXMLQuizContent.Title,
	       SD18EXAM_tbXMLQuizContent.DifficultyId, SD18EXAM_tbQuizVersion.Version, SD18EXAM_tbQuizVersion.Versionid,
		   SD18EXAM_tbDifficulty.Difficultyname
	from SD18EXAM_tbXMLQuizContent,SD18EXAM_tbQuizVersion, SD18EXAM_tbDifficulty
	where SD18EXAM_tbXMLQuizContent.XMLQuizID = SD18EXAM_tbQuizVersion.Quizid and
	      SD18EXAM_tbXMLQuizContent.DifficultyId = SD18EXAM_tbDifficulty.Difficultyid
	
end 
go


--Loads the Quiz Result (User side)
create procedure SD18EXAM_spViewQuizResults(
@Userid int
)

as begin 
	select * from SD18EXAM_tbQuizVersion, SD18EXAM_tbQuizStudent, SD18EXAM_tbIssuedQuiz 
	where SD18EXAM_tbQuizStudent.QuizStudentid = @Userid and
	      SD18EXAM_tbQuizVersion.Versionid = SD18EXAM_tbIssuedQuiz.Versionid and
		  SD18EXAM_tbIssuedQuiz.IssuedQuizId = SD18EXAM_tbQuizStudent.IssuedQuizId
end 
go

--Loads the Quiz Result of all students
create procedure SD18EXAM_spViewQuizResults2

as begin 
	select * from tbResults 
	
end 
go

--Loads Pending Quiz (student side)
 create procedure SD18EXAM_spViewPendingQuiz2(
 @Userid int
 )
as begin 
	select * from SD18EXAM_tbQuizStudent,SD18EXAM_tbXMLQuizContent,SD18EXAM_tbDifficulty, SD18EXAM_tbIssuedQuiz
	where  Userid=@Userid and
	       SD18EXAM_tbQuizStudent.IssuedQuizId = SD18EXAM_tbIssuedQuiz.IssuedQuizId and	      
	      SD18EXAM_tbXMLQuizContent.DifficultyId = SD18EXAM_tbDifficulty.Difficultyid
	end 
go

--SD18EXAM_spViewPendingQuiz2 @Userid=3
create procedure SD18EXAM_spInsertUser(
@Firstname varchar(60),
@Lastname varchar(60),
@Email varchar(60),
@Password varchar(60)
)
as begin
	if EXISTS(select * from SD18EXAM_tbUser where Email=@Email)
	insert into SD18EXAM_tbUser(Firstname,Lastname, Email,Password,Classid,SecurityLevel)values
					  (@Firstname,@Lastname, @Email,@Password,null,1)
end
go

--Insert Difficulty
create procedure SD18EXAM_spInsertDifficulty(
@Difficultyname varchar(60)
)
as begin
	insert into SD18EXAM_tbDifficulty(Difficultyname)values
				(@Difficultyname)
end
go

----Insert Class

--Insert Course
create procedure SD18EXAM_spInsertCourse(
@Coursename varchar(60)
)
as begin 
	insert into SD18EXAM_tbCourse (Coursename) values
						 (@Coursename)
end
go

----------------UPDATES-------------

--Update Users
create procedure SD18EXAM_spUpdateUser(
@Userid int,
@Firstname varchar (60),
@Lastname varchar (60),
@Password varchar (60),
@Email varchar (60),
@Classid int,
@SecurityLevel int
)
as begin
update SD18EXAM_tbUser set Firstname =@Firstname, Lastname=@Lastname, Password=@Password, 
		Classid=@Classid, SecurityLevel=@SecurityLevel, Email = @Email
			 where SD18EXAM_tbUser.Userid = @Userid
end
go

--Update Difficulty
create procedure SD18EXAM_spUpdateDifficulty(
@Difficultyid int = null,
@Difficultyname varchar(60)
)
as begin
	update SD18EXAM_tbDifficulty set Difficultyname = @Difficultyname
	where Difficultyid =@Difficultyid
end 
go

--Update Class
create procedure SD18EXAM_spUpdateClass(
@Classid int = null,
@Classname varchar (60),
@Courseid int
)
as begin
update SD18EXAM_tbClass set Classname =@Classname, Courseid=@Courseid
			 where SD18EXAM_tbClass.Classid = @Classid
end
go

--Update Course
create procedure SD18EXAM_spUpdateCourse(
@Courseid int = null,
@Coursename varchar(60)
)
as begin
	update SD18EXAM_tbCourse set Coursename = @Coursename 
	where Courseid=@Courseid
end
go


-----------------DELETES----------------

--Delete Students

create procedure SD18EXAM_spDeleteStudent(
@Userid int = null
)
as begin

    delete from SD18EXAM_tbQuizStudent
	where SD18EXAM_tbQuizStudent.Userid = @Userid

	delete from SD18EXAM_tbUser 
	where SD18EXAM_tbUser.Userid = @Userid
end
go

--Delete Difficulty
create procedure SD18EXAM_spDeleteDifficulty(
@Difficultyid int = null
)
as begin 
	delete from tbQuiz
	where tbQuiz.Difficulty =@Difficultyid

	delete from SD18EXAM_tbDifficulty 
	where SD18EXAM_tbDifficulty.Difficultyid = @Difficultyid
	
	delete from tbQuiz
	where tbQuiz.Difficulty = @Difficultyid
end 
go

--Delete Class
create procedure SD18EXAM_spDeleteClass(
@Classid int
)
as begin
	
	delete from SD18EXAM_tbClass 
	where SD18EXAM_tbClass.Classid = @Classid
end
go

--Delete Course
create procedure SD18EXAM_spDeleteCourse(
@Courseid int

)
as begin 
	delete from SD18EXAM_tbCourse 
	where SD18EXAM_tbCourse.Courseid =@Courseid
end 
go


----------------Settings-------------

--Update---
create procedure SD18EXAM_spUpdateSettings(
@Userid int = null,
@Firstname varchar (60),
@Lastname varchar (60),
@Password varchar (60),
@Classid int,
@SecurityLevel int
)
as begin
update SD18EXAM_tbUser set Firstname =@Firstname, Lastname=@Lastname, Password=@Password, 
		Classid=@Classid, SecurityLevel=@SecurityLevel
			 where SD18EXAM_tbUser.Userid = @Userid
end
go

create procedure SD18EXAM_spGetXml
as begin
select * from SD18EXAM_tbQuizVersion
end
go

---------------------------------------------------

create table SD18EXAM_tbTestSample(
TestSampleid int primary key identity(0,1),
XMLQuiz xml
)
go

insert into SD18EXAM_tbTestSample(XMLQuiz)values
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
    <FillBlanks />
  </Questions>
</Quiz>')

go

select * from SD18EXAM_tbTestSample
go
create procedure spGetTestSample
as begin
	select * from SD18EXAM_tbTestSample
end 
go


create procedure SD18EXAM_spGetSortColumn(
@SortColumn varchar (60)
)
as begin
select './Pictures/' + UserPicture as UserPicture,
	Userid,Lastname, Classname, Coursename,
	Firstname,Password, SD18EXAM_tbClass.Classid, SecurityLevel,Email from SD18EXAM_tbUser, SD18EXAM_tbCourse, SD18EXAM_tbClass
	where SD18EXAM_tbUser.Classid = SD18EXAM_tbClass.Classid and
		  SD18EXAM_tbClass.Courseid = SD18EXAM_tbCourse.Courseid 
order by
case when @SortColumn='Firstname asc' then Firstname end asc,
case when @SortColumn='Lastname asc' then Lastname end asc,
case when @SortColumn='Password asc' then Password end asc,
case when @SortColumn='Classid asc' then Classname end asc,
case when @SortColumn='SecurityLevel asc' then SecurityLevel end asc,
case when @SortColumn='UserPicture asc' then UserPicture end asc,
case when @SortColumn='Email asc' then Email end asc,


case when @SortColumn='Firstname desc' then Firstname end desc,
case when @SortColumn='Lastname desc' then Lastname end desc,
case when @SortColumn='Password desc' then Password end desc,
case when @SortColumn='Classid desc' then Classname end desc,
case when @SortColumn='SecurityLevel desc' then SecurityLevel end desc,
case when @SortColumn='UserPicture desc' then UserPicture end desc,
case when @SortColumn='Email desc' then Email end desc

end
go

-------------Reports Start Here---------------

create procedure SD18EXAM_spGetIssuedQuizes
as begin
select IssuedQuizId, SD18EXAM_tbIssuedQuiz.Versionid, SD18EXAM_tbIssuedQuiz.ClassId,
       convert (varchar(12),DateIssued,107) as DateIssued, 
       Mentorid, Firstname + ' ' + Lastname as 'Mentor', XmlFile, Classname
from SD18EXAM_tbIssuedQuiz, SD18EXAM_tbUser, SD18EXAM_tbQuizVersion, SD18EXAM_tbClass
where SD18EXAM_tbIssuedQuiz.Mentorid = SD18EXAM_tbUser.Userid and
      SD18EXAM_tbIssuedQuiz.Versionid = SD18EXAM_tbQuizVersion.Versionid and
	  SD18EXAM_tbIssuedQuiz.ClassId = SD18EXAM_tbClass.Classid
end
go

create procedure SD18EXAM_spGetQuizesByStatus(
@QuizStatus int = null
)
as begin
select IssuedQuizId, SD18EXAM_tbIssuedQuiz.Versionid, SD18EXAM_tbIssuedQuiz.ClassId,
        convert (varchar(12),DateIssued,107) as DateIssued, 
       Mentorid, Firstname + ' ' + Lastname as 'Mentor', XmlFile, SD18EXAM_tbClass.Classname,
	   SD18EXAM_tbIssuedQuiz.QuizStatus, SD18EXAM_tbQuizStatus.StatusName
from SD18EXAM_tbIssuedQuiz, SD18EXAM_tbUser, SD18EXAM_tbQuizVersion, SD18EXAM_tbQuizStatus, SD18EXAM_tbClass
where SD18EXAM_tbIssuedQuiz.QuizStatus = isnull(@QuizStatus, QuizStatus) and
      SD18EXAM_tbIssuedQuiz.QuizStatus = SD18EXAM_tbQuizStatus.StatusId and
      SD18EXAM_tbIssuedQuiz.Mentorid = SD18EXAM_tbUser.Userid and
      SD18EXAM_tbIssuedQuiz.Versionid = SD18EXAM_tbQuizVersion.Versionid and
	  SD18EXAM_tbIssuedQuiz.ClassId = SD18EXAM_tbClass.Classid
end
go



create procedure SD18EXAM_spGetStudentResponseReport(
@Userid int = null,
@XMLQuizID int = null,
@CourseID int = null
)
as begin
declare @xmlvar XML;
set     @xmlvar = (select top 1 XMLStudentResponse from SD18EXAM_tbQuizStudent)
;WITH XMLNAMESPACES (N'urn:Question-Schema' as ns)
select SD18EXAM_tbQuizStudent.IssuedQuizId, SD18EXAM_tbQuizStudent.Userid as 'StudentID', 
        Firstname + ' ' + Lastname as 'StudentName',
        SD18EXAM_tbQuizStudentStatus.StatusName, Points,
		-- casting xml as varchar as xml data type cannot be used in group by clause
		CAST([XMLStudentResponse] AS VARCHAR(MAX)),
		-- getting count of different question types
	    @xmlvar.value('count(ns:Quiz/ns:Questions/ns:MultipleChoice/ns:Question/@ID)', 'INT') 
		             AS 'MultipleChoiceCount',
		@xmlvar.value('count(ns:Quiz/ns:Questions/ns:FillBlanks/ns:Question/@ID)', 'INT')
	                 AS 'FillBlanksCount',
		@xmlvar.value('count(ns:Quiz/ns:Questions/ns:TrueFalse/ns:Question/@ID)', 'INT') 
		             AS 'TrueFalseCount',
		-- using sum in this statement to get total questions count here
		(sum(@xmlvar.value('count(ns:Quiz/ns:Questions/ns:MultipleChoice/ns:Question/@ID)', 'INT')) +
		 sum(@xmlvar.value('count(ns:Quiz/ns:Questions/ns:FillBlanks/ns:Question/@ID)', 'INT')) +
		 sum(@xmlvar.value('count(ns:Quiz/ns:Questions/ns:TrueFalse/ns:Question/@ID)', 'INT'))) 
		             AS 'TotalQuestions'
		    
from    SD18EXAM_tbQuizStudent, SD18EXAM_tbQuizStudentStatus, SD18EXAM_tbUser, 
        SD18EXAM_tbXMLQuizContent, SD18EXAM_tbQuizVersion, SD18EXAM_tbIssuedQuiz
where   SD18EXAM_tbQuizStudent.Status = SD18EXAM_tbQuizStudentStatus.StatusId and
        SD18EXAM_tbQuizStudent.Userid = SD18EXAM_tbUser.Userid and
	    SD18EXAM_tbQuizStudent.Userid = isnull(@Userid, SD18EXAM_tbQuizStudent.Userid) and
		SD18EXAM_tbXMLQuizContent.XMLQuizID = isnull(@XMLQuizID, SD18EXAM_tbXMLQuizContent.XMLQuizID) and
		SD18EXAM_tbXMLQuizContent.CourseID = isnull(@CourseID, SD18EXAM_tbXMLQuizContent.CourseID) and
		-- 4 more tables here to get XMLQuizID
		SD18EXAM_tbQuizStudent.IssuedQuizId = SD18EXAM_tbIssuedQuiz.IssuedQuizId and
		SD18EXAM_tbIssuedQuiz.Versionid = SD18EXAM_tbQuizVersion.Versionid and
		SD18EXAM_tbQuizVersion.Quizid = SD18EXAM_tbXMLQuizContent.XMLQuizID

GROUP BY SD18EXAM_tbQuizStudent.IssuedQuizId, SD18EXAM_tbQuizStudent.Userid, Firstname, Lastname, StatusName, Points,
         CAST([XMLStudentResponse] AS VARCHAR(MAX))

end
go

create procedure SD18EXAM_spGetQuizDetails(
@Versionid int
)
as begin
declare @xmlvar XML;
set     @xmlvar = (select top 1 XmlFile from SD18EXAM_tbQuizVersion)
;WITH XMLNAMESPACES (N'urn:Question-Schema' as ns)
select  
		-- casting xml as varchar as xml data type cannot be used in group by clause
		CAST([XmlFile] AS VARCHAR(MAX)),
		-- getting count of different question types
	    @xmlvar.value('count(ns:Quiz/ns:Questions/ns:MultipleChoice/ns:Question/@ID)', 'INT') 
		             AS 'MultipleChoiceCount',
		@xmlvar.value('count(ns:Quiz/ns:Questions/ns:FillBlanks/ns:Question/@ID)', 'INT')
	                 AS 'FillBlanksCount',
		@xmlvar.value('count(ns:Quiz/ns:Questions/ns:TrueFalse/ns:Question/@ID)', 'INT') 
		             AS 'TrueFalseCount',
		-- using sum in this statement to get total questions count here
		(sum(@xmlvar.value('count(ns:Quiz/ns:Questions/ns:MultipleChoice/ns:Question/@ID)', 'INT')) +
		 sum(@xmlvar.value('count(ns:Quiz/ns:Questions/ns:FillBlanks/ns:Question/@ID)', 'INT')) +
		 sum(@xmlvar.value('count(ns:Quiz/ns:Questions/ns:TrueFalse/ns:Question/@ID)', 'INT'))) 
		             AS 'TotalQuestions'		
from    SD18EXAM_tbQuizVersion, SD18EXAM_tbIssuedQuiz, SD18EXAM_tbXMLQuizContent
where   SD18EXAM_tbQuizVersion.Versionid = SD18EXAM_tbIssuedQuiz.Versionid and
        SD18EXAM_tbQuizVersion.Versionid = @Versionid
GROUP BY 
         CAST([XmlFile] AS VARCHAR(MAX))

end
go

create procedure SD18EXAM_spGetStudentResponseDetails(
@QuizStudentid int = null
)
as begin
select SD18EXAM_tbQuizStudent.QuizStudentid, SD18EXAM_tbQuizStudent.IssuedQuizId, SD18EXAM_tbQuizStudent.Status,
       SD18EXAM_tbQuizStudent.Userid, XMLStudentResponse, SD18EXAM_tbQuizStudent.Points,
	   Firstname + ' ' + Lastname as 'StudentName', StatusName
from SD18EXAM_tbQuizStudent, SD18EXAM_tbUser, SD18EXAM_tbQuizStatus
where SD18EXAM_tbQuizStudent.Userid = SD18EXAM_tbUser.Userid and
      SD18EXAM_tbQuizStudent.Status = SD18EXAM_tbQuizStatus.StatusId and
	  SD18EXAM_tbQuizStudent.QuizStudentid = isnull(@QuizStudentid, SD18EXAM_tbQuizStudent.QuizStudentid )
end
go

--------------------------INSERTS FOR TESTING--------------------------
SD18EXAM_spInsertXMLContent @xml = '<?xml version="1.0" encoding="utf-8"?><Quiz QuizId="111230123" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns="urn:Question-Schema"><Details><Title>testtitle</Title><Subject>tsubh</Subject><Course>Software and Database Developer</Course><Time>15</Time><Difficulty>Intermediate</Difficulty></Details><Questions><MultipleChoice> <Question ID="1"><Questi>what is?</Questi><Options><Option>a</Option><Option Correct="yes">b</Option><Option>c</Option><Option>d</Option></Options></Question></MultipleChoice><FillBlanks /><TrueFalse /><FillBlanks /></Questions></Quiz>'
go
SD18EXAM_spInsertXMLContent @xml = '<?xml version="1.0" encoding="utf-8"?><Quiz QuizId="111230123" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns="urn:Question-Schema"><Details><Title>testtitle</Title><Subject>tsubh</Subject><Course>Software and Database Developer</Course><Time>25</Time><Difficulty>Intermediate</Difficulty></Details><Questions><MultipleChoice><Question ID="1"><Questi>what is?</Questi><Options><Option>a</Option><Option Correct="yes">b</Option><Option>c</Option><Option>d</Option></Options></Question></MultipleChoice><FillBlanks /><TrueFalse /><FillBlanks /></Questions></Quiz>'
go
SD18EXAM_spInsertXMLContent @xml = '<?xml version="1.0" encoding="utf-8"?><Quiz QuizId="9999" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns="urn:Question-Schema"><Details><Title>testNetwork</Title><Subject>tsubh</Subject><Course>Network Engineering</Course><Time>31</Time><Difficulty>Intermediate</Difficulty></Details><Questions><MultipleChoice><Question ID="1"><Questi>what is?</Questi><Options><Option>a</Option><Option Correct="yes">b</Option><Option>c</Option><Option>d</Option></Options></Question></MultipleChoice><FillBlanks /><TrueFalse /><FillBlanks /></Questions></Quiz>'
go
SD18EXAM_spInsertXMLContent @xml = '<?xml version="1.0"?><Quiz QuizId="570748" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns="urn:Question-Schema"><Details><Title>Yow </Title><Subject>YowS</Subject><Course>Software and Database Developer</Course><Time>31</Time><Difficulty>Intermediate</Difficulty></Details><Questions><MultipleChoice><Question ID="1"><Questi>What is ?</Questi><Options><Option>a</Option><Option>3b</Option><Option Correct="yes">4x</Option><Option>5a</Option></Options></Question><Question ID="2"><Questi>Who is</Questi><Options><Option Correct="yes">zxcasd</Option><Option>4asdasd</Option><Option>5qwe</Option><Option>6asda</Option></Options></Question><Question ID="3"><Questi>What kind of?</Questi><Options><Option>4zxc</Option><Option>5asd</Option><Option Correct="yes">6qw</Option><Option>7qe</Option></Options></Question><Question ID="4"><Questi>Where is?</Questi><Options><Option>1asd</Option><Option>2xzcasd</Option><Option Correct="yes">3asd</Option><Option>5qwe</Option></Options></Question><Question ID="5"><Questi>add ?</Questi><Options><Option Correct="yes">sad</Option><Option>asd</Option><Option>qw</Option><Option>qeqwe</Option></Options></Question></MultipleChoice><FillBlanks /><TrueFalse><Question ID="6"><Questi>true is correct</Questi><Answer>True</Answer></Question><Question ID="7"><Questi>false is correct</Questi><Answer>False</Answer></Question></TrueFalse><FillBlanks><Question ID="8"><Questi> ________________  is the most amazing thing in the world.</Questi><Options><Option Correct="yes">Love</Option><Option Correct="yes">Boots</Option><Option>Money</Option><Option>Weed</Option></Options></Question></FillBlanks></Questions></Quiz>'
go
SD18EXAM_spInsertXMLContent @xml ='<?xml version="1.0"?><Quiz QuizId="249747" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns="urn:Question-Schema"><Details><Title>test2</Title><Subject>test2</Subject><Course>Software and Database Developer</Course><Time>31</Time><Difficulty>Intermediate</Difficulty></Details><Questions><MultipleChoice><Question ID="1"><Questi>test2</Questi><Options><Option>test2</Option><Option>test2</Option><Option>test2</Option><Option Correct="yes">tewst</Option></Options></Question><Question ID="2"><Questi>xzcase</Questi><Options><Option Correct="yes">asdqweqweqw</Option><Option>asdase</Option><Option>eas</Option><Option>dqwe</Option></Options></Question></MultipleChoice><FillBlanks /><TrueFalse /><FillBlanks /></Questions></Quiz>'
go

-- inserts into SD18EXAM_tbIssuedQuiz
SD18EXAM_spIssueNewQuiz @Versionid = 0, @ClassId = 1, @Mentorid =0
go
SD18EXAM_spIssueNewQuiz @Versionid = 1, @ClassId = 1, @Mentorid =1
go
SD18EXAM_spIssueNewQuiz @Versionid = 2, @ClassId = 2, @Mentorid =0
go
SD18EXAM_spIssueNewQuiz @Versionid = 3, @ClassId = 3, @Mentorid =0
go

insert into SD18EXAM_tbQuizStudent values (0,9,'<?xml version="1.0"?><Quiz QuizId="570748" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns="urn:Question-Schema"><Details><Title>Yow </Title><Subject>YowS</Subject><Course>Software and Database Developer</Course><Time>31</Time><Difficulty>Intermediate</Difficulty></Details><Questions><MultipleChoice><Question ID="1"><Questi>What is ?</Questi><Options><Option>a</Option><Option>3b</Option><Option Correct="yes">4x</Option><Option>5a</Option></Options></Question><Question ID="2"><Questi>Who is</Questi><Options><Option Correct="yes">zxcasd</Option><Option>4asdasd</Option><Option>5qwe</Option><Option>6asda</Option></Options></Question><Question ID="3"><Questi>What kind of?</Questi><Options><Option>4zxc</Option><Option>5asd</Option><Option Correct="yes">6qw</Option><Option>7qe</Option></Options></Question><Question ID="4"><Questi>Where is?</Questi><Options><Option>1asd</Option><Option>2xzcasd</Option><Option Correct="yes">3asd</Option><Option>5qwe</Option></Options></Question><Question ID="5"><Questi>add ?</Questi><Options><Option Correct="yes">sad</Option><Option>asd</Option><Option>qw</Option><Option>qeqwe</Option></Options></Question></MultipleChoice><FillBlanks /><TrueFalse><Question ID="6"><Questi>true is correct</Questi><Answer>True</Answer></Question><Question ID="7"><Questi>false is correct</Questi><Answer>False</Answer></Question></TrueFalse><FillBlanks><Question ID="8"><Questi> ________________  is the most amazing thing in the world.</Questi><Options><Option Correct="yes">Love</Option><Option Correct="yes">Boots</Option><Option>Money</Option><Option>Weed</Option></Options></Question></FillBlanks></Questions></Quiz>',0, 7)
go
insert into SD18EXAM_tbQuizStudent values (0,8,'<?xml version="1.0"?><Quiz QuizId="570748" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns="urn:Question-Schema"><Details><Title>Yow </Title><Subject>YowS</Subject><Course>Software and Database Developer</Course><Time>31</Time><Difficulty>Intermediate</Difficulty></Details><Questions><MultipleChoice><Question ID="1"><Questi>What is ?</Questi><Options><Option>a</Option><Option>3b</Option><Option Correct="yes">4x</Option><Option>5a</Option></Options></Question><Question ID="2"><Questi>Who is</Questi><Options><Option Correct="yes">zxcasd</Option><Option>4asdasd</Option><Option>5qwe</Option><Option>6asda</Option></Options></Question><Question ID="3"><Questi>What kind of?</Questi><Options><Option>4zxc</Option><Option>5asd</Option><Option Correct="yes">6qw</Option><Option>7qe</Option></Options></Question><Question ID="4"><Questi>Where is?</Questi><Options><Option>1asd</Option><Option>2xzcasd</Option><Option Correct="yes">3asd</Option><Option>5qwe</Option></Options></Question><Question ID="5"><Questi>add ?</Questi><Options><Option Correct="yes">sad</Option><Option>asd</Option><Option>qw</Option><Option>qeqwe</Option></Options></Question></MultipleChoice><FillBlanks /><TrueFalse><Question ID="6"><Questi>true is correct</Questi><Answer>True</Answer></Question><Question ID="7"><Questi>false is correct</Questi><Answer>False</Answer></Question></TrueFalse><FillBlanks><Question ID="8"><Questi> ________________  is the most amazing thing in the world.</Questi><Options><Option Correct="yes">Love</Option><Option Correct="yes">Boots</Option><Option>Money</Option><Option>Weed</Option></Options></Question></FillBlanks></Questions></Quiz>',0, 2)
go
insert into SD18EXAM_tbQuizStudent values (0,7,'<?xml version="1.0"?><Quiz QuizId="570748" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns="urn:Question-Schema"><Details><Title>Yow </Title><Subject>YowS</Subject><Course>Software and Database Developer</Course><Time>31</Time><Difficulty>Intermediate</Difficulty></Details><Questions><MultipleChoice><Question ID="1"><Questi>What is ?</Questi><Options><Option>a</Option><Option>3b</Option><Option Correct="yes">4x</Option><Option>5a</Option></Options></Question><Question ID="2"><Questi>Who is</Questi><Options><Option Correct="yes">zxcasd</Option><Option>4asdasd</Option><Option>5qwe</Option><Option>6asda</Option></Options></Question><Question ID="3"><Questi>What kind of?</Questi><Options><Option>4zxc</Option><Option>5asd</Option><Option Correct="yes">6qw</Option><Option>7qe</Option></Options></Question><Question ID="4"><Questi>Where is?</Questi><Options><Option>1asd</Option><Option>2xzcasd</Option><Option Correct="yes">3asd</Option><Option>5qwe</Option></Options></Question><Question ID="5"><Questi>add ?</Questi><Options><Option Correct="yes">sad</Option><Option>asd</Option><Option>qw</Option><Option>qeqwe</Option></Options></Question></MultipleChoice><FillBlanks /><TrueFalse><Question ID="6"><Questi>true is correct</Questi><Answer>True</Answer></Question><Question ID="7"><Questi>false is correct</Questi><Answer>False</Answer></Question></TrueFalse><FillBlanks><Question ID="8"><Questi> ________________  is the most amazing thing in the world.</Questi><Options><Option Correct="yes">Love</Option><Option Correct="yes">Boots</Option><Option>Money</Option><Option>Weed</Option></Options></Question></FillBlanks></Questions></Quiz>',0, 3)
go
insert into SD18EXAM_tbQuizStudent values (1,5,'<?xml version="1.0"?><Quiz QuizId="570748" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns="urn:Question-Schema"><Details><Title>Yow </Title><Subject>YowS</Subject><Course>Software and Database Developer</Course><Time>31</Time><Difficulty>Intermediate</Difficulty></Details><Questions><MultipleChoice><Question ID="1"><Questi>What is ?</Questi><Options><Option>a</Option><Option>3b</Option><Option Correct="yes">4x</Option><Option>5a</Option></Options></Question><Question ID="2"><Questi>Who is</Questi><Options><Option Correct="yes">zxcasd</Option><Option>4asdasd</Option><Option>5qwe</Option><Option>6asda</Option></Options></Question><Question ID="3"><Questi>What kind of?</Questi><Options><Option>4zxc</Option><Option>5asd</Option><Option Correct="yes">6qw</Option><Option>7qe</Option></Options></Question><Question ID="4"><Questi>Where is?</Questi><Options><Option>1asd</Option><Option>2xzcasd</Option><Option Correct="yes">3asd</Option><Option>5qwe</Option></Options></Question><Question ID="5"><Questi>add ?</Questi><Options><Option Correct="yes">sad</Option><Option>asd</Option><Option>qw</Option><Option>qeqwe</Option></Options></Question></MultipleChoice><FillBlanks /><TrueFalse><Question ID="6"><Questi>true is correct</Questi><Answer>True</Answer></Question><Question ID="7"><Questi>false is correct</Questi><Answer>False</Answer></Question></TrueFalse><FillBlanks><Question ID="8"><Questi> ________________  is the most amazing thing in the world.</Questi><Options><Option Correct="yes">Love</Option><Option Correct="yes">Boots</Option><Option>Money</Option><Option>Weed</Option></Options></Question></FillBlanks></Questions></Quiz>',1,6)
go
insert into SD18EXAM_tbQuizStudent values (1,6,'<?xml version="1.0"?><Quiz QuizId="570748" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns="urn:Question-Schema"><Details><Title>Yow </Title><Subject>YowS</Subject><Course>Software and Database Developer</Course><Time>31</Time><Difficulty>Intermediate</Difficulty></Details><Questions><MultipleChoice><Question ID="1"><Questi>What is ?</Questi><Options><Option>a</Option><Option>3b</Option><Option Correct="yes">4x</Option><Option>5a</Option></Options></Question><Question ID="2"><Questi>Who is</Questi><Options><Option Correct="yes">zxcasd</Option><Option>4asdasd</Option><Option>5qwe</Option><Option>6asda</Option></Options></Question><Question ID="3"><Questi>What kind of?</Questi><Options><Option>4zxc</Option><Option>5asd</Option><Option Correct="yes">6qw</Option><Option>7qe</Option></Options></Question><Question ID="4"><Questi>Where is?</Questi><Options><Option>1asd</Option><Option>2xzcasd</Option><Option Correct="yes">3asd</Option><Option>5qwe</Option></Options></Question><Question ID="5"><Questi>add ?</Questi><Options><Option Correct="yes">sad</Option><Option>asd</Option><Option>qw</Option><Option>qeqwe</Option></Options></Question></MultipleChoice><FillBlanks /><TrueFalse><Question ID="6"><Questi>true is correct</Questi><Answer>True</Answer></Question><Question ID="7"><Questi>false is correct</Questi><Answer>False</Answer></Question></TrueFalse><FillBlanks><Question ID="8"><Questi> ________________  is the most amazing thing in the world.</Questi><Options><Option Correct="yes">Love</Option><Option Correct="yes">Boots</Option><Option>Money</Option><Option>Weed</Option></Options></Question></FillBlanks></Questions></Quiz>',1,5)
go
insert into SD18EXAM_tbQuizStudent values (2,4,'<?xml version="1.0"?><Quiz QuizId="570748" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns="urn:Question-Schema"><Details><Title>Yow </Title><Subject>YowS</Subject><Course>Software and Database Developer</Course><Time>31</Time><Difficulty>Intermediate</Difficulty></Details><Questions><MultipleChoice><Question ID="1"><Questi>What is ?</Questi><Options><Option>a</Option><Option>3b</Option><Option Correct="yes">4x</Option><Option>5a</Option></Options></Question><Question ID="2"><Questi>Who is</Questi><Options><Option Correct="yes">zxcasd</Option><Option>4asdasd</Option><Option>5qwe</Option><Option>6asda</Option></Options></Question><Question ID="3"><Questi>What kind of?</Questi><Options><Option>4zxc</Option><Option>5asd</Option><Option Correct="yes">6qw</Option><Option>7qe</Option></Options></Question><Question ID="4"><Questi>Where is?</Questi><Options><Option>1asd</Option><Option>2xzcasd</Option><Option Correct="yes">3asd</Option><Option>5qwe</Option></Options></Question><Question ID="5"><Questi>add ?</Questi><Options><Option Correct="yes">sad</Option><Option>asd</Option><Option>qw</Option><Option>qeqwe</Option></Options></Question></MultipleChoice><FillBlanks /><TrueFalse><Question ID="6"><Questi>true is correct</Questi><Answer>True</Answer></Question><Question ID="7"><Questi>false is correct</Questi><Answer>False</Answer></Question></TrueFalse><FillBlanks><Question ID="8"><Questi> ________________  is the most amazing thing in the world.</Questi><Options><Option Correct="yes">Love</Option><Option Correct="yes">Boots</Option><Option>Money</Option><Option>Weed</Option></Options></Question></FillBlanks></Questions></Quiz>',0, 5)
go
insert into SD18EXAM_tbQuizStudent values (2,10,'<?xml version="1.0"?><Quiz QuizId="570748" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns="urn:Question-Schema"><Details><Title>Yow </Title><Subject>YowS</Subject><Course>Software and Database Developer</Course><Time>31</Time><Difficulty>Intermediate</Difficulty></Details><Questions><MultipleChoice><Question ID="1"><Questi>What is ?</Questi><Options><Option>a</Option><Option>3b</Option><Option Correct="yes">4x</Option><Option>5a</Option></Options></Question><Question ID="2"><Questi>Who is</Questi><Options><Option Correct="yes">zxcasd</Option><Option>4asdasd</Option><Option>5qwe</Option><Option>6asda</Option></Options></Question><Question ID="3"><Questi>What kind of?</Questi><Options><Option>4zxc</Option><Option>5asd</Option><Option Correct="yes">6qw</Option><Option>7qe</Option></Options></Question><Question ID="4"><Questi>Where is?</Questi><Options><Option>1asd</Option><Option>2xzcasd</Option><Option Correct="yes">3asd</Option><Option>5qwe</Option></Options></Question><Question ID="5"><Questi>add ?</Questi><Options><Option Correct="yes">sad</Option><Option>asd</Option><Option>qw</Option><Option>qeqwe</Option></Options></Question></MultipleChoice><FillBlanks /><TrueFalse><Question ID="6"><Questi>true is correct</Questi><Answer>True</Answer></Question><Question ID="7"><Questi>false is correct</Questi><Answer>False</Answer></Question></TrueFalse><FillBlanks><Question ID="8"><Questi> ________________  is the most amazing thing in the world.</Questi><Options><Option Correct="yes">Love</Option><Option Correct="yes">Boots</Option><Option>Money</Option><Option>Weed</Option></Options></Question></FillBlanks></Questions></Quiz>',0, 4)
go


select * from SD18EXAM_tbQuizStatus 
select * from SD18EXAM_tbIssuedQuiz
select * from SD18EXAM_tbQuizStudent
select * from SD18EXAM_tbUser
select * from SD18EXAM_tbQuizStudentStatus
select * from SD18EXAM_tbXMLQuizContent
select * from SD18EXAM_tbClass
select * from SD18EXAM_tbCourse
select * from SD18EXAM_tbQuizVersion
