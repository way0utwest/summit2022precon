CREATE TABLE [dbo].[Summit2022]
(
[Summit2022ID] [int] NOT NULL IDENTITY(1, 1),
[QuoteBy] [varchar] (50) NULL,
[Quote] [varchar] (500) NULL
)
GO
ALTER TABLE [dbo].[Summit2022] ADD CONSTRAINT [Summit2022PK] PRIMARY KEY CLUSTERED ([Summit2022ID])
GO
