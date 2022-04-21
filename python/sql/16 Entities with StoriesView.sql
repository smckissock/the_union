USE RussiaNews
GO



CREATE FUNCTION [dbo].[slugify](@string varchar(4000)) 
    RETURNS varchar(4000) AS BEGIN 
    declare @out varchar(4000)

    --convert to ASCII
    set @out = lower(@string COLLATE SQL_Latin1_General_CP1251_CS_AS)

    declare @pi int 
    --I'm sorry T-SQL have no regex. Thanks for patindex, MS .. :-)
    set @pi = patindex('%[^a-z0-9 -]%',@out)
    while @pi>0 begin
        set @out = replace(@out, substring(@out,@pi,1), '')
        --set @out = left(@out,@pi-1) + substring(@out,@pi+1,8000)
        set @pi = patindex('%[^a-z0-9 -]%',@out)
    end

    set @out = ltrim(rtrim(@out))

   -- replace space to hyphen   
   set @out = replace(@out, ' ', '-')

   -- remove double hyphen
   while CHARINDEX('--', @out) > 0 set @out = replace(@out, '--', '-')

   return (@out)
END
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
	--, LOWER(REPLACE(e.Name, ' ', '-')) Slug
FROM Entity e
JOIN RdfType t ON t.ID = e.RdfTypeID
GO


EXEC DropView 'EntitiesWithStoriesView'
GO
CREATE VIEW EntitiesWithStoriesView
AS
 
WITH EntityCounts AS (
	SELECT EntityID, COUNT(*) num 
	FROM StoryEntity
	GROUP BY EntityID
)
SELECT 
	e.ID
	, e.Name
	, e.Type 
	, c.num Stories
	, e.Slug
FROM EntityView e
JOIN EntityCounts c ON c.EntityID = e.ID  
WHERE c.Num > 50 
AND c.Num < 1000  
AND e.Valid = 1 
GO


-- SELECT ID, Type, Name, Stories FROM EntitiesWithStoriesView ORDER BY CASE[Type] WHEN 'Person' THEN 0 WHEN 'Organization' THEN 1 ELSE 2 END, Stories DESC

