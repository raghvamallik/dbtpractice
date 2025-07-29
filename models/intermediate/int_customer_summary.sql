{{ config(materialized='view') }}

SELECT
    CustomerID,
    COUNT(DISTINCT InvoiceNo) AS total_orders,
    SUM(line_total) AS total_revenue,
    MIN(InvoiceDate) AS first_order_date,
    MAX(InvoiceDate) AS last_order_date
FROM {{ ref('stg_supply') }}
WHERE is_canceled = FALSE
GROUP BY CustomerID
