SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW [dbo].[LatestEvents]
AS
SELECT TOP 10 *
 FROM dbo.Event
 ORDER BY EventDate DESC
GO
