USE [Senate_2019_04_25]
GO

ALTER VIEW DiffBotBatchView
AS


SELECT 
	Batch, StartTime, CompletedTime, RunTime, 
	SUM(PagesAttempted) PagesAttempted,
	SUM(PagesCompleted) PagesCompleted,
	SUM(Stories) Stories,
	FindEntitiesDate
FROM (

SELECT 
	b.Name Batch 
	, StartTime
	, CompletedTime
	, RIGHT('0' + CAST(DATEPART(HOUR, CompletedTime - StartTime) AS VARCHAR), 2) + ':' +
		RIGHT('0' + CAST(DATEPART(MINUTE, CompletedTime - StartTime) AS VARCHAR), 2) + ':' +
		RIGHT('0' + CAST(DATEPART(SECOND, CompletedTime - StartTime) AS VARCHAR), 2) RunTime
	, PagesAttempted
	, PagesCompleted
	, Count(s.ID) Stories
	, b.FindEntitiesDate
FROM DiffBotBatch b 
LEFT JOIN DiffBotStory s ON s.DiffBotBatchID = b.ID
GROUP BY 
	b.Name
	, StartTime
	, CompletedTime
	, PagesAttempted
	, PagesCompleted
	, b.FindEntitiesDate
HAVING b.Name <> 'None'	 

UNION ALL

SELECT 
	'Total', NULL, NULL, NULL, SUM(PagesAttempted), SUM(PagesCompleted), 0, NULL 
FROM DiffBotBatch b 
UNION ALL
SELECT 'Total', NULL, NULL, NULL, 0, 0, COUNT(*), NULL 
FROM DiffBotStory

) a
GROUP BY 
	Batch, 
	StartTime, 
	CompletedTime, 
	RunTime,
	FindEntitiesDate 

	 


SELECT * FROM DiffBotBatchView