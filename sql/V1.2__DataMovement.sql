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
(   'Navy Seals', -- QuoteBy - varchar(50)
    'Slow is smooth, smooth is fast'  -- Quote - varchar(500)
    )


-- pictures
INSERT dbo.Summit2022Pix
(
    PictureDesc,
    PictureURL
)
VALUES
(   'PASS Summit', -- PictureDesc - varchar(200)
    'https://something.org'  -- PictureURL - varchar(300)
    )

-- save as migration script