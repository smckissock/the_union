USE Senate
GO

EXEC DropView 'StoryForAppView'
GO

CREATE VIEW StoryForAppView 
AS  
SELECT 
	dbs.ID,
	a.Name,
	a.ID AppID,
	a.ShortName slug  
FROM MediaCloudBatch mcb
JOIN MediaCloudStory mcs ON mcb.ID = MediaCloudBatchID
JOIN DiffBotStory dbs ON dbs.MediaCloudStoryID = mcs.ID 
JOIN App a ON a.Name = mcb.Term 
--WHERE mcb.Term = 'Mark Warner'


