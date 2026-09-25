{{ config(materialized='table') }}
WITH numbers AS(
    SELECT 
            ROW_NUMBER() OVER(ORDER BY seq4())-1 AS n 
    FROM 
            TABLE(GENERATOR(ROWCOUNT=>731))
  ),days as (  
    SELECT 
            DATEADD(DAY,n,'2024-01-01'::DATE) DATE_DAY 
    FROM 
            NUMBERS
  ) SELECT 
            DATE_DAY
            ,YEAR(DATE_DAY) AS year
            ,QUARTER(DATE_DAY) AS quarter
            ,MONTH(DATE_DAY) AS month
            ,TO_CHAR(DATE_DAY,'MMMM') AS month_name
            ,WEEKOFYEAR(DATE_DAY) AS week_of_year
            ,DAYNAME(DATE_DAY) AS day_of_week
FROM 
    days

            