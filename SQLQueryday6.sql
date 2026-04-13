

/*
   Q1:
   Show customer name and number of orders  */
SELECT c.Name AS CustomerName,
       COUNT(o.OrderID) AS NumberOfOrders
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.Name
ORDER BY NumberOfOrders DESC;



/* 
   Q2:
   Customers who placed more than 3 orders*/
SELECT c.Name AS CustomerName,
       COUNT(o.OrderID) AS TotalOrders
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.Name
HAVING COUNT(o.OrderID) > 3;



/* 
   Q3:
   Customers who spent more than 50 JD */
SELECT c.Name AS CustomerName,
       SUM(m.Price * oi.Quantity) AS TotalSpent
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN OrderItems oi ON o.OrderID = oi.OrderID
JOIN MenuItems m ON oi.ItemID = m.ItemID
GROUP BY c.Name
HAVING SUM(m.Price * oi.Quantity) > 50;



/* 
   Q4:
   Menu items sold more than 10 units */
SELECT m.Name AS ItemName,
       SUM(oi.Quantity) AS TotalSold
FROM MenuItems m
JOIN OrderItems oi ON m.ItemID = oi.ItemID
GROUP BY m.Name
HAVING SUM(oi.Quantity) > 10;



/* 
   Part 2: Normalization
    */

/*
Why separate tables?
- Reduce redundancy
- Improve consistency
- Easier updates
- Better organization

Problems in one table:
- Data duplication
- Update anomaly
- Insert anomaly
- Delete anomaly
*/



/* =========================
   Part 3: Denormalization
   ========================= */

-- إنشاء الجدول مرة وحدة فقط
CREATE TABLE orders_monthly_report (
    customer_id INT,
    customer_name NVARCHAR(100),
    restaurant_name NVARCHAR(100),
    month_year VARCHAR(7),
    total_orders INT,
    total_amount DECIMAL(10,2),

    PRIMARY KEY (customer_id, restaurant_name, month_year)
);


/*
Why denormalized?
- Combines multiple tables
- Contains redundant data

Redundant columns:
- customer_name
- restaurant_name

Advantage:
- Faster reports

Disadvantage:
- ممكن البيانات تصير outdated

Solution:
- Batch jobs
- Triggers
- ETL
*/



/* =========================
   Data (for testing)
   ========================= */

INSERT INTO Orders VALUES
(103, 1, '2026-04-09'),
(104, 1, '2026-04-10'),
(105, 1, '2026-04-11'),
(106, 1, '2026-04-12');

INSERT INTO OrderItems VALUES
(103, 1, 3),
(104, 2, 4),
(105, 1, 2),
(106, 3, 5);