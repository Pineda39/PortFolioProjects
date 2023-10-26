/*

Queries used for Tableau Project

*/


-- 1. General data

Select Count(Disorder_Type) as Total_Number_of_Disorders,
Sum(Fatalities) as Total_Deaths, 
(Select Count(CIVILIAN_TARGETING) from UkraineBS where CIVILIAN_TARGETING like 'Civilian targeting') as Civil_Targeting_Disorders
From UkraineBS

-- 2. Types of sources scales

DROP Table if exists #PercentTypeDisorder
Create Table #PercentTypeDisorder
(
Source_Scale nvarchar(255),
Disorders numeric,
)

Insert into #PercentTypeDisorder
Select Source_Scale, Count(Source_Scale) as Disorders From UkraineBS
Group by Source_Scale

Select *, (Disorders/(Select Count(EVENT_ID_CNTY) From UkraineBS))*100 as Percentage_Disorder
From #PercentTypeDisorder
Order by Source_Scale

-- 3. Percentage of civilian targeting disorders

DROP Table if exists #PercentCivilianTargeting
Create Table #PercentCivilianTargeting
(
Type nvarchar(255),
Number numeric,
)

Insert into #PercentCivilianTargeting (Type, Number)
Values ('Civilian Targeting', (Select Count(Civilian_Targeting) from UkraineBS
Where CIVILIAN_TARGETING like 'Civilian Targeting')), ('No Civilian Targeting', (Select Count(Civilian_Targeting) from UkraineBS
Where CIVILIAN_TARGETING not like 'Civilian Targeting'))

Select *, (Number/(Select Count(EVENT_ID_CNTY) From UkraineBS))*100 as Percentage From #PercentCivilianTargeting

-- 4. Deaths per month

DROP Table if exists #AccumulativeDeaths
Create Table #AccumulativeDeaths
(
Event_date datetime,
Deaths numeric,
)

Insert into #AccumulativeDeaths
Select Event_date, sum(Fatalities) as Deaths From UkraineBS
Group by event_date
Order by event_date asc

Select *, Sum(Deaths) Over(Order by Event_Date) as Accumulative_deaths,
(Sum(Deaths) Over(Order by Event_Date)/(Select Sum(Fatalities) From UkraineBS))*100 as Acumulated_Percentage_Deaths
From #AccumulativeDeaths
Order by event_date

-- 5. Map of deaths in Ukraine

Select Location, sum(Fatalities) as Deaths From UkraineBS
Group by Location
Order by Location

-- 6. 5 most dangerous cities

Select Country,Location, sum(Fatalities) as Total_Deaths From UkraineBS
Group by Country,Location
Order by Total_Deaths desc
Offset 5 Rows 
Fetch Next 5 Rows Only