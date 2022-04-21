USE TheUnion
GO

SELECT * FROM AppType
SELECT * FROM App
SELECT * FROM Term 

INSERT INTO AppType VALUES ('The Union', 'the-union')

-- Ohio
INSERT INTO App VALUES ('Josh Mandel', 'josh-mandel', dbo.ID('AppType', 'The Union'))
INSERT INTO App VALUES ('Mike Gibbons', 'mike-gibbons', dbo.ID('AppType', 'The Union'))
INSERT INTO App VALUES ('J.D. Vance', 'j-d-vance', dbo.ID('AppType', 'The Union'))
INSERT INTO App VALUES ('Matt Dolan', 'matt-dolan', dbo.ID('AppType', 'The Union'))
INSERT INTO App VALUES ('Jane Timken', 'jane-timken', dbo.ID('AppType', 'The Union'))

-- Pensylvania
INSERT INTO App VALUES ('Kathy Barnette', 'kathy-barnette', dbo.ID('AppType', 'The Union'))
INSERT INTO App VALUES ('Jeff Bartos', 'jeff-bartos', dbo.ID('AppType', 'The Union'))
INSERT INTO App VALUES ('David McCormick', 'david-mccormick', dbo.ID('AppType', 'The Union'))
INSERT INTO App VALUES ('Mehmet Oz', 'mehmet-oz', dbo.ID('AppType', 'The Union'))
INSERT INTO App VALUES ('Carla Sands', 'carla-sands', dbo.ID('AppType', 'The Union'))

-- Terms
INSERT INTO Term VALUES ('Josh Mandel', 1)
INSERT INTO Term VALUES ('Mike Gibbons', 1)
INSERT INTO Term VALUES ('J.D. Vance', 1)
INSERT INTO Term VALUES ('Matt Dolan', 1)
INSERT INTO Term VALUES ('Jane Timken', 1)
INSERT INTO Term VALUES ('Kathy Barnette', 1)
INSERT INTO Term VALUES ('Jeff Bartos', 1)
INSERT INTO Term VALUES ('David McCormick', 1)
INSERT INTO Term VALUES ('Mehmet Oz', 1)
INSERT INTO Term VALUES ('Carla Sands', 1)


INSERT INTO AppTerm VALUES (dbo.ID('App', 'Josh Mandel'), dbo.ID('Term', 'Josh Mandel')) 

INSERT INTO AppTerm VALUES (dbo.ID('App', 'J.D. Vance'), dbo.ID('Term', 'J.D. Vance')) 




INSERT INTO MediaCloudCollection VALUES (186572515, 'U.S. Top Digital Native Sources 2018') 
INSERT INTO MediaCloudCollection VALUES (186572435, 'U.S. Top Newspapers 2018') 
INSERT INTO MediaCloudCollection VALUES (9360520, 'Left') 
INSERT INTO MediaCloudCollection VALUES (9360521, 'Center Left') 
INSERT INTO MediaCloudCollection VALUES (9360522, 'Center') 
INSERT INTO MediaCloudCollection VALUES (9360524, 'Right') 
INSERT INTO MediaCloudCollection VALUES (9360523, 'Center Right') 

SELECT * fROM AppMediaCloudCollection

--DELETE FROM AppMediaCloudCollection


INSERT INTO AppMediaCloudCollection VALUES (dbo.ID('App', 'Josh Mandel'), dbo.ID('MediaCloudCollection', 'U.S. Top Digital Native Sources 2018'))
INSERT INTO AppMediaCloudCollection VALUES (dbo.ID('App', 'Josh Mandel'), dbo.ID('MediaCloudCollection', 'U.S. Top Newspapers 2018'))
INSERT INTO AppMediaCloudCollection VALUES (dbo.ID('App', 'Josh Mandel'), dbo.ID('MediaCloudCollection', 'Left'))
INSERT INTO AppMediaCloudCollection VALUES (dbo.ID('App', 'Josh Mandel'), dbo.ID('MediaCloudCollection', 'Center Left'))
INSERT INTO AppMediaCloudCollection VALUES (dbo.ID('App', 'Josh Mandel'), dbo.ID('MediaCloudCollection', 'Center'))
INSERT INTO AppMediaCloudCollection VALUES (dbo.ID('App', 'Josh Mandel'), dbo.ID('MediaCloudCollection', 'Right'))
INSERT INTO AppMediaCloudCollection VALUES (dbo.ID('App', 'Josh Mandel'), dbo.ID('MediaCloudCollection', 'Center Right'))

