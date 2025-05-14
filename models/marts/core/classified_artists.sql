WITH scored AS (
  SELECT *,
    CASE
      WHEN popularity_score >= 0.7 THEN 'famous'
      WHEN popularity_score >= 0.3 THEN 'popular'
      ELSE 'emerging'
    END AS artist_class
  FROM {{ ref('artist_popularity_scores') }}
)

SELECT *
FROM scored
