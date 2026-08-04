USE EcommerceCustomerIntelligence;
GO

/*=========================================================
06 - Data Quality Validation
Purpose:
Validate production tables before enforcing
referential integrity and building analytics.
=========================================================*/

SET NOCOUNT ON;
GO

/*=========================================================
1. Duplicate Customers
=========================================================*/
SELECT
    customer_id,
    COUNT(*) AS DuplicateCount
FROM dbo.customers
GROUP BY customer_id
HAVING COUNT(*) > 1;
GO

/*=========================================================
2. Duplicate Orders
=========================================================*/
SELECT
    order_id,
    COUNT(*) AS DuplicateCount
FROM dbo.orders
GROUP BY order_id
HAVING COUNT(*) > 1;
GO

/*=========================================================
3. Duplicate Products
=========================================================*/
SELECT
    product_id,
    COUNT(*) AS DuplicateCount
FROM dbo.products
GROUP BY product_id
HAVING COUNT(*) > 1;
GO

/*=========================================================
4. Duplicate Sellers
=========================================================*/
SELECT
    seller_id,
    COUNT(*) AS DuplicateCount
FROM dbo.sellers
GROUP BY seller_id
HAVING COUNT(*) > 1;
GO

/*=========================================================
5. Orders without Customers
=========================================================*/
SELECT COUNT(*) AS OrdersWithoutCustomers
FROM dbo.orders o
LEFT JOIN dbo.customers c
    ON o.customer_id = c.customer_id
WHERE c.customer_id IS NULL;
GO

/*=========================================================
6. Order Items without Orders
=========================================================*/
SELECT COUNT(*) AS OrderItemsWithoutOrders
FROM dbo.order_items oi
LEFT JOIN dbo.orders o
    ON oi.order_id = o.order_id
WHERE o.order_id IS NULL;
GO

/*=========================================================
7. Order Items without Products
=========================================================*/
SELECT COUNT(*) AS OrderItemsWithoutProducts
FROM dbo.order_items oi
LEFT JOIN dbo.products p
    ON oi.product_id = p.product_id
WHERE p.product_id IS NULL;
GO

/*=========================================================
8. Order Items without Sellers
=========================================================*/
SELECT COUNT(*) AS OrderItemsWithoutSellers
FROM dbo.order_items oi
LEFT JOIN dbo.sellers s
    ON oi.seller_id = s.seller_id
WHERE s.seller_id IS NULL;
GO

/*=========================================================
9. Payments without Orders
=========================================================*/
SELECT COUNT(*) AS PaymentsWithoutOrders
FROM dbo.payments p
LEFT JOIN dbo.orders o
    ON p.order_id = o.order_id
WHERE o.order_id IS NULL;
GO

/*=========================================================
10. Reviews without Orders
=========================================================*/
SELECT COUNT(*) AS ReviewsWithoutOrders
FROM dbo.reviews r
LEFT JOIN dbo.orders o
    ON r.order_id = o.order_id
WHERE o.order_id IS NULL;
GO

/*=========================================================
11. Invalid Review Scores
=========================================================*/
SELECT COUNT(*) AS InvalidReviewScores
FROM dbo.reviews
WHERE review_score NOT BETWEEN 1 AND 5;
GO

/*=========================================================
12. Negative Product Prices
=========================================================*/
SELECT COUNT(*) AS NegativePrices
FROM dbo.order_items
WHERE price < 0;
GO

/*=========================================================
13. Negative Freight Values
=========================================================*/
SELECT COUNT(*) AS NegativeFreightValues
FROM dbo.order_items
WHERE freight_value < 0;
GO

/*=========================================================
14. Zero or Negative Payment Values
=========================================================*/
SELECT COUNT(*) AS InvalidPayments
FROM dbo.payments
WHERE payment_value <= 0;
GO

/*=========================================================
15. Orders Delivered Before Purchase
=========================================================*/
SELECT COUNT(*) AS InvalidDeliveryDates
FROM dbo.orders
WHERE order_delivered_customer_date IS NOT NULL
  AND order_delivered_customer_date < order_purchase_timestamp;
GO

/*=========================================================
16. Final Data Quality Summary
=========================================================*/
SELECT
    (SELECT COUNT(*) FROM dbo.customers) AS Customers,
    (SELECT COUNT(*) FROM dbo.orders) AS Orders,
    (SELECT COUNT(*) FROM dbo.order_items) AS OrderItems,
    (SELECT COUNT(*) FROM dbo.products) AS Products,
    (SELECT COUNT(*) FROM dbo.sellers) AS Sellers,
    (SELECT COUNT(*) FROM dbo.payments) AS Payments,
    (SELECT COUNT(*) FROM dbo.reviews) AS Reviews,
    (SELECT COUNT(*) FROM dbo.geolocation) AS Geolocations,
    (SELECT COUNT(*) FROM dbo.product_category_translation) AS Categories;
GO