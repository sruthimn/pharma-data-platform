{{ config(materialized='view') }}

select
    test_id,
    batch_id,
    test_name,
    analyst_id,

    test_date,

    test_result,
    unit,
    lower_spec_limit,
    upper_spec_limit,

    result_status,
    release_status,
    calculated_status,

    below_reporting_limit,
    limits_swapped,
    status_mismatch,
    is_orphan,
    test_before_batch_start

from {{ source('silver', 'LIMS') }}