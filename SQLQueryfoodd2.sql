use FooddDelivery;
-- Q1: الطلبات اللي سعرها أكبر من متوسط الطلبات
SELECT o.OrderID,
       SUM(m.Price * oi.Quantity) AS TotalPrice
FROM Orders o
JOIN OrderItems oi ON o.OrderID = oi.OrderID
JOIN MenuItems m ON oi.ItemID = m.ItemID
GROUP BY o.OrderID
HAVING SUM(m.Price * oi.Quantity) > (
   
    SELECT AVG(OrderTotal)
    FROM (
        SELECT SUM(m2.Price * oi2.Quantity) AS OrderTotal
        FROM Orders o2
        JOIN OrderItems oi2 ON o2.OrderID = oi2.OrderID
        JOIN MenuItems m2 ON oi2.ItemID = m2.ItemID
        GROUP BY o2.OrderID
    ) AS AvgTable
);


-- Q2: أغلى صنف
SELECT Name, Price
FROM MenuItems
WHERE Price = (
    SELECT MAX(Price)
    FROM MenuItems
);


-- Q3: العملاء اللي عملوا آخر طلب
SELECT c.Name, o.OrderID, o.OrderDate
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE o.OrderDate = (
    SELECT MAX(OrderDate)
    FROM Orders
);


-- Q4: المطاعم اللي عندها طلب واحد على الأقل
SELECT DISTINCT r.Name
FROM Restaurants r
JOIN MenuItems m ON r.RestaurantID = m.RestaurantID
JOIN OrderItems oi ON m.ItemID = oi.ItemID;




-- Q5: أسماء العملاء بدون تكرار
SELECT DISTINCT Name
FROM Customers;



-- Q6: الأصناف اللي ما انطلبت
SELECT Name
FROM MenuItems
WHERE ItemID NOT IN (
    SELECT ItemID
    FROM OrderItems
);