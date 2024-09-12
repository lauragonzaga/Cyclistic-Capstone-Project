CREATE TABLE combined_data
(
ride_id VARCHAR(255),
rideable_type VARCHAR(255),
started_at DATETIME,
ended_at DATETIME,
start_station_name VARCHAR(255),
start_station_id VARCHAR(255),
end_station_name VARCHAR(255),
end_station_id VARCHAR(255),
start_lat VARCHAR(255),
start_lng VARCHAR(255),
end_lat VARCHAR(255),
end_lng VARCHAR(255),
member_casual VARCHAR(255)
);

SELECT COUNT(*)
FROM data202406
WHERE MONTH(started_at) = 5;


DELETE
FROM data202406
WHERE MONTH(started_at) = 5;


INSERT INTO combined_data
SELECT * FROM data202308
UNION ALL
SELECT * FROM data202309
UNION ALL
SELECT * FROM data202310
UNION ALL
SELECT * FROM data202311
UNION ALL
SELECT * FROM data202312
UNION ALL
SELECT * FROM data202401
UNION ALL
SELECT * FROM data202402
UNION ALL
SELECT * FROM data202403
UNION ALL
SELECT * FROM data202404
UNION ALL
SELECT * FROM data202405
UNION ALL
SELECT * FROM data202406
UNION ALL
SELECT * FROM data202407;

SELECT *
FROM combined_data;







 










