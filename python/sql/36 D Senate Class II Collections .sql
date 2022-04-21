--SELECT * FROM Senate WHERE Class = 'Class II' AND Party = 'D' 

--Booker, Cory A. (D-NJ)
--Coons, Christopher A. (D-DE)
--Durbin, Richard J. (D-IL)
--Jones, Doug (D-AL)
--Markey, Edward J. (D-MA)
--Merkley, Jeff (D-OR)
--Peters, Gary C. (D-MI)
--Reed, Jack (D-RI)
--Shaheen, Jeanne (D-NH)
--Smith, Tina (D-MN)
--Udall, Tom (D-NM)
--Warner, Mark R. (D-VA)


SELECT * FROM MediaCloudCollection

INSERT INTO MediaCloudCollection VALUES ('38381386', 'New Jersey, United States - State & Local')
INSERT INTO MediaCloudCollection VALUES ('38381336', 'Delaware, United States - State & Local')
INSERT INTO MediaCloudCollection VALUES ('38381334', 'Illinois, United States - State & Local')
INSERT INTO MediaCloudCollection VALUES ('38381313', 'Alabama, United States - State & Local')
INSERT INTO MediaCloudCollection VALUES ('38381372', 'Massachusetts, United States - State & Local')
INSERT INTO MediaCloudCollection VALUES ('38381398', 'Oregon, United States - State & Local')
INSERT INTO MediaCloudCollection VALUES ('38381374', 'Michigan, United States - State & Local')
INSERT INTO MediaCloudCollection VALUES ('38381400', 'Rhode Island, United States - State & Local')
INSERT INTO MediaCloudCollection VALUES ('38381382', 'New Hampshire, United States - State & Local')
INSERT INTO MediaCloudCollection VALUES ('38379771', 'Minnesota, United States - State & Local')
INSERT INTO MediaCloudCollection VALUES ('38381388', 'New Mexico, United States - State & Local')
INSERT INTO MediaCloudCollection VALUES ('38381404', 'Virginia, United States - State & Local')

INSERT INTO MediaCloudCollection VALUES ('38380550', 'California, United States - State & Local')
INSERT INTO MediaCloudCollection VALUES ('38381331', 'Connecticut, United States - State & Local')
INSERT INTO MediaCloudCollection VALUES ('38381347', 'Hawaii, United States - State & Local')
INSERT INTO MediaCloudCollection VALUES ('38381338', 'Maryland, United States - State & Local')
INSERT INTO MediaCloudCollection VALUES ('38381353', 'Washington, United States - State & Local')
INSERT INTO MediaCloudCollection VALUES ('38381325', 'Nevada, United States - State & Local')

INSERT INTO AppMediaCloudCollection VALUES ((SELECT ID FROM App WHERE ShortName = 'dianne-feinstein'), (SELECT ID FROM MediaCloudCollection WHERE Name = 'California, United States - State & Local'))

