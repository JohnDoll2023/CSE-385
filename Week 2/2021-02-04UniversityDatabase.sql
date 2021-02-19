USE master;
GO

DROP DATABASE IF EXISTS UniversityDatabase;
GO

CREATE DATABASE UniversityDatabase;
GO

USE UniversityDatabase;

CREATE TABLE tblTeachers (
	teacherId		INT				NOT NULL	PRIMARY KEY		IDENTITY,
	name			VARCHAR(30)		NOT NULL,								--could put brackets around name but not required and he does not
	email			VARCHAR(90)		NULL,
	isRetired		BIT				NOT NULL	DEFAULT(0)
)
GO

CREATE TABLE tblCourses (
	courseId		INT				NOT NULL	PRIMARY KEY		IDENTITY,
	name			VARCHAR(60)		NOT NULL,
	section			CHAR(2)			NOT NULL,
	credits			INT				NOT NULL	DEFAULT(3)
)
GO

CREATE TABLE tblStudents (
	studentID		INT				NOT NULL	PRIMARY KEY		IDENTITY,
	name			VARCHAR(30)		NOT NULL,
	email			VARCHAR(90)		NULL,
	yearInSchool	INT				NOT NULL	DEFAULT(1)
)
GO

CREATE TABLE tblTeacherCourses (
	teacherId		INT				NOT NULL	FOREIGN KEY REFERENCES tblTeachers(teacherId),
	courseId		INT				NOT NULL	FOREIGN KEY REFERENCES tblCourses(courseId),
	isActive		BIT				NOT NULL	DEFAULT(1),	
	activeDate		DATE			NOT NULL,
	inactiveDate	DATE			NULL		DEFAULT(NULL), --comma not required
	PRIMARY KEY (		--how to declare dual pk
		teacherId, courseId
	)
)
GO

CREATE TABLE tblStudentCourses (
	studentId		INT				NOT NULL	FOREIGN KEY REFERENCES tblStudents(studentId),
	courseId		INT				NOT NULL	FOREIGN KEY REFERENCES tblCourses(courseId),
	isDeleted		BIT				NOT NULL	DEFAULT(0),
	currentGrade	FLOAT			NULL		DEFAULT(NULL)
	PRIMARY KEY (
		studentId, courseId
	)
)
GO