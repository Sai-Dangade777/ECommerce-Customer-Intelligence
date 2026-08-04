USE EcommerceCustomerIntelligence;
GO

/*=========================================================
05 - Transform Staging Data into Production Tables
=========================================================*/

SET NOCOUNT ON;
GO

/*=========================================================
Load Customers
=========================================================*/

TRUNCATE TABLE dbo.customers;

INSERT INTO dbo.customers
(
    customer_id,
    customer_unique_id,
    customer_zip_code_prefix,
    customer_city,
    customer_state
)
SELECT DISTINCT
    REPLACE(LTRIM(RTRIM(customer_id)), '"', ''),
    REPLACE(LTRIM(RTRIM(customer_unique_id)), '"', ''),
    TRY_CAST(REPLACE(customer_zip_code_prefix, '"', '') AS INT),
    REPLACE(LTRIM(RTRIM(customer_city)), '"', ''),
    UPPER(REPLACE(LTRIM(RTRIM(customer_state)), '"', ''))
FROM dbo.stg_customers;

SELECT COUNT(*) AS CustomersLoaded
FROM dbo.customers;
GO

/*=========================================================
Load Orders
=========================================================*/

TRUNCATE TABLE dbo.orders;

INSERT INTO dbo.orders
(
    order_id,
    customer_id,
    order_status,
    order_purchase_timestamp,
    order_approved_at,
    order_delivered_carrier_date,
    order_delivered_customer_date,
    order_estimated_delivery_date
)
SELECT
    REPLACE(LTRIM(RTRIM(order_id)), '"', ''),
    REPLACE(LTRIM(RTRIM(customer_id)), '"', ''),
    REPLACE(LTRIM(RTRIM(order_status)), '"', ''),
    TRY_CONVERT(DATETIME2, order_purchase_timestamp),
    TRY_CONVERT(DATETIME2, order_approved_at),
    TRY_CONVERT(DATETIME2, order_delivered_carrier_date),
    TRY_CONVERT(DATETIME2, order_delivered_customer_date),
    TRY_CONVERT(DATETIME2, order_estimated_delivery_date)
FROM dbo.stg_orders;

SELECT COUNT(*) AS OrdersLoaded
FROM dbo.orders;
GO

/*=========================================================
Load Products
=========================================================*/

TRUNCATE TABLE dbo.products;

INSERT INTO dbo.products
(
    product_id,
    product_category_name,
    product_name_lenght,
    product_description_lenght,
    product_photos_qty,
    product_weight_g,
    product_length_cm,
    product_height_cm,
    product_width_cm
)
SELECT
    REPLACE(LTRIM(RTRIM(product_id)), '"', ''),
    NULLIF(REPLACE(LTRIM(RTRIM(product_category_name)), '"', ''), ''),
    TRY_CAST(product_name_lenght AS INT),
    TRY_CAST(product_description_lenght AS INT),
    TRY_CAST(product_photos_qty AS INT),
    TRY_CAST(product_weight_g AS INT),
    TRY_CAST(product_length_cm AS INT),
    TRY_CAST(product_height_cm AS INT),
    TRY_CAST(product_width_cm AS INT)
FROM dbo.stg_products;

SELECT COUNT(*) AS ProductsLoaded
FROM dbo.products;
GO

/*=========================================================
Load Order Items
=========================================================*/

TRUNCATE TABLE dbo.order_items;

INSERT INTO dbo.order_items
(
    order_id,
    order_item_id,
    product_id,
    seller_id,
    shipping_limit_date,
    price,
    freight_value
)
SELECT
    REPLACE(LTRIM(RTRIM(order_id)), '"', ''),
    TRY_CAST(order_item_id AS INT),
    REPLACE(LTRIM(RTRIM(product_id)), '"', ''),
    REPLACE(LTRIM(RTRIM(seller_id)), '"', ''),
    TRY_CONVERT(DATETIME2, shipping_limit_date),
    TRY_CAST(price AS DECIMAL(10,2)),
    TRY_CAST(freight_value AS DECIMAL(10,2))
