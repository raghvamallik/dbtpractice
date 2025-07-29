{{ config(materialized='view') }}

SELECT
    InvoiceNo,
    StockCode,
    Description,
    Quantity,
    InvoiceDate,
    UnitPrice,
    CustomerID,
    Country,
    Quantity * UnitPrice AS line_total,
    IFF(LEFT(InvoiceNo, 1) = 'C', TRUE, FALSE) AS is_canceled
FROM {{ source('analytics', 'supply') }}
