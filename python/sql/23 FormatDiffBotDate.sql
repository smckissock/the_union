USE RussiaNews
GO


DROP FUNCTION dbo.FormatDiffBotDate
GO
CREATE FUNCTION [dbo].[FormatDiffBotDate] (@date varchar(100)) 
RETURNS varchar(30) AS 
BEGIN
	IF @date = ''
		RETURN ''

	-- https://stackoverflow.com/questions/74385/how-to-convert-datetime-to-varchar
	DECLARE @noGmt varchar(100)
	SET @noGmt = SUBSTRING(@date, 1, LEN(@date) - 13)

	DECLARE @noWeekday varchar(100)
	SET @noWeekday = SUBSTRING(@noGmt, 6, LEN(@noGmt) - 5)

	DECLARE @goodDate date
	SET @goodDate = CONVERT(date, @noWeekday)
	   
	RETURN CONVERT(varchar(10), @goodDate, 23)
END
GO


--SELECT dbo.FormatDiffBotDate ('Mon, 28 Aug 2017 00:00:00 GMT') 
--SELECT  dbo.FormatDiffBotDate(EstimatedDate) FROM DiffBotStory

