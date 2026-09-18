{{ config(materialized='table') }}

with ranked_products as (
    select
        product_id,
        product_name,
        product_category,
        row_number() over (
            partition by product_id
            order by order_date desc, order_id desc
        ) as observation_rank
    from 
        {{ ref('stg_orders') }}
)

select
    product_id,
    product_name,
    product_category
from 
    ranked_products
where 
    observation_rank = 1
