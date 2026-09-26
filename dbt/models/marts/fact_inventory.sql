{{ config(materialized='table') }}

select
    inventory_id,
    material_id,
    material_name,
    material_type,
    product_code,
    site,

    available_qty,
    uom,
    reorder_level,

    expected_delivery_date,
    supplier,
    last_updated,

    stock_gap,
    inventory_status,
    data_quality_issue,

    case
        when available_qty < reorder_level then true
        else false
    end as below_reorder_level,

    case
        when expected_delivery_date is not null
             and expected_delivery_date < date '2024-12-31'
        then true
        else false
    end as delivery_overdue

from {{ ref('stg_erp') }}