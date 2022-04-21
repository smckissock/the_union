USE [RussiaNews]
GO


EXEC DropView 'AllStoriesForTermView'
GO

CREATE VIEW [dbo].[AllStoriesForTermView] 
AS
SELECT DISTINCT EntityID, StoryID, MediaID, Date, Slug
FROM (
	SELECT * FROM StoryForTermView
	UNION ALL
	SELECT * FROM StoryForTermWithLinksView
) a
WHERE (Date <> '') 
AND (Date > '2014-12-31') 
AND (MediaID <> 1) -- Major problem - there are a lot of these
GO


