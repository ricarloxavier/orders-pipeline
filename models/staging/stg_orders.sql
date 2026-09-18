{{ config(materialized='view') }}

select
    cast(order_id as bigint) as order_id,
    cast(customer_id as bigint) as customer_id,
    nullif(trim(customer_name), '') as customer_name,
    nullif(lower(trim(customer_email)), '') as customer_email,
    cast(product_id as bigint) as product_id,
    nullif(trim(product_name), '') as product_name,
    nullif(trim(product_category), '') as product_category,
    cast(order_amount as numeric(12, 2)) as order_amount,
    upper(trim(order_currency)) as order_currency,
    cast(order_date as date) as order_date,
    lower(trim(order_status)) as order_status
from {{ ref('sample_orders') }}