INSERT INTO AppMediaCloudCollection VALUES ((SELECT ID FROM App WHERE ShortName = 'kamala-harris'), (SELECT ID FROM MediaCloudCollection WHERE Name = 'California, United States - State & Local'))
INSERT INTO AppMediaCloudCollection VALUES ((SELECT ID FROM App WHERE ShortName = 'richard-blumenthal'), (SELECT ID FROM MediaCloudCollection WHERE Name = 'Connecticut, United States - State & Local'))
INSERT INTO AppMediaCloudCollection VALUES ((SELECT ID FROM App WHERE ShortName = 'christopher-murphy'), (SELECT ID FROM MediaCloudCollection WHERE Name = 'Connecticut, United States - State & Local'))
INSERT INTO AppMediaCloudCollection VALUES ((SELECT ID FROM App WHERE ShortName = 'thomas-carper'), (SELECT ID FROM MediaCloudCollection WHERE Name = 'Delaware, United States - State & Local'))
INSERT INTO AppMediaCloudCollection VALUES ((SELECT ID FROM App WHERE ShortName = 'mazie-hirono'), (SELECT ID FROM MediaCloudCollection WHERE Name = 'Hawaii, United States - State & Local'))
INSERT INTO AppMediaCloudCollection VALUES ((SELECT ID FROM App WHERE ShortName = 'brian-schatz'), (SELECT ID FROM MediaCloudCollection WHERE Name = 'Hawaii, United States - State & Local'))
INSERT INTO AppMediaCloudCollection VALUES ((SELECT ID FROM App WHERE ShortName = 'tammy-duckworth'), (SELECT ID FROM MediaCloudCollection WHERE Name = 'Illinois, United States - State & Local'))
INSERT INTO AppMediaCloudCollection VALUES ((SELECT ID FROM App WHERE ShortName = 'chris-van-hollen'), (SELECT ID FROM MediaCloudCollection WHERE Name = 'Maryland, United States - State & Local'))
INSERT INTO AppMediaCloudCollection VALUES ((SELECT ID FROM App WHERE ShortName = 'benjamin-cardin'), (SELECT ID FROM MediaCloudCollection WHERE Name = 'Maryland, United States - State & Local'))
INSERT INTO AppMediaCloudCollection VALUES ((SELECT ID FROM App WHERE ShortName = 'debbie-stabenow'), (SELECT ID FROM MediaCloudCollection WHERE Name = 'Michigan, United States - State & Local'))
INSERT INTO AppMediaCloudCollection VALUES ((SELECT ID FROM App WHERE ShortName = 'margaret-wood-hassan'), (SELECT ID FROM MediaCloudCollection WHERE Name = 'New Hampshire, United States - State & Local'))
INSERT INTO AppMediaCloudCollection VALUES ((SELECT ID FROM App WHERE ShortName = 'martin-heinrich'), (SELECT ID FROM MediaCloudCollection WHERE Name = 'New Mexico, United States - State & Local'))
INSERT INTO AppMediaCloudCollection VALUES ((SELECT ID FROM App WHERE ShortName = 'catherine-cortez-masto'), (SELECT ID FROM MediaCloudCollection WHERE Name = 'Nevada, United States - State & Local'))
INSERT INTO AppMediaCloudCollection VALUES ((SELECT ID FROM App WHERE ShortName = 'jacky-rosen'), (SELECT ID FROM MediaCloudCollection WHERE Name = 'Nevada, United States - State & Local'))
INSERT INTO AppMediaCloudCollection VALUES ((SELECT ID FROM App WHERE ShortName = 'ron-wyden'), (SELECT ID FROM MediaCloudCollection WHERE Name = 'Oregon, United States - State & Local'))
INSERT INTO AppMediaCloudCollection VALUES ((SELECT ID FROM App WHERE ShortName = 'sheldon-whitehouse'), (SELECT ID FROM MediaCloudCollection WHERE Name = 'Rhode Island, United States - State & Local'))
INSERT INTO AppMediaCloudCollection VALUES ((SELECT ID FROM App WHERE ShortName = 'maria-cantwell'), (SELECT ID FROM MediaCloudCollection WHERE Name = 'Washington, United States - State & Local'))
INSERT INTO AppMediaCloudCollection VALUES ((SELECT ID FROM App WHERE ShortName = 'patty-murray'), (SELECT ID FROM MediaCloudCollection WHERE Name = 'Washington, United States - State & Local'))



*Dianne	Feinstein	CA
*Kamala D.	Harris	CA
*Richard	Blumenthal	CT
*Christopher	Murphy	CT
*Thomas R.	Carper	DE
*Mazie K.	Hirono	HI
*Brian	Schatz	HI
*Tammy	Duckworth	IL
*Chris Van Hollen	MD
*Benjamin Cardin	MD
*Debbie	Stabenow	MI
*Margaret Wood Hassan	NH
*Martin	Heinrich	NM
*Catherine Cortez Masto	NV
*Jacky Rosen	NV
*Ron Wyden	OR
*Sheldon Whitehouse	RI
*Maria Cantwell	WA
*Patty Murray	WA




