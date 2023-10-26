/*
Ukraine and Black Sea Conflicts Data Exploration 

Skills used: CTE's, Temp Tables, Windows Functions, Aggregate Functions, Creating Views, Subqueries.

*/

Select * From UkraineBS


Select Country,Location,Event_Date,Fatalities,Disorder_Type,Event_Type, Sub_Event_Type From UkraineBS
Order by 1,2,3

--Select Data that we are going to be using


-- Looking at deaths in each event vs Total Deaths in the whole period
-- Showing highest death percentage

Select Country,Location,Disorder_Type, Event_Type, Sub_event_type, Fatalities, (Fatalities/(Sum(Fatalities) Over()))*100 as Percentage_Deaths From UkraineBS
Order by Percentage_Deaths desc

-- This shows that the most lethal event was in Bakhmut, Ukraine with 600 of deaths which represents approximately 1% of the total deaths.
-- Furthermore, it was a Battle, Armed Clash

-- Usig temp table, it shows deaths per day, the accumulative deaths
-- and which is percentage represents with respect to the accumulated deaths vs the total deaths


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

-- Shows total deaths on every city

Select Location, sum(Fatalities) as Deaths From UkraineBS
Group by Location
Order by Location

-- Shows the 5 most dangerous cities of the conflicts

Select Country,Location, sum(Fatalities) as Total_Deaths From UkraineBS
Group by Country,Location
Order by Total_Deaths desc
Offset 5 Rows 
Fetch Next 5 Rows Only

-- General Information


-- Shows total number of disorders, deaths and civil targeting disorders

Select Count(Disorder_Type) as Total_Number_of_Disorders,
Sum(Fatalities) as Total_Deaths, 
(Select Count(CIVILIAN_TARGETING) from UkraineBS where CIVILIAN_TARGETING like 'Civilian targeting') as Civil_Targeting_Disorders
From UkraineBS


-- Showing which the lethality of each event and what percentage of the deaths do they represent

Select sum(Fatalities) as Total_Deaths,Event_Type, sum(Fatalities)/59032 as Percentage_Deaths From UkraineBS
Group by Event_Type
Order by Total_Deaths desc

-- Showing which were the 10 days with highest number of deaths

Select Top 10 Event_Date, sum(Fatalities) as Total_Deaths From UkraineBS
Group by Event_date
Order by Total_Deaths desc

-- BREAKING THINGS DOWN BY CITIES

-- Shows the cities with hightest number of disorders and the percentage of total disorders
-- Using CTE to perform Calculation on Partition By

DROP Table if exists #PercentDisorders
Create Table #PercentDisorders
(
Country nvarchar(255),
Location nvarchar(255),
Number_disorders numeric,
)

Insert into #PercentDisorders
Select Country,Location
, Count(Disorder_Type) Over (Partition by Location) as Number_disorders
From UkraineBS

Select *, (Number_disorders/Sum(Number_disorders) over())*100 as Percentage_Disorders
From #PercentDisorders
Group by Country,Location,Number_disorders
Order by Number_disorders desc


-- Showing the total number of protests and riots that happend in Kyiv since the conflict against Russia started.

Select Count(DISORDER_TYPE) as Total_Demonstrations_Kyiv From UkraineBS
where location like 'Kyiv' and DISORDER_TYPE like 'demonstrations' and event_date >= 2022-02-22

-- Creating View to store data for later visualizations

Create View PercentDisorders as
Select Country,Location
, Count(Disorder_Type) Over (Partition by Location) as Number_disorders
From UkraineBS

-- Shows how many disorders of each source Scale happened over the period
-- and which percentage do they represent with the respect to the total number of disorders


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

-- Showing how many of the disorders where Civilian Targeting and how many were not 
-- and the percentage that they represent with respect to the total number of disorders

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
