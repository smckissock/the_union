USE [RussiaNews]
GO

EXEC DropTable 'DiffBotStoryLink'
GO
EXEC DropTable 'DiffBotStory'
GO
EXEC DropTable 'DiffBotBatch'
GO
EXEC DropTable 'MediaCloudStory'
GO
EXEC DropTable 'MediaCloudBatch'
GO


EXEC DropTable 'MediaCloudBatch'
GO
CREATE TABLE MediaCloudBatch(
	ID int IDENTITY(1,1) NOT NULL,
	Term varchar(500) NOT NULL,
	StartDate Date NULL,
	EndDate Date NULL,
	Collection varchar(100) NOT NULL,
	CollectionID int NOT NULL,
	CsvName varchar(200) NOT NULL,
	RunTime DateTime NULL,
 CONSTRAINT MediaCloudBatch_KEY PRIMARY KEY CLUSTERED 
(
	ID ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO


INSERT INTO MediaCloudBatch VALUES ('N/A', '2015-11-23', '2018-12-25', 'U.S. Top Online News 2017', 58722749, '', NULL)

INSERT INTO MediaCloudBatch VALUES ('Affliction Entertainment', '2015-11-23', '2018-12-25', 'U.S. Top Online News 2017', 58722749, 'affliction-entertainment-sampled-stories-20181225092241.csv', NULL)
INSERT INTO MediaCloudBatch VALUES ('Alexander Mashkevich', '2015-11-23', '2018-12-25', 'U.S. Top Online News 2017', 58722749, 'alexander-mashkevich-sampled-stories-20181226102139.csv', NULL)
INSERT INTO MediaCloudBatch VALUES ('Aras Agalarov', '2015-11-23', '2018-12-25', 'U.S. Top Online News 2017', 58722749, 'aras-agalarov-sampled-stories-20181226101323.csv', NULL)
INSERT INTO MediaCloudBatch VALUES ('CrowdStrike', '2015-11-23', '2018-12-25', 'U.S. Top Online News 2017', 58722749, 'crowdstrike-sampled-stories-20181225093712.csv', NULL)
INSERT INTO MediaCloudBatch VALUES ('Dmitry Peskov', '2015-11-23', '2018-12-25', 'U.S. Top Online News 2017', 58722749, 'dmitry-peskov-sampled-stories-20181225104416.csv', NULL)
INSERT INTO MediaCloudBatch VALUES ('Dmitry Rybolovlev', '2015-11-23', '2018-12-25', 'U.S. Top Online News 2017', 58722749, 'dmitry-rybolovlev-sampled-stories-20181226101357.csv', NULL)
INSERT INTO MediaCloudBatch VALUES ('Dmytro Firtash', '2015-11-23', '2018-12-25', 'U.S. Top Online News 2017', 58722749, 'dmytro-firtash-sampled-stories-20181226101431.csv', NULL)
INSERT INTO MediaCloudBatch VALUES ('Emin Agalarov', '2015-11-23', '2018-12-25', 'U.S. Top Online News 2017', 58722749, 'emin-agalarov-sampled-stories-20181226101459.csv', NULL)
INSERT INTO MediaCloudBatch VALUES ('Essential Consultants', '2015-11-23', '2018-12-25', 'U.S. Top Online News 2017', 58722749, 'essential-consultants-sampled-stories-20181225093619.csv', NULL)
INSERT INTO MediaCloudBatch VALUES ('Evgeny Buryakov', '2015-11-23', '2018-12-25', 'U.S. Top Online News 2017', 58722749, 'evgeny-buryakov-sampled-stories-20181226102253.csv', NULL)
INSERT INTO MediaCloudBatch VALUES ('Herman Gref', '2015-11-23', '2018-12-25', 'U.S. Top Online News 2017', 58722749, 'herman-gref-sampled-stories-20181226102203.csv', NULL)
INSERT INTO MediaCloudBatch VALUES ('Igor Sechin', '2015-11-23', '2018-12-25', 'U.S. Top Online News 2017', 58722749, 'igor-sechin-sampled-stories-20181226101533.csv', NULL)
INSERT INTO MediaCloudBatch VALUES ('Irakly Kaveladze', '2015-11-23', '2018-12-25', 'U.S. Top Online News 2017', 58722749, 'irakly-kaveladze-sampled-stories-20181226102117.csv', NULL)
INSERT INTO MediaCloudBatch VALUES ('Konstantin Kilimnik', '2015-11-23', '2018-12-25', 'U.S. Top Online News 2017', 58722749, 'konstantin-kilimnik-sampled-stories-20181226101603.csv', NULL)
INSERT INTO MediaCloudBatch VALUES ('Leonard Blavatnik', '2015-11-23', '2018-12-25', 'U.S. Top Online News 2017', 58722749, 'len-blavatnik-sampled-stories-20181225092119.csv', NULL)
INSERT INTO MediaCloudBatch VALUES ('Natalia Veselnitskaya', '2015-11-23', '2018-12-25', 'U.S. Top Online News 2017', 58722749, 'natalia-veselnitskaya-sampled-stories-20181226101643.csv', NULL)
INSERT INTO MediaCloudBatch VALUES ('Oleg Deripaska', '2015-11-23', '2018-12-25', 'U.S. Top Online News 2017', 58722749, 'oleg-deripaska-sampled-stories-20181225092940.csv', NULL)
INSERT INTO MediaCloudBatch VALUES ('Rick Dearborn', '2015-11-23', '2018-12-25', 'U.S. Top Online News 2017', 58722749, 'rick-dearborn-sampled-stories-20181226101709.csv', NULL)
INSERT INTO MediaCloudBatch VALUES ('Rinat Akhmetshin', '2015-11-23', '2018-12-25', 'U.S. Top Online News 2017', 58722749, 'rinat-akhmetshin-sampled-stories-20181226101735.csv', NULL)
INSERT INTO MediaCloudBatch VALUES ('Sergei Gorkov', '2015-11-23', '2018-12-25', 'U.S. Top Online News 2017', 58722749, 'sergei-gorkov-sampled-stories-20181226102056.csv', NULL)
INSERT INTO MediaCloudBatch VALUES ('Sergei Ivanov', '2015-11-23', '2018-12-25', 'U.S. Top Online News 2017', 58722749, 'sergei-ivanov-sampled-stories-20181226101805.csv', NULL)
INSERT INTO MediaCloudBatch VALUES ('Sergei Ryabkov', '2015-11-23', '2018-12-25', 'U.S. Top Online News 2017', 58722749, 'sergei-ryabkov-sampled-stories-20181226102226.csv', NULL)
INSERT INTO MediaCloudBatch VALUES ('Sergey Kislyak', '2015-11-23', '2018-12-25', 'U.S. Top Online News 2017', 58722749, 'sergey-kislyak-sampled-stories-20181226101828.csv', NULL)
INSERT INTO MediaCloudBatch VALUES ('Sergey Lavrov', '2015-11-23', '2018-12-25', 'U.S. Top Online News 2017', 58722749, 'sergey-lavrov-sampled-stories-20181226101903.csv', NULL)
INSERT INTO MediaCloudBatch VALUES ('Sergey Shoygu', '2015-11-23', '2018-12-25', 'U.S. Top Online News 2017', 58722749, 'sergey-shoygu-sampled-stories-20181226101925.csv', NULL)
INSERT INTO MediaCloudBatch VALUES ('Valery Gerasimov', '2015-11-23', '2018-12-25', 'U.S. Top Online News 2017', 58722749, 'valery-gerasimov-sampled-stories-20181225092530.csv', NULL)
INSERT INTO MediaCloudBatch VALUES ('Viktor Khrapunov', '2015-11-23', '2018-12-25', 'U.S. Top Online News 2017', 58722749, 'viktor-khrapunov-sampled-stories-20181226101958.csv', NULL)
INSERT INTO MediaCloudBatch VALUES ('Viktor Yanukovych', '2015-11-23', '2018-12-25', 'U.S. Top Online News 2017', 58722749, 'viktor-yanukovych-sampled-stories-20181226102030.csv', NULL)
INSERT INTO MediaCloudBatch VALUES ('Yevgeniy Prigozhin', '2015-11-23', '2018-12-25', 'U.S. Top Online News 2017', 58722749, 'yevgeniy-prigozhin-sampled-stories-20181226102315.csv', NULL)

--INSERT INTO MediaCloudBatch VALUES ('Oleg Deripaska', '2015-11-23', '2018-12-23', 'U.S. Top Online News 2017', 58722749, 'oleg-deripaska-sampled-stories-20181225092940.csv', NULL)
--INSERT INTO MediaCloudBatch VALUES ('Dmitry Peskov', '2015-11-23', '2018-12-25', 'U.S. Top Online News 2017', 58722749, 'dmitry-peskov-sampled-stories-20181225104416.csv', NULL)
--INSERT INTO MediaCloudBatch VALUES ('Affliction Entertainment', '2015-11-23', '2018-12-25', 'U.S. Top Online News 2017', 58722749, 'affliction-entertainment-sampled-stories-20181225092241.csv', NULL)
--INSERT INTO MediaCloudBatch VALUES ('Crowdstrike', '2015-11-23', '2018-12-25', 'U.S. Top Online News 2017', 58722749, 'crowdstrike-sampled-stories-20181225093712.csv', NULL)
--INSERT INTO MediaCloudBatch VALUES ('Essential Consultants', '2015-11-23', '2018-12-25', 'U.S. Top Online News 2017', 58722749, 'essential-consultants-sampled-stories-20181225093619.csv', NULL)
--INSERT INTO MediaCloudBatch VALUES ('Len Blavatnik', '2015-11-23', '2018-12-25', 'U.S. Top Online News 2017', 58722749, 'len-blavatnik-sampled-stories-20181225092119.csv', NULL)
--INSERT INTO MediaCloudBatch VALUES ('Valery Gerasimov', '2015-11-23', '2018-12-25', 'U.S. Top Online News 2017', 58722749, 'valery-gerasimov-sampled-stories-20181225092530.csv', NULL)


GO


EXEC DropTable 'MediaCloudStory'
GO
CREATE TABLE [dbo].[MediaCloudStory](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	MediaCloudBatchID int NOT NULL REFERENCES MediaCloudBatch(ID),
	[MediaCloudStoriesID] [varchar](100) NOT NULL DEFAULT '',
	[PublishDate] [varchar](100) NOT NULL DEFAULT '',
	[Title] [varchar](2000) NOT NULL DEFAULT '',
	[Url] [varchar](1500) NOT NULL DEFAULT '',
	[Language] varchar(10) NOT NULL DEFAULT '', 
	[ApSyndicated] bit NOT NULL DEFAULT 0, 
	[MediaID] [varchar](10) NOT NULL DEFAULT '',
	[MediaName] [varchar](200) NOT NULL DEFAULT '',
	[MediaUrl] [varchar](200) NOT NULL DEFAULT '',
	[MediaType] [varchar](200) NOT NULL DEFAULT '',
	[Themes] [varchar](1000) NOT NULL DEFAULT ''
 CONSTRAINT [MediaCloudStory_KEY] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] 
GO

CREATE UNIQUE NONCLUSTERED INDEX [NonClusteredIndex-20181221-044806] ON [dbo].[MediaCloudStory]
(
	[Url] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO


INSERT INTO MediaCloudStory VALUES (1, 1, '1900-01-01', 'N/A', '', '', 0, '', '', '', '', '')


EXEC DropTable 'DiffBotBatch'
GO
CREATE TABLE DiffBotBatch(
	ID int IDENTITY(1,1) NOT NULL,
	MediaCloudBatchID int NOT NULL REFERENCES MediaCloudBatch(ID),
	DiffBotBatchID int NOT NULL,
	Name varchar(500) NOT NULL,
	StartTime DateTime NULL,
	CompletedTime DateTime NULL,
	PagesAttempted int NOT NULL DEFAULT (0),
	PagesCompleted int NOT NULL DEFAULT (0)
 CONSTRAINT DiffBotBatch_KEY PRIMARY KEY CLUSTERED 
(
	ID ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO


INSERT INTO DiffBotBatch (MediaCloudBatchID, DiffBotBatchID, Name, PagesAttempted, PagesCompleted) 
VALUES (1, 1, 'N/A - Media Cloud', 0, 0)
GO


EXEC DropTable 'DiffbotStory'
GO
CREATE TABLE [dbo].[DiffbotStory](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	DiffBotBatchID int NOT NULL REFERENCES DiffBotBatch(ID),
	[MediaCloudStoryID] int NOT NULL REFERENCES MediaCloudStory(ID), -- Null?
	[Title] [varchar](1000) NOT NULL DEFAULT '',
	[Author] [varchar](200) NOT NULL DEFAULT '',
	[AuthorUrl] [varchar](500) NOT NULL DEFAULT '',
	[SiteName] [varchar](500) NOT NULL DEFAULT '',
	[Date] [varchar](100) NOT NULL DEFAULT '',
	[EstimatedDate] [varchar](100) NOT NULL DEFAULT '',
	[DiffbotUri] [varchar](200) NOT NULL DEFAULT '',
	[PageUrl] [varchar](1000) NOT NULL DEFAULT '',
	[ResolvedPageUrl] [varchar](1000) NOT NULL DEFAULT '',
	[Text] [varchar](max) NOT NULL DEFAULT '',
	[HTML] [varchar](max) NOT NULL DEFAULT ''
 CONSTRAINT [DiffbotStory_KEY] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

--CREATE UNIQUE NONCLUSTERED INDEX [NonClusteredIndex-20181221-050254] ON [dbo].[DiffbotStory]
--(
--	[MediaCloudStoryID] ASC
--)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
--GO

CREATE UNIQUE NONCLUSTERED INDEX [NonClusteredIndex-20181221-050254X] ON [dbo].[DiffbotStory]
(
	[ResolvedPageUrl] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO



EXEC DropTable 'DiffBotStoryLink'
GO
CREATE TABLE [dbo].[DiffBotStoryLink](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[DiffBotStoryID] [int] NOT NULL REFERENCES DiffBotStory(ID),
	[Link] [varchar](1500) NOT NULL
 CONSTRAINT [PK_DiffBotStoryLink] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] 
GO


