USE RussiaNews
GO

EXEC DropTable 'MediaOutletAlias'
GO

CREATE TABLE [dbo].[MediaOutletAlias](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[MediaOutletID] [int] NOT NULL REFERENCES MediaOutlet(ID),
	[Name] [varchar](200) NOT NULL,
	CONSTRAINT MediaOutletAlias_Name UNIQUE(Name)
)


ALTER TABLE MediaOutlet ADD	CONSTRAINT MediaOutlet_Name UNIQUE(Name)

INSERT INTO MediaOutlet VALUES ('Today', '', 'today.com', 4)
INSERT INTO MediaOutlet VALUES ('Fox Business', '', 'foxbusiness.com', 4)
INSERT INTO MediaOutlet VALUES ('Barrons', '', 'barrons.com', 3)
INSERT INTO MediaOutlet VALUES ('Money', '', 'money.com', 3)


INSERT INTO MediaOutletAlias VALUES ((SELECT ID FROM MediaOutlet WHERE Name = 'Huffington Post'), 'HuffPost')
INSERT INTO MediaOutletAlias VALUES ((SELECT ID FROM MediaOutlet WHERE Name = 'Wall Street Journal'), 'WSJ')
INSERT INTO MediaOutletAlias VALUES ((SELECT ID FROM MediaOutlet WHERE Name = 'LA Times'), 'latimes.com')
INSERT INTO MediaOutletAlias VALUES ((SELECT ID FROM MediaOutlet WHERE Name = 'Yahoo'), 'Yahoo! News')

INSERT INTO MediaOutletAlias VALUES ((SELECT ID FROM MediaOutlet WHERE Name = 'NY Daily News'), 'nydailynews.com')
INSERT INTO MediaOutletAlias VALUES ((SELECT ID FROM MediaOutlet WHERE Name = 'Slate'), 'Slate Magazine')
INSERT INTO MediaOutletAlias VALUES ((SELECT ID FROM MediaOutlet WHERE Name = 'New Yorker'), 'The New Yorker')
INSERT INTO MediaOutletAlias VALUES ((SELECT ID FROM MediaOutlet WHERE Name = 'Politico'), 'POLITICO Magazine')
INSERT INTO MediaOutletAlias VALUES ((SELECT ID FROM MediaOutlet WHERE Name = 'The Blaze'), 'TheBlaze')
INSERT INTO MediaOutletAlias VALUES ((SELECT ID FROM MediaOutlet WHERE Name = 'BuzzFeed'), 'BuzzFeed News')
INSERT INTO MediaOutletAlias VALUES ((SELECT ID FROM MediaOutlet WHERE Name = 'CNN Money'), 'CNNMoney')
INSERT INTO MediaOutletAlias VALUES ((SELECT ID FROM MediaOutlet WHERE Name = 'Huffington Post'), 'HuffPost UK')
INSERT INTO MediaOutletAlias VALUES ((SELECT ID FROM MediaOutlet WHERE Name = 'Fox News'), 'Fox News Insider')
INSERT INTO MediaOutletAlias VALUES ((SELECT ID FROM MediaOutlet WHERE Name = 'Huffington Post'), 'Huffington Post Black Voices')
INSERT INTO MediaOutletAlias VALUES ((SELECT ID FROM MediaOutlet WHERE Name = 'Time'), 'TIME.com')
INSERT INTO MediaOutletAlias VALUES ((SELECT ID FROM MediaOutlet WHERE Name = 'New York Times'), 'NYTimes.com - Video')
INSERT INTO MediaOutletAlias VALUES ((SELECT ID FROM MediaOutlet WHERE Name = 'Huffington Post'), 'Le Huffington Post')
INSERT INTO MediaOutletAlias VALUES ((SELECT ID FROM MediaOutlet WHERE Name = 'Politico'), 'Politico Pro')
INSERT INTO MediaOutletAlias VALUES ((SELECT ID FROM MediaOutlet WHERE Name = 'MSNBC'), 'MSNBC.com')
INSERT INTO MediaOutletAlias VALUES ((SELECT ID FROM MediaOutlet WHERE Name = 'LA Times'), 'www.latimes.com')
INSERT INTO MediaOutletAlias VALUES ((SELECT ID FROM MediaOutlet WHERE Name = 'Huffington Post'), 'HuffPost Canada')
INSERT INTO MediaOutletAlias VALUES ((SELECT ID FROM MediaOutlet WHERE Name = 'Vox'), 'vox.com')
INSERT INTO MediaOutletAlias VALUES ((SELECT ID FROM MediaOutlet WHERE Name = 'New York Times'), 'The New York Times')
INSERT INTO MediaOutletAlias VALUES ((SELECT ID FROM MediaOutlet WHERE Name = 'Wall Street Journal'), 'wsj.com')
INSERT INTO MediaOutletAlias VALUES ((SELECT ID FROM MediaOutlet WHERE Name = 'CNN'), 'CNN Style')
INSERT INTO MediaOutletAlias VALUES ((SELECT ID FROM MediaOutlet WHERE Name = 'Today'), 'TODAY.com')
INSERT INTO MediaOutletAlias VALUES ((SELECT ID FROM MediaOutlet WHERE Name = 'Forbes'), 'Forbes Italia')
INSERT INTO MediaOutletAlias VALUES ((SELECT ID FROM MediaOutlet WHERE Name = 'Daily Caller'), 'dailycaller.com')
INSERT INTO MediaOutletAlias VALUES ((SELECT ID FROM MediaOutlet WHERE Name = 'Reuters'), 'Reuters TV')
INSERT INTO MediaOutletAlias VALUES ((SELECT ID FROM MediaOutlet WHERE Name = 'Politico'), 'POLITICO Media')
--INSERT INTO MediaOutletAlias VALUES ((SELECT ID FROM MediaOutlet WHERE Name = 'Money'), '')
INSERT INTO MediaOutletAlias VALUES ((SELECT ID FROM MediaOutlet WHERE Name = 'Fox News'), 'FOXNews.com')
INSERT INTO MediaOutletAlias VALUES ((SELECT ID FROM MediaOutlet WHERE Name = 'Huffington Post'), 'HuffPost Mexico')
INSERT INTO MediaOutletAlias VALUES ((SELECT ID FROM MediaOutlet WHERE Name = 'Huffington Post'), 'HuffPost Australia')
INSERT INTO MediaOutletAlias VALUES ((SELECT ID FROM MediaOutlet WHERE Name = 'Huffington Post'), 'The Huffington Post')
INSERT INTO MediaOutletAlias VALUES ((SELECT ID FROM MediaOutlet WHERE Name = 'Barrons'), 'barrons.com')
INSERT INTO MediaOutletAlias VALUES ((SELECT ID FROM MediaOutlet WHERE Name = 'Business Insider'), 'markets.businessinsider.com')
INSERT INTO MediaOutletAlias VALUES ((SELECT ID FROM MediaOutlet WHERE Name = 'Daily Caller'), 'The Daily Caller')
INSERT INTO MediaOutletAlias VALUES ((SELECT ID FROM MediaOutlet WHERE Name = 'LA Times'), 'Los Angeles Times')
--INSERT INTO MediaOutletAlias VALUES ((SELECT ID FROM MediaOutlet WHERE Name = 'Fox Business'), 'Fox Business')
INSERT INTO MediaOutletAlias VALUES ((SELECT ID FROM MediaOutlet WHERE Name = 'Washington Post'), 'The Washington Post')
INSERT INTO MediaOutletAlias VALUES ((SELECT ID FROM MediaOutlet WHERE Name = 'Forbes'), 'Forbes.com')
INSERT INTO MediaOutletAlias VALUES ((SELECT ID FROM MediaOutlet WHERE Name = 'Politico'), 'politicopro.com')



