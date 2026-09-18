{{ config(materialized='table') }}

select
    order_date,
    order_currency,
    count(*)                                            as total_order_count,
    count(*) filter (where order_status <> 'cancelled') as non_cancelled_order_count,
    count(*) filter (where order_status = 'cancelled')  as cancelled_order_count,
    count(*) filter (where order_status = 'delivered')  as delivered_order_count,
    count(distinct customer_id) as distinct_customer_count,
    cast(sum(order_amount) as numeric(14, 2))           as total_order_value,
    cast(
        coalesce(sum(order_amount) filter (where order_status <> 'cancelled'), 0)
        as numeric(14, 2)
    )                                                   as non_cancelled_order_value,
    cast(
        sum(order_amount) filter (where order_status <> 'cancelled')
        / nullif(count(*) filter (where order_status <> 'cancelled'), 0)
        as numeric(14, 2)
    )                                                   as average_non_cancelled_order_value
from 
    {{ ref('fct_orders') }}
group by 
    order_date, 
    order_currency
