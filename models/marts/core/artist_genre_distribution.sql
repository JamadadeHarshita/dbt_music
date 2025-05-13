SELECT
  category,
  SPLIT(genre, ', ') AS genre,
  COUNT(*) AS artist_count
FROM {{ ref('dim_artists') }},
UNNEST(SPLIT(genres, ', ')) AS genre
GROUP BY category, genre
ORDER BY category, artist_count DESC
