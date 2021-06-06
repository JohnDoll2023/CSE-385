/*
	SELECT ', ' + InvoiceNumber
	FROM Invoices i
		JOIN Vendors v ON v.VendorID = i.VendorID
	FOR XML PATH('')
*/

				--1-based
--STUFF(string, startIndex, numOfCharsToDelete, stringToInsert)

/*
SELECT STUFF('today isa good day', 9, 0, ' ')
SELECT STUFF('today isa good day', 9, 1, ' a')
SELECT STUFF('today isa good day', 9, 6, ' a')

-- delete word good + space
SELECT STUFF('today is a good day', 12, 5, ' ')
*/

--next three statements all equivalent (in their base form)
	SELECT	DISTINCT VendorName,
			[Invoices] = ISNULL(
							STUFF(
								(
								SELECT ', ' + InvoiceNumber
								FROM Invoices i
								WHERE v.VendorID = i.VendorID
								FOR XML PATH('')
								),
								1, 2, ''
						), '')


	FROM Vendors v
		LEFT JOIN Invoices i ON v.VendorID = i.VendorID
	FOR XML PATH('VENDOR'), ROOT('Vendors')
	--WHERE VendorID IN (SELECT DISTINCT VendorID FROM Invoices)

/*
	SELECT VendorName
	FROM Vendors v
		JOIN Invoices i on v.VendorID = i.VendorID

	SELECT VendorName
	FROM Vendors v, Invoices i
	WHERE v.VendorID = i.VendorID
	*/