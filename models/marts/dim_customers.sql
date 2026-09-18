{{ config(materialized='table') }}

with ranked_customers as (
    select
        customer_id,
        customer_name,
        customer_email,
        row_number() over (
            partition by customer_id
            order by order_date desc, order_id desc
        ) as observation_rank
    from 
        {{ ref('stg_orders') }}
)

select
    customer_id,
    customer_name,
    customer_email
from 
    ranked_customers
where 
    observation_rank = 1
