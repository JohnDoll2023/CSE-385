USE Example;
DROP TABLE IF EXISTS [tblPeople]

-- Q1 (5 pts): Create tblPeople table

--id	first_name	last_name	email	gender	ip_address
--1	Cherilyn	Camden	ccamden0@huffingtonpost.com	Male	184.129.31.27

CREATE TABLE tblPeople (
	id			INT			NOT NULL	PRIMARY KEY		IDENTITY,
	first_name	VARCHAR(20) NOT NULL,
	last_name	VARCHAR(20)	NOT NULL,
	email		VARCHAR(40)	NOT NULL	DEFAULT(''),
	gender		VARCHAR(20)	NOT NULL	DEFAULT(''),
	ip_address	VARCHAR(20)	NOT NULL	DEFAULT('')
)
GO

-- Q2 (5 pts): Import your records from the file
BULK INSERT tblPeople 
	FROM 'C:\Users\jdoll\OneDrive\CSE 385\Lab-01-People.txt'
	WITH (
		FIRSTROW = 2,
		ROWTERMINATOR = '\n',
		FIELDTERMINATOR = '\t',
		KEEPIDENTITY
	);
GO

-- Q3 (5 pts): Query that returns all fields from tblPeople that have a first name of Dale
SELECT * FROM tblPeople WHERE first_name = 'Dale'
GO

-- Q4 (5 pts): Query that returns the first name, last name, and email of all females
SELECT first_name, last_name, email FROM tblPeople WHERE gender = 'Female'
GO
