USE [RussiaNews]
GO

EXEC DropTable 'DiffBotLink'
GO

CREATE TABLE DiffBotLink (
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[FromID] [int] NOT NULL REFERENCES DiffBotStory(ID),
	[ToID] [int] NOT NULL REFERENCES DiffBotStory(ID)
)
CREATE UNIQUE NONCLUSTERED INDEX [NonClusteredIndex-20181229-001802] ON [dbo].[DiffBotLink]
(
	[FromID] ASC,
	[ToID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)

GO

INSERT INTO DiffBotLink
SELECT DISTINCT l.DiffBotStoryID, s.ID
FROM DiffBotStoryLink l
JOIN DiffBotStory s ON l.Link = s.PageUrl -- 55055


INSERT INTO DiffBotLink
SELECT DISTINCT l.DiffBotStoryID, s.ID
FROM DiffBotStoryLink l
JOIN DiffBotStory s ON l.Link = s.ResolvedPageUrl -- 5398
AND s.PageUrl <> s.ResolvedPageUrl 
AND l.DiffBotStoryID * 10000 + s.ID
NOT IN (SELECT FromID * 10000 + toID  FROM DiffBotLink) -- Too hackish way to remove dupes (could fail - use strings)) 



