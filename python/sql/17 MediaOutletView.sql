USE [RussiaNews]
GO

EXEC DropView 'MediaOutletView'
GO

CREATE VIEW MediaOutletView
AS
SELECT 
	m.ID
	, m.Name 
	, ISNULL(br.Name, 'Unspecified') BiasRating
	, CASE ISNULL(br.Name, 'Unspecified') 
		WHEN 'Left' THEN 0
		WHEN 'Center Left' THEN 1
		WHEN 'Unspecified' THEN 2
		WHEN 'Mixed' THEN 3 
		WHEN 'Center' THEN 4
		WHEN 'Center Right' THEN 5 
		WHEN 'Right' THEN 6
		ELSE 7 END Sort
FROM MediaOutlet m
LEFT JOIN MediaOutletBiasRating mb ON m.ID = mb.MediaOutletID
LEFT JOIN BiasRating br ON mb.BiasRatingID = br.ID
GO


--SELECT ID, Name, BiasRating FROM MediaOutletView ORDER BY Sort, Name


