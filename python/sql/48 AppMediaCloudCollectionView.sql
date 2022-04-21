USE Senate_2019_04_25
GO


ALTER TABLE App Add StartDate date NOT NULL DEFAULT '2015-01-01'
GO

CREATE VIEW [dbo].[AppMediaCloudCollectionView] 
AS
SELECT 
	c.ID MediaCloudCollectionID,
	c.Name MediaCloudCollectionName,
	c.CollectionID,
	a.ShortName App,
	a.ID AppID 
FROM App a
JOIN AppMediaCloudCollection ac ON a.ID = ac.AppID
JOIN MediaCloudCollection c ON ac.MediaCloudCollectionID = c.ID
GO


EXEC DropView 'AppTermView'
GO

CREATE VIEW [dbo].[AppTermView] 
AS
SELECT 
	t.ID TermID,
	t.Name TermName,
	a.ShortName App,
	a.ID AppID, 
	t.Active
FROM App a
JOIN AppTerm at ON a.ID = at.AppID
JOIN Term t ON at.TermID = t.ID
GO

