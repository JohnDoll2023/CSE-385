ALTER proc spGetVendors	@state char(2)as begin	set nocount on;	select * from vendors where (Vendorstate = @state) or (@state = '') order by VendorNameend
