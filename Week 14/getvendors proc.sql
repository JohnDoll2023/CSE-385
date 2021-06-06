create proc spGetInvoices	@vendorID INTas begin	set nocount on;	select * from invoices where (vendorID = @vendorID) order by InvoiceNumberend
