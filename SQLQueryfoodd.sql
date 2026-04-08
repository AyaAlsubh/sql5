CREATE DATABASE FooddDelivery;
GO

USE FooddDelivery;
GO

CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    Name NVARCHAR(100),
    Phone NVARCHAR(20)
);

CREATE TABLE Restaurants (
    RestaurantID INT PRIMARY KEY,
    Name NVARCHAR(100)
);

CREATE TABLE MenuItems (
    ItemID INT PRIMARY KEY,
    Name NVARCHAR(100),
    Price DECIMAL(6,2),
    RestaurantID INT,
    FOREIGN KEY (RestaurantID) REFERENCES Restaurants(RestaurantID)
);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

CREATE TABLE OrderItems (
    OrderID INT,
    ItemID INT,
    Quantity INT,
    PRIMARY KEY (OrderID, ItemID),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ItemID) REFERENCES MenuItems(ItemID)
);


-- Customers
INSERT INTO Customers VALUES
(1, 'Aya', '0791111111'),
(2, 'Ali', '0792222222');

-- Restaurants
INSERT INTO Restaurants VALUES
(1, 'Pizza Place'),
(2, 'Burger House');

-- MenuItems
INSERT INTO MenuItems VALUES
(1, 'Pizza', 8.50, 1),
(2, 'Pasta', 6.00, 1),
(3, 'Burger', 5.50, 2);

-- Orders
INSERT INTO Orders VALUES
(101, 1, '2026-04-08'),
(102, 2, '2026-04-08');

-- OrderItems
INSERT INTO OrderItems VALUES
(101, 1, 2),
(101, 2, 1),
(102, 3, 3);


SELECT o.OrderID, c.Name, o.OrderDate
FROM Orders o
JOIN Customers c
ON o.CustomerID = c.CustomerID;


SELECT o.OrderID, m.Name AS ItemName, oi.Quantity
FROM Orders o
JOIN OrderItems oi ON o.OrderID = oi.OrderID
JOIN MenuItems m ON oi.ItemID = m.ItemID;

SELECT o.OrderID, 
       SUM(m.Price * oi.Quantity) AS TotalPrice
FROM Orders o
JOIN OrderItems oi ON o.OrderID = oi.OrderID
JOIN MenuItems m ON oi.ItemID = m.ItemID
GROUP BY o.OrderID;