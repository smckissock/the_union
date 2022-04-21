USE RussiaNews
GO


EXEC DropView 'StoryDetailsView'
GO

CREATE VIEW [dbo].[StoryDetailsView]
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
WHERE s.ID IN (SELECT DISTINCT StoryID FROM AllStoriesForTermView)


-- SELECT * FROM StoryDetailsView