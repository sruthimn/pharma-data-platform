{{ config(materialized='table') }}
SELECT 
        L.TEST_ID
        ,L.BATCH_ID
        ,L.TEST_DATE
        ,L.TEST_NAME
        ,L.UNIT
        ,L.ANALYST_ID
        ,L.LOWER_SPEC_LIMIT
        ,L.UPPER_SPEC_LIMIT
        ,L.TEST_RESULT
        ,L.RESULT_STATUS
        ,L.RELEASE_STATUS
        ,L.CALCULATED_STATUS
        ,L.LIMITS_SWAPPED
        ,L.STATUS_MISMATCH
        ,L.TEST_BEFORE_BATCH_START
        ,L.BELOW_REPORTING_LIMIT
        ,M.PRODUCT_CODE
        ,M.SITE
        ,CASE 
            WHEN RESULT_STATUS = 'OOS' AND CALCULATED_STATUS = 'Fail'
            THEN 'OOS'
            WHEN CALCULATED_STATUS IS NOT NULL
            THEN CALCULATED_STATUS
            ELSE RESULT_STATUS
            END AS quality_result
FROM
        {{ ref('stg_lims') }} L
INNER JOIN 
        {{ ref('stg_mes') }} M 
        ON L.BATCH_ID = M.BATCH_ID
