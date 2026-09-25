{{ config(materialized='view') }}

SELECT

    BATCH_ID
    ,SITE
    ,PRODUCTION_LINE
    ,PRODUCT_CODE
    ,THERAPY_AREA
    ,PLANNED_QTY
    ,ACTUAL_QTY
    ,YIELD_PCT
    ,BATCH_STATUS
    ,DEVIATION_FLAG
    ,START_TIME
    ,END_TIME
    ,BATCH_DURATION_HOURS
    ,YIELD_EXCEEDS_100
    ,END_BEFORE_START
FROM  
   
{{ source('silver', 'MES') }}