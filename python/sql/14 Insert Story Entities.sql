USE RussiaNews
GO


EXEC DropView 'DiffBotTagView'
GO

CREATE VIEW DiffBotTagView 
AS
SELECT 
	s.ID StoryID
	, Label
	, Score
	, Count
	, RdfTypes
FROM DiffBotTag t	
JOIN DiffBotStory s ON t.ResolvedUrl = s.ResolvedpageUrl  



EXEC DropTable 'StoryEntity' 
GO

CREATE TABLE [dbo].[StoryEntity](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[StoryID] [int] NOT NULL REFERENCES DiffBotStory(ID),
	[EntityID] [int] NOT NULL REFERENCES Entity(ID),
	[Score] [varchar](20) NOT NULL DEFAULT 0,
	[Count] [int] NULL,
 CONSTRAINT [PK_StoryEntity] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE UNIQUE NONCLUSTERED INDEX [NonClusteredIndex-20181229-013254] ON [dbo].[StoryEntity]
(
	[StoryID] ASC,
	[EntityID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)





CREATE PROCEDURE [dbo].[InsertStoryEntityOrganization]
AS
BEGIN
WITH UniqueStoryOrganization AS (
	SELECT 
		StoryID,
		(SELECT ID FROM Entity WHERE Name = Label) EntityID, 
		MAX(Score) Score,
		MAX(Count) Count,
		Label
    FROM DiffBotTagView
    WHERE ((RdFTypes Like '%Organization%') OR (RdFTypes Like '%Organisation%')) AND (RdFTypes NOT Like '%Populated%') AND (RdFTypes NOT Like '%Person%')
	--AND StoryID + '-' + (SELECT ID FROM Entity WHERE Name = Label) NOT IN (SELECT StoryID + '-' + (SELECT ID FROM Entity WHERE Name = Label) FROM StoryEntity)
    GROUP BY StoryID, Label
)
INSERT INTO StoryEntity 
SELECT 
  StoryID,
  EntityID,
  Score,
  Count
FROM UniqueStoryOrganization
END
GO

EXEC [dbo].[InsertStoryEntityOrganization]


CREATE PROCEDURE [dbo].[InsertStoryEntityPerson]
AS
BEGIN

WITH UniqueStoryPerson AS (
	SELECT 
		StoryID,
		(SELECT ID FROM Entity WHERE Name = Label) EntityID, 
		MAX(Score) Score,
		MAX(Count) Count,
		Label
    FROM DiffBotTagView
    WHERE RdFTypes Like '%Person%' AND RdfTypes NOT LIKE '%Profession%'
	--AND StoryID + '-' + (SELECT ID FROM Entity WHERE Name = Label) NOT IN (SELECT StoryID + '-' + (SELECT ID FROM Entity WHERE Name = Label) FROM StoryEntity)
    GROUP BY StoryID, Label
)
INSERT INTO StoryEntity 
SELECT 
  StoryID,
  EntityID,
  Score,
  Count
FROM UniqueStoryPerson;
END
GO

EXEC [dbo].[InsertStoryEntityPerson]



CREATE PROCEDURE [dbo].[InsertStoryEntityPlace]
AS
BEGIN
WITH UniqueStoryPlace AS (
	SELECT 
		StoryID,
		(SELECT ID FROM Entity WHERE Name = Label) EntityID, 
		MAX(Score) Score,
		MAX(Count) Count,
		Label
    FROM DiffBotTagView
    WHERE (RdFTypes Like '%Populated%') AND (RdFTypes NOT LIKE '%Person%')
	--AND StoryID + '-' + (SELECT ID FROM Entity WHERE Name = Label) NOT IN (SELECT StoryID + '-' + (SELECT ID FROM Entity WHERE Name = Label) FROM StoryEntity)
    GROUP BY StoryID, Label
)
INSERT INTO StoryEntity 
SELECT 
  StoryID,
  EntityID,
  Score,
  Count
FROM UniqueStoryPlace
END
GO


EXEC InsertStoryEntityPlace