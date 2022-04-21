USE [RussiaNews]
GO


SELECT Count(*) FROM Entity -- 20,996
SELECT Count(*) FROM StoryEntity -- 177,253

EXEC InsertEntityOrganization

CREATE PROCEDURE [dbo].[InsertEntityOrganization]
AS
BEGIN
INSERT INTO Entity 
SELECT DISTINCT  
	2, 
	Label, 
	'', -- no URI
	'', 1  -- no DifBotUri
FROM DiffBotTag 
WHERE RdFTypes Like '%Organisation%' AND RdFTypes NOT Like  '%Populated%'
AND (Label NOT IN (SELECT Name FROM Entity));
END
GO


CREATE PROCEDURE [dbo].[InsertEntityPerson]
AS
BEGIN

INSERT INTO Entity 
SELECT DISTINCT  
	1, 
	Label, 
	'', -- no URI
	''  -- no DifBotUri
	,1
FROM DiffBotTag 
WHERE RdFTypes Like '%Person%' AND RdfTypes NOT LIKE '%Profession%'
AND (Label NOT IN (SELECT Name FROM Entity));
END
GO


CREATE PROCEDURE [dbo].[InsertEntityPlace]
AS
BEGIN

INSERT INTO Entity 
SELECT DISTINCT  
	3, 
	Label, 
	'', -- no URI
	'', 1  -- no DifBotUri
FROM DiffBotTag 
WHERE RdFTypes Like '%Populated%' -- 104
AND (Label NOT IN (SELECT Name FROM Entity));
END
GO


