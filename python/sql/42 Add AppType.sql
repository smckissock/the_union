USE Congress
GO


EXEC DropTable 'AppType'
GO

CREATE TABLE [dbo].[AppType](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](100) NOT NULL
 CONSTRAINT [PK_AppType] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE AppType ADD CONSTRAINT AppType_Unique_Name UNIQUE (Name) WITH (IGNORE_DUP_KEY= OFF)
GO

ALTER TABLE AppType ADD Slug varchar(100) UNIQUE (Name) WITH (IGNORE_DUP_KEY= OFF) DEFAULT 'senate_democrats'
GO

INSERT INTO AppType VALUES ('Unspecified')

INSERT INTO AppType VALUES ('Senate Democrats', 'senate_democrats')
GO


ALTER TABLE App ADD AppTypeID int NOT NULL DEFAULT 1 REFERENCES AppType(ID)  

UPDATE AppType SET Slug = 'all' WHERE ID = 1


UPDATE App SET AppTypeID = 2 WHERE ID > 24



EXEC DropView 'AppView'
GO

CREATE VIEW AppView 
AS
SELECT
	a.ID,
	a.Name AppName,
	a.ShortName AppSlug,
	at.Name AppTypeName,
	at.Slug AppTypeSlug
FROM App a
JOIN AppType at ON a.AppTypeID = at.ID








SELECT * FROM AppView




