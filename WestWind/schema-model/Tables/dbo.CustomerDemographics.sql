CREATE TABLE [dbo].[CustomerDemographics]
(
[CustomerTypeID] [nchar] (10) NOT NULL,
[CustomerDesc] [ntext] NULL,
[nationality] [nvarchar] (20) NULL
)
GO
ALTER TABLE [dbo].[CustomerDemographics] ADD CONSTRAINT [PK_CustomerDemographics] PRIMARY KEY NONCLUSTERED ([CustomerTypeID])
GO
