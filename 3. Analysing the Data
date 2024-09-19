-- Are most bikes used by members?


SELECT member_casual,
	COUNT(member_casual) as cnt_member
FROM combined_data
GROUP BY member_casual; -- Yes. 3599549 rides by members and 1976795 by casual riders


-- What is the average time of ride length?

SELECT SEC_TO_TIME(ROUND(AVG(TIME_TO_SEC(ride_length)))) AS avg_ride_length -- 00:15:51 average
FROM combined_data;  


-- Average ride length for members vs casuals


SELECT member_casual,
	SEC_TO_TIME(ROUND(AVG(TIME_TO_SEC(ride_length)))) AS avg_ride_length 
FROM combined_data
GROUP BY member_casual; -- 00:12:34 for members and 00:21:50 for casual riders



-- Which day of the week are most riders using the bikes?


SELECT day_of_week, member_casual,
	COUNT(*) as day_of_week_count
FROM combined_data
GROUP BY day_of_week, member_casual
ORDER BY day_of_week_count desc; -- Members use the bikes mostly on Wednesdays and other weekdays. The weekend comes at bottom two. Casual riders use the bikes mostly on the weekends, especially Saturdays.


-- Which bikes are most used?


SELECT rideable_type, member_casual,
	COUNT(rideable_type) cnt_rideabletype
FROM combined_data
GROUP BY rideable_type, member_casual
ORDER BY cnt_rideabletype desc; 

 -- members : 1856120 classic_bike,  1743429 electric_bike, not one 'docked_bike'
 -- casuals: 995023 electric_bike,  966312  classic_bike,  15460  docked_bike	


-- What stations are most popular for casual riders?


SELECT start_station_name,start_lat, start_lng,
	COUNT(start_station_name) cnt_station
FROM combined_data
WHERE incomplete_station_data is null AND member_casual = 'casual'
GROUP BY start_station_name, start_lat, start_lng
ORDER BY cnt_station DESC
LIMIT 10;

SELECT end_station_name, end_lat, end_lng, 
	COUNT(end_station_name) cnt_station
FROM combined_data
WHERE incomplete_station_data is null AND member_casual = 'casual'
GROUP BY end_station_name, end_lat, end_lng
ORDER BY cnt_station DESC
LIMIT 10;



-- Distribution of rides per month

SELECT member_casual, month_ride, COUNT(month_ride) cnt_month
from 
(
SELECT member_casual, MONTH(started_at) as month_ride
FROM combined_data
) a
GROUP BY member_casual, month_ride;




-- Seasonal effect on duration?

SELECT member_casual, MONTH(started_at) as month_ride,
	SEC_TO_TIME(ROUND(AVG(TIME_TO_SEC(ride_length)))) AS avg_ride_length 
FROM combined_data
GROUP BY member_casual, month_ride; -- Season affects casual's ride length, but not member's



-- Distribution of time of day by members vs casuals

SELECT member_casual, HOUR(started_at) time_of_day, count(HOUR(started_at)) time_of_day_count
FROM combined_data
GROUP BY member_casual, time_of_day
ORDER BY member_casual, time_of_day;