FROM dbo.stg_order_items;

SELECT COUNT(*) AS OrderItemsLoaded
FROM dbo.order_items;
GO

/*=========================================================
Load Payments
=========================================================*/

TRUNCATE TABLE dbo.payments;

INSERT INTO dbo.payments
(
    order_id,
    payment_sequential,
    payment_type,
    payment_installments,
    payment_value
)
SELECT
    REPLACE(LTRIM(RTRIM(order_id)), '"', ''),
    TRY_CAST(payment_sequential AS INT),
    REPLACE(LTRIM(RTRIM(payment_type)), '"', ''),
    TRY_CAST(payment_installments AS INT),
    TRY_CAST(payment_value AS DECIMAL(10,2))
FROM dbo.stg_payments;

SELECT COUNT(*) AS PaymentsLoaded
FROM dbo.payments;
GO

/*=========================================================
Load Reviews
=========================================================*/

TRUNCATE TABLE dbo.reviews;

INSERT INTO dbo.reviews
(
    review_id,
    order_id,
    review_score,
    review_comment_title,
    review_comment_message,
    review_creation_date,
    review_answer_timestamp
)
SELECT
    REPLACE(LTRIM(RTRIM(review_id)), '"', ''),
    REPLACE(LTRIM(RTRIM(order_id)), '"', ''),
    TRY_CAST(review_score AS INT),
    NULLIF(REPLACE(LTRIM(RTRIM(review_comment_title)), '"', ''), ''),
    NULLIF(REPLACE(LTRIM(RTRIM(review_comment_message)), '"', ''), ''),
    TRY_CONVERT(DATETIME2, review_creation_date),
    TRY_CONVERT(DATETIME2, review_answer_timestamp)
FROM dbo.stg_reviews;

SELECT COUNT(*) AS ReviewsLoaded
FROM dbo.reviews;
GO

/*=========================================================
Load Sellers
=========================================================*/

TRUNCATE TABLE dbo.sellers;

INSERT INTO dbo.sellers
(
    seller_id,
    seller_zip_code_prefix,
    seller_city,
    seller_state
)
SELECT
    REPLACE(LTRIM(RTRIM(seller_id)), '"', ''),
    TRY_CAST(seller_zip_code_prefix AS INT),
    REPLACE(LTRIM(RTRIM(seller_city)), '"', ''),
    UPPER(REPLACE(LTRIM(RTRIM(seller_state)), '"', ''))
FROM dbo.stg_sellers;

SELECT COUNT(*) AS SellersLoaded
FROM dbo.sellers;
GO

/*=========================================================
Load Geolocation
=========================================================*/

TRUNCATE TABLE dbo.geolocation;

INSERT INTO dbo.geolocation
(
    geolocation_zip_code_prefix,
    geolocation_lat,
    geolocation_lng,
    geolocation_city,
    geolocation_state
)
SELECT
    TRY_CAST(geolocation_zip_code_prefix AS INT),
    TRY_CAST(geolocation_lat AS DECIMAL(12,8)),
    TRY_CAST(geolocation_lng AS DECIMAL(12,8)),
    REPLACE(LTRIM(RTRIM(geolocation_city)), '"', ''),
    UPPER(REPLACE(LTRIM(RTRIM(geolocation_state)), '"', ''))
FROM dbo.stg_geolocation;

SELECT COUNT(*) AS GeolocationLoaded
FROM dbo.geolocation;
GO

/*=========================================================
Load Product Category Translation
=========================================================*/

TRUNCATE TABLE dbo.product_category_translation;

INSERT INTO dbo.product_category_translation
(
    product_category_name,
    product_category_name_english
)
SELECT
    REPLACE(LTRIM(RTRIM(product_category_name)), '"', ''),
    REPLACE(LTRIM(RTRIM(product_category_name_english)), '"', '')
FROM dbo.stg_product_category_translation;

SELECT COUNT(*) AS CategoriesLoaded
FROM dbo.product_category_translation;
GO
