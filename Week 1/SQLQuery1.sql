USE master;
GO

/*
	Older version of dropping a database
	This is a safer way to do it
*/

IF DB_ID('Example') IS NOT NULL   --no double quotes in SQLserver
	DROP DATABASE Example;
GO

DROP DATABASE IF EXISTS Example;   --not understood by version 12
GO

CREATE DATABASE Example; -- could also write [Example]
GO

USE Example;
GO

-- Creating our first table

CREATE TABLE tblFriends (	--good example of table creation (would not have comments)
	friendId		INT				NOT NULL	PRIMARY KEY		IDENTITY,  --IDENTITY by default will start at 1 and increase by 1 with each new record
	firstName		VARCHAR(20)		NOT NULL,
	lastName		VARCHAR(20)		NOT NULL,
	age				INT				NOT NULL	DEFAULT(-1),
	phoneNumber		VARCHAR(20)		NOT NULL	DEFAULT('(***) ***-****'),
	[address]		VARCHAR(100)	NULL		DEFAULT(NULL)		--address surrounded by brackets because was highlighted blue since it is keyword
)
GO

/*
	C.R.U.D.

	Create	INSERT
	Read	SELECT
	Update	UPDATE
	Delete	DELETE
*/

--DELETE FROM tblFriends
TRUNCATE TABLE tblFriends
GO

INSERT INTO tblFriends (firstName, lastName, age, phoneNumber, address)	VALUES ('A', 'A', 22, '(123)456-7890', 'A') --could out brackets around address if wanted, also don't need space even tho had it above between ( and 4
INSERT INTO tblFriends (firstName, lastName, age, phoneNumber		)	VALUES ('B', 'B', 22, 'B')
INSERT INTO tblFriends (firstName, lastName, age)						VALUES ('C', 'C', 22)
INSERT INTO tblFriends (firstName, lastName)							VALUES ('D', 'D')
--INSERT INTO tblFriends (firstName)									VALUES ('E')       error bc doesn't accept null for last name

INSERT INTO tblFriends (firstName, lastName, age, phoneNumber, address)	VALUES 
	('A', 'A', 22, '(123)456-7890', 'A'),
	('B', 'B', 22, 'B', 'B'),
	('C', 'C', 22, 'C', 'C'),
	('D', 'D', 22, 'D', 'D')

--id	vin	make	model	year
--1	3N6CM0KN6FK202799	Subaru	Impreza	2009

DROP TABLE IF EXISTS tblCars;
GO

CREATE TABLE tblCars(
	carId		INT				NOT NULL	PRIMARY KEY		IDENTITY,
	vin			VARCHAR(20)		NOT NULL,
	make		VARCHAR(20)		NOT NULL,
	model		VARCHAR(40)		NOT NULL,
	[year]		INT				NOT NULL
)
GO

BULK INSERT tblCars
	FROM 'C:\Users\jdoll\OneDrive\CSE 385\CarData.txt'
	WITH (
		FIRSTROW = 2,
		ROWTERMINATOR = '\n',
		FIELDTERMINATOR = '\t',
		KEEPIDENTITY
	);
GO

SELECT make, model, year FROM tblCars WHERE make = 'Honda'