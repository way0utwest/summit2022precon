CREATE TABLE dbo.Summit2022Pix (
 Summit2022PixID INT IDENTITY(1,1) NOT NULL CONSTRAINT Summit2022PixPK PRIMARY KEY,
 PictureDesc varchar(200),
 PictureURL varchar(300)
)
GO
