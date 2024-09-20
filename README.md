# Google Data Analytics: Cyclistic Bike-Share Case Study 🚲


## Introduction 👋

This project was created using all the skills I learned in the Google Data Analytics Professional Certificate.
In order to answer the business question, I'm following all steps in the data analysis process: **Ask**, **Prepare**, **Process**, **Analyse**, **Share** and **Act**.



## Context 📜

### Cyclistic

In 2016, Cyclistic launched a successful bike-share offering. Since then, the program has grown to a fleet of 5,824 bicycles that are geotracked and locked into a network of 692 stations across Chicago, IL. The bikes can be unlocked from one station and returned to any other station in the system anytime.

Until now, Cyclistic’s marketing strategy relied on building general awareness and appealing to broad consumer segments. One approach that helped make these things possible was the flexibility of its pricing plans: single-ride passes, full-day passes, and annual memberships. Customers who purchase single-ride or full-day passes are referred to as **casual riders**. Customers who purchase annual memberships are **Cyclistic members**.<br>


### The problem

Cyclistic’s finance analysts have concluded that annual members are much more profitable than casual riders. Although the pricing flexibility helps Cyclistic attract more customers, Moreno believes that maximizing the number of annual members will be key to future growth. Rather than creating a marketing campaign that targets all-new customers, Moreno believes there is a solid opportunity to convert casual riders into members. She notes that casual riders are already aware of the Cyclistic program and have chosen Cyclistic for their mobility needs.

The director of marketing, Lily Moreno, has set a clear goal: Design marketing strategies aimed at converting casual riders into annual members. In order to do that, however, the team needs to better understand **how annual members and casual riders differ**, why casual riders would buy a membership, and how digital media could affect their marketing tactics. Moreno and her team are interested in analyzing the Cyclistic historical bike trip data to identify trends.<br>

### Scenario

You are a junior data analyst working on the marketing analyst team at Cyclistic, a bike-share company in Chicago. The director of marketing believes the company’s future success depends on maximizing the number of annual memberships. Therefore, your team wants to understand how casual riders and annual members use Cyclistic bikes differently. From these insights, your team will design a new marketing strategy to convert casual riders into annual members. 

But first, Cyclistic executives must approve your recommendations, so they must be backed up with compelling data insights and professional data visualizations.<br><br><br>




## Ask ❓

### Business Task

Moreno has assigned you to answer the question: *How do annual members and casual riders use Cyclistic bikes differently?*<br><br><br>



## Prepare 🔍

### The data

I'm using the last 12-month available data from [divvy-tripdata](https://divvy-tripdata.s3.amazonaws.com/index.html) (August 2023 to July 2024). 

*Note: The datasets have a different name because Cyclistic is a fictional company. For the purposes of this case study, the datasets are appropriate and will enable you to answer the business questions. The data has been made available by Motivate International Inc. under this [license](https://divvybikes.com/data-license-agreement).
This is public data that you can use to explore how different customer types are using Cyclistic bikes. But note that data-privacy issues prohibit you from using riders’ personally identifiable information. This means that you won’t be able to connect pass purchases to credit card numbers to determine if casual riders live in the Cyclistic service area or if they have purchased multiple single passes*


There are 12 tables each containing information for a specific month. The columns are: ride_id, rideable_type, started_at, ended_at, start_station_name, start_station_id, end_station_name, end_station_id, start_lat, start_lng, end_lat, end_lng and member_casual.<br><br><br>


## Process 🖥️

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

After data cleaning, we now have 5,576,344 rows to analyse.<br><br><br>



## Analyse 👩‍💻

[Data Analysis SQL Queries](https://github.com/lauragonzaga/Cyclistic-Capstone-Project/blob/main/4.%20Analysing%20the%20Data.sql) 

Wrote some queries to find trends in the data. After that, I copied the resulting tables into Excel to save as a workbook for Tableau.<br><br><br>


## Share 📊📈

[Tableau Dashboard](https://public.tableau.com/app/profile/laura.gonzaga/viz/CyclisticBike-ShareCaseStudy_17267860907680/Dashboard1)


First valuable information obtained was the total number of rides completed by members. As expected, the majority of rides were conducted by members.

![image](https://github.com/user-attachments/assets/b834c1e0-886a-4f13-b29b-e2e8e983af3d)


Then I calculated the average ride length for members and casuals. The result indicated members tend to take shorter trips. 

![image](https://github.com/user-attachments/assets/f8ba5d2c-7eef-4ab2-8b95-89a902b3e6c3)


Decided to see how this value changed over the year and discovered members' ride length mostly stays consistent throughout the year, while casuals tend to take longer trips during the summer season.

![image](https://github.com/user-attachments/assets/f7a16b25-2d9e-4096-b3b1-beb095f4a204)


I also had access to the time of day of each trip. So I extracted the hour and calculated the count of trips in each hour of the day. Realized members have two high peaks at 8AM and 17PM, indicating they are probably using the bicycles for transportation during work hours.

![image](https://github.com/user-attachments/assets/ed6b45f9-8561-455a-bf77-b9ef823dd23a)


Using the day of the week column created during the Process step, I discovered that members use the bicycles more often during work days while casuals tend to ride more during the weekend

![image](https://github.com/user-attachments/assets/ee324447-5d0d-48a0-a08f-1193174d4578)


I extracted the month from the started_at column and had a big discovery. There is a clear season effect in the usage of bicycles, especially for casual members. 

![image](https://github.com/user-attachments/assets/0c93ccea-539b-43e3-a1a5-be7d6a2ac4c0)


I created a calculated field on Tableau that let me make this graph, separating the months in seasons. This indicated very clearly that the warmer months are a lot more profitable to the company.

![image](https://github.com/user-attachments/assets/85fce43e-39cd-4ac5-acb9-27ed612f3b50)


Then it was time to use the stations information. I decided to only show the most popular stations for casual users, since these are the ones we are trying to target. The result shows that the top stations for casuals are in busy places, with access to tourist attractions and/or located near Lake Michigan.

![image](https://github.com/user-attachments/assets/9b29c665-f53a-4cfb-a074-a987a6fae980)<br><br><br>



### Conclusions ✅

| Casuals  | Members   |
|------------|------------|
| Tend to ride on weekends    | Tend to ride on week days and during work hours  |
| Travel for longer, but less frequently    | Travel for shorter time, but take more trips |
| Prefer the warmer months    | Also travel more during summer months, but some still use the membership in colder months    |
| Tend to use the bicycles for leisure or tourism | Tend to use the bikes to go to work or run errands |
<br><br><br>



## Act 🗣

Top 3 recommendations based on my analysis:

1. **Create subscription plans for the summer season**
   Consider creating special offers and discounts on subscription plans during the summer to capitalize on the increase of bike usage. Promote it with advertisements on tourist locations.

3. **Promote Cycling with City Partnership**
   One way to convert casuals into the membership is to make them consider biking as a means of transportation for daily life. We can collaborate with the city council to encourage people to choose cycling as a sustainable commuting option. The campaign can address climate issues, highlight how traffic can improve and promote healthy choices for the population.

4. **Develop weekend-specific benefits**
   Marketing can create a new membership that lowers cost of bike rentals during the weekends. The campaign could target the most popular stations used by casual riders.




