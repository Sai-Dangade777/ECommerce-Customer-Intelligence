USE master;
GO

IF DB_ID('EcommerceCustomerIntelligence') IS NOT NULL
BEGIN
    ALTER DATABASE EcommerceCustomerIntelligence
    SET SINGLE_USER WITH ROLLBACK IMMEDIATE;

    DROP DATABASE EcommerceCustomerIntelligence;
END
GO

CREATE DATABASE EcommerceCustomerIntelligence;
GO

USE EcommerceCustomerIntelligence;
GO