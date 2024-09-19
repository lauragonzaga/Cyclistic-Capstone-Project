
----------------------------------------------------------------------------------------------------------------------------------------------- 

-- Checking for duplicates

SELECT COUNT(ride_id) - COUNT(DISTINCT ride_id) from combined_data;
-- 211 duplicate values


-- Finding the duplicates

WITH CTE as
(SELECT ride_id,
           ROW_NUMBER() OVER(PARTITION BY ride_id) DuplicateCount
           FROM combined_data
           ORDER BY ride_id
    )
SELECT *
 FROM CTE
WHERE DuplicateCount > 1;


-- Realized the duplicates were all trips that started on May and ended in June that ended up on both tables.
-- To make things easier, decided to truncated the table, deleted those duplicates (211) in the June table and combined the data again.


TRUNCATE TABLE combined_data;

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



SELECT COUNT(ride_id) - COUNT(DISTINCT ride_id) from combined_data;
-- No duplicates


SELECT COUNT(*)
FROM combined_data;
-- There are now 5715482 rows



-----------------------------------------------------------------------------------------------------------------------------------------------

-- Deleting useless data


ALTER TABLE combined_data 
ADD COLUMN ride_length_seconds BIGINT; -- Decided to calculate in seconds because a lot of ride lenghts exceeded the 838 hours time limit and it wouldn't let me update the column


UPDATE combined_data
SET ride_length_seconds = TIMESTAMPDIFF(SECOND, started_at, ended_at);


SELECT COUNT(ride_length_seconds) 
FROM combined_data
WHERE ride_length_seconds > 86400  -- ride length greater than 1 day
   OR ride_length_seconds < 60     -- ride length less than 1 minute
   OR ride_length_seconds < 0;     -- negative ride lengths (bad data)
-- Total of 139138 values to be deleted


DELETE
FROM combined_data
WHERE ride_length_seconds > 86400 
   OR ride_length_seconds < 60
   OR ride_length_seconds < 0;


-- Converting the column from seconds to regular timestamp

ALTER TABLE combined_data 
ADD COLUMN ride_length TIME;

UPDATE combined_data
SET ride_length = SEC_TO_TIME(ride_length_seconds); -- 5576344 rows affected (all)


ALTER TABLE combined_data 
DROP COLUMN ride_length_seconds;



-----------------------------------------------------------------------------------------------------------------------------------------------


-- Setting column for day of the week

ALTER TABLE combined_data 
ADD COLUMN day_of_week VARCHAR(20);

UPDATE combined_data
SET day_of_week = 
		CASE WHEN WEEKDAY(started_At) = 0 THEN 'Mon'
		 WHEN WEEKDAY(started_At) = 1 THEN 'Tue'
		 WHEN WEEKDAY(started_At) = 2 THEN 'Wed'
		 WHEN WEEKDAY(started_At) = 3 THEN 'Thur'
		 WHEN WEEKDAY(started_At) = 4 THEN 'Fri'
		 WHEN WEEKDAY(started_At) = 5 THEN 'Sat'
		 WHEN WEEKDAY(started_At) = 6 THEN 'Sun' END;
         


-----------------------------------------------------------------------------------------------------------------------------------------------


-- Checking for nulls

SELECT sum(case when ride_id is null then 1 else 0 end) nulls
FROM combined_data;
-- No nulls in the primary key



SELECT COUNT(*)
FROM combined_data
where start_station_name = '' or start_station_id = '' or end_station_name = '' or end_station_id = '' or end_lat = '' or end_lng = ''; -- 1397330 null values

-- Since it's a big portion of the data and I don't know how crucial those columns will be in analysis, I will just flag them for now

ALTER TABLE combined_data
ADD COLUMN incomplete_station_data int;


UPDATE combined_data
SET incomplete_station_data = 1
where start_station_name = '' or start_station_id = '' or end_station_name = '' or end_station_id = '' or end_lat = '' or end_lng = '';
