/*
UNION

[STATUS]:       Warning, Send Collection Notice, Cancel Account, Paid
if Balance      1-99     100 - 500               > 500           0
Balance
InvoiceNumber

ORDER BY VendorID
*/

USE AP
-- CTE = Common Table Expression
GO

WITH tbl AS (
    SELECT  [STATUS] = 'Warning',
            Balance,
            InvoiceNumber
    FROM vwInvoices
    WHERE Balance BETWEEN 1 AND 99 --inclusive 
UNION
    SELECT  [STATUS] = 'Send Collection Notice',
            Balance,
            InvoiceNumber
    FROM vwInvoices
    WHERE Balance BETWEEN 100 AND 500 --inclusive 
UNION
    SELECT  [STATUS] = 'Cancel Account',
            Balance,
            InvoiceNumber
    FROM vwInvoices
    WHERE Balance > 500
UNION
    SELECT  [STATUS] = 'Paid',
            Balance,
            InvoiceNumber
    FROM vwInvoices
    WHERE Balance = 0
)


SELECT *
FROM tbl
    JOIN vwInvoices i   ON tbl.InvoiceNumber = i.InvoiceNumber
    JOIN Vendors v      ON i.VendorID = v.VendorID
--ORDER BY Status -- was with query before added CTE, could be lined up here or tabbed over one on last query, can order by only vars given so status, balance and iNumber



-- return list of every vendor and number of invocies they ahve
    SELECT  VendorName,
            [InvoiceCount] = COUNT(i.InvoiceID) --COUNT(*) not correct because it counts null
    FROM Vendors v 
        LEFT JOIN Invoices i ON v.VendorID = i.VendorID
    GROUP BY VendorName
    ORDER BY InvoiceCount DESC


USE Examples
    SELECT  CustomerFirst,
            CustomerLast
    FROM Customers c 
EXCEPT 
    SELECT  FirstName,
            LastName
    FROM Employees e --only one customer is employee so one less row

--returns the one person who is customer and employee
GO
WITH tbl AS (
    SELECT  CustomerFirst,
            CustomerLast
    FROM Customers
INTERSECT
    SELECT  FirstName,
            LastName
    FROM Employees e
)

SELECT e.*
FROM tbl JOIN Employees e ON tbl.CustomerFirst = e.FirstName AND 
                             tbl.CustomerLast  = e.LastName

    SELECT EmployeeID, LastName FROM Employees
UNION ALL
    SELECT EmployeeID, LastName FROM Employees