{{ config(materialized='view') }}

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

    reorder_flag,
    stock_gap,
    inventory_status,
    data_quality_issue

from {{ source('silver', 'ERP') }}