SELECT *,
	   [Balance] = (InvoiceTotal - PaymentTotal - CreditTotal)
FROM Invoices
WHERE isDeleted = 0 AND (InvoiceTotal - PaymentTotal - CreditTotal) > 0 --can't just write balance since not property

SELECT *
FROM vwInvoices --gets rid of deleted for us
WHERE Balance > 0