INSERT INTO App VALUES ('Dianne	Feinstein', 'dianne-feinstein', 2, '2015-01-01')
INSERT INTO App VALUES ('Kamala Harris', 'kamala-harris', 2, '2015-01-01')
INSERT INTO App VALUES ('Richard Blumenthal', 'richard-blumenthal', 2, '2015-01-01')
INSERT INTO App VALUES ('Christopher Murphy', 'christopher-murphy', 2, '2015-01-01')
INSERT INTO App VALUES ('Thomas Carper', 'thomas-carper', 2, '2015-01-01')
INSERT INTO App VALUES ('Mazie Hirono', 'mazie-hirono', 2, '2015-01-01')
INSERT INTO App VALUES ('Brian Schatz', 'brian-schatz', 2, '2015-01-01')
INSERT INTO App VALUES ('Tammy Duckworth', 'tammy-duckworth', 2, '2015-01-01')
INSERT INTO App VALUES ('Chris Van Hollen', 'chris-van-hollen', 2, '2015-01-01')
INSERT INTO App VALUES ('Benjamin Cardin', 'benjamin-cardin', 2, '2015-01-01')
INSERT INTO App VALUES ('Debbie	Stabenow', 'debbie-stabenow', 2, '2015-01-01')
INSERT INTO App VALUES ('Margaret Wood Hassan', 'margaret-wood-hassan', 2, '2015-01-01')
INSERT INTO App VALUES ('Martin	Heinrich', 'martin-heinrich', 2, '2015-01-01')
INSERT INTO App VALUES ('Catherine Cortez Masto', 'catherine-cortez-masto', 2, '2015-01-01')
INSERT INTO App VALUES ('Jacky Rosen', 'jacky-rosen', 2, '2015-01-01')
INSERT INTO App VALUES ('Ron Wyden', 'ron-wyden', 2, '2015-01-01')
INSERT INTO App VALUES ('Sheldon Whitehouse', 'sheldon-whitehouse', 2, '2015-01-01')
INSERT INTO App VALUES ('Maria Cantwell', 'maria-cantwell', 2, '2015-01-01')
INSERT INTO App VALUES ('Patty Murray', 'patty-murray', 2, '2015-01-01')

INSERT INTO AppMediaCloudCollection VALUES ((SELECT ID FROM App WHERE ShortName = 'dianne-feinstein'), (SELECT ID FROM MediaCloudCollection WHERE Name = 'U.S. Top Online News 2017'))
INSERT INTO AppMediaCloudCollection VALUES ((SELECT ID FROM App WHERE ShortName = 'kamala-harris'), (SELECT ID FROM MediaCloudCollection WHERE Name = 'U.S. Top Online News 2017'))
INSERT INTO AppMediaCloudCollection VALUES ((SELECT ID FROM App WHERE ShortName = 'richard-blumenthal'), (SELECT ID FROM MediaCloudCollection WHERE Name = 'U.S. Top Online News 2017'))
INSERT INTO AppMediaCloudCollection VALUES ((SELECT ID FROM App WHERE ShortName = 'christopher-murphy'), (SELECT ID FROM MediaCloudCollection WHERE Name = 'U.S. Top Online News 2017'))
INSERT INTO AppMediaCloudCollection VALUES ((SELECT ID FROM App WHERE ShortName = 'thomas-carper'), (SELECT ID FROM MediaCloudCollection WHERE Name = 'U.S. Top Online News 2017'))
INSERT INTO AppMediaCloudCollection VALUES ((SELECT ID FROM App WHERE ShortName = 'mazie-hirono'), (SELECT ID FROM MediaCloudCollection WHERE Name = 'U.S. Top Online News 2017'))
INSERT INTO AppMediaCloudCollection VALUES ((SELECT ID FROM App WHERE ShortName = 'brian-schatz'), (SELECT ID FROM MediaCloudCollection WHERE Name = 'U.S. Top Online News 2017'))
INSERT INTO AppMediaCloudCollection VALUES ((SELECT ID FROM App WHERE ShortName = 'tammy-duckworth'), (SELECT ID FROM MediaCloudCollection WHERE Name = 'U.S. Top Online News 2017'))
INSERT INTO AppMediaCloudCollection VALUES ((SELECT ID FROM App WHERE ShortName = 'chris-van-hollen'), (SELECT ID FROM MediaCloudCollection WHERE Name = 'U.S. Top Online News 2017'))
INSERT INTO AppMediaCloudCollection VALUES ((SELECT ID FROM App WHERE ShortName = 'benjamin-cardin'), (SELECT ID FROM MediaCloudCollection WHERE Name = 'U.S. Top Online News 2017'))
INSERT INTO AppMediaCloudCollection VALUES ((SELECT ID FROM App WHERE ShortName = 'debbie-stabenow'), (SELECT ID FROM MediaCloudCollection WHERE Name = 'U.S. Top Online News 2017'))
INSERT INTO AppMediaCloudCollection VALUES ((SELECT ID FROM App WHERE ShortName = 'margaret-wood-hassan'), (SELECT ID FROM MediaCloudCollection WHERE Name = 'U.S. Top Online News 2017'))
INSERT INTO AppMediaCloudCollection VALUES ((SELECT ID FROM App WHERE ShortName = 'martin-heinrich'), (SELECT ID FROM MediaCloudCollection WHERE Name = 'U.S. Top Online News 2017'))
INSERT INTO AppMediaCloudCollection VALUES ((SELECT ID FROM App WHERE ShortName = 'catherine-cortez-masto'), (SELECT ID FROM MediaCloudCollection WHERE Name = 'U.S. Top Online News 2017'))
INSERT INTO AppMediaCloudCollection VALUES ((SELECT ID FROM App WHERE ShortName = 'jacky-rosen'), (SELECT ID FROM MediaCloudCollection WHERE Name = 'U.S. Top Online News 2017'))
INSERT INTO AppMediaCloudCollection VALUES ((SELECT ID FROM App WHERE ShortName = 'ron-wyden'), (SELECT ID FROM MediaCloudCollection WHERE Name = 'U.S. Top Online News 2017'))
INSERT INTO AppMediaCloudCollection VALUES ((SELECT ID FROM App WHERE ShortName = 'sheldon-whitehouse'), (SELECT ID FROM MediaCloudCollection WHERE Name = 'U.S. Top Online News 2017'))
INSERT INTO AppMediaCloudCollection VALUES ((SELECT ID FROM App WHERE ShortName = 'maria-cantwell'), (SELECT ID FROM MediaCloudCollection WHERE Name = 'U.S. Top Online News 2017'))
INSERT INTO AppMediaCloudCollection VALUES ((SELECT ID FROM App WHERE ShortName = 'patty-murray'), (SELECT ID FROM MediaCloudCollection WHERE Name = 'U.S. Top Online News 2017'))


