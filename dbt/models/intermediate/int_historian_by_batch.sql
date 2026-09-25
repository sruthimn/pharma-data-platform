with historian as (

    select
        batch_id,
        temperature,
        pressure,
        ph,
        flow_rate,
        any_abnormal

    from {{ ref('stg_historian') }}

    where batch_id is not null

),

valid_mes_batches as (

    select distinct
        batch_id

    from {{ source('silver', 'MES') }}

    where batch_id is not null

),

valid_historian as (

    select
        h.*

    from historian h

    inner join valid_mes_batches m
        on h.batch_id = m.batch_id

)

select
    batch_id,

    count(*) as reading_count,

    sum(
        case
            when any_abnormal = true then 1
            else 0
        end
    ) as abnormal_reading_count,

    avg(temperature) as avg_temperature,
    avg(pressure) as avg_pressure,
    avg(ph) as avg_ph,
    avg(flow_rate) as avg_flow_rate

from valid_historian

group by batch_id