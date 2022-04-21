USE RussiaNews
GO

EXEC DropView 'RecordCountView'
GO

CREATE VIEW RecordCountView
AS

SELECT 'MediaCloudBatch' Tbl, COUNT(*) Count FROM MediaCloudBatch
UNION ALL 
SELECT 'MediaCloudBotStory', COUNT(*) FROM MediaCloudStory 
UNION ALL
SELECT 'DiffBotBatch', COUNT(*) FROM DiffBotBatch
UNION ALL 
SELECT 'DiffBotStory', COUNT(*) FROM DiffBotStory
UNION ALL 
SELECT 'DiffBotStoryLink', COUNT(*) FROM DiffBotStoryLink


SELECT * FROM RecordCountView


--UPDATE DiffBotBatch SET StartTime = NULL WHERE ID IN (2, 3, 12 ,14, 21, 26, 28)