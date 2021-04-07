
----------------------------------------------------------------------VIEW
DROP PROCEDURE IF EXISTS spGetVendors

/*CREATE PROCEDURE spGetVendors   
		@st varchar(50),   
		@includeVendorsWithNoInvoices bit = 0  
		WITH ENCRYPTION
	AS BEGIN 
		SET NOCOUNT ON     
			
		SELECT	v.VendorId, 
				v.VendorName, 
				COUNT(i.InvoiceId) AS InvoiceCount   
		FROM Vendors v    
			LEFT JOIN Invoices i ON v.VendorId = i.VendorId   
		WHERE (VendorState = @st) OR (@st='')   
		GROUP BY v.VendorId, v.VendorName   
		HAVING		( COUNT(i.InvoiceId) > 0 ) 
				OR  ( @includeVendorsWithNoInvoices = 1 )   
		ORDER BY v.VendorName    
	END*/
	
--EXEC spGetVendors @st = 'ca'
/*
--gets back original code for stored procedure creation
EXEC sp_helptext 'spGetVendors'

-- gives back original code for stored procedure creation
SELECT definition
from sys.sql_modules
WHERE object_id = OBJECT_ID('spGetVendors')
*/

-----------------------------------------------------------------VIEW
/*
DROP VIEW IF EXISTS vwVendorStuff
GO

CREATE VIEW vwVendorStuff
	WITH ENCRYPTION
AS

	SELECT	VendorName,
			VendorCity,
			VendorState,
			InvoiceNumber,
			Balance,
			InvoiceLineItemDescription,
			InvoiceLineItemAmount
	FROM Vendors v, vwInvoices i, InvoiceLineItems ili
	WHERE	(v.vendorID = i.VendorID) AND
			(i.InvoiceID = ili.InvoiceID)
GO

SELECT * FROM vwVendorStuff WHERE VendorState = 'ca'
*/

--------------------------------------------------------------------Functions

DROP FUNCTION IF EXISTS fnMultiply 
GO

CREATE FUNCTION dbo.fnMultiply(@num1 INT, @num2 INT) RETURNS INT -----------don't need dbo in this particular case
	WITH ENCRYPTION
AS BEGIN
	RETURN @num1 * @num2
END
GO

select dbo.fnMultiply(5, 7)

select *, dbo.fnMultiply(InvoiceSequence, InvoiceLineItemAmount) 
from InvoiceLineItems