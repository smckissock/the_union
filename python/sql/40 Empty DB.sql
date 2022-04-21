USE Congress
GO


-- Delete existing data to make a new database for congress

SELECT COUNT(*) From MediaCloudStory

SELECT Count(*) FROM DiffBotStory



-- Ran these
DELETE FROM DiffBotStoryLink
DELETE FROM DiffBotLink
DELETE FROM Sentence

DELETE FROM StoryEntity
DELETE FROM SearchTerm
DELETE FROM Entity

DELETE FROM NewspaperStory
DELETE FROM DiffBotStory
DELETE FROM MediaCloudStory

DELETE FROM DiffBotBatch
DELETE FROM MediaCloudBatch

DELETE FROM PipelineError 

DELETE FROM DiffBotTag




-- This record must be there
SET IDENTITY_INSERT dbo.DiffBotBatch ON;  

INSERT INTO DiffBotBatch (ID, StartTime, CompletedTime, PagesAttempted, PagesCompleted, Name, FindEntitiesDate) 
VALUES (1, null, null, 0, 0, 'None', null)

SET IDENTITY_INSERT dbo.DiffBotBatch OFF;



-- Backup
 BACKUP DATABASE Congress
 TO DISK = N'd:\Congress\Congress_Empty.bak' WITH NOFORMAT, NOINIT, NAME = N'Full Database Backup', SKIP, NOREWIND, NOUNLOAD, STATS = 10
 GO

 

RESTORE FILELISTONLY
FROM DISK = N'd:\Congress\Congress_Empty.bak'
GO


----Restore  (not run)
RESTORE DATABASE Congress**
FROM DISK = N'd:\Congress\Congress_Empty.bak'
WITH MOVE 'RussiaNews' TO 'C:\TrumpDb\RussiaNews2.mdf',
MOVE 'RussiaNews_log' TO 'C:\TrumpDb\RussiaNews2_ldf.mdf'



