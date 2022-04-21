USE [Congress]
GO

EXEC DropView 'StoryDetails2View'
GO

CREATE VIEW [dbo].[StoryDetails2View]
AS
SELECT
	s.ID
	, s.ID StoryID
	--, s.Description
	, db.ResolvedPageUrl Link
	, n.Image
	, db.Title
	, s.Date
	, m.Name MediaOutlet
	, m.ID MediaID
	, IsNULL(mb.BiasRatingID, 1) BiasRatingID 
	, db.Author Author
	, db.AuthorUrl AuthorUrl
	--, LEN(AllWords) - LEN(REPLACE(AllWords, ' ', '')) WordCount
FROM StoryView s
JOIN DiffBotStory db ON s.ID = db.ID
JOIN MediaOutlet m ON m.ID = s.MediaOutletID
LEFT JOIN NewspaperStory n ON n.DiffBotStoryID = s.ID 
LEFT JOIN MediaOutletBiasRating mb ON mb.MediaOutletID = s.MediaOutletID
--WHERE s.ID IN (SELECT DISTINCT StoryID FROM StoryForTermView WHERE AppID = 26)


-- SELECT * FROM StoryDetailsView
GO


SELECT * FROM S


SELECT * fROM App



SELECT Count(*) FROM AllStoriesForTermView


SELECT * FROM StoryForTermView 

SELECT * FROM StoryDetails2View

SELECT * FROM StoryDetails2View 
WHERE ID IN (SELECT DISTINCT StoryID FROM StoryForTermView WHERE AppID = 27)