{{ config(materialized='table') }}

select distinct
    site

from {{ ref('stg_mes') }}

where site is not null
  and trim(site) <> ''