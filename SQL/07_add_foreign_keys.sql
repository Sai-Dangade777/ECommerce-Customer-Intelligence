USE EcommerceCustomerIntelligence;
GO

/*=========================================================
07 - ADD FOREIGN KEY CONSTRAINTS
=========================================================*/


/*---------------------------------------------------------
Orders → Customers
---------------------------------------------------------*/
IF NOT EXISTS
(
    SELECT 1
    FROM sys.foreign_keys
    WHERE name = 'FK_Orders_Customers'
)
BEGIN
    ALTER TABLE dbo.orders
    ADD CONSTRAINT FK_Orders_Customers
    FOREIGN KEY (customer_id)
    REFERENCES dbo.customers(customer_id);
END
GO


/*---------------------------------------------------------
Order Items → Orders
---------------------------------------------------------*/
IF NOT EXISTS
(
    SELECT 1
    FROM sys.foreign_keys
    WHERE name = 'FK_OrderItems_Orders'
)
BEGIN
    ALTER TABLE dbo.order_items
    ADD CONSTRAINT FK_OrderItems_Orders
    FOREIGN KEY (order_id)
    REFERENCES dbo.orders(order_id);
END
GO


/*---------------------------------------------------------
Order Items → Products
---------------------------------------------------------*/
IF NOT EXISTS
(
    SELECT 1
    FROM sys.foreign_keys
    WHERE name = 'FK_OrderItems_Products'
)
BEGIN
    ALTER TABLE dbo.order_items
    ADD CONSTRAINT FK_OrderItems_Products
    FOREIGN KEY (product_id)
    REFERENCES dbo.products(product_id);
END
GO


/*---------------------------------------------------------
Order Items → Sellers
---------------------------------------------------------*/
IF NOT EXISTS
(
    SELECT 1
    FROM sys.foreign_keys
    WHERE name = 'FK_OrderItems_Sellers'
)
BEGIN
    ALTER TABLE dbo.order_items
    ADD CONSTRAINT FK_OrderItems_Sellers
    FOREIGN KEY (seller_id)
    REFERENCES dbo.sellers(seller_id);
END
GO


/*---------------------------------------------------------
Payments → Orders
---------------------------------------------------------*/
IF NOT EXISTS
(
    SELECT 1
    FROM sys.foreign_keys
    WHERE name = 'FK_Payments_Orders'
)
BEGIN
    ALTER TABLE dbo.payments
    ADD CONSTRAINT FK_Payments_Orders
    FOREIGN KEY (order_id)
    REFERENCES dbo.orders(order_id);
END
GO


/*---------------------------------------------------------
Reviews → Orders
---------------------------------------------------------*/
IF NOT EXISTS
(
    SELECT 1
    FROM sys.foreign_keys
    WHERE name = 'FK_Reviews_Orders'
)
BEGIN
    ALTER TABLE dbo.reviews
    ADD CONSTRAINT FK_Reviews_Orders
    FOREIGN KEY (order_id)
    REFERENCES dbo.orders(order_id);
END
GO
