USE RussiaNews
GO


EXEC DropView 'StoryView'
GO
CREATE VIEW StoryView
AS
SELECT
	db.ID,	
	db.MediaOutletID, 
	CASE 
		WHEN mc.PublishDate <> '1900-01-01' THEN mc.PublishDate
		WHEN mc.PublishDate = '1900-01-01' THEN db.EstimatedDate
		ELSE '' END Date
FROM DiffBotStory db
LEFT JOIN MediaCloudStory mc ON db.MediaCloudStoryID = mc.ID
GO


EXEC DropView 'StoryForTermView'
GO
CREATE VIEW StoryForTermView
AS
SELECT 
	se.EntityID
	, se.StoryID 
	, s.MediaOutletID MediaID
	, s.Date
	, e.Slug
FROM StoryEntity se
JOIN StoryView s ON s.ID = se.StoryID
JOIN EntityView e ON e.ID = se.EntityID
WHERE EntityID IN (SELECT ID FROM EntitiesWithStoriesView) -- 102114
GO



EXEC DropView 'StoryForTermWithLinksView'
GO

CREATE VIEW StoryForTermWithLinksView
AS

WITH LinkedStories AS (
	SELECT 
		l.FromID
		, l.ToID StoryID
		, s.MediaOutletID MediaID
		, s.Date
	FROM DiffBotLink l
	JOIN StoryView s ON l.ToID = s.ID
) 
SELECT 
	st.EntityID
	, l.StoryID 
	, l.MediaID
	, l.Date
	, st.Slug
FROM StoryForTermView st
JOIN LinkedStories l ON st.StoryID = l.FromID
GO


EXEC DropView 'AllStoriesForTermView'
GO

CREATE VIEW AllStoriesForTermView 
AS
SELECT DISTINCT EntityID, StoryID, MediaID, Date, Slug
FROM (
	SELECT * FROM StoryForTermView
	UNION ALL
	SELECT * FROM StoryForTermWithLinksView
) a


