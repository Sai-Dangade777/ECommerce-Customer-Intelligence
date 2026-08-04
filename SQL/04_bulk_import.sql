USE EcommerceCustomerIntelligence;
GO

/*=========================================================
Clear all staging tables
=========================================================*/

TRUNCATE TABLE dbo.stg_order_items;
TRUNCATE TABLE dbo.stg_payments;
TRUNCATE TABLE dbo.stg_reviews;
TRUNCATE TABLE dbo.stg_orders;
TRUNCATE TABLE dbo.stg_products;
TRUNCATE TABLE dbo.stg_customers;
TRUNCATE TABLE dbo.stg_sellers;
TRUNCATE TABLE dbo.stg_geolocation;
TRUNCATE TABLE dbo.stg_product_category_translation;
GO

/*=========================================================
Import 1 : Customers
=========================================================*/

BULK INSERT dbo.stg_customers
FROM 'D:\ECommerce-Customer-Intelligence\dataset\raw\olist_customers_dataset.csv'
WITH
(
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0A',
    TABLOCK
);
GO

/*=========================================================
Import 2 : Geolocation
=========================================================*/

BULK INSERT dbo.stg_geolocation
FROM 'D:\ECommerce-Customer-Intelligence\dataset\raw\olist_geolocation_dataset.csv'
WITH
(
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0A',
    TABLOCK
);
GO

/*=========================================================
Import 3 : Orders
=========================================================*/

BULK INSERT dbo.stg_orders
FROM 'D:\ECommerce-Customer-Intelligence\dataset\raw\olist_orders_dataset.csv'
WITH
(
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0A',
    TABLOCK
);
GO

/*=========================================================
Import 4 : Order Items
=========================================================*/

BULK INSERT dbo.stg_order_items
FROM 'D:\ECommerce-Customer-Intelligence\dataset\raw\olist_order_items_dataset.csv'
WITH
(
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0A',
    TABLOCK
);
GO

/*=========================================================
Import 5 : Payments
=========================================================*/

BULK INSERT dbo.stg_payments
FROM 'D:\ECommerce-Customer-Intelligence\dataset\raw\olist_order_payments_dataset.csv'
WITH
(
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0A',
    TABLOCK
);
GO

/*=========================================================
Import 6 : Reviews
=========================================================*/

BULK INSERT dbo.stg_reviews
FROM 'D:\ECommerce-Customer-Intelligence\dataset\raw\olist_order_reviews_dataset.csv'
WITH
(
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDQUOTE = '"',
    TABLOCK
);
GO

SELECT COUNT(*) AS TotalReviews
FROM dbo.stg_reviews;
GO

/*=========================================================
Import 7 : Products
=========================================================*/

BULK INSERT dbo.stg_products
FROM 'D:\ECommerce-Customer-Intelligence\dataset\raw\olist_products_dataset.csv'
WITH
(
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0A',
    TABLOCK
);
GO

SELECT COUNT(*) AS TotalProducts
FROM dbo.stg_products;
GO

/*=========================================================
Import 8 : Sellers
=========================================================*/

BULK INSERT dbo.stg_sellers
FROM 'D:\ECommerce-Customer-Intelligence\dataset\raw\olist_sellers_dataset.csv'
WITH
(
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0A',
    CODEPAGE = '65001',
    TABLOCK
);
GO

SELECT COUNT(*) AS TotalSellers
FROM dbo.stg_sellers;
GO

/*=========================================================
Import 9 : Product Category Translation
=========================================================*/

BULK INSERT dbo.stg_product_category_translation
FROM 'D:\ECommerce-Customer-Intelligence\dataset\raw\product_category_name_translation.csv'
WITH
(
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0A',
    TABLOCK
);
GO

SELECT COUNT(*) AS TotalCategories
FROM dbo.stg_product_category_translation;
GO

/*=========================================================
Verification
=========================================================*/

SELECT 'stg_customers' AS TableName, COUNT(*) AS TotalRows
FROM dbo.stg_customers

UNION ALL

SELECT 'stg_geolocation', COUNT(*)
FROM dbo.stg_geolocation

UNION ALL

SELECT 'stg_orders', COUNT(*)
FROM dbo.stg_orders

UNION ALL

SELECT 'stg_order_items', COUNT(*)
FROM dbo.stg_order_items

UNION ALL

SELECT 'stg_payments', COUNT(*)
FROM dbo.stg_payments

UNION ALL

SELECT 'stg_reviews', COUNT(*)
FROM dbo.stg_reviews

UNION ALL

SELECT 'stg_products', COUNT(*)
FROM dbo.stg_products

UNION ALL

SELECT 'stg_sellers', COUNT(*)
FROM dbo.stg_sellers

UNION ALL

SELECT 'stg_product_category_translation', COUNT(*)
FROM dbo.stg_product_category_translation;
GO