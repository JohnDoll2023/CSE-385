-- return vendorstate, #of vendors in that state
/*
/*
SELECT	VendorState,
		COUNT(*) AS NumOfVendorsInState
FROM Vendors
GROUP BY VendorState
*/
/*
AZ	CA	CT	DC	FL ...
3	75	...
pivot_wider from R
*/


DECLARE @cols VARCHAR(MAX), @query VARCHAR(MAX)
SET @cols = (
	SELECT STUFF((SELECT CONCAT(',', QUOTENAME(VendorState)) FROM Vendors GROUP BY VendorState FOR XML PATH('')), 1, 1, '')
)
PRINT @cols

--(SELECT ',' + VendOrState FROM Vendors GROUP BY VendorState FOR XML PATH(''))

SET @query = CONCAT(
	'SELECT * ',
	'FROM (SELECT VendorState, COUNT(*) AS NumOfVendorsInState ',
	'FROM Vendors GROUP BY VendorState) q PIVOT (',
	'MAX(NumOfVendorsInState) FOR VendorState IN (', @cols, ')) X'
) 
EXEC(@query)

/*
PIVOT (
	MAX(NumOfVendorsInState) FOR VendorState IN (	
			[AZ], [CA], [CT], [DC], [FL], [IA], [IL], [KS], [MA], [MI], [MN],
			[MO], [NC], [NJ], [NV], [NY], [OH], [PA], [TN], [TX], [VA], [WI] )
) X
*/



SELECT ',' + VendOrState FROM Vendors GROUP BY VendorState FOR XML PATH('')
*/

/*
DECLARE @db VARCHAR(20) = 'AP'

SELECT	[Drive] = SUBSTRING(physical_name, 1, 3),
		[GB]	= (8.0 * SUM(size))/1024/1024,
		[Files] = COUNT(*)
FROM sys.master_files
WHERE database_id = (SELECT database_id FROM sys.master_files WHERE name = @db)
GROUP BY SUBSTRING(physical_name, 1, 3)
*/





