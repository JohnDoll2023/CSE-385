--===============================================================Math
SELECT 5*3, 5/3, 5%3, 5*3.5, 5/3.5, 5%3.5

--===============================================================Date
SELECT GETDATE(), SYSDATETIMEOFFSET(), SYSDATETIME()

SELECT DATEDIFF(day, '01/03/2001', GETDATE()), EOMONTH('2/11/2021'), EOMONTH(GETDATE()), ISDATE('2/29/2020'), ISDATE('2/29/2021'), 
	   DATEPART(WEEKDAY, GETDATE()),
	   DATENAME(WEEKDAY, GETDATE())

--===============================================================Converting
SELECT GETDATE(),
	   CONVERT(CHAR(10), GETDATE()),
	   CONVERT(CHAR(15), GETDATE()),
	   CONVERT(CHAR(11), GETDATE(), 1),
	   CONVERT(CHAR(11), GETDATE(), 101),
	   CONVERT(CHAR(11), GETDATE(), 5),
	   CONVERT(CHAR(11), GETDATE(), 105),
	   CAST(GETDATE() AS DATE),
	   CAST(GETDATE() AS CHAR(10)),
	   CAST(SYSDATETIME() AS CHAR(10)),
	   CAST(SYSDATETIME() AS CHAR(15))

--===============================================================Value Checking
--===============================================================VARCHAR
DROP TABLE IF EXISTS Users;
	CREATE TABLE Users (
		id		INT PRIMARY KEY		IDENTITY,
		un		VARCHAR(20),
		pw		VARCHAR(20)
)
	INSERT INTO Users (un, pw) VALUES ('tom', 'myPassworD')

	DECLARE @un VARCHAR(20) = 'tom', @pw VARCHAR(20) = 'myPAssworD'

	SELECT * FROM Users WHERE un = @un AND pw = @pw

	SELECT * FROM Users WHERE un = @un AND CAST(pw AS varbinary) = CAST(@pw AS varbinary)
	SELECT * FROM Users WHERE un = @un AND CAST(pw AS varbinary) = CAST('myPAssworD' AS varbinary)

--===============================================================NVARCHAR
DROP TABLE IF EXISTS Users;
	CREATE TABLE Users (
		id		INT PRIMARY KEY		IDENTITY,
		un		NVARCHAR(20),
		pw		NVARCHAR(20)
)
	INSERT INTO Users (un, pw) VALUES ('tom', 'myPassworD')

	DECLARE @un NVARCHAR(20) = 'tom', @pw NVARCHAR(20) = 'myPAssworD'

	SELECT * FROM Users WHERE un = @un AND pw = @pw

	SELECT * FROM Users WHERE un = @un AND pw COLLATE LATIN1_GENERAL_CS_AS = @pw
	SELECT * FROM Users WHERE un = @un AND 'myPassworD' COLLATE LATIN1_GENERAL_CS_AS = @pw

DROP TABLE IF EXISTS Users;

--==================================================================Comparing and switching
SELECT * FROM Invoices WHERE CreditTotal != 0		--this works but not universal
SELECT * FROM Invoices WHERE CreditTotal <> 0		--proper way

SELECT * FROM Invoices WHERE CreditTotal <> 0 OR isDeleted = 1

SELECT *, [ToggleIsDeleted] = ~isDeleted
FROM Invoices
WHERE CreditTotal <> 0 OR isDeleted = 1

--===================================================================
SELECT *
FROM Vendors
WHERE VendorState LIKE 'N[^K-Y]'

SELECT *		--much better than below method in terms of speed
FROM Vendors
WHERE VendorName LIKE 'Am%'

SELECT *
FROM Vendors
WHERE LEFT(VendorName ,2) = 'Am'

SELECT *
FROM Vendors
WHERE VendorID IN (
	SELECT DISTINCT VendorID FROM Invoices
)

SELECT *		--opposite
FROM Vendors
WHERE VendorID NOT IN (
	SELECT DISTINCT VendorID FROM Invoices
)

--=====================================================================NULL

SELECT COUNT(*) FROM Vendors

SELECT COUNT(VendorID) FROM Vendors

SELECT COUNT(VendorName) FROM Vendors

SELECT COUNT(VendorAddress1) FROM Vendors

SELECT COUNT(VendorAddress2) FROM Vendors

SELECT COUNT(DefaultTermsID) FROM Vendors

SELECT COUNT(DISTINCT DefaultTermsID) FROM Vendors

SELECT VendorName, 
	   [VendorAddress2] = ISNULL(VendorAddress2, ''), 
	   [VendorPhone] = ISNULL(VendorPhone, '***-***-****')
FROM Vendors
WHERE VendorAddress2 IS NULL

--===========================================================Paging

DECLARE @page INT = 12, @records INT = 10

SELECT VendorName, (SELECT COUNT(*) FROM Vendors)/@records AS numOfPages
FROM Vendors
GROUP BY VendorName
ORDER BY VendorName
	OFFSET (@page * @records) ROWS
	FETCH NEXT @records ROWS ONLY