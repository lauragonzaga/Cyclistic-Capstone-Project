# Google Data Analytics Capstone Project: Cyclistic Bike-Share Case Study


## Introduction

This project was created using all the skills I learned in the Google Data Analytics Professional Certificate.
In order to answer the business question, I'm following all steps in the data analysis process: **Ask**, **Prepare**, **Process**, **Analyse**, **Share** and **Act**.



## Context

### Cyclistic

In 2016, Cyclistic launched a successful bike-share offering. Since then, the program has grown to a fleet of 5,824 bicycles that are geotracked and locked into a network of 692 stations across Chicago, IL. The bikes can be unlocked from one station and returned to any other station in the system anytime.

Until now, Cyclistic’s marketing strategy relied on building general awareness and appealing to broad consumer segments. One approach that helped make these things possible was the flexibility of its pricing plans: single-ride passes, full-day passes, and annual memberships. Customers who purchase single-ride or full-day passes are referred to as **casual riders**. Customers who purchase annual memberships are **Cyclistic members**.


### The problem

Cyclistic’s finance analysts have concluded that annual members are much more profitable than casual riders. Although the pricing flexibility helps Cyclistic attract more customers, Moreno believes that maximizing the number of annual members will be key to future growth. Rather than creating a marketing campaign that targets all-new customers, Moreno believes there is a solid opportunity to convert casual riders into members. She notes that casual riders are already aware of the Cyclistic program and have chosen Cyclistic for their mobility needs.

The director of marketing, Lily Moreno, has set a clear goal: Design marketing strategies aimed at converting casual riders into annual members. In order to do that, however, the team needs to better understand **how annual members and casual riders differ**, why casual riders would buy a membership, and how digital media could affect their marketing tactics. Moreno and her team are interested in analyzing the Cyclistic historical bike trip data to identify trends.

### Scenario

You are a junior data analyst working on the marketing analyst team at Cyclistic, a bike-share company in Chicago. The director of marketing believes the company’s future success depends on maximizing the number of annual memberships. Therefore, your team wants to understand how casual riders and annual members use Cyclistic bikes differently. From these insights, your team will design a new marketing strategy to convert casual riders into annual members. 

But first, Cyclistic executives must approve your recommendations, so they must be backed up with compelling data insights and professional data visualizations.




## Ask

### Business Task

Moreno has assigned you to answer the question: *How do annual members and casual riders use Cyclistic bikes differently?*



## Prepare

### The data

I'm using the last 12-month available data from [divvy-tripdata](https://divvy-tripdata.s3.amazonaws.com/index.html) (August 2023 to July 2024). 

*Note: The datasets have a different name because Cyclistic is a fictional company. For the purposes of this case study, the datasets are appropriate and will enable you to answer the business questions. The data has been made available by Motivate International Inc. under this [license](https://divvybikes.com/data-license-agreement).
This is public data that you can use to explore how different customer types are using Cyclistic bikes. But note that data-privacy issues prohibit you from using riders’ personally identifiable information. This means that you won’t be able to connect pass purchases to credit card numbers to determine if casual riders live in the Cyclistic service area or if they have purchased multiple single passes*


There are 12 tables each containing information for a specific month. The columns are: ride_id, rideable_type, started_at, ended_at, start_station_name, start_station_id, end_station_name, end_station_id, start_lat, start_lng, end_lat, end_lng and member_casual.


## Process

### Combining the data

After [importing](https://github.com/lauragonzaga/Cyclistic-Capstone-Project/blob/main/1.Importing%20the%20data.sql) the csv.s to MySQL, I [combined](https://github.com/lauragonzaga/Cyclistic-Capstone-Project/blob/main/2.%20Combining%20the%20Data.sql) all data into one table *combined_data*. 
In total, the table had 5,715,693 rows.

### Data Cleaning

[Data Cleaning SQL Queries](https://github.com/lauragonzaga/Cyclistic-Capstone-Project/blob/main/3.%20Cleaning%20the%20Data.sql)

#### Deleting duplicates

First thing I did was finding the duplicates. There were 211 duplicates with the same ride_id. After much investigation, I realized the 211 duplicates were all trips that started on May and ended in June that ended up on both tables.
I was having trouble deleting those rows so, to make things easier, I decided to truncate the table, delete those duplicates (211) in the June table and combine the data again.

#### Deleting useless data

I calculated the ride length for each trip using the started_at and ended_at columns. Then deleted all trips that had negative time values, trips shorter than a minute and trips longer than a day.

#### Day of week column

Created a column indicating the day of the week of each trip for further analysis.

#### Checking for nulls

There were a lot a of rows with missing information on these columns: start_station_name, start_station_id, end_station_name, end_station_id, end_lat, end_lng. A total of 1,397,330 null values, about 25% of the data.
Since it was a big portion of the data and I don't know how crucial those columns would be in analysis, I flagged them creating a new column: incomplete_station_data. Any incomplete data now has a 1 value in this new column.




## Analyse

[Data Analysis SQL Queries](https://github.com/lauragonzaga/Cyclistic-Capstone-Project/blob/main/4.%20Analysing%20the%20Data.sql) 




