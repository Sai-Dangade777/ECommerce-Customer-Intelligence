USE EcommerceCustomerIntelligence;
GO

SET NOCOUNT ON;
GO

/*===========================================================
FILE 13
RFM CUSTOMER SEGMENTATION ANALYSIS
=============================================================

Reference Date : 2018-10-18
Dataset : Olist E-Commerce

===========================================================*/


/*===========================================================
1. Create Customer RFM Base
===========================================================*/

WITH CustomerRFM AS
(
SELECT

    c.customer_unique_id,

    MAX(o.order_purchase_timestamp) AS LastPurchaseDate,

    DATEDIFF
    (
        DAY,
        MAX(o.order_purchase_timestamp),
        '2018-10-18'
    ) AS Recency,

    COUNT(DISTINCT o.order_id) AS Frequency,

    ROUND(SUM(oi.price),2) AS Monetary

FROM dbo.customers c

INNER JOIN dbo.orders o
ON c.customer_id = o.customer_id

INNER JOIN dbo.order_items oi
ON o.order_id = oi.order_id

GROUP BY
c.customer_unique_id
)


/*===========================================================
2. Calculate RFM Scores
===========================================================*/

,
RFMScore AS
(

SELECT

*,

NTILE(5)
OVER
(
ORDER BY Recency DESC
)
AS RScore,

NTILE(5)
OVER
(
ORDER BY Frequency ASC
)
AS FScore,

NTILE(5)
OVER
(
ORDER BY Monetary ASC
)
AS MScore

FROM CustomerRFM

)


/*===========================================================
3. Final RFM Dataset
===========================================================*/

,
FinalRFM AS
(

SELECT

customer_unique_id,

LastPurchaseDate,

Recency,

Frequency,

Monetary,

RScore,

FScore,

MScore,

CONCAT
(
RScore,
FScore,
MScore
)
AS RFMScore

FROM RFMScore

)



/*===========================================================
4. Complete RFM Table
===========================================================*/

SELECT *

FROM FinalRFM

ORDER BY

Monetary DESC;

GO


/*===========================================================
5. Executive KPI
===========================================================*/

SELECT

COUNT(*) AS Customers,

AVG(Recency) AS AvgRecency,

AVG(Frequency) AS AvgFrequency,

ROUND(AVG(Monetary),2) AS AvgMonetary,

MAX(Monetary) AS HighestCustomerValue,

MIN(Monetary) AS LowestCustomerValue

FROM
(

SELECT

c.customer_unique_id,

DATEDIFF
(
DAY,
MAX(o.order_purchase_timestamp),
'2018-10-18'
) AS Recency,

COUNT(DISTINCT o.order_id) AS Frequency,

SUM(oi.price) AS Monetary

FROM dbo.customers c

JOIN dbo.orders o
ON c.customer_id=o.customer_id

JOIN dbo.order_items ON
oi o.order_id=oi.order_id

GROUP BY
c.customer_unique_id

) X;

GO