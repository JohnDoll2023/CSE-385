/*

    -XML
    -SELECT INTO
    -MERGE
    -Dynamic TSQL

*/

--=============================================================XML
DECLARE @xml XML = 
		'
			<records>
				<users>
					<data id="22" email="tryan@gmail.com">
						<fName>Tom</fName>
						<lName>Ryan</lName>
						<phone>123-456-7890</phone>
					</data>
					<data id="35" email="bross@gmail.com">
						<fName>Bob</fName>
						<lName>Ross</lName>
						<phone>555-111-2222</phone>
					</data>
					<data id="85" email="tanderson@gmail.com">
						<fName>Tammy</fName>
						<lName>Anderson</lName>
						<phone>678-901-2345</phone>
					</data>
				</users>
			</records>
		'
        SELECT 
            [vendorID]      = rec.value('@id', 'int'),
            [vendorName]    = v.VendorName,
            [firstName]     = CAST(rec.query('fName/text()') AS VARCHAR),
            [lastName]      = CAST(rec.query('lName/text()') AS VARCHAR),
            [email]         = rec.value('@email', 'varchar(100)'),
            [phone]         = CAST(rec.query('phone/text()') AS VARCHAR)
        FROM @xml.nodes('records/users/data') Records(rec)
            JOIN Vendors v ON v.VendorID = rec.value('@id', 'int')
        ORDER BY lastName
--===============================================================SELECT INTO / MERGE

    -- SELECT INTO
    --SELECT * INTO InvoiceBackup FROM Invoices
    --SELECT InvoiceNumber, VendorID INTO InvoiceBackup FROM Invoices WHERE VendorID BETWEEN 20 AND 30
    SELECT  v.VendorName,
            v.VendorState,
            i.InvoiceNumber,
            i.InvoiceTotal
    INTO InvoiceBackup
    FROM Invoices i, Vendors v
    WHERE i.VendorID = v.VendorID

    DROP TABLE InvoiceBackup

    --MERGE and SELECT INTO
    BEGIN TRAN
        -- make backup
        SELECT * INTO TermUpdates FROM Terms

        -- add a record to TermUpdates
        INSERT INTO TermUpdates(TermsDescription, TermsDueDays)
            VALUES ('Net due 120 days', 120)

        -- mess up the terms table (simulate what the data orignally looked like)
        UPDATE Terms SET TermsDescription = NEWID(), TermsDueDays = 0
        UPDATE Terms SET TermsDueDays = 500 WHERE TermsID = 5
        INSERT INTO Terms (TermsDescription, TermsDueDays) VALUES
            ('Sample data row 1', 1000),
            ('Sample data row 2', 2000),
            ('Sample data row 3', 3000)

        SELECT 'Orig Terms Data', * FROM Terms

        SET IDENTITY_INSERT Terms ON
            
            MERGE   Terms t  --TARGET
            USING   TermUpdates tu --source
            ON t.TermsID = tu.TermsID
            WHEN MATCHED AND t.TermsDueDays < 500 THEN
                UPDATE SET
                    t.TermsDescription = tu.TermsDescription,
                    t.TermsDueDays = tu.TermsDueDays
            WHEN NOT MATCHED BY SOURCE THEN 
                DELETE
            WHEN NOT MATCHED BY TARGET THEN 
                INSERT(TermsID, TermsDescription, TermsDueDays)
                VALUES(tu.TermsID, tu.TermsDescription, tu.TermsDueDays)
                ;               ----------------------------------------------------------merge requires ;
        SET IDENTITY_INSERT Terms OFF

        SELECT 'Updated Terms Data', * FROM Terms

        --SELECT 'Change to Data', * FROM TermUpdates
    ROLLBACK TRAN


--=================================================================Dynamic SQL

    DECLARE @VendorID VARCHAR(10) = 5
    DECLARE @cmd NVARCHAR(100) = 'SELECT * FROM Vendors WHERE VendorID = @VendorID'
    DECLARE @type NVARCHAR(20) = '@VendorID INT'

    --SET @VendorID = @VendorID + ' + '
    
    --SELECT * FROM Vendors WHERE VendorID = @VendorID
    EXEC('SELECT * FROM Vendors WHERE VendorID = 5') --horrible idea
    EXEC('SELECT * FROM Vendors WHERE VendorID = ' + @VendorID) --horrible but better
    EXEC sp_executesql N'SELECT * FROM Vendors WHERE VendorID = ', N'@VendorID INT', @VendorID --better yet
    EXEC sp_executesql @cmd, @type, @VendorID --better again
