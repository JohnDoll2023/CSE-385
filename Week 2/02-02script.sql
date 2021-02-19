-- C.R.U.D. 

-- CREATE (INSERT)
/**
	INSERT INTO tblFriends (firstName, lastName, age, phoneNumber, address)
	VALUES ('Tom', 'Ryan', 25, '123-456-7890', 'Oxford, OH')

	INSERT INTO tblFriends (firstName, lastName, age, phoneNumber, address)
	VALUES ('Jack', 'Ryan', 35, '000-000-0000', 'New York, NY')

	SET IDENTITY_INSERT tblFriends ON
	
		INSERT INTO tblFriends (friendId, firstName, lastName, age, phoneNumber, address)
		VALUES (467, 'Paul', 'Brick',45, '000-000-0000', 'New York, NY')

	SET IDENTITY_INSERT tblFriends OFF

	SELECT * FROM tblFriends

	-- =============================================================================



-- READ
	-- New School Version of Naming
	SELECT firstName + ' ' + lastName AS fullName, 
		   age						  AS friendAge
	FROM tblFriends

	-- Old School Version of Naming
	SELECT [fullName] = firstName + ' ' + lastName, 
		   [friendAge] = age 
	FROM tblFriends
	WHERE [address] = 'New York, NY'

-- UPDATE
	
	select [car] = [year] + ', ' + make + ' ' + model --year is integer and make and model are strings and it can't convert integer to string
	from tblCars

	select [year],
		   [car] = make + ' ' + model
	from tblCars

	UPDATE tblCars
	SET	   make = 'HONDA', [year] = [year] + 1
	WHERE  make = 'HoNda'

	select * from tblCars where make = 'honda'

	UPDATE tblCars
	SET	   make = 'Honda', [year] = [year] - 1
	WHERE  make = 'HoNda'

	select * from tblCars where make = 'honda'

-- DELETE
	SELECT * FROM tblFriends

	DELETE
	FROM tblFriends
	WHERE friendId > 10

	SELECT * FROM tblFriends
*/