SELECT * FROM Term

INSERT INTO Term
SELECT Name, 1 FROM App WHERe ID > 39 AND NAME NOT IN (SELECT Name FROM Term) 

SELECT * FROM MediaCloudBatch

INSERT INTO MediaCloudBatch
SELECT Name, '2015-01-01', '2019-05-09', NULL, 3, (SELECT ID FROM Term WHERE Name = app.Name)
FROM App WHERE ID > 39


INSERT INTO 

SELECT * FROM MediaCloudCollection


SELECT * fROM AppTerm

INSERT INTO AppTerm
SELECT ID, (SELECT ID FROM Term WHERE Name = app.Name)
FROM App WHERE ID > 39

SELECT * FROM App WHERE ID = 54	
SELECT * FROM Term WHERE ID =1076

*Dianne	Feinstein	CA
*Kamala D.	Harris	CA
*Richard	Blumenthal	CT
*Christopher	Murphy	CT
*Thomas R.	Carper	DE
*Mazie K.	Hirono	HI
*Brian	Schatz	HI
*Tammy	Duckworth	IL
*Chris Van Hollen	MD
*Benjamin Cardin	MD
*Debbie	Stabenow	MI
*Margaret Wood Hassan	NH
*Martin	Heinrich	NM
*Catherine Cortez Masto	NV
*Jacky Rosen	NV
*Ron Wyden	OR
*Sheldon Whitehouse	RI
*Maria Cantwell	WA
*Patty Murray	WA

SELECT * FROM MediaCloudBatch 
SELECT ID, Name FROM App WHERe ID > 39 




