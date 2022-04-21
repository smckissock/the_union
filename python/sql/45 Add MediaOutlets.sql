USE Congress
GO




--INSERT INTO MediaOutletType VALUES ('Local Publication', 'local_publication')

-- Add Missing Publication (these need better names, and MediaOutletType is just "local publication" 
INSERT INTO MediaOutlet
SELECT DISTINCT  MediaName, MediaID, MediaUrl, 9 FROM MediaCloudStory 
WHERE MediaName NOT IN (SELECT Name FROM MediaOutlet)



UPDATE DiffBotStory 
	SET MediaOutletID = Media.MediaID
	FROM (
		SELECT DiffBotStory.ID StoryID, MediaOutletAliasView.ID MediaID 
		FROM DiffBotStory 
		JOIN MediaOutletAliasView  ON MediaOutletAliasView.Name = DiffBotStory.SiteName) Media 
	WHERE 
		DiffBotStory.ID = Media.StoryID


-- ISSUE - lots arent being picked up 12k yes, 7k no
--SELECT Count(*) FROM DiffBotStory WHERE MediaOutletID = 1 




SELECT s.ID StoryID, ISNULL(sen.Text, '') Text 
FROM StoryView s LEFT JOIN Sentence sen ON s.ID = sen.DiffBotStoryID  
WHERE s.ID IN (SELECT DISTINCT StoryID FROM StoryForTermView WHERE AppID = 26) ORDER BY s.ID, LEN(sen.Text) DESC


SELECT top 1 (*) FROm StoryDetailsView

