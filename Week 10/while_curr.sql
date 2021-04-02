/*

		Table variables
		while
		cursors
		while loop and cursor work together, cursor is like pointer
*/
/*
	@@Fetch_status possible values:
	
	0 = successful fetch
   -1 = fetch failed or row was beyond result set
   -2 = row fetched is missing	
*/

---------------------------------------------------------Example 1
	DECLARE @Employees TABLE (				--cant put identity on variable on variable table
		empId		int			primary key,
		empName		varchar(30),
		salary		int,
		city		varchar(30)
	)

	INSERT INTO @Employees(empId, empName, salary, city) VALUES
		(1, 'mohan', 12000, 'Oxford'),
		(2, 'Pavan', 25000, 'Cincinnati'),
		(3, 'Amit',  22000,	'Hamilton'),
		(4, 'Sonu',  22000, 'Rockland'),
		(5, 'Deepak', 28000, 'Middletown')

---------------------------------------------------------------Actual cursor code
	DECLARE curr CURSOR STATIC FOR
		SELECT empId, empName, salary
		FROM @Employees

	DECLARE @empId int, @empName varchar(30), @salary int

	OPEN curr

	IF(@@CURSOR_ROWS > 0) BEGIN

		FETCH FROM curr INTO @empId, @empName, @salary
		WHILE(@@FETCH_STATUS = 0) BEGIN
			PRINT CONCAT('ID: ', @empId, ' NAME: ', @empName, ' SALARY: ', @salary)
			FETCH FROM curr INTO @empId, @empName, @salary
		END

	END

	-----------------------CLEAN YOUR ROOM
	CLOSE curr
	DEALLOCATE curr
	DELETE @Employees

	GO
	
----------------------------------------------------------Example 2
	DECLARE curr CURSOR STATIC FOR
		SELECT[parameter] = CONCAT(LOWER(TABLE_NAME), '_', COLUMN_NAME), 
			  [dataType] = DATA_TYPE
		FROM INFORMATION_SCHEMA.COLUMNS
		--char must be length of 7, takes up all 7 spots even if value is ess than 7
	DECLARE @parameter varchar(50), @dataType char(7)

	OPEN curr

	FETCH FROM curr INTO @parameter, @dataType
	WHILE(@@FETCH_STATUS = 0) BEGIN
		SET @dataType = CASE
							WHEN @dataType IN ('int', 'smallint', 'bigint') THEN 'int'
							WHEN @dataType IN ('money', 'float')			THEN 'double'
							WHEN @dataType = 'bit'							THEN 'boolean'
							WHEN @dataType LIKE '%data%'					THEN 'Date'
							ELSE												 'String'
						END
		PRINT CONCAT(@dataType, ' ', @parameter)
		FETCH FROM curr INTO @parameter, @dataType
	END
	CLOSE curr
	DEALLOCATE curr