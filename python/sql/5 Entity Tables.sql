USE [RussiaNews]
GO

EXEC DropTable 'RdfType'
GO

EXEC DropTable 'Entity'
GO

CREATE TABLE [dbo].[RdfType](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](100) NOT NULL,
	[DbpediaName] [varchar](100) NOT NULL,
 CONSTRAINT [PK_RdfType] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[RdfType] ADD  DEFAULT ('') FOR [DbpediaName]
GO


CREATE TABLE [dbo].[Entity](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[RdfTypeID] [int] NOT NULL,
	[Name] [varchar](100) NOT NULL,
	[Uri] [varchar](500) NOT NULL,
	[DiffBotUri] [varchar](500) NOT NULL,
	[Valid] [bit] NOT NULL,
 CONSTRAINT [PK_Entity] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Entity] ADD  DEFAULT ('') FOR [Uri]
GO

ALTER TABLE [dbo].[Entity] ADD  DEFAULT ('') FOR [DiffBotUri]
GO

ALTER TABLE [dbo].[Entity] ADD  DEFAULT ((1)) FOR [Valid]
GO

ALTER TABLE [dbo].[Entity]  WITH CHECK ADD FOREIGN KEY([RdfTypeID])
REFERENCES [dbo].[RdfType] ([ID])
GO



INSERT INTO RdfType VALUES ('Person', 'http://dbpedia.org/ontology/Person') 
INSERT INTO RdfType VALUES ('Organization', 'http://dbpedia.org/ontology/Organisation') 
INSERT INTO RdfType VALUES ('Place', 'http://dbpedia.org/ontology/PopulatedPlace') 