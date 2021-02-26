/*
	Homework-02
	Due: Tuesday, 2021-03-02 by 11:59pm
	5 pts each = 40pts
	Author: John Doll
*/

USE AP;
GO

/********************************************************************************* Q1: 1 Record
	Write a query that returns:
		1. The total number of invoices
		2. The average InvoiceTotal
		3. The sum of all invoice totals
		4. The highest InvoiceTotal
		5. The lowest InvoiceTotal
	Where the invoice date was in February of 2016
*/

SELECT 	[Invoices] 	      = COUNT(InvoiceID),
		[AvgInvoiceTotal] = AVG(InvoiceTotal),
		[SumInvoiceTotal] = SUM(InvoiceTotal),
		[MaxInvoiceTotal] = MAX(InvoiceTotal),
		[MinInvoiceTotal] = MIN(InvoiceTotal)
FROM Invoices
WHERE InvoiceDate BETWEEN '2-1-2016' AND DATEADD(day, -1, '3-1-2016')



/********************************************************************************* Q2: 8 Records
	Return a list of VendorID's and the average invoice total for each vendor.
	Order the list by the average invoice total and only show records that
	have an average more than 2,000
*/

SELECT 	v.VendorID,
		[AvgInvoiceTotal] = AVG(InvoiceTotal)
FROM Vendors v
	JOIN Invoices i ON v.VendorID = i.VendorID
GROUP BY v.VendorID
HAVING AVG(InvoiceTotal) > 2000
ORDER BY AvgInvoiceTotal



/********************************************************************************* Q3: 122 Records
	Write a query that returns VendorName and VendorState if the state is CA and 
	"Outside 'CA'" if the vendor is not in CA
*/

	SELECT 	VendorName,
			[VendorState] = VendorState
	FROM Vendors
	WHERE VendorState = 'CA'
UNION
	SELECT 	VendorName,
			[VendorState] = 'Outside ''CA'''
	FROM Vendors
	WHERE VendorState != 'CA'



/********************************************************************************* Q4: 10 Records
	List the top 10 Vendors by how much they have paid. 
	Return the VendorName and total payments
*/

SELECT TOP(10) 
		VendorName,
		[TotalPayments] = SUM(PaymentTotal)
FROM Vendors v
	JOIN Invoices i ON v.VendorID = i.VendorID
GROUP BY VendorName
ORDER BY TotalPayments DESC


/********************************************************************************* Q5: 10 Records
	List the top 10 vendors with the most number of invoices (included ties). 
	Return VendorName, the total number of invoices, and the total amount of the 
	invoice totals. Name columns VendorName, InvoiceCount, and InvoiceSum 
	Use new school notation.
*/

SELECT TOP(10) WITH TIES
		VendorName,
		COUNT(DISTINCT i.InvoiceID) AS InvoiceCount, 
		SUM(i.InvoiceTotal) AS InvoiceSum
FROM Vendors v
	JOIN Invoices i ON v.VendorID = i.VendorID
GROUP BY VendorName
ORDER BY InvoiceCount DESC


/********************************************************************************* Q6: 10 Records
	Write the same thing as the previous query but with no ties and assume we
	can only show 10 records at a time and want to view the 3rd page of records.
	NOTE:	This one can throw you off and you should test your code. May need a 
			secondary sorter
*/

SELECT 	VendorName,
		[InvoiceCount] = COUNT(DISTINCT i.InvoiceID), 
		[InvoiceSum] =  SUM(i.InvoiceTotal)
FROM Vendors v
	JOIN Invoices i ON v.VendorID = i.VendorID
GROUP BY VendorName
ORDER BY InvoiceCount DESC
	OFFSET 20 ROWS 
        FETCH NEXT 10 ROWS ONLY

/********************************************************************************* Q7: 6 Records
	List, by GLAccount description, the number of items for each GLAccount type 
	and the total invoice line item amount. Only return GLAccount types that show 
	up more than 3 times Name the fileds AccountDescription, LineItemCount, 
	LineItemSum. Sort the list by the LineItemCount from highest to lowest
*/

SELECT 	g.AccountDescription,
		[LineItemCount] = COUNT(*),
		[LineItemSum] = SUM(InvoiceLineItemAmount)
FROM GLAccounts g
	JOIN InvoiceLineItems ili ON g.AccountNo = ili.AccountNo
GROUP BY AccountDescription
HAVING COUNT(*) > 3
ORDER BY LineItemCount DESC


/********************************************************************************* Q8: 22 Records
	NOTE: This question can be done in a couple of ways.  You know one way.

	From the InvoiceLineItems table return the sum of each AccountNo. 
	In this query you are to include a single row that has the value of NULL for 
	the AccountNo and the total for all rows
*/

SELECT 	AccountNo,
		[TotalInvoiceLineItemAmount] = SUM(InvoiceLineItemAmount)
FROM InvoiceLineItems
GROUP BY AccountNo WITH ROLLUP