/*
-- get the nth record from invoices table --


	SELECT *
	FROM Invoices
	ORDER BY InvoiceTotal
		OFFSET 114 ROWS
		FETCH NEXT 1 ROW ONLY




DROP PROC IF EXISTS spGetNthRecord;
GO

CREATE PROC spGetNthRecord
	@nth int
AS BEGIN
	SET NOCOUNT ON
	;WITH tbl AS (
		SELECT TOP(@nth) *
		FROM Invoices
		ORDER BY InvoiceTotal DESC
	) SELECT TOP(1) * FROM tbl ORDER BY InvoiceTotal DESC
END
GO

EXEC spGetNthRecord @nth = 15

*/


/*
begin tran
	;with tbl as (
		SELECT	*,
				[RowNum] = ROW_NUMBER() OVER(PARTITION BY VendorID ORDER BY InvoiceDate)
		FROM Invoices
	) delete tbl where RowNum > 1

	select * from Invoices

rollback tran
*/

/*
CREATE TABLE tblPeople (
	personId		INT				PRIMARY KEY		IDENTITY,
	personName		VARCHAR(100),
)
*/

/*
DECLARE @i INT = 1;

SET NOCOUNT ON
WHILE(@i <= 2000000) BEGIN
	INSERT INTO tblPeople(personName) VALUES (CONCAT('Person of Interest Name - ', @i))
	SET @i = @i + 1;
END

SELECT COUNT(*) FROM tblPeople
*/
--DROP INDEX IF EXISTS tblPeople.idxPersonName

--DECLARE @start DATETIME, @stop DATETIME

--SET @start = getdate()
--	SELECT * FROM tblPeople WHERE personName = 'Person of Interest Name - 2000000'
--SET @stop = getdate()

--SELECT DATEDIFF(MILLISECOND, @start, @stop) AS timeInMS

--CREATE INDEX idxPersonName ON tblPeople(personName)
--SET @start = getdate()
--	SELECT * FROM tblPeople WHERE personName = 'Person of Interest Name - 2000000'
--SET @stop = getdate()

--SELECT DATEDIFF(MILLISECOND, @start, @stop) AS timeInMS

DROP TABLE tblPeople

DBCC SHRINKDATABASE (AP, 10)