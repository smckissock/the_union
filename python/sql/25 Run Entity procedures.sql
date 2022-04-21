USE RussiaNews
GO

SELECT Count(*) FROM Entity -- 20,996
SELECT Count(*) FROM StoryEntity -- 177,253


EXEC InsertEntityOrganization
EXEC InsertEntityPerson
EXEC InsertEntityPlace

DELETE FROM StoryEntity
GO

EXEC InsertStoryEntityPerson
EXEC InsertStoryEntityOrganization -- Might be a problem here 
EXEC InsertStoryEntityPlace



