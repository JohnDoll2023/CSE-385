-------STUFF
-- @data = '12g4bui235' -> convert to 124235
-------------------------> gbui

--select STUFF('12g4bui235', 3, 1, '')

/*
DROP FUNCTION IF EXISTS fnExtractNums;
GO

CREATE FUNCTION fnExtractNums(@data varchar(255)) RETURNS INT AS BEGIN
	DECLARE @index INT = Patindex('%[^0-9]%', @data);

	WHILE(@index > 0) BEGIN
		SET @data = STUFF(@data, @index, 1, '');
		SET @index = Patindex('%[^0-9]%', @data);
	END

	RETURN CAST(ISNULL(@data, 0) AS INT)
END	
GO

DROP FUNCTION IF EXISTS fnExtractAlpha;
GO

CREATE FUNCTION fnExtractAlpha(@data varchar(255)) RETURNS VARCHAR(255) AS BEGIN
	DECLARE @index INT = Patindex('%[^a-zA-Z]%', @data);

	WHILE(@index > 0) BEGIN
		SET @data = STUFF(@data, @index, 1, '');
		SET @index = Patindex('%[^a-zA-Z]%', @data);
	END

	
	RETURN ISNULL(@data, '')
END	
GO



DECLARE @str VARCHAR(255) = '12g4bUi235'

SELECT	[ID] = dbo.fnExtractNums(@str),
		[PW] = dbo.fnExtractAlpha(@str)

--select Patindex('%[^0-9]%', '12g4bui235');

--select stuff('12g4bui235', Patindex('%[^0-9]%', '12g4bui235'), 1, '')

*/



----------------------------------string_split()

--SELECT * FROM string_split('Today is a good day', ' ')


DECLARE @tbl AS TABLE (
	VendorID	INT,
	Invoices	VARCHAR(1000)
)


INSERT INTO @tbl
SELECT	DISTINCT v.VendorID,
		[Invoices] = 
			ISNULL(STUFF(
			(
				SELECT ',' + i.InvoiceNumber
				FROM Invoices i
				WHERE i.VendorID = v.VendorID
				FOR XML PATH('')
			), 1, 1, ''), '')
FROM Vendors v
	JOIN Invoices i ON v.VendorID = i.VendorID

SELECT t.VendorID, v.VendorName, [Invoice] = value
FROM @tbl t
	JOIN Vendors v ON t.VendorID = v.VendorID
CROSS APPLY string_split(t.Invoices, ',')


DELETE @tbl