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

--INSERT INTO MediaCloudCollection VALUES ('38381386', 'New Jersey, United States - State & Local')
--INSERT INTO MediaCloudCollection VALUES ('38381336', 'Delaware, United States - State & Local')
--INSERT INTO MediaCloudCollection VALUES ('38381334', 'Illinois, United States - State & Local')
--INSERT INTO MediaCloudCollection VALUES ('38381313', 'Alabama, United States - State & Local')
--INSERT INTO MediaCloudCollection VALUES ('38381372', 'Massachusetts, United States - State & Local')
--INSERT INTO MediaCloudCollection VALUES ('38381398', 'Oregon, United States - State & Local')
--INSERT INTO MediaCloudCollection VALUES ('38381374', 'Michigan, United States - State & Local')
--INSERT INTO MediaCloudCollection VALUES ('38381400', 'Rhode Island, United States - State & Local')
--INSERT INTO MediaCloudCollection VALUES ('38381382', 'New Hampshire, United States - State & Local')
--INSERT INTO MediaCloudCollection VALUES ('38379771', 'Minnesota, United States - State & Local')
--INSERT INTO MediaCloudCollection VALUES ('38381388', 'New Mexico, United States - State & Local')
--INSERT INTO MediaCloudCollection VALUES ('38381404', 'Virginia, United States - State & Local')



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



-- Insert batches for Senators
DECLARE @Senator varchar(200)
--SET @Senator = 'Jeff Merkley'
--SET @Senator = 'Tom Udall'
--SET @Senator = 'Tina Smith'
--SET @Senator = 'Jeanne Shaheen'
--SET @Senator = 'Jack Reed'
--SET @Senator = 'Gary Peters'
--SET @Senator = 'Edward Markey'
--SET @Senator = 'Richard Durbin'
SET @Senator = 'Christopher Coons'
--SET @Senator = 'Tim Kaine'
--SET @Senator = 'Jennifer Wexton'
--SET @Senator = 'Don Beyer'

INSERT INTO MediaCloudBatch
SELECT @Senator, '2015-01-01', '2019-05-09', NULL, 1, (SELECT ID FROM Term WHERE Name = @Senator) 

INSERT INTO MediaCloudBatch
SELECT @Senator, '2015-01-01', '2019-05-09', NULL, (SELECT MediaCloudCollectionID FROM AppTermMediaCloudCollectionView WHERE Term = @Senator AND MediaCloudCollectionID <> 1), 
(SELECT ID FROM Term WHERE Name = @Senator) 


SELECT * FROM MediaCloudBatch
SELECT * FROM DiffBotBatch





SELECT * FROM Term WHERE Name LIKE '%Don Beyer%'
SELECT * FROM Term WHERE Name Like 'Jennifer Wexton'

SELECT * FROM App WHERE Name Like '%Wex%'

SELECT * FROM App

INSERT INTO App VALUES ('Jennifer Wexton', 'jennifer-wexton', 3, '2015-01-01')
INSERT INTO App VALUES ('Don Beyer', 'don-beyer', 3, '2015-01-01')

INSERT INTO AppTerm 
SELECT (SELECT ID FROM App WHERE Name = 'Don Beyer'), (SELECT ID FROM Term WHERE Name = 'Don Beyer')  

INSERT INTO AppTerm 
SELECT (SELECT ID FROM App WHERE Name = 'Jennifer Wexton'), (SELECT ID FROM Term WHERE Name = 'Jennifer Wexton') 

UPDATE MediaCloudBatch SET EndDate = NULL WHERE Term = 'Mark Warner'



SELECT * FROM AppMediaCloudCollection

INSERT INTO AppMediaCloudCollection 
SELECT 38, 1
INSERT INTO AppMediaCloudCollection 
SELECT 38, 14

INSERT INTO AppMediaCloudCollection 
SELECT 39, 1
INSERT INTO AppMediaCloudCollection 
SELECT 39, 14 


SELECT * FROM MediaCloudCollection

SELECT * FROM App

SELECT * FROM AppMediaCloudCollectionValues


SELECT * FROM AppTermMediaCloudCollectionView WHERE MediaCloudCollection


SELECT * FROm MediaCloudBatch



UPDATE MediaCloudBatch SET RunTime = NULL WHERE Term IN ('Tom Udall', 'Jeff Merkley', 'Tina Smith')


UPDATE MediaCloudBatch SET Runtime  = null where ID IN (1159, 1160, 1161, 1162, 1163) 


DELETE FROM MediaClOUDStory WHERE DiffBotBatchID > 731
DELETE FROM MediaCloudBatch WHERE ID > 731


SELECT DiffBotBatchID, Count(*) FROM MediaCloudStory GROUP BY DiffBotBatchID ORDER BY DiffBotBatchID



SELECT Count(*) FROM DiffBotStory 



UPDATE MediaCloudBatch SET RunTime = NULL 



SELECT * FROM MediaCloudBatch
SELECT * FROM DiffBotBatch




SELECT Firstname, LastName, State FROM Senate WHERE party = 'D' AND Class <> 'Class II' ORDER BY State


