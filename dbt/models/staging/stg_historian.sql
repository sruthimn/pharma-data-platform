{{ config(materialized='view') }}

select
    reading_id,
    batch_id,
    equipment_id,
    reading_timestamp,
    reading_date,

    temperature,
    pressure,
    ph,
    flow_rate,
    temperature_unit,

    temperature_abnormal,
    pressure_abnormal,
    ph_abnormal,
    flow_rate_abnormal,

    abnormal_sensor_count,
    any_abnormal,

    missing_sensor_flag,
    timestamp_suspicious_flag,
    data_quality_issue

from {{ source('silver', 'HISTORIAN') }}