WITH spotify AS (
  SELECT 
    artist_id,
    artist_name AS spotify_name,  
    popularity,
    followers,
    genres,
    pipeline_uid
  FROM {{ ref('stg_spotify_artists') }}
  WHERE row_num = 1
),
youtube AS (
  SELECT 
    artist_id,
    channel_id,
    channel_title,
    subscribers,
    pipeline_uid
  FROM {{ ref('stg_youtube_channels') }}
  WHERE row_num = 1
),
deezer AS (
  SELECT 
    artist_id,
    deezer_id,
    deezer_url,
    fans,
    top_track_1,
    top_track_2,
    top_track_3,
    pipeline_uid
  FROM {{ ref('stg_deezer_artists') }}
  WHERE row_num = 1
)

SELECT
  s.artist_id,
  s.spotify_name,
  s.popularity,
  s.followers,
  s.genres,
  s.pipeline_uid,
  y.channel_id,
  y.channel_title,
  y.subscribers,
  d.deezer_id,
  d.deezer_url,
  d.fans,
  d.top_track_1,
  d.top_track_2,
  d.top_track_3
FROM spotify s
LEFT JOIN youtube y ON s.pipeline_uid = y.pipeline_uid
LEFT JOIN deezer d ON s.pipeline_uid = d.pipeline_uid