EXEC DropView 'MediaOutletAliasView'
GO

CREATE VIEW MediaOutletAliasView 
AS

SELECT
	ID, Name 
FROM MediaOutlet m 
UNION ALL
SELECT
	MediaOutletID, Name 
FROM MediaOutletAlias  




--WITH StoryMediaJoin
--AS (
--SELECT DISTINCT
--	s.SiteName, Count(*) JoinCount
--FROM DiffBotStory s
--JOIN MediaOutletAliasView m ON s.SiteName = m.Name
--GROUP BY s.SiteName
----ORDER BY Count(*) DESC
--),
--AllMedia AS (
--SELECT SiteName, Count(*) AllCount
--FROM DiffBotStory 
--GROUP BY Sitename
----ORDER BY Count(*) DESC
--)
--SELECT * FROM AllMedia
--WHERE SiteName NOT IN (SELECT SiteName FROM StoryMediaJoin)
--ORDER BY AllCount DESC



ALTER TABLE DiffBotStory ADD MediaOutletID int NOT NULL REFERENCES MediaOutlet(ID) DEFAULT 1
GO


SELECT 
	s.ID,
	m.ID 
FROM DiffBotStory s
JOIN MediaOutletAliasView m ON m.Name = s.SiteName


-- Set MEdiaOutletID for stories based on site name matches
UPDATE DiffBotStory 
	SET MediaOutletID = Media.MediaID
	FROM (
		SELECT DiffBotStory.ID StoryID, MediaOutletAliasView.ID MediaID 
		FROM DiffBotStory 
		JOIN MediaOutletAliasView  ON MediaOutletAliasView.Name = DiffBotStory.SiteName) Media 
	WHERE 
		DiffBotStory.ID = Media.StoryID

