CREATE TABLE [dbo].[Event]
(
[EventID] [int] NOT NULL IDENTITY(1, 1),
[EventName] [varchar] (100) NULL,
[EventDate] [date] NULL,
[EventLocation] [varchar] (100) NULL,
[CountryCode] [varchar] (3) NULL
)
GO
ALTER TABLE [dbo].[Event] ADD CONSTRAINT [EventPK] PRIMARY KEY CLUSTERED ([EventID])
GO
