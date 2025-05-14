SELECT
  artist_id,
  spotify_name AS name,
  COALESCE(popularity, 0) AS spotify_popularity,
  COALESCE(followers, 0) AS spotify_followers,
  COALESCE(subscribers, 0) AS youtube_subscribers,
  COALESCE(fans, 0) AS deezer_fans,

  
  ROUND(
    0.4 * COALESCE(popularity, 0) +
    0.3 * LOG(1 + COALESCE(followers, 0)) +
    0.2 * LOG(1 + COALESCE(subscribers, 0)) +
    0.1 * LOG(1 + COALESCE(fans, 0))
  , 2) AS popularity_score

FROM {{ ref('dim_artists') }}
