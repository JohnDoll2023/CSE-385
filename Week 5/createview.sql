/*
CREATE VIEW [dbo].[vwVendorInvoiceTotals]
AS
    SELECT  v.VendorID,
            [InvoiceTotals] = SUM(i.InvoiceTotal)
    FROM Vendors v
        JOIN Invoices i ON v.VendorID = i.VendorID
    GROUP BY v.VendorID
can only run query once
*/

GO
SELECT  v.*,
        vi.InvoiceTotals
FROM Vendors v
    LEFT JOIN vwVendorInvoiceTotals vi ON v.VendorID = vi.VendorID