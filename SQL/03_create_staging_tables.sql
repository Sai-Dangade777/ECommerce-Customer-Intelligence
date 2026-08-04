
USE EcommerceCustomerIntelligence;
GO

/*=========================================================
Staging Table : Customers
Purpose : Stores raw customer data exactly as received from CSV.
=========================================================*/

CREATE TABLE stg_customers
(
    customer_id VARCHAR(50),
    customer_unique_id VARCHAR(50),
    customer_zip_code_prefix VARCHAR(20),
    customer_city VARCHAR(255),
    customer_state VARCHAR(10)
);
GO

/*=========================================================
Staging Table : Orders
Purpose : Raw order transaction data before validation.
=========================================================*/

CREATE TABLE stg_orders
(
    order_id VARCHAR(50),
    customer_id VARCHAR(50),
    order_status VARCHAR(50),
    order_purchase_timestamp VARCHAR(100),
    order_approved_at VARCHAR(100),
    order_delivered_carrier_date VARCHAR(100),
    order_delivered_customer_date VARCHAR(100),
    order_estimated_delivery_date VARCHAR(100)
);
GO

/*=========================================================
Staging Table : Products
=========================================================*/

CREATE TABLE stg_products
(
    product_id VARCHAR(50),
    product_category_name VARCHAR(255),
    product_name_lenght VARCHAR(50),
    product_description_lenght VARCHAR(50),
    product_photos_qty VARCHAR(50),
    product_weight_g VARCHAR(50),
    product_length_cm VARCHAR(50),
    product_height_cm VARCHAR(50),
    product_width_cm VARCHAR(50)
);
GO

/*=========================================================
Staging Table : Sellers
=========================================================*/

CREATE TABLE stg_sellers
(
    seller_id VARCHAR(50),
    seller_zip_code_prefix VARCHAR(20),
    seller_city VARCHAR(255),
    seller_state VARCHAR(10)
);
GO

/*=========================================================
Staging Table : Order Items
=========================================================*/

CREATE TABLE stg_order_items
(
    order_id VARCHAR(50),
    order_item_id VARCHAR(20),
    product_id VARCHAR(50),
    seller_id VARCHAR(50),
    shipping_limit_date VARCHAR(100),
    price VARCHAR(50),
    freight_value VARCHAR(50)
);
GO

/*=========================================================
Staging Table : Payments
=========================================================*/

CREATE TABLE stg_payments
(
    order_id VARCHAR(50),
    payment_sequential VARCHAR(20),
    payment_type VARCHAR(50),
    payment_installments VARCHAR(20),
    payment_value VARCHAR(50)
);
GO

/*=========================================================
Staging Table : Reviews
=========================================================*/

CREATE TABLE stg_reviews
(
    review_id VARCHAR(50),
    order_id VARCHAR(50),
    review_score VARCHAR(20),
    review_comment_title VARCHAR(255),
    review_comment_message VARCHAR(MAX),
    review_creation_date VARCHAR(100),
    review_answer_timestamp VARCHAR(100)
);
GO

/*=========================================================
Staging Table : Geolocation
=========================================================*/

CREATE TABLE stg_geolocation
(
    geolocation_zip_code_prefix VARCHAR(20),
    geolocation_lat VARCHAR(50),
    geolocation_lng VARCHAR(50),
    geolocation_city VARCHAR(255),
    geolocation_state VARCHAR(10)
);
GO

/*=========================================================
Staging Table : Product Category Translation
=========================================================*/

CREATE TABLE stg_product_category_translation
(
    product_category_name VARCHAR(255),
    product_category_name_english VARCHAR(255)
);
GO

SELECT TABLE_NAME
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_NAME LIKE 'stg%'
ORDER BY TABLE_NAME;

EXEC sp_help 'dbo.stg_reviews';
GO

EXEC sp_help 'dbo.stg_geolocation';
GO

EXEC sp_help 'dbo.stg_sellers';
GO