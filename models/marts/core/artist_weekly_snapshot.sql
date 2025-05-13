SELECT
  artist_id,
  name,
  category,
  popularity,
  followers,
  EXTRACT(YEAR FROM fetched_at) AS year,
  FORMAT_DATE('%G-W%V', DATE(fetched_at)) AS iso_week,
  fetched_at
FROM {{ ref('stg_spotify_artists') }}
WHERE row_num = 1