INSERT INTO AppMediaCloudCollection VALUES (dbo.ID('App', 'J.D. Vance'), dbo.ID('MediaCloudCollection', 'U.S. Top Digital Native Sources 2018'))
INSERT INTO AppMediaCloudCollection VALUES (dbo.ID('App', 'J.D. Vance'), dbo.ID('MediaCloudCollection', 'U.S. Top Newspapers 2018'))
INSERT INTO AppMediaCloudCollection VALUES (dbo.ID('App', 'J.D. Vance'), dbo.ID('MediaCloudCollection', 'Left'))
INSERT INTO AppMediaCloudCollection VALUES (dbo.ID('App', 'J.D. Vance'), dbo.ID('MediaCloudCollection', 'Center Left'))
INSERT INTO AppMediaCloudCollection VALUES (dbo.ID('App', 'J.D. Vance'), dbo.ID('MediaCloudCollection', 'Center'))
INSERT INTO AppMediaCloudCollection VALUES (dbo.ID('App', 'J.D. Vance'), dbo.ID('MediaCloudCollection', 'Right'))
INSERT INTO AppMediaCloudCollection VALUES (dbo.ID('App', 'J.D. Vance'), dbo.ID('MediaCloudCollection', 'Center Right'))


INSERT INTO MediaCloudBatch VALUES ('Josh Mandel', '2022-01-01', '2022-04-17', NULL, dbo.ID('MediaCloudCollection', 'U.S. Top Digital Native Sources 2018'), dbo.ID('Term', 'Josh Mandel'))
INSERT INTO MediaCloudBatch VALUES ('Josh Mandel', '2022-01-01', '2022-04-17', NULL, dbo.ID('MediaCloudCollection', 'U.S. Top Newspapers 2018'), dbo.ID('Term', 'Josh Mandel'))
INSERT INTO MediaCloudBatch VALUES ('Josh Mandel', '2022-01-01', '2022-04-17', NULL, dbo.ID('MediaCloudCollection', 'Left'), dbo.ID('Term', 'Josh Mandel'))
INSERT INTO MediaCloudBatch VALUES ('Josh Mandel', '2022-01-01', '2022-04-17', NULL, dbo.ID('MediaCloudCollection', 'Center Left'), dbo.ID('Term', 'Josh Mandel'))
INSERT INTO MediaCloudBatch VALUES ('Josh Mandel', '2022-01-01', '2022-04-17', NULL, dbo.ID('MediaCloudCollection', 'Center'), dbo.ID('Term', 'Josh Mandel'))
INSERT INTO MediaCloudBatch VALUES ('Josh Mandel', '2022-01-01', '2022-04-17', NULL, dbo.ID('MediaCloudCollection', 'Right'), dbo.ID('Term', 'Josh Mandel'))
INSERT INTO MediaCloudBatch VALUES ('Josh Mandel', '2022-01-01', '2022-04-17', NULL, dbo.ID('MediaCloudCollection', 'Center Right'), dbo.ID('Term', 'Josh Mandel'))

INSERT INTO MediaCloudBatch VALUES ('J.D. Vance', '2022-01-01', '2022-04-17', NULL, dbo.ID('MediaCloudCollection', 'U.S. Top Digital Native Sources 2018'), dbo.ID('Term', 'J.D. Vance'))
INSERT INTO MediaCloudBatch VALUES ('J.D. Vance', '2022-01-01', '2022-04-17', NULL, dbo.ID('MediaCloudCollection', 'U.S. Top Newspapers 2018'), dbo.ID('Term', 'J.D. Vance'))
INSERT INTO MediaCloudBatch VALUES ('J.D. Vance', '2022-01-01', '2022-04-17', NULL, dbo.ID('MediaCloudCollection', 'Left'), dbo.ID('Term', 'J.D. Vance'))
INSERT INTO MediaCloudBatch VALUES ('J.D. Vance', '2022-01-01', '2022-04-17', NULL, dbo.ID('MediaCloudCollection', 'Center Left'), dbo.ID('Term', 'J.D. Vance'))
INSERT INTO MediaCloudBatch VALUES ('J.D. Vance', '2022-01-01', '2022-04-17', NULL, dbo.ID('MediaCloudCollection', 'Center'), dbo.ID('Term', 'J.D. Vance'))
INSERT INTO MediaCloudBatch VALUES ('J.D. Vance', '2022-01-01', '2022-04-17', NULL, dbo.ID('MediaCloudCollection', 'Right'), dbo.ID('Term', 'J.D. Vance'))
INSERT INTO MediaCloudBatch VALUES ('J.D. Vance', '2022-01-01', '2022-04-17', NULL, dbo.ID('MediaCloudCollection', 'Center Right'), dbo.ID('Term', 'J.D. Vance'))

SELECT * FROM MediaCloudBatch 

