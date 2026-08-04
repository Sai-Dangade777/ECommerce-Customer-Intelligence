USE EcommerceCustomerIntelligence;
GO

/*=========================================================
Table 1 : Customers
Description : Stores customer information.
=========================================================*/

CREATE TABLE dbo.customers
(
    customer_id VARCHAR(50) PRIMARY KEY,
    customer_unique_id VARCHAR(50) NOT NULL,
    customer_zip_code_prefix INT,
    customer_city VARCHAR(100),
    customer_state CHAR(2)
);
GO

/*=========================================================
Table 2 : Orders
Description : Stores order-level transaction details.
=========================================================*/

CREATE TABLE dbo.orders
(
    order_id VARCHAR(50) PRIMARY KEY,
    customer_id VARCHAR(50) NOT NULL,
    order_status VARCHAR(20),
    order_purchase_timestamp DATETIME2,
    order_approved_at DATETIME2 NULL,
    order_delivered_carrier_date DATETIME2 NULL,
    order_delivered_customer_date DATETIME2 NULL,
    order_estimated_delivery_date DATETIME2
);
GO

/*=========================================================
Table 3 : Products
Description : Stores product information.
=========================================================*/

CREATE TABLE dbo.products
(
    product_id VARCHAR(50) PRIMARY KEY,
    product_category_name VARCHAR(100),
    product_name_lenght INT,
    product_description_lenght INT,
    product_photos_qty INT,
    product_weight_g INT,
    product_length_cm INT,
    product_height_cm INT,
    product_width_cm INT
);
GO

/*=========================================================
Table 4 : Sellers
Description : Stores seller information.
=========================================================*/

CREATE TABLE dbo.sellers
(
    seller_id VARCHAR(50) PRIMARY KEY,
    seller_zip_code_prefix INT,
    seller_city VARCHAR(100),
    seller_state CHAR(2)
);
GO

/*=========================================================
Table 5 : Order Items
Description : Stores line-item details for each order.
=========================================================*/

CREATE TABLE dbo.order_items
(
    order_id VARCHAR(50),
    order_item_id INT,
    product_id VARCHAR(50),
    seller_id VARCHAR(50),
    shipping_limit_date DATETIME2,
    price DECIMAL(10,2),
    freight_value DECIMAL(10,2)
);
GO

/*=========================================================
Table 6 : Payments
Description : Stores payment transactions.
=========================================================*/

CREATE TABLE dbo.payments
(
    order_id VARCHAR(50),
    payment_sequential INT,
    payment_type VARCHAR(30),
    payment_installments INT,
    payment_value DECIMAL(10,2)
);
GO

/*=========================================================
Table 7 : Reviews
Description : Stores customer reviews.
=========================================================*/

CREATE TABLE dbo.reviews
(
    review_id VARCHAR(50) NOT NULL,
    order_id VARCHAR(50) NOT NULL,
    review_score INT,
    review_comment_title NVARCHAR(255),
    review_comment_message NVARCHAR(MAX),
    review_creation_date DATETIME2,
    review_answer_timestamp DATETIME2,

    CONSTRAINT PK_reviews
        PRIMARY KEY (review_id, order_id)
);
GO


/*=========================================================
Table 8 : Geolocation
Description : Stores ZIP-code geolocation mapping.
=========================================================*/

CREATE TABLE dbo.geolocation
(
    geolocation_zip_code_prefix INT,
    geolocation_lat DECIMAL(12,8),
    geolocation_lng DECIMAL(12,8),
    geolocation_city VARCHAR(100),
    geolocation_state CHAR(2)
);
GO

/*=========================================================
Table 9 : Product Category Translation
Description : Portuguese to English category mapping.
=========================================================*/

CREATE TABLE dbo.product_category_translation
(
    product_category_name VARCHAR(100),
    product_category_name_english VARCHAR(100)
);
GO



----------------------------------------------------------------------------------------


USE EcommerceCustomerIntelligence;
GO

EXEC sp_help 'dbo.customers';
GO

EXEC sp_help 'dbo.orders';
GO

EXEC sp_help 'dbo.products';
GO

EXEC sp_help 'dbo.sellers';
GO