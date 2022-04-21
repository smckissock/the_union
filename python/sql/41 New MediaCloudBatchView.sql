USE Congress
GO

EXEC DropView 'MediaCloudBatchView'
GO
CREATE VIEW [dbo].[MediaCloudBatchView] 
AS

SELECT 
	b.ID, 
	b.Term,
	c.Name Collection,
	COUNT(*) Stories	 
FROM MediaCloudBatch b
JOIN MediaCloudStory s ON s.MediaCloudBatchID = b.ID
JOIN MediaCloudCollection c ON b.MediaCloudCollectionID = c.ID
GROUP BY b.ID, b.Term, c.Name 
