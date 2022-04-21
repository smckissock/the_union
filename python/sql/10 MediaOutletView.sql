USE [RussiaNews]
GO

CREATE VIEW [dbo].[MediaOutletView] 
-- Problem - does not return all media outlets...
AS
SELECT 
	m.ID,
	m.Name,
	mt.Name MediaType,
	b.Name BiasRating,
	CASE b.Name
		WHEN 'Center' THEN 1 
		WHEN 'Mixed' THEN 2 
		WHEN 'Center Left' THEN 3 
		WHEN 'Center Right' THEN 4 
		WHEN 'Left' THEN 5 
		WHEN 'Right' THEN 6 
		WHEN 'Unspecified' THEN 7 
	END Sort
FROM MediaOutlet m
JOIN MediaOutletType mt ON mt.ID = m.MediaOutletTypeID
LEFT JOIN MediaOutletBiasRating mb ON m.ID = mb.MediaOutletID 
LEFT JOIN BiasRating b ON mb.BiasRatingID = b.ID
WHERE mb.BiasRatingSourceID = 1
GO






