USE DB -- [Senate_2019_04_25]
GO



EXEC DropView 'AppView'
GO

CREATE VIEW AppView 
AS
SELECT
	a.ID,
	a.Name AppName,
	a.ShortName AppSlug,
	a.StartDate,
	at.Name AppTypeName,
	at.Slug AppTypeSlug
FROM App a
JOIN AppType at ON a.AppTypeID = at.ID
GO




EXEC DropView 'AppMediaCloudCollectionView'
GO
CREATE VIEW AppMediaCloudCollectionView
AS
SELECT 
	a.Name AppName,
	a.ShortName App,
	a.ID AppID, 
	c.CollectionID,
	c.ID MediaCloudCollectionID,
	c.Name MediaCloudCollectionName
FROM App a
JOIN AppMediaCloudCollection ac ON a.ID = ac.AppID
JOIN MediaCloudCollection c ON ac.MediaCloudCollectionID = c.ID
GO


-- For use in creating MediaCloudBatch records
EXEC DropView 'AppTermMediaCloudCollectionView'
GO
CREATE VIEW AppTermMediaCloudCollectionView
AS
SELECT 
	t.AppID,
	t.App AppShortName, 
	t.TermName Term,
	t.TermID,
	c.CollectionID,
	c.MediaCloudCollectionID,
	c.MediaCloudCollectionName 
FROM AppTermView t
JOIN AppMediaCloudCollectionView c ON c.AppID = t.AppID
GO


EXEC DropView 'MakeMediaCloudBatchView'
GO
CREATE VIEW MakeMediaCloudBatchView
AS
SELECT DISTINCT
	a.AppID,
	a.AppShortName, 
	a.Term,
	a.TermID,
	a.CollectionID,
	a.MediaCloudCollectionID,
	a.MediaCloudCollectionName, 
	Last.LastRun
FROM AppTermMediaCloudCollectionView a
LEFT JOIN (
	SELECT MediaCloudCollectionID, TermID, MAX(EndDate) LastRun
	FROM MediaCloudBatch
	GROUP BY MediaCloudCollectionID, TermID) Last
ON Last.TermID = a.TermID AND Last.MediaCloudCollectionID = a.MediaCloudCollectionID

