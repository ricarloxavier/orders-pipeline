select
    order_date,
    order_currency
from {{ ref('mart_daily_order_metrics') }}
group by order_date, order_currency
having count(*) > 1

