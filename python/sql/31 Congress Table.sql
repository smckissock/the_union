

DROP Table Congress


CREATE TABLE [dbo].[Congress](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] varchar(100) NOT NULL DEFAULT '',
	[MiddleName] varchar(100) NOT NULL DEFAULT '',
	[LastName] varchar(100) NOT NULL DEFAULT '',
	[Suffix] varchar(100) NOT NULL DEFAULT '',
	[Address] varchar(500) NOT NULL DEFAULT '',
	[City] varchar(100) NOT NULL DEFAULT '',
	[State] varchar(100) NOT NULL DEFAULT '',
	[Zip] varchar(100) NOT NULL DEFAULT '',
	[StateDistrict] varchar(100) NOT NULL DEFAULT '',
	[BioGuideID] varchar(100) NOT NULL DEFAULT '',
	[Party] varchar(100) NOT NULL DEFAULT '',
	HouseOrSenate varchar(10) NOT NULL DEFAULT 'House'
 CONSTRAINT [PK_Congress] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO


CREATE VIEW CongressView 
AS

SELECT
	FirstName + ' ' + LastName FullName
	, StateDistrict
	, Party
FROM Congress WHERE BioGuideID <> ''	 





member_full	last_name	first_name	party	state	address	phone	email	website	class	bioguide_id	leadership_position	last_updated


DROP Table Senate
GO
CREATE TABLE [dbo].[Senate](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] varchar(100) NOT NULL DEFAULT '',
	[LastName] varchar(100) NOT NULL DEFAULT '',
	[Party] varchar(100) NOT NULL DEFAULT '',
	[State] varchar(100) NOT NULL DEFAULT '',
	[Address] varchar(500) NOT NULL DEFAULT '',
	[Phone] varchar(100) NOT NULL DEFAULT '',
	[Email] varchar(100) NOT NULL DEFAULT '',
	[Website] varchar(100) NOT NULL DEFAULT '',
	[Class] varchar(100) NOT NULL DEFAULT '',
	[BioGuideID] varchar(100) NOT NULL DEFAULT '',
	[LeadershipPosition] varchar(100) NOT NULL DEFAULT ''
 CONSTRAINT [PK_Senate] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO


CREATE VIEW SenateView 
AS

SELECT
	FirstName + ' ' + LastName FullName
	, State
	, Class
	, Party
FROM Senate WHERE BioGuideID <> ''	



SP_help 'Senate' 


