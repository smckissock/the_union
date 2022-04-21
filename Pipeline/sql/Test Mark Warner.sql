USE Senate_2019_04_25
GO


DELETE FROM MediaCloudStory
DELETE FROM MediaCloudBatch

DELETE FROM PipelineError
DELETE FROM PythonLog 

DELETE FROM DiffBotBatch WHERE ID <> 1

--INSERT INTO MediaCloudBatch VALUES ('Mark Warner', '2015-01-01', '2018-12-30', '2018-12-30', 1, 1169)  -- National Media
--INSERT INTO MediaCloudBatch VALUES ('Mark Warner', '2015-01-01', '2018-12-30', '2018-12-30', 14, 1169) -- VA Media


INSERT INTO MediaCloudBatch VALUES ('Mark Warner', '2015-01-01', '2018-12-30', '2018-12-30', 1, 1169)  -- National Media
INSERT INTO MediaCloudBatch VALUES ('Mark Warner', '2015-01-01', '2018-12-30', '2018-12-30', 14, 1169) -- VA Media

SELECT * FROM MediaCloudBatch


SELECT * FROM MediaCloudBatch

SELECT * FROM DiffBotBatch

SELECT * FROM MediaCloudStory

SELECT * FROM DiffBotStory

SELECT * FROM PipelineError



SELECT * FROM Term WHERe ID IN (
1169
,1169
,1051
,1051
,1063
,1063
,1095
,1095
,1088
,1088
,1051
,1051
)


SELECT * FROm DiffBotBatch
SELECT Count(*) FROM DiffBotStory



SELECT * FROM DiffBotTag

UPDATE MediaCloudBatch SET RunTime = '2019-05-09 07:25:10.970' WHERE ID > 1163 






SELECT  * FROM  MediaCloudBatch
SELECT * FROM DiffBotBatch


SELECT ID, Name FROM DiffBotBatch WHERE (CompletedTime IS NOT NULL) AND (FindEntitiesDate IS NULL) AND (Name <> 'NONE')