DELETE FROM MediaCloudBatch

---------------------------------------
--INSERT INTO AppType VALUES ('Never Trump', 'never-trump')
--INSERT INTO App VALUES ('Lincoln Project', 'lincoln-project', 4)
--INSERT INTO Term VALUES ('Lincoln Project', 1)
--INSERT INTO AppTerm VALUES ((SELECT ID FROM App WHERE Name = 'Lincoln Project'), (SELECT ID FROM Term WHERE Name = 'Lincoln Project')) 

--INSERT INTO MediaCloudCollection VALUES (186572515, 'U.S. Top Digital Native Sources 2018') 
--INSERT INTO MediaCloudCollection VALUES (186572435, 'U.S. Top Newspapers 2018') 
--INSERT INTO MediaCloudCollection VALUES (9360520, 'Left') 
--INSERT INTO MediaCloudCollection VALUES (9360521, 'Center Left') 
--INSERT INTO MediaCloudCollection VALUES (9360522, 'Center') 
--INSERT INTO MediaCloudCollection VALUES (9360524, 'Right') 
--INSERT INTO MediaCloudCollection VALUES (9360523, 'Center Right') 

--INSERT INTO AppMediaCloudCollection VALUES ((SELECT ID FROM App WHERE Name = 'Lincoln Project'), 25)
--INSERT INTO AppMediaCloudCollection VALUES ((SELECT ID FROM App WHERE Name = 'Lincoln Project'), 26)
--INSERT INTO AppMediaCloudCollection VALUES ((SELECT ID FROM App WHERE Name = 'Lincoln Project'), 27)
--INSERT INTO AppMediaCloudCollection VALUES ((SELECT ID FROM App WHERE Name = 'Lincoln Project'), 28)
--INSERT INTO AppMediaCloudCollection VALUES ((SELECT ID FROM App WHERE Name = 'Lincoln Project'), 29)
--INSERT INTO AppMediaCloudCollection VALUES ((SELECT ID FROM App WHERE Name = 'Lincoln Project'), 30)
--INSERT INTO AppMediaCloudCollection VALUES ((SELECT ID FROM App WHERE Name = 'Lincoln Project'), 31)



INSERT INTO MediaCloudBatch VALUES ('Lincoln Project', '2019-11-01', '2020-06-24', NULL, 25, (SELECT ID FROM Term WHERE Name = 'Lincoln Project'))
INSERT INTO MediaCloudBatch VALUES ('Lincoln Project', '2019-11-01', '2020-06-24', NULL, 26, (SELECT ID FROM Term WHERE Name = 'Lincoln Project'))
INSERT INTO MediaCloudBatch VALUES ('Lincoln Project', '2019-11-01', '2020-06-24', NULL, 27, (SELECT ID FROM Term WHERE Name = 'Lincoln Project'))
INSERT INTO MediaCloudBatch VALUES ('Lincoln Project', '2019-11-01', '2020-06-24', NULL, 28, (SELECT ID FROM Term WHERE Name = 'Lincoln Project'))
INSERT INTO MediaCloudBatch VALUES ('Lincoln Project', '2019-11-01', '2020-06-24', NULL, 29, (SELECT ID FROM Term WHERE Name = 'Lincoln Project'))
INSERT INTO MediaCloudBatch VALUES ('Lincoln Project', '2019-11-01', '2020-06-24', NULL, 30, (SELECT ID FROM Term WHERE Name = 'Lincoln Project'))
INSERT INTO MediaCloudBatch VALUES ('Lincoln Project', '2019-11-01', '2020-06-24', NULL, 31, (SELECT ID FROM Term WHERE Name = 'Lincoln Project'))


EXEC InsertEntityOrganization
EXEC InsertEntityPerson
EXEC InsertEntityPlace

DELETE FROM StoryEntity

EXEC InsertStoryEntityPerson
EXEC InsertStoryEntityOrganization -- Might be a problem here 
EXEC InsertStoryEntityPlace




-- Use Name
UPDATE DiffBotStory
	SET MediaOutletID = Media.MediaID
	FROM (
		SELECT DiffBotStory.ID StoryID, MediaOutlet.ID MediaID
		FROM DiffBotStory
		JOIN MediaCloudStory ON MediaCloudStory.ID = DiffBotStory.MediaCloudStoryID
		JOIN MediaOutlet ON MediaCloudStory.MediaName = MediaOutlet.Name) media  
	WHERE 
		DiffBotStory.ID = Media.StoryID
		
