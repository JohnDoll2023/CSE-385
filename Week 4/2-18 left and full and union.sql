/*
	2021-02-18
	Chapter 4 Joining
*/

USE AP

-----------------------------------------------------------LEFT JOIN (ALL)
/*
	SELECT v.VendorName, i.InvoiceNumber, i.Balance
	FROM Vendors v
		LEFT JOIN vwInvoices i ON v.VendorID = i.VendorID
	WHERE i.InvoiceNumber IS NULL

	-- checks that no vendorID's are null
	SELECT v.VendorName, i.InvoiceNumber, i.Balance
	FROM vwInvoices i
		LEFT JOIN Vendors v ON v.VendorID = i.VendorID
	WHERE v.VendorID IS NULL
*/
--------------------------------------------------------------RIGHT JOIN - try to avoid
/* Gives everything from vwInvoices with matched values from Vendors
	SELECT v.VendorName, i.InvoiceNumber, i.Balance
	FROM Vendors v
		RIGHT JOIN vwInvoices i ON v.VendorID = i.VendorID
	WHERE v.VendorID IS NULL
*/

/*
	--will tell us if there are invoicelineitems that dont go to an invoice
	SELECT i.InvoiceID, ili.InvoiceLineItemDescription
	FROM InvoiceLineItems ili
		LEFT JOIN Invoices i ON i.InvoiceID = ili.InvoiceID
	WHERE i.InvoiceID IS NULL; --important that this i and not ili, ili never null since it is the table being pulled from

	SELECT cu.*, v.VendorID
	FROM ContactUpdates cu
		LEFT JOIN Vendors v ON cu.VendorID = v.VendorID
	WHERE v.VendorID is NULL
*/

USE Examples
/*
	--department name, dept #, last name of employee
	SELECT d.DeptName, d.DeptNo, e.LastName
	FROM Departments d
		LEFT JOIN Employees e ON d.DeptNo = e.DeptNo --if just JOIN, null deptnames gone, if LEFT JOIN, then nulls shown, if change to RIGHT, then we get all employees and missing depts show up null
		--use FULL JOIN to get everything from both tables, this will give all depts and all employees
	--WHERE e.EmployeeID IS NULL
	ORDER BY d.DeptName, e.LastName
*/

/*
	--return list of departments and thier employees as well as projects theyre on
	SELECT d.DeptName, p.ProjectNo, e.LastName
	FROM Departments d
		JOIN Employees e ON d.DeptNo = e.DeptNo
		JOIN Projects p ON p.EmployeeID = e.EmployeeID
	ORDER BY d.DeptName
*/

/*
	--same as last query but take in all depts and employees without excluding nulls, just adding LEFT
	SELECT d.DeptName, p.ProjectNo, e.LastName
	FROM Departments d
		LEFT JOIN Employees e ON d.DeptNo = e.DeptNo
		LEFT JOIN Projects p ON p.EmployeeID = e.EmployeeID
	ORDER BY d.DeptName
*/

/*
	SELECT	d.DeptName, 
			e.LastName,	
			p.ProjectNo, 
			[empEID] = e.EmployeeID, 
			[proEID] = p.EmployeeID --can see that there is a project employee id 10 assigned to a project that is not in employee table
	FROM Departments d
		FULL JOIN Employees e ON d.DeptNo = e.DeptNo
		FULL JOIN Projects p ON p.EmployeeID = e.EmployeeID
*/

-------------------------------CROSS JOIN, these 2 equivalent
/*
	SELECT d.deptNo, d.DeptName
	FROM Departments d, Employees e
	ORDER BY d.DeptNo

	SELECT d.deptNo, d.DeptName
	FROM Departments d CROSS JOIN Employees e
	ORDER BY d.DeptNo
*/


USE AP


	SELECT	[status] = 'Warning', --status not needed
			i.InvoiceNumber, 
			i.Balance
	FROM vwInvoices i
	WHERE i.Balance BETWEEN 1 AND 99
UNION
	SELECT	[status] = 'Send Collection Notice', --status not needed
			i.InvoiceNumber, 
			i.Balance
	FROM vwInvoices i
	WHERE i.Balance BETWEEN 100 AND 500
UNION
	SELECT	[status] = 'Cancel Account', --status not needed
			i.InvoiceNumber, 
			i.Balance
	FROM vwInvoices i
	WHERE i.Balance > 500
UNION
	SELECT	[status] = 'Paid', --status not needed
			i.InvoiceNumber, 
			i.Balance
	FROM vwInvoices i
	WHERE i.Balance = 0