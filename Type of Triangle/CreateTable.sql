-- Switch to another DB first
USE master;

IF DB_ID (N'mytest') IS NOT NULL
	BEGIN
		ALTER DATABASE mytest SET SINGLE_USER WITH ROLLBACK IMMEDIATE
		DROP DATABASE mytest;
	END

CREATE DATABASE mytest;
USE mytest;

CREATE TABLE triangles(
	A INTEGER,
	B INTEGER,
	C INTEGER
);

INSERT INTO triangles(A,B,C)
VALUES (20,20,23),
	(20,20,20),
	(20,21,22),
	(13,14,30);


INSERT INTO triangles(A,B,C)
VALUES 
(10, 10, 10),
(11, 11, 11),
(30, 32, 30),
(40, 40, 40),
(20, 20, 21),
(21, 21, 21),
(20, 22, 21),
(20, 20, 40),
(20, 22, 21),
(30, 32, 41),
(50, 22, 51),
(20, 12, 61),
(20, 22, 50),
(50, 52, 51),
(80, 80, 80);