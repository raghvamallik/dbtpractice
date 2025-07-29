{{ config(materialized='table') }}

WITH customer_orders AS (
    SELECT * FROM {{ ref('int_customer_summary') }}
),
today AS (
    SELECT MAX(InvoiceDate) AS today_date FROM {{ ref('stg_supply') }}
)

SELECT
    c.CustomerID,
    DATEDIFF('day', c.last_order_date, t.today_date) AS recency_days,
    c.total_orders AS frequency,
    c.total_revenue AS monetary
FROM customer_orders c
CROSS JOIN today t