-- Now use URL, not name, to pick up even more!
UPDATE DiffBotStory
	SET MediaOutletID = Media.MediaID
	FROM (
		SELECT DiffBotStory.ID StoryID, MediaOutlet.ID MediaID
		FROM DiffBotStory
		JOIN MediaCloudStory ON MediaCloudStory.ID = DiffBotStory.MediaCloudStoryID
		JOIN MediaOutlet ON MediaCloudStory.MediaUrl = MediaOutlet.DomainName) media  
	WHERE 
		DiffBotStory.ID = Media.StoryID



SELECT * FROM DiffBotStory WHERe MediaOutletID = 1


SELECT * FROM MediaOutlet
-- Inserts any missing ones, but with MediaType = ''
INSERT INTO MediaOutlet
SELECT MediaName, MediaID, MediaUrl, 1, '', ''
FROM MediaCloudStory WHERE MediaID NOT IN (SELECT MediaCloudID FROM MediaOutlet)
GROUP BY MediaName, MediaID, MediaUrl



UPDATE MediaOutlet SET MediaType = 'Right' WHERE Name = 'American Thinker'



USE [TheUnion]
GO



SELECT * FROM StoryEntity

-- Might put a way to score media outlets - i.e. pick Post first..
CREATE    VIEW [dbo].[FeatureView]
AS
SELECT 
	s.DiffBotStoryID
	, s.App
	, m.Name
	, Date
	, s.MediaOutletID
FROM AppStoryView s
JOIN MediaOutlet m ON s.MediaOutletID = m.ID
WHERE m.Name IN ('Washington Post', 'New York Times', 'USA Today', 'FOX News', 'MSNBC', 'NewsMax', 'Independent', 'American Greatness', 'Huffington Post')
GO

SELECT * FROM MediaOutlet

USE [TheUnion]
GO


CREATE       VIEW [dbo].[AppStoryView]
AS
SELECT  
	ds.ID -- DiffBotStoryID
	, ds.ID DiffBotStoryID
	, at.AppID
	, at.App -- Slug
	, at.TermID
	, TermName
	, ds.Title
	, ds.Author
	
	, ds.MediaOutletID 
	, CASE 
		WHEN mc.PublishDate <> '1900-01-01' THEN SUBSTRING(mc.PublishDate, 1, 10) -- Media Cloud date is best
		WHEN mc.PublishDate = '1900-01-01' AND ds.EstimatedDate <> '' THEN dbo.FormatDiffBotDate(ds.EstimatedDate) -- Use DiffBot  
		ELSE dbo.FormatNewspaperDate(ns.Date) END Date -- Finally try to use newspaper
	
	,ds.Good
FROM AppTermView at
JOIN MediaCloudBatch mcb ON mcb.TermID = at.TermID
JOIN MediaCloudStory mcs ON mcs.MediaCloudBatchID = mcb.ID
JOIN DiffbotStory ds ON ds.MediaCloudStoryID = mcs.ID 

JOIN MediaOutlet m ON m.ID = ds.MediaOutletID
LEFT JOIN MediaCloudStory mc ON ds.MediaCloudStoryID = mc.ID
LEFT JOIN NewspaperStory ns ON ns.DiffBotStoryID = ds.ID
WHERE m.MediaType <> 'BAD'
AND ds.Good <> 0
GO

SELECT * FROM DiffBotStory

SELECT DiffBotStoryID FROM FeatureView WHERE App = 'josh-mandel' ORDER BY DATE DESC

SELECT 
	s.DiffBotStoryID
	, s.App
	--, m.Name
	, Date
	, s.MediaOutletID
FROM AppStoryView s


SELECT * FROM AppStoryView


SELECT DiffBotStoryID FROM FeatureView WHERE App = 'josh-mandel' ORDER BY DATE DESC
SELECT DiffBotStoryID FROM FeatureView WHERE App = 'J-D-Vance' ORDER BY DATE DESC



SELECT AppSlug FROM AppView WHERE AppTypeName = 'The Union' AND AppSlug IN ('josh-mandel', 'j-d-vance')


SELECT Name, ShortName FROM App WHERE ShortName IN ('josh-mandel', 'j-d-vance') ORDER BY ID

DELETE FROM PipelineError
SELECT * FROM PipelineError

SELECT * FROM PythonLog

SELECT * FROM DiffBOtbatch

TRUNCATE TABLE DiffBotBatch

SELECT * FROM FeatureView

SELECT DiffBotStoryID FROM FeatureView WHERE App = 'mike-gibbons' ORDER BY DATE DESC


SET IDENTITY_INSERT DiffBotBatch OFF
INSERT INTO DiffBotBatch (ID,
StartTime,
CompletedTime,
PagesAttempted,
PagesCompleted,
Name,
FindEntitiesDate
)VALUES (1, NULL, NULL, 0, 0, '', NULL) 

