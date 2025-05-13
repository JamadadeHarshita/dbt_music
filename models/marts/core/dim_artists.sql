WITH spotify AS (
  SELECT * FROM {{ ref('stg_spotify_artists') }} WHERE row_num = 1
),
youtube AS (
  SELECT * FROM {{ ref('stg_youtube_channels') }} WHERE row_num = 1
),
deezer AS (
  SELECT * FROM {{ ref('stg_deezer_artists') }} WHERE row_num = 1
)

SELECT
  s.artist_id,
  s.name,
  s.category,
  s.popularity,
  s.followers,
  s.genres,
  y.channel_id,
  y.channel_title,
  y.subscribers,
  d.deezer_id,
  d.deezer_url,
  d.fans,
  d.top_track_1,
  d.top_track_2,
  d.top_track_3,
  s.fetched_at
FROM spotify s
LEFT JOIN youtube y ON s.artist_id = y.artist_id
LEFT JOIN deezer d ON s.artist_id = d.artist_id
