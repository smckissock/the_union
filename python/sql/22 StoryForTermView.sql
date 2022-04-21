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
		WHEN mc.PublishDate <> '1900-01-01' THEN SUBSTRING(mc.PublishDate, 1, 10) -- Media Cloud date is best
		WHEN mc.PublishDate = '1900-01-01' AND db.EstimatedDate <> '' THEN dbo.FormatDiffBotDate(db.EstimatedDate) -- Use DiffBot  
		ELSE dbo.FormatNewspaperDate(ns.Date) END Date -- Finally try to use newspaper
FROM DiffBotStory db
LEFT JOIN MediaCloudStory mc ON db.MediaCloudStoryID = mc.ID
LEFT JOIN NewspaperStory ns ON ns.DiffBotStoryID = db.ID
GO


-- SELECT * FROM StoryView WHERE Date = ''   -- Down to 1063 missing dates out of 49000



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
GO



EXEC DropView 'MissingDateView'
GO 
CREATE VIEW MissingDateView
AS
SELECT 
	s.MediaOutletID, 
	m.name MediaOutlet,
	Count(*) NoDates
FROM DiffBotStory s 
JOIN MediaOutlet m ON s.MediaOutletID = m.ID 
WHERE Date = '' 
GROUP BY MediaOutletID , m.name -- WashingtonPost 2612, Bloomberg 1412
--ORDER BY Count(*) DESC



