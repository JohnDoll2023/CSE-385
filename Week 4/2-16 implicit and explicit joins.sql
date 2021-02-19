--==================================================================Implicit Join
--want vendorname, invoice number and invoicet total

/*
SELECT	v.VendorID,
		VendorName,
		InvoiceNumber,
		InvoiceTotal
FROM	Vendors v, 
		Invoices i
WHERE v.VendorID = i.VendorID
*/

--vendorname, invoice#, invoice total, balance (if balance > 0)
/*
SELECT	v.VendorID,		--v needed and could specify others but not needed
		VendorName,
		InvoiceNumber,
		InvoiceTotal,
		i.Balance		--i not needed but stahr likes it
FROM	Vendors v, 
		vwInvoices i
WHERE (v.VendorID = i.VendorID) AND (Balance > 0)
ORDER BY v.VendorName
*/

	--vendorname, invoice#, invoicelineitemdescription, invoicelineitemamount
/*
SELECT	VendorName, 
		InvoiceNumber, 
		InvoiceLineItemDescription, 
		InvoiceLineItemAmount 
FROM	Vendors v, 
		Invoices i, 
		InvoiceLineItems ili
WHERE (v.VendorID = i.VendorID) AND (i.InvoiceID = ili.InvoiceID)
*/

--====================================================================================Explicit join

/*
SELECT	v.VendorID,
		VendorName,
		InvoiceNumber,
		InvoiceTotal
FROM	Vendors v JOIN    --change comma to JOIN             INNER implied here so do not need to write INNER JOIN
		Invoices i
ON v.VendorID = i.VendorID		--change WHERE to ON
*/
/*
SELECT	v.VendorID,		
		VendorName,
		InvoiceNumber,
		InvoiceTotal,
		i.Balance		
FROM	Vendors v
	JOIN vwInvoices i ON (v.VendorID = i.VendorID) 
WHERE (Balance > 0)
ORDER BY v.VendorName
*/
/*
SELECT	VendorName, 
		InvoiceNumber, 
		InvoiceLineItemDescription, 
		InvoiceLineItemAmount 
FROM	Vendors v 
	JOIN Invoices i ON (v.VendorID = i.VendorID)
	JOIN InvoiceLineItems ili ON (i.InvoiceID = ili.InvoiceID)
*/

--self join
/*
SELECT DISTINCT v1.VendorName, v1.VendorCity, v1.VendorState
FROM Vendors v1
	JOIN  Vendors v2 ON 
		(v1.VendorCity = v2.VendorCity) AND (v1.VendorState = v2.VendorState) AND (v1.VendorID <> v2.VendorID)
ORDER BY v1.VendorState, v1.VendorCity
*/

--VendorName, customerlastname, custfirstname, state, city
/*
SELECT	VendorName,
		CustLastName,
		CustFirstName,
		VendorState,
		VendorCity
FROM AP..Vendors v
	JOIN ProductOrders..Customers c ON v.VendorZipCode = c.CustZip
ORDER BY VendorState, VendorCity
*/

--Full join
SELECT v.VendorName, c.FirstName
FROM Vendors v
	FULL JOIN ContactUpdates c ON v.VendorID = c.VendorID  --where these dont match, nulls will be put in