USE RussiaNews
GO

DROP FUNCTION dbo.FormatNewspaperDate
GO
CREATE FUNCTION [dbo].[FormatNewspaperDate] (@date varchar(100)) 
RETURNS varchar(30) AS 
BEGIN
	IF @date = ''
		RETURN ''

	if @date IS NULL
		return ''

	-- https://stackoverflow.com/questions/74385/how-to-convert-datetime-to-varchar
	DECLARE @add20 varchar(100)
	SET @add20 = SUBSTRING(@date, 1, 6) + '20' + SUBSTRING(@date, 7, 9)
	
	DECLARE @goodDate date

	SET @goodDate = CONVERT(date, @add20)
	RETURN CONVERT(varchar(10), @goodDate, 23)
END
GO


