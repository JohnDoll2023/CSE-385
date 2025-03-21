DROP TABLE IF EXISTS #Users;
GO

CREATE TABLE #Users (
	userId			INT				PRIMARY KEY		IDENTITY,
	fName			VARCHAR(30),
	lName			VARCHAR(30),
	departmentId	INT,
	badgeId			INT
)

DECLARE @xml	AS XML = 
		'
			<Data>
				<Add did="5">
					<user uid = "1"		fn = "Tom"		ln = "Ryan"			bid = "224" />
					<user uid = "2"		fn = "Cindy"	ln = "Waters"		bid = "412" />
					<user uid = "3"		fn = "Woody"	ln = "Woodpecker"	bid = "118" />
				</Add>

				<Add did="6">
					<user uid = "4"		fn = "Nin"		ln = "BoBina"		bid = "312" />
					<user uid = "5"		fn = "Bob"		ln = "Evans"		bid = "643" />
					<user uid = "6"		fn = "Rick"		ln = "Finder"		bid = "285" />
				</Add>

				<Update uid = "5">
					<field did = "10" />
					<field bid = "772" />
				</Update>

				<UpdateV2 uid = "1" 	fn = "Tommy" />
				<UpdateV2 uid = "4"		fn = "Nina"		bid = "999" />

				<Delete uid = "2" />
				<Delete uid = "5" />
				<Delete uid = "6" />
			</Data>
		'
		
--------------------------------------------------------------------- Add
	SET IDENTITY_INSERT #Users ON
	--------------------------------------------------------------------
	INSERT INTO #Users (userId, fName, lName, departmentId, badgeId)
		VALUES (100, 'Jack', 'Ryan', 10, 118)
	--------------------------------------------------------------------
		INSERT INTO #Users (userId, fName, lName, departmentId, badgeId)
			SELECT uid, ufn, uln, did, bid
			FROM (
				SELECT 	[uid] = child.value('@uid','int'),
						[ufn] = child.value('@fn','varchar(30)'),
						[uln] = child.value('@ln','varchar(30)'),
						[did] = parent.value('@did','int'),
						[bid] = child.value('@bid','int')
				FROM @xml.nodes('Data/Add') Parent(parent)
					CROSS APPLY parent.nodes('user') Child(child)
			) tbl
			WHERE NOT EXISTS(SELECT NULL FROM #Users WHERE badgeId = tbl.bid) 
	SET IDENTITY_INSERT #Users OFF

	SELECT * FROM #Users

--------------------------------------------------------------------- Update with a parent


--------------------------------------------------------------------- Update with attributes


--------------------------------------------------------------------- Delete


-------------------- Delete the temp table	
DROP TABLE #Users
