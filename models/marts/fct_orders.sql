{{ config(materialized='table') }}

select
    order_id,
    customer_id,
    product_id,
    order_amount,
    order_currency,
    order_date,
    order_status
from 
    {{ ref('stg_orders') }}
