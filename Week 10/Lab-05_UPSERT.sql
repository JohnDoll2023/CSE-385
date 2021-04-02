DROP TABLE IF EXISTS Employees;
DROP TABLE IF EXISTS EmployeeUpdates;


CREATE table Employees (
	id			INT				PRIMARY KEY		IDENTITY,
	age			INT,
	first_name	VARCHAR(50),
	last_name	VARCHAR(50),
	email		VARCHAR(50),
	gender		VARCHAR(50),
	ip_address	VARCHAR(20),
	lastChanged datetime NOT NULL DEFAULT(GETDATE())
);

SET IDENTITY_INSERT Employees ON
	INSERT INTO Employees (id, age, first_name, last_name, email, gender, ip_address) VALUES 
		 (1, 22, 'Cindelyn', 'Hunton', 'chunton0@jugem.jp', 'Male', '249.115.217.218')
		,(2, 28, 'Valeda', 'Frarey', 'vfrarey1@51.la', 'Non-binary', '254.130.193.22')
		,(3, 25, 'Aurie', 'Sainer', 'asainer2@google.cn', 'Agender', '74.219.216.205')
		,(4, 29, 'Marion', 'Cella', 'mcella3@macromedia.com', 'Female', '127.73.126.77')
		,(5, 21, 'Lil', 'Gilks', 'lgilks4@typepad.com', 'Genderfluid', '188.38.246.139')
		,(6, 20, 'Madelin', 'McLachlan', 'mmclachlan5@mozilla.com', 'Agender', '23.243.108.110')		
		,(7, 17, 'Barnie', 'MacGeffen', 'bmacgeffen6@free.fr', 'Agender', '127.202.123.186')
		,(8, 24, 'Jorge', 'Halfhead', 'jhalfhead7@hostgator.com', 'Polygender', '71.226.172.10')
		,(9, 29, 'Barbette', 'Klima', 'bklima8@printfriendly.com', 'Bigender', '56.229.92.245')
		,(10, 11, 'Herb', 'Parnell', 'hparnell9@whitehouse.gov', 'Female', '164.165.125.170')
		,(11, 22, 'Bryon', 'Swann', 'bswanna@lycos.com', 'Polygender', '68.69.78.51')
		,(12, 14, 'Becky', 'Pietersen', 'bpietersenb@is.gd', 'Genderqueer', '251.204.45.49')
		,(13, 22, 'Rachelle', 'Grave', 'rgravec@statcounter.com', 'Polygender', '9.45.87.89')
		,(14, 28, 'Welch', 'Foss', 'wfossd@ihg.com', 'Female', '18.238.182.222')
		,(15, 21, 'Jeanette', 'Blewmen', 'jblewmene@posterous.com', 'Agender', '24.174.255.155')
		,(16, 27, 'Kizzie', 'Ceillier', 'kceillierf@amazon.de', 'Agender', '103.215.79.84')
		,(17, 24, 'Shamus', 'Kibel', 'skibelg@independent.co.uk', 'Genderfluid', '199.122.108.43')
		,(18, 20, 'Nancie', 'Crewes', 'ncrewesh@tinypic.com', 'Bigender', '106.91.140.101')
		,(19, 29, 'Trudy', 'Lambricht', 'tlambrichti@blogtalkradio.com', 'Genderqueer', '150.132.23.151')
		,(20, 28, 'Cristie', 'Venable', 'cvenablej@baidu.com', 'Genderfluid', '158.205.125.79')
		,(21, 24, 'Lacy', 'Howlings', 'lhowlingsk@yale.edu', 'Female', '190.238.61.127')
		,(22, 22, 'Saunder', 'Shoute', 'sshoutel@google.com', 'Bigender', '68.253.180.70')
		,(23, 24, 'Joe', 'Minear', 'jminearm@reddit.com', 'Male', '82.223.234.111')
		,(24, 21, 'Alphonso', 'Sara', 'asaran@thetimes.co.uk', 'Bigender', '40.197.254.191')
		,(25, 26, 'Lance', 'Duer', 'lduero@gravatar.com', 'Non-binary', '94.135.23.214')
SET IDENTITY_INSERT Employees OFF



--========================================================= Now for the daily changes 
CREATE table EmployeeUpdates (
	id			INT				IDENTITY,
	age			INT,
	first_name	VARCHAR(50),
	last_name	VARCHAR(50),
	email		VARCHAR(50),
	gender		VARCHAR(50),
	ip_address	VARCHAR(20)
);


