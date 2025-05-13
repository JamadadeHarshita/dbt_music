SELECT
  artist_id,
  name,
  popularity,
  followers,
  category,
  ARRAY_TO_STRING(genres, ', ') AS genres,
  fetched_at,
  pipeline_uid,
  ROW_NUMBER() OVER (PARTITION BY artist_id ORDER BY fetched_at DESC) AS row_num
FROM {{ source('spotify_dataset', 'processed_artists') }}
