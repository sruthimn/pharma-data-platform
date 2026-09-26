{{ config(materialized='table') }}

select distinct
    product_code,
    therapy_area

from {{ ref('stg_mes') }}

where product_code is not null
  and trim(product_code) <> ''