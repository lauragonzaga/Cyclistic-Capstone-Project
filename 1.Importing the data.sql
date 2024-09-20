CREATE DATABASE IF NOT EXISTS Cyclistic;


USE Cyclistic;


CREATE TABLE data202308
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
member_casual VARCHAR(255),
);


LOAD DATA INFILE "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/202308-divvy-tripdata.csv"
INTO TABLE data202308
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;


-- repeated this process for every table
