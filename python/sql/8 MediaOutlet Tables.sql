USE [RussiaNews]
GO


/****** Object:  Table [dbo].[BiasRating]    Script Date: 12/26/2018 5:58:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BiasRating](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](12) NOT NULL,
	[Ordering] [int] NOT NULL,
 CONSTRAINT [PK_BiasRating] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BiasRatingSource]    Script Date: 12/26/2018 5:58:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BiasRatingSource](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](10) NOT NULL,
 CONSTRAINT [PK_BiasRatingSource] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MediaOutlet]    Script Date: 12/26/2018 5:58:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MediaOutlet](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](100) NOT NULL,
	[MediaCloudID] [varchar](10) NULL,
	[DomainName] [varchar](100) NULL,
	[MediaOutletTypeID] [int] NULL,
 CONSTRAINT [PK_MediaOutlet] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MediaOutletBiasRating]    Script Date: 12/26/2018 5:58:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MediaOutletBiasRating](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[MediaOutletID] [int] NULL,
	[BiasRatingID] [int] NULL,
	[BiasRatingSourceID] [int] NULL,
 CONSTRAINT [PK_MediaOutletBiasRating] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MediaOutletType]    Script Date: 12/26/2018 5:58:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MediaOutletType](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](100) NOT NULL,
	[MediaCloudCode] [varchar](100) NOT NULL,
 CONSTRAINT [PK_MediaOutletType] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[BiasRating] ON 
GO
INSERT [dbo].[BiasRating] ([ID], [Name], [Ordering]) VALUES (1, N'Unspecified', 0)
GO
INSERT [dbo].[BiasRating] ([ID], [Name], [Ordering]) VALUES (2, N'Left', 1)
GO
INSERT [dbo].[BiasRating] ([ID], [Name], [Ordering]) VALUES (3, N'Center Left', 2)
GO
INSERT [dbo].[BiasRating] ([ID], [Name], [Ordering]) VALUES (4, N'Center', 3)
GO
INSERT [dbo].[BiasRating] ([ID], [Name], [Ordering]) VALUES (5, N'Mixed', 3)
GO
INSERT [dbo].[BiasRating] ([ID], [Name], [Ordering]) VALUES (6, N'Center Right', 4)
GO
INSERT [dbo].[BiasRating] ([ID], [Name], [Ordering]) VALUES (7, N'Right', 5)
GO
SET IDENTITY_INSERT [dbo].[BiasRating] OFF
GO
SET IDENTITY_INSERT [dbo].[BiasRatingSource] ON 
GO
INSERT [dbo].[BiasRatingSource] ([ID], [Name]) VALUES (1, N'AllSides')
GO
SET IDENTITY_INSERT [dbo].[BiasRatingSource] OFF
GO
SET IDENTITY_INSERT [dbo].[MediaOutlet] ON 
GO
INSERT [dbo].[MediaOutlet] ([ID], [Name], [MediaCloudID], [DomainName], [MediaOutletTypeID]) VALUES (1, N'N/A', N'', N'', 1)
GO
INSERT [dbo].[MediaOutlet] ([ID], [Name], [MediaCloudID], [DomainName], [MediaOutletTypeID]) VALUES (2, N'New York Times', N'1', N'nytimes.com', 3)
GO
INSERT [dbo].[MediaOutlet] ([ID], [Name], [MediaCloudID], [DomainName], [MediaOutletTypeID]) VALUES (3, N'NPR', N'', N'', 1)
GO
INSERT [dbo].[MediaOutlet] ([ID], [Name], [MediaCloudID], [DomainName], [MediaOutletTypeID]) VALUES (4, N'Trump, Inc. (WNYC)', N'', N'', 1)
GO
INSERT [dbo].[MediaOutlet] ([ID], [Name], [MediaCloudID], [DomainName], [MediaOutletTypeID]) VALUES (5, N'Florida Division of Corporations', N'', N'', 1)
GO
INSERT [dbo].[MediaOutlet] ([ID], [Name], [MediaCloudID], [DomainName], [MediaOutletTypeID]) VALUES (6, N'PR Newsire', N'', N'', 1)
GO
INSERT [dbo].[MediaOutlet] ([ID], [Name], [MediaCloudID], [DomainName], [MediaOutletTypeID]) VALUES (7, N'The Post and Courier', N'', N'', 1)
GO
INSERT [dbo].[MediaOutlet] ([ID], [Name], [MediaCloudID], [DomainName], [MediaOutletTypeID]) VALUES (8, N'Jacksonville Daily Record', N'', N'', 1)
GO
INSERT [dbo].[MediaOutlet] ([ID], [Name], [MediaCloudID], [DomainName], [MediaOutletTypeID]) VALUES (9, N'Tulsa World', N'', N'', 1)
GO
INSERT [dbo].[MediaOutlet] ([ID], [Name], [MediaCloudID], [DomainName], [MediaOutletTypeID]) VALUES (10, N'GigaOm', N'', N'', 1)
GO
INSERT [dbo].[MediaOutlet] ([ID], [Name], [MediaCloudID], [DomainName], [MediaOutletTypeID]) VALUES (11, N'CNN Money', N'', N'', 1)
GO
INSERT [dbo].[MediaOutlet] ([ID], [Name], [MediaCloudID], [DomainName], [MediaOutletTypeID]) VALUES (12, N'Japan Times', N'', N'', 1)
GO
INSERT [dbo].[MediaOutlet] ([ID], [Name], [MediaCloudID], [DomainName], [MediaOutletTypeID]) VALUES (13, N'PR Web', N'', N'', 1)
GO
INSERT [dbo].[MediaOutlet] ([ID], [Name], [MediaCloudID], [DomainName], [MediaOutletTypeID]) VALUES (14, N'Bloomberg', N'40944', N'bloomberg.com', 2)
GO
INSERT [dbo].[MediaOutlet] ([ID], [Name], [MediaCloudID], [DomainName], [MediaOutletTypeID]) VALUES (15, N'BuzzFeed', N'6218', N'buzzfeed.com', 2)
GO
INSERT [dbo].[MediaOutlet] ([ID], [Name], [MediaCloudID], [DomainName], [MediaOutletTypeID]) VALUES (16, N'ProPublica', N'', N'', 1)
GO
INSERT [dbo].[MediaOutlet] ([ID], [Name], [MediaCloudID], [DomainName], [MediaOutletTypeID]) VALUES (17, N'General Services Administration', N'', N'', 1)
GO
INSERT [dbo].[MediaOutlet] ([ID], [Name], [MediaCloudID], [DomainName], [MediaOutletTypeID]) VALUES (18, N'Government Executive', N'', N'', 1)
GO
INSERT [dbo].[MediaOutlet] ([ID], [Name], [MediaCloudID], [DomainName], [MediaOutletTypeID]) VALUES (19, N'MNC Newsroom', N'', N'', 1)
GO
INSERT [dbo].[MediaOutlet] ([ID], [Name], [MediaCloudID], [DomainName], [MediaOutletTypeID]) VALUES (20, N'Indy Star', N'', N'', 1)
GO
INSERT [dbo].[MediaOutlet] ([ID], [Name], [MediaCloudID], [DomainName], [MediaOutletTypeID]) VALUES (21, N'Wall Street Journal', N'1150', N'', 1)
GO
INSERT [dbo].[MediaOutlet] ([ID], [Name], [MediaCloudID], [DomainName], [MediaOutletTypeID]) VALUES (22, N'CNN', N'1095', N'cnn.com', 4)
GO
INSERT [dbo].[MediaOutlet] ([ID], [Name], [MediaCloudID], [DomainName], [MediaOutletTypeID]) VALUES (23, N'Newsweek', N'', N'', 1)
GO
INSERT [dbo].[MediaOutlet] ([ID], [Name], [MediaCloudID], [DomainName], [MediaOutletTypeID]) VALUES (24, N'Mother Jones', N'', N'', 1)
GO
INSERT [dbo].[MediaOutlet] ([ID], [Name], [MediaCloudID], [DomainName], [MediaOutletTypeID]) VALUES (25, N'The Real Deal', N'', N'', 1)
GO
INSERT [dbo].[MediaOutlet] ([ID], [Name], [MediaCloudID], [DomainName], [MediaOutletTypeID]) VALUES (26, N'Washington Post', N'2', N'washintonpost/com', 3)
GO
INSERT [dbo].[MediaOutlet] ([ID], [Name], [MediaCloudID], [DomainName], [MediaOutletTypeID]) VALUES (27, N'National Labor Relations Board', N'', N'', 1)
GO
INSERT [dbo].[MediaOutlet] ([ID], [Name], [MediaCloudID], [DomainName], [MediaOutletTypeID]) VALUES (28, N'Pacific Standard', N'', N'', 1)
GO
INSERT [dbo].[MediaOutlet] ([ID], [Name], [MediaCloudID], [DomainName], [MediaOutletTypeID]) VALUES (29, N'Variety', N'', N'', 1)
GO
INSERT [dbo].[MediaOutlet] ([ID], [Name], [MediaCloudID], [DomainName], [MediaOutletTypeID]) VALUES (30, N'McClatchy', N'', N'', 1)
GO
INSERT [dbo].[MediaOutlet] ([ID], [Name], [MediaCloudID], [DomainName], [MediaOutletTypeID]) VALUES (31, N'Forbes', N'1104', N'forbes.com', 3)
GO
INSERT [dbo].[MediaOutlet] ([ID], [Name], [MediaCloudID], [DomainName], [MediaOutletTypeID]) VALUES (32, N'New York Post', N'', N'', 1)
GO
INSERT [dbo].[MediaOutlet] ([ID], [Name], [MediaCloudID], [DomainName], [MediaOutletTypeID]) VALUES (33, N'Vanity Fair', N'', N'', 1)
GO
INSERT [dbo].[MediaOutlet] ([ID], [Name], [MediaCloudID], [DomainName], [MediaOutletTypeID]) VALUES (34, N'Associated Press', N'', N'', 1)
GO
INSERT [dbo].[MediaOutlet] ([ID], [Name], [MediaCloudID], [DomainName], [MediaOutletTypeID]) VALUES (35, N'Business Insider', N'18710', N'businessinsider.com', 2)
GO
INSERT [dbo].[MediaOutlet] ([ID], [Name], [MediaCloudID], [DomainName], [MediaOutletTypeID]) VALUES (36, N'Bloomberg Politics', N'', N'', 1)
GO
INSERT [dbo].[MediaOutlet] ([ID], [Name], [MediaCloudID], [DomainName], [MediaOutletTypeID]) VALUES (37, N'Center for Public Integrity', N'', N'', 1)
GO
INSERT [dbo].[MediaOutlet] ([ID], [Name], [MediaCloudID], [DomainName], [MediaOutletTypeID]) VALUES (38, N'Economic Times', N'', N'', 1)
GO
INSERT [dbo].[MediaOutlet] ([ID], [Name], [MediaCloudID], [DomainName], [MediaOutletTypeID]) VALUES (39, N'Shanghaiist', N'', N'', 1)
GO
INSERT [dbo].[MediaOutlet] ([ID], [Name], [MediaCloudID], [DomainName], [MediaOutletTypeID]) VALUES (40, N'Fox News', N'1092', N'foxnews.com', 4)
GO
INSERT [dbo].[MediaOutlet] ([ID], [Name], [MediaCloudID], [DomainName], [MediaOutletTypeID]) VALUES (41, N'Huffington Post', N'27502', N'huffingtonpost.com', 2)
GO
INSERT [dbo].[MediaOutlet] ([ID], [Name], [MediaCloudID], [DomainName], [MediaOutletTypeID]) VALUES (42, N'Politico', N'18268', N'politico.com', 3)
GO
INSERT [dbo].[MediaOutlet] ([ID], [Name], [MediaCloudID], [DomainName], [MediaOutletTypeID]) VALUES (43, N'La Nacion', N'', N'', 1)
GO
INSERT [dbo].[MediaOutlet] ([ID], [Name], [MediaCloudID], [DomainName], [MediaOutletTypeID]) VALUES (44, N'@realDonaldTrump', N'', N'', 1)
GO
INSERT [dbo].[MediaOutlet] ([ID], [Name], [MediaCloudID], [DomainName], [MediaOutletTypeID]) VALUES (45, N'NYS Department of State', N'', N'', 1)
GO
INSERT [dbo].[MediaOutlet] ([ID], [Name], [MediaCloudID], [DomainName], [MediaOutletTypeID]) VALUES (46, N'You Tube', N'', N'', 1)
GO
INSERT [dbo].[MediaOutlet] ([ID], [Name], [MediaCloudID], [DomainName], [MediaOutletTypeID]) VALUES (47, N'The Daily Beast', N'', N'', 1)
GO
INSERT [dbo].[MediaOutlet] ([ID], [Name], [MediaCloudID], [DomainName], [MediaOutletTypeID]) VALUES (48, N'Reuters', N'4442', N'reuters.com', 1)
GO
INSERT [dbo].[MediaOutlet] ([ID], [Name], [MediaCloudID], [DomainName], [MediaOutletTypeID]) VALUES (49, N'US Department of Justice', N'', N'', 1)
GO
INSERT [dbo].[MediaOutlet] ([ID], [Name], [MediaCloudID], [DomainName], [MediaOutletTypeID]) VALUES (50, N'The Hill', N'', N'', 1)
GO
INSERT [dbo].[MediaOutlet] ([ID], [Name], [MediaCloudID], [DomainName], [MediaOutletTypeID]) VALUES (51, N'Breitbart', N'19334', N'breitbart.com', 2)
GO
INSERT [dbo].[MediaOutlet] ([ID], [Name], [MediaCloudID], [DomainName], [MediaOutletTypeID]) VALUES (52, N'Yahoo', N'751082', N'yahoo.com/news.com', 2)
GO
INSERT [dbo].[MediaOutlet] ([ID], [Name], [MediaCloudID], [DomainName], [MediaOutletTypeID]) VALUES (53, N'Twitter', N'', N'', 1)
GO
INSERT [dbo].[MediaOutlet] ([ID], [Name], [MediaCloudID], [DomainName], [MediaOutletTypeID]) VALUES (54, N'Page Six', N'', N'', 1)
GO
INSERT [dbo].[MediaOutlet] ([ID], [Name], [MediaCloudID], [DomainName], [MediaOutletTypeID]) VALUES (55, N'US Department of State', N'', N'', 1)
GO
INSERT [dbo].[MediaOutlet] ([ID], [Name], [MediaCloudID], [DomainName], [MediaOutletTypeID]) VALUES (56, N'The Independent', N'', N'', 1)
GO
INSERT [dbo].[MediaOutlet] ([ID], [Name], [MediaCloudID], [DomainName], [MediaOutletTypeID]) VALUES (57, N'Federal Bureau of Investigation', N'', N'', 1)
GO
INSERT [dbo].[MediaOutlet] ([ID], [Name], [MediaCloudID], [DomainName], [MediaOutletTypeID]) VALUES (58, N'The Smoking Gun', N'', N'', 1)
GO
INSERT [dbo].[MediaOutlet] ([ID], [Name], [MediaCloudID], [DomainName], [MediaOutletTypeID]) VALUES (59, N'guccifer', N'', N'', 1)
GO
INSERT [dbo].[MediaOutlet] ([ID], [Name], [MediaCloudID], [DomainName], [MediaOutletTypeID]) VALUES (60, N'House of Representatives', N'', N'', 1)
GO
INSERT [dbo].[MediaOutlet] ([ID], [Name], [MediaCloudID], [DomainName], [MediaOutletTypeID]) VALUES (61, N'CNBC', N'1755', N'cnbc.com', 4)
GO
INSERT [dbo].[MediaOutlet] ([ID], [Name], [MediaCloudID], [DomainName], [MediaOutletTypeID]) VALUES (62, N'Crowdstrike', N'', N'', 1)
GO
INSERT [dbo].[MediaOutlet] ([ID], [Name], [MediaCloudID], [DomainName], [MediaOutletTypeID]) VALUES (63, N'ABC News', N'', N'', 1)
GO
INSERT [dbo].[MediaOutlet] ([ID], [Name], [MediaCloudID], [DomainName], [MediaOutletTypeID]) VALUES (64, N'The Intercept', N'', N'', 1)
GO
INSERT [dbo].[MediaOutlet] ([ID], [Name], [MediaCloudID], [DomainName], [MediaOutletTypeID]) VALUES (65, N'Media Matters', N'', N'', 1)
GO
INSERT [dbo].[MediaOutlet] ([ID], [Name], [MediaCloudID], [DomainName], [MediaOutletTypeID]) VALUES (66, N'The Boston Globe', N'', N'', 1)
GO
INSERT [dbo].[MediaOutlet] ([ID], [Name], [MediaCloudID], [DomainName], [MediaOutletTypeID]) VALUES (67, N'Politifact', N'', N'', 1)
GO
INSERT [dbo].[MediaOutlet] ([ID], [Name], [MediaCloudID], [DomainName], [MediaOutletTypeID]) VALUES (68, N'America Online', N'', N'', 1)
GO
INSERT [dbo].[MediaOutlet] ([ID], [Name], [MediaCloudID], [DomainName], [MediaOutletTypeID]) VALUES (69, N'Department of Homeland Security', N'', N'', 1)
GO
INSERT [dbo].[MediaOutlet] ([ID], [Name], [MediaCloudID], [DomainName], [MediaOutletTypeID]) VALUES (70, N'The Guardian', N'', N'', 1)
GO
INSERT [dbo].[MediaOutlet] ([ID], [Name], [MediaCloudID], [DomainName], [MediaOutletTypeID]) VALUES (71, N'Time', N'4419', N'time.com', 3)
GO
INSERT [dbo].[MediaOutlet] ([ID], [Name], [MediaCloudID], [DomainName], [MediaOutletTypeID]) VALUES (72, N'DocumentCloud', N'', N'', 1)
GO
INSERT [dbo].[MediaOutlet] ([ID], [Name], [MediaCloudID], [DomainName], [MediaOutletTypeID]) VALUES (73, N'USA Today', N'64866', N'usatoday.com', 3)
GO
INSERT [dbo].[MediaOutlet] ([ID], [Name], [MediaCloudID], [DomainName], [MediaOutletTypeID]) VALUES (74, N'NBC News', N'25499', N'nbcnews.com', 4)
GO
INSERT [dbo].[MediaOutlet] ([ID], [Name], [MediaCloudID], [DomainName], [MediaOutletTypeID]) VALUES (75, N'The Atlantic', N'1110', N'theatlantic.com', 3)
GO
INSERT [dbo].[MediaOutlet] ([ID], [Name], [MediaCloudID], [DomainName], [MediaOutletTypeID]) VALUES (76, N'PBS', N'', N'', 1)
GO
INSERT [dbo].[MediaOutlet] ([ID], [Name], [MediaCloudID], [DomainName], [MediaOutletTypeID]) VALUES (77, N'Wikileaks', N'', N'', 1)
GO
INSERT [dbo].[MediaOutlet] ([ID], [Name], [MediaCloudID], [DomainName], [MediaOutletTypeID]) VALUES (78, N'RT', N'', N'', 1)
GO
INSERT [dbo].[MediaOutlet] ([ID], [Name], [MediaCloudID], [DomainName], [MediaOutletTypeID]) VALUES (79, N'LA Times', N'6', N'latimes.com', 3)
GO
INSERT [dbo].[MediaOutlet] ([ID], [Name], [MediaCloudID], [DomainName], [MediaOutletTypeID]) VALUES (80, N'Foreign Policy', N'', N'', 1)
GO
INSERT [dbo].[MediaOutlet] ([ID], [Name], [MediaCloudID], [DomainName], [MediaOutletTypeID]) VALUES (81, N'BBC', N'', N'', 1)
GO
INSERT [dbo].[MediaOutlet] ([ID], [Name], [MediaCloudID], [DomainName], [MediaOutletTypeID]) VALUES (82, N'Washington Examiner', N'', N'', 1)
GO
INSERT [dbo].[MediaOutlet] ([ID], [Name], [MediaCloudID], [DomainName], [MediaOutletTypeID]) VALUES (83, N'Fortune', N'', N'', 1)
GO
INSERT [dbo].[MediaOutlet] ([ID], [Name], [MediaCloudID], [DomainName], [MediaOutletTypeID]) VALUES (84, N'Wired', N'', N'', 1)
GO
INSERT [dbo].[MediaOutlet] ([ID], [Name], [MediaCloudID], [DomainName], [MediaOutletTypeID]) VALUES (85, N'US Department of Treasury', N'', N'', 1)
GO
INSERT [dbo].[MediaOutlet] ([ID], [Name], [MediaCloudID], [DomainName], [MediaOutletTypeID]) VALUES (86, N'CBS Miami', N'', N'', 1)
GO
INSERT [dbo].[MediaOutlet] ([ID], [Name], [MediaCloudID], [DomainName], [MediaOutletTypeID]) VALUES (87, N'US Senate', N'', N'', 1)
GO
INSERT [dbo].[MediaOutlet] ([ID], [Name], [MediaCloudID], [DomainName], [MediaOutletTypeID]) VALUES (88, N'AJC', N'', N'', 1)
GO
INSERT [dbo].[MediaOutlet] ([ID], [Name], [MediaCloudID], [DomainName], [MediaOutletTypeID]) VALUES (89, N'Kyiv Post', N'', N'', 1)
GO
INSERT [dbo].[MediaOutlet] ([ID], [Name], [MediaCloudID], [DomainName], [MediaOutletTypeID]) VALUES (90, N'RBC', N'', N'', 1)
GO
INSERT [dbo].[MediaOutlet] ([ID], [Name], [MediaCloudID], [DomainName], [MediaOutletTypeID]) VALUES (91, N'US Bankrupcy Court', N'', N'', 1)
GO
INSERT [dbo].[MediaOutlet] ([ID], [Name], [MediaCloudID], [DomainName], [MediaOutletTypeID]) VALUES (1094, N'Weekly Standard', N'', N'', 1)
GO
INSERT [dbo].[MediaOutlet] ([ID], [Name], [MediaCloudID], [DomainName], [MediaOutletTypeID]) VALUES (1095, N'NY Daily News', N'', N'', 1)
GO
INSERT [dbo].[MediaOutlet] ([ID], [Name], [MediaCloudID], [DomainName], [MediaOutletTypeID]) VALUES (1096, N'CBS News', N'1752', N'cbsnews.com', 4)
GO
INSERT [dbo].[MediaOutlet] ([ID], [Name], [MediaCloudID], [DomainName], [MediaOutletTypeID]) VALUES (1097, N'Russia Matters', N'', N'', 1)
GO
INSERT [dbo].[MediaOutlet] ([ID], [Name], [MediaCloudID], [DomainName], [MediaOutletTypeID]) VALUES (1098, N'Real Clear Politics', N'', N'', 1)
GO
INSERT [dbo].[MediaOutlet] ([ID], [Name], [MediaCloudID], [DomainName], [MediaOutletTypeID]) VALUES (1099, N'Detriot News', N'', N'', 1)
GO
INSERT [dbo].[MediaOutlet] ([ID], [Name], [MediaCloudID], [DomainName], [MediaOutletTypeID]) VALUES (1100, N'The Aspen Institute', N'', N'', 1)
GO
INSERT [dbo].[MediaOutlet] ([ID], [Name], [MediaCloudID], [DomainName], [MediaOutletTypeID]) VALUES (1101, N'The Telegraph', N'', N'', 1)
GO
INSERT [dbo].[MediaOutlet] ([ID], [Name], [MediaCloudID], [DomainName], [MediaOutletTypeID]) VALUES (1102, N'Director of National Intelligence', N'', N'', 1)
GO
INSERT [dbo].[MediaOutlet] ([ID], [Name], [MediaCloudID], [DomainName], [MediaOutletTypeID]) VALUES (1103, N'US Computer Emergency Readiness Team', N'', N'', 1)
GO
INSERT [dbo].[MediaOutlet] ([ID], [Name], [MediaCloudID], [DomainName], [MediaOutletTypeID]) VALUES (1105, N'Judicial Watch', N'', N'', 1)
GO
INSERT [dbo].[MediaOutlet] ([ID], [Name], [MediaCloudID], [DomainName], [MediaOutletTypeID]) VALUES (1108, N'New Yorker', N'1101', N'newyorker.com', 3)
GO
INSERT [dbo].[MediaOutlet] ([ID], [Name], [MediaCloudID], [DomainName], [MediaOutletTypeID]) VALUES (1110, N'National Review', N'', N'', 1)
GO
INSERT [dbo].[MediaOutlet] ([ID], [Name], [MediaCloudID], [DomainName], [MediaOutletTypeID]) VALUES (1111, N'Rolling Stone', N'', N'', 1)
GO
INSERT [dbo].[MediaOutlet] ([ID], [Name], [MediaCloudID], [DomainName], [MediaOutletTypeID]) VALUES (1112, N'MSNBC', N'', N'', 1)
GO
INSERT [dbo].[MediaOutlet] ([ID], [Name], [MediaCloudID], [DomainName], [MediaOutletTypeID]) VALUES (1113, N'Esquire', N'', N'', 1)
GO
INSERT [dbo].[MediaOutlet] ([ID], [Name], [MediaCloudID], [DomainName], [MediaOutletTypeID]) VALUES (1121, N'Chicago Tribune', N'', N'', 1)
GO
INSERT [dbo].[MediaOutlet] ([ID], [Name], [MediaCloudID], [DomainName], [MediaOutletTypeID]) VALUES (1122, N'', N'', N'', 1)
GO
INSERT [dbo].[MediaOutlet] ([ID], [Name], [MediaCloudID], [DomainName], [MediaOutletTypeID]) VALUES (1127, N'History Channel', N'', N'', 1)
GO
INSERT [dbo].[MediaOutlet] ([ID], [Name], [MediaCloudID], [DomainName], [MediaOutletTypeID]) VALUES (1129, N'Third Way', N'', N'', 1)
GO
INSERT [dbo].[MediaOutlet] ([ID], [Name], [MediaCloudID], [DomainName], [MediaOutletTypeID]) VALUES (1130, N'Hollywood Reporter', N'', N'', 1)
GO
INSERT [dbo].[MediaOutlet] ([ID], [Name], [MediaCloudID], [DomainName], [MediaOutletTypeID]) VALUES (1131, N'MarketWatch', N'', N'', 1)
GO
INSERT [dbo].[MediaOutlet] ([ID], [Name], [MediaCloudID], [DomainName], [MediaOutletTypeID]) VALUES (1132, N'Global Policy Journal', N'', N'', 1)
GO
INSERT [dbo].[MediaOutlet] ([ID], [Name], [MediaCloudID], [DomainName], [MediaOutletTypeID]) VALUES (1133, N'Charlotte Observer', N'', N'', 1)
GO
INSERT [dbo].[MediaOutlet] ([ID], [Name], [MediaCloudID], [DomainName], [MediaOutletTypeID]) VALUES (1134, N'Dailymotion', N'', N'', 1)
GO
INSERT [dbo].[MediaOutlet] ([ID], [Name], [MediaCloudID], [DomainName], [MediaOutletTypeID]) VALUES (1135, N'The Diplomat', N'', N'', 1)
GO
INSERT [dbo].[MediaOutlet] ([ID], [Name], [MediaCloudID], [DomainName], [MediaOutletTypeID]) VALUES (1136, N'Google Docs', N'', N'', 1)
GO
INSERT [dbo].[MediaOutlet] ([ID], [Name], [MediaCloudID], [DomainName], [MediaOutletTypeID]) VALUES (1138, N'American Diplomacy', N'', N'', 1)
GO
INSERT [dbo].[MediaOutlet] ([ID], [Name], [MediaCloudID], [DomainName], [MediaOutletTypeID]) VALUES (1139, N'Protect America Today', N'', N'', 1)
GO
INSERT [dbo].[MediaOutlet] ([ID], [Name], [MediaCloudID], [DomainName], [MediaOutletTypeID]) VALUES (1141, N'Haaretz', N'', N'', 1)
GO
INSERT [dbo].[MediaOutlet] ([ID], [Name], [MediaCloudID], [DomainName], [MediaOutletTypeID]) VALUES (1142, N'SnappyTV', N'', N'', 1)
GO
INSERT [dbo].[MediaOutlet] ([ID], [Name], [MediaCloudID], [DomainName], [MediaOutletTypeID]) VALUES (1143, N'Caputo PR', N'', N'', 1)
GO
INSERT [dbo].[MediaOutlet] ([ID], [Name], [MediaCloudID], [DomainName], [MediaOutletTypeID]) VALUES (1144, N'New York Magazine', N'', N'', 1)
GO
INSERT [dbo].[MediaOutlet] ([ID], [Name], [MediaCloudID], [DomainName], [MediaOutletTypeID]) VALUES (1146, N'WJLA', N'', N'', 1)
GO
INSERT [dbo].[MediaOutlet] ([ID], [Name], [MediaCloudID], [DomainName], [MediaOutletTypeID]) VALUES (1147, N'King and Spalding Law Firm', N'', N'', 1)
GO
INSERT [dbo].[MediaOutlet] ([ID], [Name], [MediaCloudID], [DomainName], [MediaOutletTypeID]) VALUES (1148, N'Jewish Journal', N'', N'', 1)
GO
INSERT [dbo].[MediaOutlet] ([ID], [Name], [MediaCloudID], [DomainName], [MediaOutletTypeID]) VALUES (1149, N'Bank of Cyprus', N'', N'', 1)
GO
INSERT [dbo].[MediaOutlet] ([ID], [Name], [MediaCloudID], [DomainName], [MediaOutletTypeID]) VALUES (1150, N'Alliance for Securing Democracy', N'', N'', 1)
GO
INSERT [dbo].[MediaOutlet] ([ID], [Name], [MediaCloudID], [DomainName], [MediaOutletTypeID]) VALUES (1151, N'Daily Caller', N'18775', N'dailycaller.com', 2)
GO
INSERT [dbo].[MediaOutlet] ([ID], [Name], [MediaCloudID], [DomainName], [MediaOutletTypeID]) VALUES (1153, N'NATO Joint Warface Center', N'', N'', 1)
GO
INSERT [dbo].[MediaOutlet] ([ID], [Name], [MediaCloudID], [DomainName], [MediaOutletTypeID]) VALUES (1156, N'JD Gordon Communications', N'', N'', 1)
GO
INSERT [dbo].[MediaOutlet] ([ID], [Name], [MediaCloudID], [DomainName], [MediaOutletTypeID]) VALUES (1161, N'Crocus Group', N'', N'', 1)
GO
INSERT [dbo].[MediaOutlet] ([ID], [Name], [MediaCloudID], [DomainName], [MediaOutletTypeID]) VALUES (1162, N'Brown University', N'', N'', 1)
GO
INSERT [dbo].[MediaOutlet] ([ID], [Name], [MediaCloudID], [DomainName], [MediaOutletTypeID]) VALUES (1164, N'Heavy', N'', N'', 1)
GO
INSERT [dbo].[MediaOutlet] ([ID], [Name], [MediaCloudID], [DomainName], [MediaOutletTypeID]) VALUES (1165, N'Corriere Della Sera', N'', N'', 1)
GO
INSERT [dbo].[MediaOutlet] ([ID], [Name], [MediaCloudID], [DomainName], [MediaOutletTypeID]) VALUES (1166, N'Observer', N'', N'', 1)
GO
INSERT [dbo].[MediaOutlet] ([ID], [Name], [MediaCloudID], [DomainName], [MediaOutletTypeID]) VALUES (1173, N'ABC 7 Chicago', N'', N'', 1)
GO
INSERT [dbo].[MediaOutlet] ([ID], [Name], [MediaCloudID], [DomainName], [MediaOutletTypeID]) VALUES (1174, N'The Kremlin', N'', N'', 1)
GO
INSERT [dbo].[MediaOutlet] ([ID], [Name], [MediaCloudID], [DomainName], [MediaOutletTypeID]) VALUES (1176, N'News 1 NY', N'', N'', 1)
GO
INSERT [dbo].[MediaOutlet] ([ID], [Name], [MediaCloudID], [DomainName], [MediaOutletTypeID]) VALUES (1177, N'Russian Federation - Ministry of Foreign Affairs', N'', N'', 1)
GO
INSERT [dbo].[MediaOutlet] ([ID], [Name], [MediaCloudID], [DomainName], [MediaOutletTypeID]) VALUES (1178, N'Sky News', N'', N'', 1)
GO
INSERT [dbo].[MediaOutlet] ([ID], [Name], [MediaCloudID], [DomainName], [MediaOutletTypeID]) VALUES (1182, N'LBC', N'', N'', 1)
GO
INSERT [dbo].[MediaOutlet] ([ID], [Name], [MediaCloudID], [DomainName], [MediaOutletTypeID]) VALUES (1183, N'Vox', N'104828', N'vox.com', 2)
GO
INSERT [dbo].[MediaOutlet] ([ID], [Name], [MediaCloudID], [DomainName], [MediaOutletTypeID]) VALUES (1184, N'Drudge Report', N'1145', N'drudgereport.com', 2)
GO
INSERT [dbo].[MediaOutlet] ([ID], [Name], [MediaCloudID], [DomainName], [MediaOutletTypeID]) VALUES (1185, N'Yahoo Finance', N'18840', N'finance.yahoo.com', 2)
GO
INSERT [dbo].[MediaOutlet] ([ID], [Name], [MediaCloudID], [DomainName], [MediaOutletTypeID]) VALUES (1186, N'Newsmax', N'25349', N'newsmax.com', 2)
GO
INSERT [dbo].[MediaOutlet] ([ID], [Name], [MediaCloudID], [DomainName], [MediaOutletTypeID]) VALUES (1187, N'Slate', N'19643', N'slate.com', 2)
GO
INSERT [dbo].[MediaOutlet] ([ID], [Name], [MediaCloudID], [DomainName], [MediaOutletTypeID]) VALUES (1188, N'The Blaze', N'22088', N'theblaze.com', 2)
GO
INSERT [dbo].[MediaOutlet] ([ID], [Name], [MediaCloudID], [DomainName], [MediaOutletTypeID]) VALUES (1189, N'Wall Street Journal Blogs', N'18839', N'blogs.wsj.com', 3)
GO
INSERT [dbo].[MediaOutlet] ([ID], [Name], [MediaCloudID], [DomainName], [MediaOutletTypeID]) VALUES (1190, N'The Guardian - US', N'623382', N'theguardian.com/us', 3)
GO
INSERT [dbo].[MediaOutlet] ([ID], [Name], [MediaCloudID], [DomainName], [MediaOutletTypeID]) VALUES (1191, N'The Daily News', N'8', N'nydailynews.com', 3)
GO
SET IDENTITY_INSERT [dbo].[MediaOutlet] OFF
GO
SET IDENTITY_INSERT [dbo].[MediaOutletBiasRating] ON 
GO
INSERT [dbo].[MediaOutletBiasRating] ([ID], [MediaOutletID], [BiasRatingID], [BiasRatingSourceID]) VALUES (8, 2, 3, 1)
GO
INSERT [dbo].[MediaOutletBiasRating] ([ID], [MediaOutletID], [BiasRatingID], [BiasRatingSourceID]) VALUES (36, 3, 4, 1)
GO
INSERT [dbo].[MediaOutletBiasRating] ([ID], [MediaOutletID], [BiasRatingID], [BiasRatingSourceID]) VALUES (47, 15, 3, 1)
GO
INSERT [dbo].[MediaOutletBiasRating] ([ID], [MediaOutletID], [BiasRatingID], [BiasRatingSourceID]) VALUES (34, 21, 4, 1)
GO
INSERT [dbo].[MediaOutletBiasRating] ([ID], [MediaOutletID], [BiasRatingID], [BiasRatingSourceID]) VALUES (9, 22, 3, 1)
GO
INSERT [dbo].[MediaOutletBiasRating] ([ID], [MediaOutletID], [BiasRatingID], [BiasRatingSourceID]) VALUES (1, 26, 3, 1)
GO
INSERT [dbo].[MediaOutletBiasRating] ([ID], [MediaOutletID], [BiasRatingID], [BiasRatingSourceID]) VALUES (11, 31, 4, 1)
GO
INSERT [dbo].[MediaOutletBiasRating] ([ID], [MediaOutletID], [BiasRatingID], [BiasRatingSourceID]) VALUES (43, 34, 4, 1)
GO
INSERT [dbo].[MediaOutletBiasRating] ([ID], [MediaOutletID], [BiasRatingID], [BiasRatingSourceID]) VALUES (3, 35, 4, 1)
GO
INSERT [dbo].[MediaOutletBiasRating] ([ID], [MediaOutletID], [BiasRatingID], [BiasRatingSourceID]) VALUES (13, 40, 7, 1)
GO
INSERT [dbo].[MediaOutletBiasRating] ([ID], [MediaOutletID], [BiasRatingID], [BiasRatingSourceID]) VALUES (7, 41, 2, 1)
GO
INSERT [dbo].[MediaOutletBiasRating] ([ID], [MediaOutletID], [BiasRatingID], [BiasRatingSourceID]) VALUES (5, 42, 3, 1)
GO
INSERT [dbo].[MediaOutletBiasRating] ([ID], [MediaOutletID], [BiasRatingID], [BiasRatingSourceID]) VALUES (39, 46, 5, 1)
GO
INSERT [dbo].[MediaOutletBiasRating] ([ID], [MediaOutletID], [BiasRatingID], [BiasRatingSourceID]) VALUES (33, 47, 2, 1)
GO
INSERT [dbo].[MediaOutletBiasRating] ([ID], [MediaOutletID], [BiasRatingID], [BiasRatingSourceID]) VALUES (4, 48, 4, 1)
GO
INSERT [dbo].[MediaOutletBiasRating] ([ID], [MediaOutletID], [BiasRatingID], [BiasRatingSourceID]) VALUES (24, 49, 1, 1)
GO
INSERT [dbo].[MediaOutletBiasRating] ([ID], [MediaOutletID], [BiasRatingID], [BiasRatingSourceID]) VALUES (41, 50, 4, 1)
GO
INSERT [dbo].[MediaOutletBiasRating] ([ID], [MediaOutletID], [BiasRatingID], [BiasRatingSourceID]) VALUES (12, 51, 7, 1)
GO
INSERT [dbo].[MediaOutletBiasRating] ([ID], [MediaOutletID], [BiasRatingID], [BiasRatingSourceID]) VALUES (17, 52, 2, 1)
GO
INSERT [dbo].[MediaOutletBiasRating] ([ID], [MediaOutletID], [BiasRatingID], [BiasRatingSourceID]) VALUES (25, 53, 5, 1)
GO
INSERT [dbo].[MediaOutletBiasRating] ([ID], [MediaOutletID], [BiasRatingID], [BiasRatingSourceID]) VALUES (90, 54, 1, 1)
GO
INSERT [dbo].[MediaOutletBiasRating] ([ID], [MediaOutletID], [BiasRatingID], [BiasRatingSourceID]) VALUES (93, 55, 1, 1)
GO
INSERT [dbo].[MediaOutletBiasRating] ([ID], [MediaOutletID], [BiasRatingID], [BiasRatingSourceID]) VALUES (85, 56, 4, 1)
GO
INSERT [dbo].[MediaOutletBiasRating] ([ID], [MediaOutletID], [BiasRatingID], [BiasRatingSourceID]) VALUES (74, 57, 1, 1)
GO
INSERT [dbo].[MediaOutletBiasRating] ([ID], [MediaOutletID], [BiasRatingID], [BiasRatingSourceID]) VALUES (81, 59, 1, 1)
GO
INSERT [dbo].[MediaOutletBiasRating] ([ID], [MediaOutletID], [BiasRatingID], [BiasRatingSourceID]) VALUES (29, 60, 1, 1)
GO
INSERT [dbo].[MediaOutletBiasRating] ([ID], [MediaOutletID], [BiasRatingID], [BiasRatingSourceID]) VALUES (16, 61, 4, 1)
GO
INSERT [dbo].[MediaOutletBiasRating] ([ID], [MediaOutletID], [BiasRatingID], [BiasRatingSourceID]) VALUES (77, 62, 1, 1)
GO
INSERT [dbo].[MediaOutletBiasRating] ([ID], [MediaOutletID], [BiasRatingID], [BiasRatingSourceID]) VALUES (30, 63, 3, 1)
GO
INSERT [dbo].[MediaOutletBiasRating] ([ID], [MediaOutletID], [BiasRatingID], [BiasRatingSourceID]) VALUES (45, 64, 2, 1)
GO
INSERT [dbo].[MediaOutletBiasRating] ([ID], [MediaOutletID], [BiasRatingID], [BiasRatingSourceID]) VALUES (79, 65, 2, 1)
GO
INSERT [dbo].[MediaOutletBiasRating] ([ID], [MediaOutletID], [BiasRatingID], [BiasRatingSourceID]) VALUES (101, 66, 3, 1)
GO
INSERT [dbo].[MediaOutletBiasRating] ([ID], [MediaOutletID], [BiasRatingID], [BiasRatingSourceID]) VALUES (46, 67, 3, 1)
GO
INSERT [dbo].[MediaOutletBiasRating] ([ID], [MediaOutletID], [BiasRatingID], [BiasRatingSourceID]) VALUES (88, 68, 1, 1)
GO
INSERT [dbo].[MediaOutletBiasRating] ([ID], [MediaOutletID], [BiasRatingID], [BiasRatingSourceID]) VALUES (98, 69, 1, 1)
GO
INSERT [dbo].[MediaOutletBiasRating] ([ID], [MediaOutletID], [BiasRatingID], [BiasRatingSourceID]) VALUES (32, 70, 3, 1)
GO
INSERT [dbo].[MediaOutletBiasRating] ([ID], [MediaOutletID], [BiasRatingID], [BiasRatingSourceID]) VALUES (42, 71, 3, 1)
GO
INSERT [dbo].[MediaOutletBiasRating] ([ID], [MediaOutletID], [BiasRatingID], [BiasRatingSourceID]) VALUES (40, 72, 1, 1)
GO
INSERT [dbo].[MediaOutletBiasRating] ([ID], [MediaOutletID], [BiasRatingID], [BiasRatingSourceID]) VALUES (27, 73, 4, 1)
GO
INSERT [dbo].[MediaOutletBiasRating] ([ID], [MediaOutletID], [BiasRatingID], [BiasRatingSourceID]) VALUES (38, 74, 3, 1)
GO
INSERT [dbo].[MediaOutletBiasRating] ([ID], [MediaOutletID], [BiasRatingID], [BiasRatingSourceID]) VALUES (10, 75, 3, 1)
GO
INSERT [dbo].[MediaOutletBiasRating] ([ID], [MediaOutletID], [BiasRatingID], [BiasRatingSourceID]) VALUES (28, 76, 3, 1)
GO
INSERT [dbo].[MediaOutletBiasRating] ([ID], [MediaOutletID], [BiasRatingID], [BiasRatingSourceID]) VALUES (86, 77, 1, 1)
GO
INSERT [dbo].[MediaOutletBiasRating] ([ID], [MediaOutletID], [BiasRatingID], [BiasRatingSourceID]) VALUES (102, 78, 1, 1)
GO
INSERT [dbo].[MediaOutletBiasRating] ([ID], [MediaOutletID], [BiasRatingID], [BiasRatingSourceID]) VALUES (18, 79, 3, 1)
GO
INSERT [dbo].[MediaOutletBiasRating] ([ID], [MediaOutletID], [BiasRatingID], [BiasRatingSourceID]) VALUES (89, 80, 1, 1)
GO
INSERT [dbo].[MediaOutletBiasRating] ([ID], [MediaOutletID], [BiasRatingID], [BiasRatingSourceID]) VALUES (44, 81, 4, 1)
GO
INSERT [dbo].[MediaOutletBiasRating] ([ID], [MediaOutletID], [BiasRatingID], [BiasRatingSourceID]) VALUES (82, 82, 6, 1)
GO
INSERT [dbo].[MediaOutletBiasRating] ([ID], [MediaOutletID], [BiasRatingID], [BiasRatingSourceID]) VALUES (75, 83, 4, 1)
GO
INSERT [dbo].[MediaOutletBiasRating] ([ID], [MediaOutletID], [BiasRatingID], [BiasRatingSourceID]) VALUES (95, 84, 1, 1)
GO
INSERT [dbo].[MediaOutletBiasRating] ([ID], [MediaOutletID], [BiasRatingID], [BiasRatingSourceID]) VALUES (73, 85, 1, 1)
GO
INSERT [dbo].[MediaOutletBiasRating] ([ID], [MediaOutletID], [BiasRatingID], [BiasRatingSourceID]) VALUES (103, 86, 1, 1)
GO
INSERT [dbo].[MediaOutletBiasRating] ([ID], [MediaOutletID], [BiasRatingID], [BiasRatingSourceID]) VALUES (31, 87, 1, 1)
GO
INSERT [dbo].[MediaOutletBiasRating] ([ID], [MediaOutletID], [BiasRatingID], [BiasRatingSourceID]) VALUES (83, 88, 3, 1)
GO
INSERT [dbo].[MediaOutletBiasRating] ([ID], [MediaOutletID], [BiasRatingID], [BiasRatingSourceID]) VALUES (97, 89, 1, 1)
GO
INSERT [dbo].[MediaOutletBiasRating] ([ID], [MediaOutletID], [BiasRatingID], [BiasRatingSourceID]) VALUES (80, 90, 1, 1)
GO
INSERT [dbo].[MediaOutletBiasRating] ([ID], [MediaOutletID], [BiasRatingID], [BiasRatingSourceID]) VALUES (91, 91, 1, 1)
GO
INSERT [dbo].[MediaOutletBiasRating] ([ID], [MediaOutletID], [BiasRatingID], [BiasRatingSourceID]) VALUES (99, 1094, 7, 1)
GO
INSERT [dbo].[MediaOutletBiasRating] ([ID], [MediaOutletID], [BiasRatingID], [BiasRatingSourceID]) VALUES (84, 1095, 4, 1)
GO
INSERT [dbo].[MediaOutletBiasRating] ([ID], [MediaOutletID], [BiasRatingID], [BiasRatingSourceID]) VALUES (37, 1096, 3, 1)
GO
INSERT [dbo].[MediaOutletBiasRating] ([ID], [MediaOutletID], [BiasRatingID], [BiasRatingSourceID]) VALUES (100, 1097, 1, 1)
GO
INSERT [dbo].[MediaOutletBiasRating] ([ID], [MediaOutletID], [BiasRatingID], [BiasRatingSourceID]) VALUES (72, 1098, 4, 1)
GO
INSERT [dbo].[MediaOutletBiasRating] ([ID], [MediaOutletID], [BiasRatingID], [BiasRatingSourceID]) VALUES (87, 1099, 1, 1)
GO
INSERT [dbo].[MediaOutletBiasRating] ([ID], [MediaOutletID], [BiasRatingID], [BiasRatingSourceID]) VALUES (96, 1100, 1, 1)
GO
INSERT [dbo].[MediaOutletBiasRating] ([ID], [MediaOutletID], [BiasRatingID], [BiasRatingSourceID]) VALUES (78, 1101, 6, 1)
GO
INSERT [dbo].[MediaOutletBiasRating] ([ID], [MediaOutletID], [BiasRatingID], [BiasRatingSourceID]) VALUES (76, 1102, 1, 1)
GO
INSERT [dbo].[MediaOutletBiasRating] ([ID], [MediaOutletID], [BiasRatingID], [BiasRatingSourceID]) VALUES (94, 1103, 1, 1)
GO
INSERT [dbo].[MediaOutletBiasRating] ([ID], [MediaOutletID], [BiasRatingID], [BiasRatingSourceID]) VALUES (48, 1105, 6, 1)
GO
INSERT [dbo].[MediaOutletBiasRating] ([ID], [MediaOutletID], [BiasRatingID], [BiasRatingSourceID]) VALUES (22, 1108, 2, 1)
GO
INSERT [dbo].[MediaOutletBiasRating] ([ID], [MediaOutletID], [BiasRatingID], [BiasRatingSourceID]) VALUES (92, 1136, 1, 1)
GO
INSERT [dbo].[MediaOutletBiasRating] ([ID], [MediaOutletID], [BiasRatingID], [BiasRatingSourceID]) VALUES (6, 1151, 7, 1)
GO
INSERT [dbo].[MediaOutletBiasRating] ([ID], [MediaOutletID], [BiasRatingID], [BiasRatingSourceID]) VALUES (15, 1183, 2, 1)
GO
INSERT [dbo].[MediaOutletBiasRating] ([ID], [MediaOutletID], [BiasRatingID], [BiasRatingSourceID]) VALUES (26, 1184, 7, 1)
GO
INSERT [dbo].[MediaOutletBiasRating] ([ID], [MediaOutletID], [BiasRatingID], [BiasRatingSourceID]) VALUES (19, 1185, 4, 1)
GO
INSERT [dbo].[MediaOutletBiasRating] ([ID], [MediaOutletID], [BiasRatingID], [BiasRatingSourceID]) VALUES (14, 1186, 7, 1)
GO
INSERT [dbo].[MediaOutletBiasRating] ([ID], [MediaOutletID], [BiasRatingID], [BiasRatingSourceID]) VALUES (20, 1187, 2, 1)
GO
INSERT [dbo].[MediaOutletBiasRating] ([ID], [MediaOutletID], [BiasRatingID], [BiasRatingSourceID]) VALUES (23, 1188, 7, 1)
GO
INSERT [dbo].[MediaOutletBiasRating] ([ID], [MediaOutletID], [BiasRatingID], [BiasRatingSourceID]) VALUES (21, 1190, 3, 1)
GO
INSERT [dbo].[MediaOutletBiasRating] ([ID], [MediaOutletID], [BiasRatingID], [BiasRatingSourceID]) VALUES (35, 1191, 2, 1)
GO
SET IDENTITY_INSERT [dbo].[MediaOutletBiasRating] OFF
GO
SET IDENTITY_INSERT [dbo].[MediaOutletType] ON 
GO
INSERT [dbo].[MediaOutletType] ([ID], [Name], [MediaCloudCode]) VALUES (1, N'Other', N'other')
GO
INSERT [dbo].[MediaOutletType] ([ID], [Name], [MediaCloudCode]) VALUES (2, N'Digital Native', N'digital_native')
GO
INSERT [dbo].[MediaOutletType] ([ID], [Name], [MediaCloudCode]) VALUES (3, N'Print Native', N'print_native')
GO
INSERT [dbo].[MediaOutletType] ([ID], [Name], [MediaCloudCode]) VALUES (4, N'Video Broadcast', N'video_broadcast')
GO
INSERT [dbo].[MediaOutletType] ([ID], [Name], [MediaCloudCode]) VALUES (5, N'Twitter', N'twitter')
GO
INSERT [dbo].[MediaOutletType] ([ID], [Name], [MediaCloudCode]) VALUES (6, N'US Government Agency', N'usg_agency')
GO
INSERT [dbo].[MediaOutletType] ([ID], [Name], [MediaCloudCode]) VALUES (7, N'Facebook', N'facebook')
GO
INSERT [dbo].[MediaOutletType] ([ID], [Name], [MediaCloudCode]) VALUES (8, N'Advocacy Group', N'advocacy_group')
GO
SET IDENTITY_INSERT [dbo].[MediaOutletType] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [U_BiasRating_Name]    Script Date: 12/26/2018 5:58:27 PM ******/
ALTER TABLE [dbo].[BiasRating] ADD  CONSTRAINT [U_BiasRating_Name] UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [U_BiasRatingSource_Name]    Script Date: 12/26/2018 5:58:27 PM ******/
ALTER TABLE [dbo].[BiasRatingSource] ADD  CONSTRAINT [U_BiasRatingSource_Name] UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [U_MediaOutletBiasRating]    Script Date: 12/26/2018 5:58:27 PM ******/
ALTER TABLE [dbo].[MediaOutletBiasRating] ADD  CONSTRAINT [U_MediaOutletBiasRating] UNIQUE NONCLUSTERED 
(
	[MediaOutletID] ASC,
	[BiasRatingID] ASC,
	[BiasRatingSourceID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__MediaOut__737584F680E3999C]    Script Date: 12/26/2018 5:58:27 PM ******/
ALTER TABLE [dbo].[MediaOutletType] ADD UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__MediaOut__FB3D314E4C6A7140]    Script Date: 12/26/2018 5:58:27 PM ******/
ALTER TABLE [dbo].[MediaOutletType] ADD UNIQUE NONCLUSTERED 
(
	[MediaCloudCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[BiasRating] ADD  DEFAULT ((1)) FOR [Name]
GO
ALTER TABLE [dbo].[BiasRating] ADD  DEFAULT ((0)) FOR [Ordering]
GO
ALTER TABLE [dbo].[BiasRatingSource] ADD  DEFAULT ((1)) FOR [Name]
GO
ALTER TABLE [dbo].[MediaOutlet] ADD  DEFAULT ('') FOR [Name]
GO
ALTER TABLE [dbo].[MediaOutlet] ADD  DEFAULT ('') FOR [MediaCloudID]
GO
ALTER TABLE [dbo].[MediaOutlet] ADD  DEFAULT ('') FOR [DomainName]
GO
ALTER TABLE [dbo].[MediaOutlet] ADD  DEFAULT ((1)) FOR [MediaOutletTypeID]
GO
ALTER TABLE [dbo].[MediaOutlet]  WITH CHECK ADD FOREIGN KEY([MediaOutletTypeID])
REFERENCES [dbo].[MediaOutletType] ([ID])
GO
ALTER TABLE [dbo].[MediaOutletBiasRating]  WITH CHECK ADD FOREIGN KEY([BiasRatingID])
REFERENCES [dbo].[BiasRating] ([ID])
GO
ALTER TABLE [dbo].[MediaOutletBiasRating]  WITH CHECK ADD FOREIGN KEY([BiasRatingSourceID])
REFERENCES [dbo].[BiasRatingSource] ([ID])
GO
ALTER TABLE [dbo].[MediaOutletBiasRating]  WITH CHECK ADD FOREIGN KEY([MediaOutletID])
REFERENCES [dbo].[MediaOutlet] ([ID])
GO
