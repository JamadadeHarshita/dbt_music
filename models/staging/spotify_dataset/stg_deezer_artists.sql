SELECT
  artist_id,
  artist_name,
  deezer_id,
  deezer_url,
  fans,
  top_track_1,
  top_track_2,
  top_track_3,
  pipeline_uid,
  ROW_NUMBER() OVER (PARTITION BY artist_id ORDER BY fans DESC) AS row_num
FROM {{ source('spotify_dataset', 'deezer_artists') }}
