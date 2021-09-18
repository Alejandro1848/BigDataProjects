
CREATE OR REPLACE VIEW `bike_insights.top_trips_2018_and_beyond_vm` AS
SELECT
    start_station_name,
    COUNT(trip_id) as num_trips
FROM
    `bigquery-public-data.san_francisco_bikeshare.bikeshare_trips`
WHERE start_date >'2017-12-31 00:00:00 UTC'
GROUP BY
    start_station_name
ORDER BY num_trips DESC
LIMIT
    10
