USE RussiaNews
GO


EXEC DropTable 'PipelineError'
GO
CREATE TABLE [dbo].[PipelineError](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Step] [varchar](100) NOT NULL DEFAULT '',
	[RecordID] int NOT NULL, 
	[Message] varchar(max) NOT NULL DEFAULT '',
	[EditTime] datetime2(6) NOT NULL 
	CONSTRAINT [PipelineError_KEY] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] 