INSERT INTO AppMediaCloudCollection VALUES ((SELECT ID FROM App WHERE ShortName = 'cory-booker'), (SELECT ID FROM MediaCloudCollection WHERE Name = 'U.S. Top Online News 2017'))
INSERT INTO AppMediaCloudCollection VALUES ((SELECT ID FROM App WHERE ShortName = 'christopher-coons'), (SELECT ID FROM MediaCloudCollection WHERE Name = 'U.S. Top Online News 2017'))
INSERT INTO AppMediaCloudCollection VALUES ((SELECT ID FROM App WHERE ShortName = 'richard-durbin'), (SELECT ID FROM MediaCloudCollection WHERE Name = 'U.S. Top Online News 2017'))
INSERT INTO AppMediaCloudCollection VALUES ((SELECT ID FROM App WHERE ShortName = 'doug-jones'), (SELECT ID FROM MediaCloudCollection WHERE Name = 'U.S. Top Online News 2017'))
INSERT INTO AppMediaCloudCollection VALUES ((SELECT ID FROM App WHERE ShortName = 'edward-markey'), (SELECT ID FROM MediaCloudCollection WHERE Name = 'U.S. Top Online News 2017'))
INSERT INTO AppMediaCloudCollection VALUES ((SELECT ID FROM App WHERE ShortName = 'jeff-merkley'), (SELECT ID FROM MediaCloudCollection WHERE Name = 'U.S. Top Online News 2017'))
INSERT INTO AppMediaCloudCollection VALUES ((SELECT ID FROM App WHERE ShortName = 'gary-peters'), (SELECT ID FROM MediaCloudCollection WHERE Name = 'U.S. Top Online News 2017'))
INSERT INTO AppMediaCloudCollection VALUES ((SELECT ID FROM App WHERE ShortName = 'jack-reed'), (SELECT ID FROM MediaCloudCollection WHERE Name = 'U.S. Top Online News 2017'))
INSERT INTO AppMediaCloudCollection VALUES ((SELECT ID FROM App WHERE ShortName = 'jeanne-shaheen'), (SELECT ID FROM MediaCloudCollection WHERE Name = 'U.S. Top Online News 2017'))
INSERT INTO AppMediaCloudCollection VALUES ((SELECT ID FROM App WHERE ShortName = 'tina-smith'), (SELECT ID FROM MediaCloudCollection WHERE Name = 'U.S. Top Online News 2017'))
INSERT INTO AppMediaCloudCollection VALUES ((SELECT ID FROM App WHERE ShortName = 'tom-udall'), (SELECT ID FROM MediaCloudCollection WHERE Name = 'U.S. Top Online News 2017'))
INSERT INTO AppMediaCloudCollection VALUES ((SELECT ID FROM App WHERE ShortName = 'mark-warner'), (SELECT ID FROM MediaCloudCollection WHERE Name = 'U.S. Top Online News 2017'))


SELECT * FROM App


INSERT INTO AppMediaCloudCollection 
SELECT (SELECT ID FROM App WHERE Name = 'Senate'), ID 
FROM MediaCloudCollection WHERE ID > 1

UPDATE DiffBotBatch SET MediaCloudCollectionID = (SELECT ID FROM MediaCloudCollection WHERe Name = ', United States - State & Local' ) WHERE ID = 1201	-- Benjamin Cardin
1202	Brian Schatz
1203	Catherine Cortez Masto
1204	Chris Van Hollen
1205	Christopher Murphy
1206	Debbie Stabenow
1207	Dianne Feinstein
1208	Jacky Rosen
1209	Kamala Harris
1210	Margaret Wood Hassan
1211	Maria Cantwell
1212	Martin Heinrich
1213	Mazie Hirono
1214	Patty Murray
1215	Richard Blumenthal
1216	Ron Wyden
1217	Sheldon Whitehouse
1218	Tammy Duckworth
1219	Thomas Carper

SELECT * FROM MediaCloudCollection

