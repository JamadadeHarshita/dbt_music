WITH weekly_data AS (
  SELECT
    artist_id,
    name,
    iso_week,
    popularity,
    followers,
    ROW_NUMBER() OVER (PARTITION BY artist_id ORDER BY iso_week DESC) AS week_rank
  FROM {{ ref('artist_weekly_snapshot') }}
)

SELECT
  curr.artist_id,
  curr.name,
  curr.iso_week AS current_week,
  prev.iso_week AS previous_week,
  curr.followers - prev.followers AS follower_growth,
  curr.popularity - prev.popularity AS popularity_change,
  CASE
    WHEN curr.followers - prev.followers > 10000 OR curr.popularity - prev.popularity > 10 THEN 'rising'
    ELSE 'stable'
  END AS momentum_status
FROM weekly_data curr
JOIN weekly_data prev
  ON curr.artist_id = prev.artist_id AND curr.week_rank = 1 AND prev.week_rank = 2
