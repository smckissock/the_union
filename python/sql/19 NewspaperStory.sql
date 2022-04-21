USE RussiaNews
GO

EXEC DropTable 'NewspaperStory'
GO
CREATE TABLE [dbo].[NewspaperStory](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[DiffBotStoryID] [int] NOT NULL REFERENCES DiffBotStory(ID),
	[Date] varchar(100) NOT NULL DEFAULT '',
	[Title] [varchar](1000) NOT NULL DEFAULT '',
	[Authors] [varchar](1000) NOT NULL DEFAULT '',
	[Image] varchar(100) NOT NULL DEFAULT '',
	[Body] varchar(max) NOT NULL DEFAULT '',
	[EditTime] datetime2(6) NOT NULL 
	CONSTRAINT [NewspaperStory_KEY] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] 

CREATE UNIQUE NONCLUSTERED INDEX [NonClusteredIndex-20190102-030127] ON [dbo].[NewspaperStory]
(
	[DiffBotStoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO



EXEC DropView 'NewspaperUrlView'
GO
-- Finds the Stories from DiffBot that do not already have a corresponding record from newspaper
-- Newspaper script should get text for those stories where HasText = 0  
CREATE VIEW NewspaperUrlView 
AS 
SELECT 
	ID DiffBotStoryID, 
	ResolvedPageUrl Url, 
	CASE WHEN Len(Text) = 0 THEN 0 ELSE 1 END HasText 
FROM DiffBotStory WHERE ID NOT IN (SELECT DiffBotStoryID FROM NewspaperStory)



