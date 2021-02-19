/*
	Basic List		Advanced List
	SELECT			SELECT
	FROM			FROM
	WHERE			WHERE
	ORDER BY		GROUP BY
					HAVING		Same as where just happens after group by
					ORDER BY
					OFFSET

SELECT *
FROM Vendors
WHERE VendorState = 'NY'

SELECT *
FROM Vendors
WHERE (VendorPhone IS NULL) AND (VendorAddress1 IS NULL)

SELECT *
FROM Vendors
WHERE (VendorState = 'NY') OR (VendorState = 'NJ')

SELECT *
FROM Vendors
WHERE VendorState IN ('NY', 'NJ')

SELECT *		all states that begin with n
FROM Vendors
WHERE VendorState LIKE 'N%'

SELECT *		all states that begin with n and end in either y or j
FROM Vendors
WHERE VendorState LIKE 'N[YJ]'

SELECT *		all zip codes ending in 18
FROM Vendors
WHERE VendorZipCode LIKE '%18'

SELECT *		all zip codes starting with 9 or 5 and ending in 1, 2 or 3
FROM Vendors
WHERE VendorZipCode LIKE '[9, 5]%[1,2,3]'

SELECT *		all zip codes starting with 9 or 5 and ending in 1, 2 or 3
FROM Vendors
WHERE VendorZipCode LIKE '[95]%[123]'

SELECT *		same as above but ordered
FROM Vendors
WHERE VendorZipCode LIKE '[95]%[1-3]'
ORDER BY VendorZipCode

SELECT InvoiceNumber,
	   [Balance] = InvoiceTotal - PaymentTotal - CreditTotal
FROM Invoices
WHERE (VendorID = 123) AND ((InvoiceTotal - PaymentTotal - CreditTotal) > 0)
ORDER BY Balance

SELECT [Balance] = SUM(InvoiceTotal - PaymentTotal - CreditTotal)		gives total balance of everyone combined
FROM Invoices

SELECT VendorID,		won't work, need group by
	   [Balance] = SUM(InvoiceTotal - PaymentTotal - CreditTotal)
FROM Invoices

SELECT VendorID,
	   [Balance] = SUM(InvoiceTotal - PaymentTotal - CreditTotal)
FROM Invoices
GROUP BY VendorID

SELECT VendorID,		works but is not best way
	   [Balance] = SUM(InvoiceTotal - PaymentTotal - CreditTotal)
FROM Invoices
WHERE (InvoiceTotal - PaymentTotal - CreditTotal) > 0
GROUP BY VendorID



SELECT VendorID,
	   [Balance] = SUM(InvoiceTotal - PaymentTotal - CreditTotal)
FROM Invoices
--WHERE InvoiceTotal >= 100
GROUP BY VendorID
HAVING SUM(InvoiceTotal - PaymentTotal - CreditTotal) > 0
37	224.00
72	85.31
80	90.36
83	579.42
106	503.20
110	30327.24
123	210.89

SELECT VendorID,
	   [Balance] = SUM(InvoiceTotal - PaymentTotal - CreditTotal)
FROM Invoices
WHERE InvoiceTotal >= 100
GROUP BY VendorID
HAVING SUM(InvoiceTotal - PaymentTotal - CreditTotal) > 0
37	224.00
83	579.42
106	503.20
110	30327.24


SELECT VendorID,
	   [Balance]		= SUM(InvoiceTotal - PaymentTotal - CreditTotal),
	   [InvoiceCount]	= COUNT(*)		--counting individual invoices for each ID
FROM Invoices
WHERE InvoiceTotal >= 100
GROUP BY VendorID
HAVING SUM(InvoiceTotal - PaymentTotal - CreditTotal) > 0

SELECT *
FROM Invoices
WHERE	(InvoiceTotal >= 100) AND
		(InvoiceTotal <= 200)

SELECT *			does same as above
FROM Invoices
WHERE	InvoiceTotal BETWEEN 100 AND 200

SELECT *
FROM Invoices
WHERE InvoiceDate BETWEEN '2016-01-01' AND '2016-05-31'

SELECT VendorState
FROM Vendors
GROUP BY VendorState
ORDER BY VendorState

SELECT DISTINCT VendorState
FROM Vendors
ORDER BY VendorState

SELECT VendorState
FROM Vendors
ORDER BY VendorState DESC

SELECT TOP(10) --WITH TIES 
	VendorID,
	VendorState, 
	VendorCity
FROM Vendors
--ORDER BY VendorState

SELECT TOP(10) WITH TIES 
	VendorID,
	VendorState, 
	VendorCity
FROM Vendors
ORDER BY VendorState

SELECT TOP(10) --WITH TIES 
	VendorID,
	VendorState, 
	VendorCity
FROM Vendors
ORDER BY VendorState

SELECT 
	VendorID, 
	VendorName, 
	VendorCity +  ', ' + VendorState AS [Location]
FROM Vendors

SELECT					doesn't work
	'(' + VendorID + ') ' + VendorName, 
	VendorCity +  ', ' + VendorState AS [Location]
FROM Vendors

SELECT				works
	'(' + CAST(VendorID AS VARCHAR(5)) + ') ' + VendorName, 
	VendorCity +  ', ' + VendorState AS [Location]
FROM Vendors

SELECT				bit better
	'(' + CONVERT(VARCHAR(5), VendorID) + ') ' + VendorName, 
	VendorCity +  ', ' + VendorState AS [Location]
FROM Vendors

SELECT				best
	[VendorName] = CONCAT('(', VendorID, ') ', VendorName), 
	[Location]   = CONCAT(VendorCity, ', ', VendorState)
FROM Vendors
*/


SELECT 
	[VendorName] = CONCAT('(', VendorID, ') ', VendorName), 
	[Location]   = CONCAT(VendorCity, ', ', VendorState)
FROM Vendors

SELECT 300/4.2 AS num1,
	   InvoiceTotal,
	   InvoiceTotal * 1.13 AS total
FROM Invoices