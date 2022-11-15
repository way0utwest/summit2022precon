BEGIN TRAN

USE [AdventureWorks2019]
GO

/****** Object:  Table [Person].[CountryCode]    Script Date: 07/11/2022 21:18:34 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [Person].[CountryCode](
	[CountryCodeID] [INT] IDENTITY(1,1) NOT NULL,
	[CountryName] NVARCHAR(200) NOT NULL,
	[CountryCodeNumber] NVARCHAR(100) NOT NULL,
	[ModifiedDate] [DATETIME] NOT NULL,
 CONSTRAINT [PK_CountryCode_CountryCodeID] PRIMARY KEY CLUSTERED 
(
	[CountryCodeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [Person].[CountryCode] ADD  CONSTRAINT [DF_CountryCode_ModifiedDate]  DEFAULT (GETDATE()) FOR [ModifiedDate]
GO

INSERT INTO [Person].[CountryCode]
(
    [CountryName],
    [CountryCodeNumber],
    [ModifiedDate]
)
VALUES
(   N'United States',      -- CountryName - nvarchar(200)
    N'001',                -- CountryCodeNumber - nvarchar(100)
    GETDATE()              -- ModifiedDate - datetime
)




ALTER TABLE [Person].[PersonPhone] ADD [CountryCodeID] INT NOT NULL DEFAULT 1
GO


ROLLBACK
-- COMMIT