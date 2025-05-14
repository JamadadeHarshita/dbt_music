WITH genres_exploded AS (
  SELECT
    artist_id,
    TRIM(genre) AS genre,
    popularity
  FROM {{ ref('dim_artists') }},
  UNNEST(SPLIT(genres, ',')) AS genre
  WHERE genre IS NOT NULL
)

SELECT
  genre,
  COUNT(DISTINCT artist_id) AS artist_count,
  AVG(popularity) AS avg_popularity
FROM genres_exploded
GROUP BY genre
ORDER BY artist_count DESC
