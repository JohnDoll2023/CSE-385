BEGIN TRAN

   -- What does the data look like first
   SELECT 'Before', VendorID, VendorPhone, VendorContactFName, VendorContactLName FROM Vendors WHERE VendorID IN (7, 13)
   
   /*
	The possible Vendor fields mapped to the XML are listed below:
			
	VendorID		=> vid
	VendorName		=> name
	VendorAddress1		=> add1
	VendorAddress2		=> add2
	VendorCity		=> city
	VendorState		=> state
	VendorZipCode		=> zip
	VendorPhone		=> phone
	VendorContactLName	=> ln
	VendorContactFName	=> fn
	DefaultTermsID		=> termId
	DefaultAccountNo	=> accId
   */

   DECLARE @xml	AS XML = 
		'
			<Changes>
				<Update   vid = "7"   phone = "(916) 555-1234" />
				<Update   vid = "13"  fn = "Jack"   ln = "Box" />
			</Changes>
		'
        
   -- Write your code here
        UPDATE Vendors
		SET
			VendorName			= ISNULL(parent.value('@name', 'varchar(50)'), VendorName),
			VendorAddress1		= ISNULL(parent.value('@add1', 'varchar(50)'), VendorAddress1),
			VendorAddress2		= ISNULL(parent.value('@add2', 'varchar(50)'), VendorAddress2),
			VendorCity			= ISNULL(parent.value('@city', 'varchar(50)'), VendorCity),
			VendorState			= ISNULL(parent.value('@state', 'varchar(2)'), VendorState),
			VendorZipCode		= ISNULL(parent.value('@zip', 'varchar(20)'), VendorZipCode),
			VendorPhone			= ISNULL(parent.value('@phone', 'varchar(50)'), VendorPhone),
			VendorContactLName	= ISNULL(parent.value('@ln', 'varchar(50)'), VendorContactLName),
			VendorContactFName	= ISNULL(parent.value('@fn', 'varchar(50)'), VendorContactFName),
			DefaultTermsID		= ISNULL(parent.value('@termId', 'int'), DefaultTermsID),
			DefaultAccountNo	= ISNULL(parent.value('@accId', 'int'), DefaultAccountNo)
		FROM @xml.nodes('/Changes/Update') Parent(parent)
		WHERE VendorID = parent.value('@vid', 'int')


        
        
   -- Test that changes were made
   SELECT 'After', VendorID, VendorPhone, VendorContactFName, VendorContactLName FROM Vendors WHERE VendorID IN (7, 13)
        
ROLLBACK TRAN  