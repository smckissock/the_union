USE TheUnion
GO


CREATE  OR ALTER  FUNCTION dbo.ID (@tableName varchar(100), @name varchar(100))
RETURNS int
AS
BEGIN
	DECLARE @Id int;
	SET @ID = 0;

	IF @tableName = 'AppType' BEGIN SELECT @Id = ID FROM AppType WHERE Name = @name END;
	IF @tableName = 'App' BEGIN SELECT @Id = ID FROM App WHERE Name = @name END;
	IF @tableName = 'Term' BEGIN SELECT @Id = ID FROM Term WHERE Name = @name END;
	IF @tableName = 'MediaCloudCollection' BEGIN SELECT @Id = ID FROM MediaCloudCollection WHERE Name = @name END;

    RETURN @Id
END