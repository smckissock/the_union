USE [RussiaNews]
GO


EXEC DropView 'EntityView'
GO

CREATE VIEW [dbo].[EntityView]
AS
SELECT 
	e.ID 
	, e.Name
	, t.Name Type
	, e.Valid
	, dbo.Slugify(e.Name) Slug
	, CASE t.Name WHEN 'Person' THEN 0 WHEN 'Organization' THEN 1 ELSE 2 END TypeSort
FROM Entity e
JOIN RdfType t ON t.ID = e.RdfTypeID
GO

