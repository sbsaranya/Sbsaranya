-- Simple SELECT query (T-SQL)
-- Retrieves all columns from the Customers table.
SELECT *
FROM Customers;

-- Select specific columns.
SELECT CustomerID,
       FirstName,
       LastName,
       Email
FROM Customers;

-- Select with a filter and sort order.
SELECT CustomerID,
       FirstName,
       LastName,
       City
FROM Customers
WHERE City = 'London'
ORDER BY LastName ASC;

-- Select the first 10 rows (T-SQL TOP clause).
SELECT TOP (10)
       CustomerID,
       FirstName,
       LastName
FROM Customers
ORDER BY CustomerID;