SET IDENTITY_INSERT EmployeeUpdates ON
	INSERT INTO EmployeeUpdates (id, age, first_name, last_name, email, gender, ip_address) VALUES 
		 (1, 22, 'Cindelyn', 'Hunton', 'chunton0@jugem.jp', 'Male', '249.115.217.218')
		,(7, 17, 'Barnie', 'MacGeffen', 'bmacgeffen6@free.fr', 'Agender', '127.202.123.186')
		,(8, 24, 'Jorge', 'Halfhead', 'jhalfhead7@hostgator.com', 'Polygender', '71.226.172.10')
		,(9, 29, 'Barbette', 'Klima', 'bklima8@printfriendly.com', 'Bigender', '56.229.92.245')
		,(11, 22, 'Bryon', 'Swann', 'bswanna@lycos.com', 'Polygender', '68.69.78.51')
		,(12, 14, 'Becky', 'Pietersen', 'bpietersenb@is.gd', 'Genderqueer', '251.204.45.49')
		,(13, 22, 'Rachelle', 'Grave', 'rgravec@statcounter.com', 'Polygender', '9.45.87.89')
		,(14, 28, 'Welch', 'Foss', 'wfossd@ihg.com', 'Female', '18.238.182.222')
		,(15, 21, 'Jeanette', 'Blewmen', 'jblewmene@posterous.com', 'Agender', '24.174.255.155')
		,(16, 27, 'Kizzie', 'Ceillier', 'kceillierf@amazon.de', 'Agender', '103.215.79.84')
		,(24, 21, 'Alphonso', 'Sara', 'asaran@thetimes.co.uk', 'Bigender', '40.197.254.191')
		,(25, 28, 'Lance', 'Duer', 'lduero@gravatar.com', 'Non-binary', '94.135.23.214')
		,(26, 24, 'Claribel', 'Dady', 'cdady0@prlog.org', 'Non-binary', '61.143.130.23')
		,(27, 25, 'Hammad', 'Heritege', 'hheritege1@yolasite.com', 'Non-binary', '41.148.183.117')
		,(28, 27, 'Delmore', 'O''Feeny', 'dofeeny2@google.com', 'Genderfluid', '203.128.203.12')
		,(29, 22, 'Pascale', 'Richings', 'prichings3@paypal.com', 'Agender', '86.237.201.219')
		,(30, 24, 'Tyler', 'Redit', 'tredit4@squidoo.com', 'Agender', '96.214.209.55')
		,(31, 31, 'Zarla', 'Ismay', 'zismay5@youtu.be', 'Genderfluid', '76.149.156.82')
		,(32, 28, 'Georgina', 'Whitington', 'gwhitington6@blogtalkradio.com', 'Male', '115.187.126.120')
		,(33, 29, 'Shari', 'Romao', 'sromao7@globo.com', 'Bigender', '14.125.99.21')
		,(34, 37, 'Antonie', 'MacDonough', 'amacdonough8@tinypic.com', 'Female', '50.188.124.245')
		,(35, 20, 'Tiphani', 'Putley', 'tputley9@mapquest.com', 'Non-binary', '162.161.254.83')
		,(36, 25, 'Sandye', 'Keays', 'skeaysa@mac.com', 'Polygender', '251.184.216.74')
		,(37, 23, 'Gaby', 'Giorgio', 'ggiorgiob@uiuc.edu', 'Male', '37.85.189.88')
		,(38, 33, 'Trudi', 'Oughtright', 'toughtrightc@feedburner.com', 'Bigender', '49.231.92.177')
		,(39, 32, 'Lorie', 'Doxsey', 'ldoxseyd@behance.net', 'Agender', '158.70.143.57')
		,(40, 61, 'Alard', 'Simants', 'asimantse@google.com.br', 'Genderfluid', '193.197.54.83')
		,(2, 28, 'Valeda', 'Frarey', 'vfrarey1@51.la', 'Non-binary', '76.149.156.22')						-- 76.149.156.22
		,(3, 25, 'Aurie', 'Sainer', 'asainer2@google.cn', 'Male', '74.219.216.205')							-- Male
		,(4, 30, 'Marion', 'Peters', 'mpeters@gmail.com', 'Female', '127.73.126.77')						-- 30, Peters, mpeters@gmail.com
		,(5, 21, 'Lilly', 'Gilks', 'lgilks4@typepad.com', 'Genderfluid', '188.38.246.139')					-- Lilly
		,(6, 21, 'Maddie', 'Barz', 'barzmj@google.com', 'Agender', '23.243.108.110')						-- 21, Maddie, barzmj@google.com
		,(10, 11, 'Herb', 'Parnell', 'hparnell9@gmail.com', 'Female', '164.165.125.170')
SET IDENTITY_INSERT EmployeeUpdates OFF
		
/*
	Create the UPSERT (MERGE).			--updates as source, employees as target
	Rule: Don't update a record for anyone under 20
*/

SET IDENTITY_INSERT Employees ON
	MERGE Employees	e				--TARGET
	USING EmployeeUpdates eu		--SOURCE
	ON e.id = eu.id					--SAY HOW RELATED
	WHEN MATCHED AND e.age >= 20 THEN
		UPDATE SET
                e.age = eu.age,
				e.first_name = eu.first_name,
				e.last_name = eu.last_name,
				e.email = eu.email,
				e.gender = eu.gender,
				e.ip_address = eu.ip_address,
				e.lastChanged = GETDATE()
        WHEN NOT MATCHED BY SOURCE THEN 
            DELETE
        WHEN NOT MATCHED BY TARGET THEN 
            INSERT(id, age, first_name, last_name, email, gender, ip_address)
            VALUES(eu.id, eu.age, eu.first_name, eu.last_name, eu.email, eu.gender, eu.ip_address);
SET IDENTITY_INSERT Employees OFF