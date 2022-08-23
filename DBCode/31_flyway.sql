/*
Data Community Summit Precon

31 - Starting to use Flyway

	We also want to change some data. Get some quotes
	from the audience and a picture or two. Maybe Steve/Grant/etc write
	a short post with a picture or two on their blog in the background.

Copyright 2022 Redgate Software
*/
-- quotes
INSERT dbo.Summit2022
(
    QuoteBy,
    Quote
)
VALUES
(   '', -- QuoteBy - varchar(50)
    ''  -- Quote - varchar(500)
    )


-- pictures
INSERT dbo.Summit2022Pix
(
    PictureDesc,
    PictureURL
)
VALUES
(   '', -- PictureDesc - varchar(200)
    ''  -- PictureURL - varchar(300)
    ),
(   '', -- PictureDesc - varchar(200)
    ''  -- PictureURL - varchar(300)
    ),


-- save as migration script