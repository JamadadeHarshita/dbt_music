SELECT
  artist_id,
  spotify_name,
  pipeline_uid,
  IF(channel_id IS NOT NULL, TRUE, FALSE) AS has_youtube,
  IF(deezer_id IS NOT NULL, TRUE, FALSE) AS has_deezer
FROM {{ ref('dim_artists') }}
