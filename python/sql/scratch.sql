USE Senate_2019_04_25
GO


-- This record must be there
SET IDENTITY_INSERT dbo.DiffBotBatch ON;  
INSERT INTO DiffBotBatch (ID, StartTime, CompletedTime, PagesAttempted, PagesCompleted, Name, FindEntitiesDate) 
VALUES (1, null, null, 0, 0, 'None', null)
SET IDENTITY_INSERT dbo.DiffBotBatch OFF;


-- Setup New Run
DELETE FROM MediaCloudStory
DELETE FROM MediaCloudBatch

DELETE FROM PipelineError
DELETE FROM PythonLog 

INSERT INTO MediaCloudBatch VALUES ('Mark Warner', '2015-01-01', '2018-12-30', '2018-12-30', 1, 1169)
INSERT INTO MediaCloudBatch VALUES ('Mark Warner', '2015-01-01', '2018-12-30', '2018-12-30', 14, 1169)
-- End Setup






SELECT * FROM DiffBotBatchView ORDER BY Batch DESC



SELECT COUNT(*) FROM DiffBotBatchView WHERE FindEntitiesDate IS NULL

SELECT Count(*) FROM DiffBotTag

SELECT ID, Name FROM DiffBotBatch WHERE (CompletedTime IS NOT NULL) AND (FindEntitiesDate IS NULL) AND (Name <> 'NONE')



SELECT * fROM PythonLog ORDER By WriteDate DESC



SELECT ID, Name FROM DiffBotBatch WHERE (CompletedTime IS NOT NULL) AND (FindEntitiesDate IS NULL) AND (Name <> 'NONE')



SELECT DiffBotStoryID, Url, HasText FROM NewspaperUrlView ORDER BY DiffBotStoryID



SELECT ID, Text FROM DiffBotStory WHERE ID NOT IN (SELECT DISTINCT DiffBotStoryID FROM Sentence) ORDER BY ID



SELECT Count(*) FROM NewspaperStory

SELECT COUNT (Distinct DiffbotStoryID) FROM Sentence