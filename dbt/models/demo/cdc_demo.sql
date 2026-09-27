{{ config(
    materialized='incremental'
    ,unique_key='MOVEMENT_ID'
    ,incremental_strategy='merge'
    ,on_schema_change='append_new_columns'
    ,tags=['demo']
) }}

SELECT
    R.MOVEMENT_ID
    ,R.MATERIAL_ID
    ,R.SITE
    ,R.QUANTITY
    ,R.MOVEMENT_TYPE
    ,R.LAST_MODIFIED
    ,R.SF_LOADED_AT
    ,SYSDATE() AS DBT_UPDATED_AT
FROM {{ source('silver_demo', 'CDC_DEMO_RAW') }} R
{% if is_incremental() %}
WHERE R.SF_LOADED_AT > (SELECT MAX(SF_LOADED_AT) FROM {{ this }})
{% endif %}
QUALIFY ROW_NUMBER() OVER (
    PARTITION BY R.MOVEMENT_ID
    ORDER BY R.LAST_MODIFIED DESC, R.SF_LOADED_AT DESC
) = 1