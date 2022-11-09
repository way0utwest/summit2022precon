CREATE TABLE [dbo].[Region]
(
[RegionID] [int] NOT NULL,
[RegionDescription] [nchar] (50) NOT NULL,
[RegionName] [nvarchar] (20) NULL,
[foo] [nvarchar] (20) NULL,
[foo2] [int] NULL,
[foo3] [int] NULL
)
GO
ALTER TABLE [dbo].[Region] ADD CONSTRAINT [PK_Region] PRIMARY KEY NONCLUSTERED ([RegionID])
GO
