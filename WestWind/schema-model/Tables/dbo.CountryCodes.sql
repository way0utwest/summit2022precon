CREATE TABLE [dbo].[CountryCodes]
(
[CountryName] [nvarchar] (255) NULL,
[CountryCode] [nvarchar] (4) NOT NULL,
[ModifiedDate] [datetime2] (3) NULL CONSTRAINT [DF__CountryCo__Modif__1881A0DE] DEFAULT (getdate())
)
GO
ALTER TABLE [dbo].[CountryCodes] ADD CONSTRAINT [PK_Countries] PRIMARY KEY CLUSTERED ([CountryCode])
GO
