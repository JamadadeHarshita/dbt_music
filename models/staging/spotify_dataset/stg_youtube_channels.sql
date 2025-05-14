WITH base AS (
  SELECT
    artist_id,
    artist_name,
    channel_id,
    channel_title,
    SAFE_CAST(subscribers AS INT64) AS subscribers,
    pipeline_uid,
    ROW_NUMBER() OVER (PARTITION BY artist_id ORDER BY subscribers DESC) AS row_num
  FROM {{ source('spotify_dataset', 'youtube_artists') }}
  WHERE artist_id IS NOT NULL
    AND channel_id IS NOT NULL
    AND pipeline_uid IS NOT NULL
)

SELECT *
FROM base
WHERE row_num = 1
