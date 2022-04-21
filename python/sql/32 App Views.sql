USE [RussiaNews]
GO

EXEC DropView 'AppTermView'
GO

CREATE VIEW [dbo].[AppTermView] AS

SELECT 
	t.ID TermID,
	t.Name TermName,
	a.ShortName App,
	a.ID AppID 
FROM App a
JOIN AppTerm at ON a.ID = at.AppID
JOIN Term t ON at.TermID = t.ID
GO



EXEC DropView 'AppStoryView'
GO

CREATE VIEW AppStoryView
AS
SELECT  
	at.AppID
	, at.App
	, at.TermID
	, TermName
	, ds.ID DiffBotStoryID
FROM AppTermView at
JOIN MediaCloudBatch mcb ON mcb.TermID = at.TermID
JOIN MediaCloudStory mcs ON mcs.MediaCloudBatchID = mcb.ID
JOIN DiffbotStory ds ON ds.MediaCloudStoryID = mcs.ID 




EXEC DropView 'EntitiesWithStoriesView'
GO

CREATE VIEW [dbo].[EntitiesWithStoriesView]
AS
 
--WITH EntityCounts AS (
--	SELECT EntityID, COUNT(*) num 
--	FROM StoryEntity
--	GROUP BY EntityID
--)
--SELECT 
--	e.ID
--	, e.Name
--	, e.Type 
--	, c.num Stories
--	, e.Slug
--FROM EntityView e
--JOIN EntityCounts c ON c.EntityID = e.ID  
--WHERE e.Valid = 1 
--AND c.Num < 3000  
--AND c.Num > 4
--GO -- 12056


WITH EntityCounts AS (
	SELECT EntityID, AppID, COUNT(*) num 
	FROM StoryEntity
	JOIN AppStoryView ON AppStoryView.DiffBotStoryID = StoryEntity.StoryID
	GROUP BY EntityID, AppID
)
SELECT 
	e.ID
	, e.Name
	, e.Type 
	, c.num Stories
	, e.Slug
	, c.AppID
FROM EntityView e
JOIN EntityCounts c ON c.EntityID = e.ID  
WHERE e.Valid = 1 
AND c.Num < 3000  
AND c.Num > 4 -- 15539 




-- Fine for now
--CREATE VIEW [dbo].[MediaOutletView]
--AS
--SELECT 
--	m.ID
--	, m.Name 
--	, ISNULL(br.Name, 'Unspecified') BiasRating
--	, CASE ISNULL(br.Name, 'Unspecified') 
--		WHEN 'Left' THEN 0
--		WHEN 'Center Left' THEN 1
--		WHEN 'Unspecified' THEN 2
--		WHEN 'Mixed' THEN 3 
--		WHEN 'Center' THEN 4
--		WHEN 'Center Right' THEN 5 
--		WHEN 'Right' THEN 6
--		ELSE 7 END Sort
--FROM MediaOutlet m
--LEFT JOIN MediaOutletBiasRating mb ON m.ID = mb.MediaOutletID
--LEFT JOIN BiasRating br ON mb.BiasRatingID = br.ID
--GO




-- ALTER TABLE EventType ADD AppID INT NOT NULL REFERENCES App(ID) DEFAULT 1

EXEC DropView 'EventView'
GO

CREATE VIEW [dbo].[EventView]
AS
SELECT 
	e.ID,
	t.AppID,
	e.Name,
	t.Name EventType,
	t.Ordering,
	e.Description,
	CONVERT(VARCHAR, e.Date, 23) Date	
FROM Event e
JOIN EventType t ON e.EventTypeID = t.ID 
GO


-- Below not done
EXEC DropView 'StoryForTermView'
GO
CREATE VIEW [dbo].[StoryForTermView]
AS
--SELECT 
--	se.EntityID
--	, se.StoryID 
--	, s.MediaOutletID MediaID
--	, s.Date
--	, e.Slug
--FROM StoryEntity se
--JOIN StoryView s ON s.ID = se.StoryID
--JOIN EntityView e ON e.ID = se.EntityID
--WHERE EntityID IN (SELECT ID FROM EntitiesWithStoriesView) -- 877,633

SELECT DISTINCT
	se.EntityID
	, es.AppID
	, se.StoryID 
	, s.MediaOutletID MediaID
	, s.Date
	, e.Slug
FROM StoryEntity se
JOIN StoryView s ON s.ID = se.StoryID
JOIN EntityView e ON e.ID = se.EntityID
JOIN EntitiesWithStoriesView es ON EntityID = es.ID  
GO



EXEC DropView 'StoryForTermWithLinksView'
GO
CREATE VIEW StoryForTermWithLinksView AS

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
	, st.AppID
	, l.StoryID 
	, l.MediaID
	, l.Date
	, st.Slug
FROM StoryForTermView st
JOIN LinkedStories l ON st.StoryID = l.FromID
GO



EXEC DropView 'AllStoriesForTermView'
GO
CREATE VIEW [dbo].[AllStoriesForTermView] 
AS
SELECT DISTINCT AppID, EntityID, StoryID, MediaID, Date, Slug
FROM (
	SELECT * FROM StoryForTermView
	UNION ALL
	SELECT * FROM StoryForTermWithLinksView
) a
WHERE (Date <> '') 
AND (Date > '2014-12-31') 
AND (MediaID <> 1) -- Major problem - there are a lot of these
GO



SELECT * FROM AllStoriesForTermView WHERe AppID = 6 ORDER BY EntityID, Date




SELECT * FROM AllStoriesForTermView WHERE AppID = 6




SELECT AppID, Count(*)  FROM AllStoriesForTermView 
GROUp BY AppID ORDER By Count(*) DESC

WHERE AppID = 6



SELECT * FROM App WHERe ID IN (
1
,6
,7
,8
,9
,11
,22
,23)
