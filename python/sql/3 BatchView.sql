USE RussiaNews
GO



EXEC DropView 'BatchView'
GO

CREATE VIEW BatchView
AS
SELECT 
	b.ID, 
	b.Name,
	b.PagesAttempted,
	b.PagesCompleted,
	COUNT(*) Stories 
FROM DiffBotBatch b
LEFT JOIN DiffBotStory s ON b.ID = s.DiffBotBatchID 
GROUP BY 
	b.ID, 
	b.Name,
	b.PagesAttempted,
	b.PagesCompleted
HAVING b.ID <> 1

SELECT * FROM BatchView