SELECT * FROM MediaCloudBatch
SELECT 'INSERT INTO MediaCloudBatch VALUES (''' + name  + ''', ''2015-01-01'', ''2019-05-09'', NULL, ,' + CONVERT(varchar(10), ID) + ')'
FROM Term WHERE Name IN (
'Brian Schatz'
,'Catherine Cortez Masto'
,'Chris Van Hollen'
,'Christopher Murphy'
,'Debbie Stabenow'
,'Dianne Feinstein'
,'Jacky Rosen'
,'Kamala Harris'
,'Margaret Wood Hassan'
,'Maria Cantwell'
,'Martin Heinrich'
,'Mazie Hirono'
,'Patty Murray'
,'Richard Blumenthal'
,'Ron Wyden'
,'Sheldon Whitehouse'
,'Tammy Duckworth'
,'Thomas Carper')




SELECT * fROM 


*Dianne	Feinstein	CA
*Kamala D.	Harris	CA
*Richard	Blumenthal	CT
*Christopher	Murphy	CT
*Thomas R.	Carper	DE
*Mazie K.	Hirono	HI
*Brian	Schatz	HI
*Tammy	Duckworth	IL
*Chris Van Hollen	MD
*Benjamin Cardin	MD
*Debbie	Stabenow	MI
*Margaret Wood Hassan	NH
*Martin	Heinrich	NM
*Catherine Cortez Masto	NV
*Jacky Rosen	NV
*Ron Wyden	OR
*Sheldon Whitehouse	RI
*Maria Cantwell	WA
*Patty Murray	WA



INSERT INTO MediaCloudBatch VALUES ('Brian Schatz', '2015-01-01', '2019-05-09', NULL, (SELECT ID FROM MediaCloudCollection WHERE Name = 'Hawaii, United States - State & Local'),1081)
INSERT INTO MediaCloudBatch VALUES ('Catherine Cortez Masto', '2015-01-01', '2019-05-09', NULL, (SELECT ID FROM MediaCloudCollection WHERE Name = 'Nevada, United States - State & Local'),1024)
INSERT INTO MediaCloudBatch VALUES ('Chris Van Hollen', '2015-01-01', '2019-05-09', NULL, (SELECT ID FROM MediaCloudCollection WHERE Name = 'Maryland, United States - State & Local'),1096)
INSERT INTO MediaCloudBatch VALUES ('Christopher Murphy', '2015-01-01', '2019-05-09', NULL, (SELECT ID FROM MediaCloudCollection WHERE Name = 'Connecticut, United States - State & Local'),1066)

INSERT INTO MediaCloudBatch VALUES ('Debbie Stabenow', '2015-01-01', '2019-05-09', NULL, (SELECT ID FROM MediaCloudCollection WHERE Name = 'Michigan, United States - State & Local'),1089)
INSERT INTO MediaCloudBatch VALUES ('Dianne Feinstein', '2015-01-01', '2019-05-09', NULL, (SELECT ID FROM MediaCloudCollection WHERE Name = 'California, United States - State & Local'),1034)
INSERT INTO MediaCloudBatch VALUES ('Jacky Rosen', '2015-01-01', '2019-05-09', NULL, (SELECT ID FROM MediaCloudCollection WHERE Name = 'Nevada, United States - State & Local'),1076)
INSERT INTO MediaCloudBatch VALUES ('Kamala Harris', '2015-01-01', '2019-05-09', NULL, (SELECT ID FROM MediaCloudCollection WHERE Name = 'California, United States - State & Local'),1176)

INSERT INTO MediaCloudBatch VALUES ('Margaret Wood Hassan', '2015-01-01', '2019-05-09', NULL, (SELECT ID FROM MediaCloudCollection WHERE Name = 'New Hampshire, United States - State & Local'),1041)
INSERT INTO MediaCloudBatch VALUES ('Maria Cantwell', '2015-01-01', '2019-05-09', NULL, (SELECT ID FROM MediaCloudCollection WHERE Name = 'Washington, United States - State & Local'),1015)
INSERT INTO MediaCloudBatch VALUES ('Martin Heinrich', '2015-01-01', '2019-05-09', NULL, (SELECT ID FROM MediaCloudCollection WHERE Name = 'New Mexico, United States - State & Local'),1043)
INSERT INTO MediaCloudBatch VALUES ('Mazie Hirono', '2015-01-01', '2019-05-09', NULL, (SELECT ID FROM MediaCloudCollection WHERE Name = 'Hawaii, United States - State & Local'),1178)
INSERT INTO MediaCloudBatch VALUES ('Patty Murray', '2015-01-01', '2019-05-09', NULL, (SELECT ID FROM MediaCloudCollection WHERE Name = 'Washington, United States - State & Local'),1067)
INSERT INTO MediaCloudBatch VALUES ('Richard Blumenthal', '2015-01-01', '2019-05-09', NULL, (SELECT ID FROM MediaCloudCollection WHERE Name = 'Connecticut, United States - State & Local'),1008)

INSERT INTO MediaCloudBatch VALUES ('Ron Wyden', '2015-01-01', '2019-05-09', NULL, (SELECT ID FROM MediaCloudCollection WHERE Name = 'Oregon, United States - State & Local'),1101)
INSERT INTO MediaCloudBatch VALUES ('Sheldon Whitehouse', '2015-01-01', '2019-05-09', NULL, (SELECT ID FROM MediaCloudCollection WHERE Name = 'Rhode Island, United States - State & Local'),1099)
INSERT INTO MediaCloudBatch VALUES ('Tammy Duckworth', '2015-01-01', '2019-05-09', NULL, (SELECT ID FROM MediaCloudCollection WHERE Name = 'Illinois, United States - State & Local'),1030)
INSERT INTO MediaCloudBatch VALUES ('Thomas Carper', '2015-01-01', '2019-05-09', NULL, (SELECT ID FROM MediaCloudCollection WHERE Name = 'Delaware, United States - State & Local'),1179)


