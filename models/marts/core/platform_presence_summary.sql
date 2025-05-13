SELECT
  a.artist_id,
  a.name,
  CASE WHEN y.artist_id IS NOT NULL THEN 1 ELSE 0 END AS has_youtube,
  CASE WHEN d.artist_id IS NOT NULL THEN 1 ELSE 0 END AS has_deezer,
  CASE
    WHEN y.artist_id IS NOT NULL AND d.artist_id IS NOT NULL THEN 'multi-platform'
    WHEN y.artist_id IS NOT NULL THEN 'youtube only'
    WHEN d.artist_id IS NOT NULL THEN 'deezer only'
    ELSE 'spotify only'
  END AS platform_footprint
FROM {{ ref('dim_artists') }} a
LEFT JOIN {{ ref('stg_youtube_channels') }} y ON a.artist_id = y.artist_id
LEFT JOIN {{ ref('stg_deezer_artists') }} d ON a.artist_id = d.artist_id
