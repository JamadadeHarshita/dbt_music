WITH base AS (
  SELECT
    artist_id,
    name AS artist_name,
    popularity,
    followers,
    ARRAY_TO_STRING(genres, ', ') AS genres,
    pipeline_uid,
    ROW_NUMBER() OVER (PARTITION BY artist_id ORDER BY pipeline_uid DESC) AS row_num
  FROM {{ source('spotify_dataset', 'processed_artists') }}
  WHERE artist_id IS NOT NULL
    AND name IS NOT NULL
    AND pipeline_uid IS NOT NULL
)

SELECT *
FROM base
WHERE row_num = 1
