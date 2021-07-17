-- Switch to another DB first
USE master;

IF DB_ID (N'mytest') IS NOT NULL
	BEGIN
		ALTER DATABASE mytest SET SINGLE_USER WITH ROLLBACK IMMEDIATE
		DROP DATABASE mytest;
	END

CREATE DATABASE mytest;
USE mytest;

create table Submissions (
  submission_date date,
  submission_id int,
  hacker_id int,
  score int
);

create table Hackers (
  hacker_id int,
  name varchar(20)
);

insert into submissions values
('2016-03-01', 8494, 20703, 0),
('2016-03-01', 22403, 53473,15),
('2016-03-01',23965,79722,60),
('2016-03-01',30173,36396,70),
('2016-03-02',34928,20703,0),
('2016-03-02',38740,15758,60),
('2016-03-02',42769,79722,25),
('2016-03-02',44364,79722,60),
('2016-03-03',45440,20703,0),
('2016-03-03',49050,36396,70),
('2016-03-03',50273,79722,5),
('2016-03-04',50344,20703,0),
('2016-03-04',51360,44065,90),
('2016-03-04',54404,53473,65),
('2016-03-04',61533,79722,45),
('2016-03-05',72852,20703,0),
('2016-03-05',74546,38289,0),
('2016-03-05',76487,62529,0),
('2016-03-05',82439,36396,10),
('2016-03-05',90006,36396,40),
('2016-03-06',90404,20703,0);

insert into hackers values 
(15758, 'Rose'),(20703, 'Angela'),
(36396,'Frank'),(38289, 'Patrick'),
(44065, 'Lisa'),(53473,'Kimberly'),
(62529, 'Bonnie'),(79722, 'Michael');


select * from hackers;
select * from Submissions;
  