ALTER TABLE dbo.Territories ADD Active BIT DEFAULT 1
GO
ALTER TABLE dbo.Territories ADD StartDate Date DEFAULT GETDATE()
GO
ALTER TABLE dbo.Territories ADD EndDate Date DEFAULT GETDATE()
GO
UPDATE dbo.Territories
 SET Active = 1
 , StartDate = '1900-01-01'
 , EndDate = '9999-12-31'
GO
