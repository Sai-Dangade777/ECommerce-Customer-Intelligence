USE EcommerceCustomerIntelligence;
GO

SELECT
    TABLE_NAME,
    COLUMN_NAME,
    DATA_TYPE,
    CHARACTER_MAXIMUM_LENGTH
FROM INFORMATION_SCHEMA.COLUMNS
WHERE COLUMN_NAME IN
(
    'order_id',
    'customer_id',
    'product_id',
    'seller_id',
    'review_id'
)
ORDER BY TABLE_NAME, COLUMN_NAME;