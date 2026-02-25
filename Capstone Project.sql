Create database Capstone;
-- EDA Questions --

-- 1)What is the average number of orders per customer? Are there high-value repeat customers? --

select 
	avg(OrderCount) as AvgOrderPerCustomer
From (
	SELECT CustomerID, count(DISTINCT OrderID) as OrderCount
    from Orders
Group By CustomerID
)sub;

-- Are there high-value(>5000) repeat (>10) customers?

select count(*) from (
select o.CustomerID,count(o.OrderID) total_orders, 
sum(od.UnitPrice*od.Quantity*(1-od.Discount)) total_spend
from orders o
join order_details od
on o.OrderID = od.OrderID
group by o.CustomerID
having total_orders >=10
and total_spend >=5000) sub;

-- 2)How do customer order patterns vary by city or country? --

with cte as (
SELECT CustomerID, count( distinct OrderID) orders_placed
from orders
group by CustomerID )
select Country, City, avg(orders_placed) from cte ct
join customers c
on ct.CustomerID = c.CustomerID
group by country,City;


-- 3)can we cliuster customer based on total spend, order count and preferred categories?

with cte1 as
(select o.CustomerID,count(o.OrderID) total_orders, sum(od.UnitPrice*od.Quantity*(1-od.Discount)) total_spend
from orders o
join order_details od
on o.OrderID = od.OrderID
group by o.CustomerID)
select * 
from cte1 c
join orders o
on c.CustomerID = o.CustomerID
join order_details od
on o.orderID = od.OrderID
join products p
on od.ProductID = p. ProductID
join categories cg
on p.ProductID = cg.CategoryID;

select o.CustomerID, p.CategoryID, cg.CategoryName, count(o.OrderID)
from orders o
join order_details od
on o.orderID = od.OrderID
join products p
on od.ProductID = p. ProductID
join categories cg
on p.CategoryID = cg.CategoryID
group by o.CustomerID, p.CategoryID, cg.CategoryName
order by o.CustomerID;

-- group by CustomerID, CategoryName

WITH rn AS (
    SELECT
        o.CustomerID,
        ct.CategoryName,
        COUNT(o.orderid) AS total_orders,
        ROUND(SUM(od.unitprice * od.quantity * (1 - od.discount)), 2) AS total_spending,
        ROW_NUMBER() OVER (
            PARTITION BY ct.CategoryName
            ORDER BY ROUND(SUM(od.unitprice * od.quantity * (1 - od.discount)), 2) DESC
        ) AS rn
    FROM orders o
    JOIN order_details od
        ON o.orderid = od.orderid
    JOIN products p
        ON p.productid = od.productid
    JOIN categories ct
        ON ct.categoryid = p.CategoryID
    GROUP BY o.customerid, ct.CategoryName
)
SELECT *
FROM rn
WHERE rn = 1;


-- 4)Which product categories or products contribute most to order revenue? 

SELECT
    c.CategoryName,
    ROUND(SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)), 2) AS total_revenue
FROM order_details od
JOIN products p
    ON od.ProductID = p.ProductID
JOIN categories c
    ON p.CategoryID = c.CategoryID
GROUP BY c.CategoryName
ORDER BY total_revenue DESC;

-- 5)Are there any correlations between orders and customer location or product category?

SELECT
    c.Country,
    cg.CategoryName,
    SUM(od.Quantity) AS total_quantity,
    COUNT(DISTINCT o.OrderID) AS total_orders
FROM orders o
JOIN order_details od
    ON o.OrderID = od.OrderID
JOIN customers c
    ON c.CustomerID = o.CustomerID
JOIN products p
    ON p.ProductID = od.ProductID
JOIN categories cg
    ON p.CategoryID = cg.CategoryID
GROUP BY
    c.Country,
    cg.CategoryName;

-- 6)How frequently do different customer segments place orders?

select CustomerID, OrderDate,
lead(OrderDate) over(partition by CustomerID order by OrderDate) next_od,
datediff(lead(OrderDate) over(partition by CustomerID order by OrderDate), orderDate)
from orders
order by CustomerID, OrderDate;

-- 7)What is the geographic and title-wise distribution of employees?

select
  Country,
  City,
  Title,
  COUNT(EmployeeID) as employee_count
from employees
group by Country, Title, City;

-- 8)What trends can we observe in hire dates across employee titles?

select
  Title,
  year(HireDate) as hire_year,
  COUNT(*) as hires
from employees
group by Title, year(HireDate);

-- 9)What patterns exist in employee title and courtesy title distributions?

select
  Title,
  TitleOfCourtesy,
  COUNT(*) as count_employees
from employees
group by Title, TitleOfCourtesy;

-- 10)Are there correlations between product pricing, stock levels, and sales performance?

SELECT
  p.ProductName,
  p.UnitPrice,
  p.UnitsInStock,
  SUM(od.Quantity) AS units_sold,
  ROUND(SUM(od.UnitPrice*od.Quantity*(1-od.Discount)),2) AS revenue
FROM products p
LEFT JOIN order_details od ON p.ProductID = od.ProductID
GROUP BY p.ProductName, p.UnitPrice, p.UnitsInStock
ORDER BY revenue DESC;

-- 11)How does product demand change over months or seasons?

SELECT
  YEAR(o.OrderDate) as year,
  MONTH(o.OrderDate) AS month,
  od.ProductID,
  SUM(od.Quantity) AS total_quantity
FROM orders o
JOIN order_details od ON o.OrderID = od.OrderID
GROUP BY YEAR,MONTH,ProductID
ORDER BY year,month;

-- 12)Can we identify anomalies in product sales or revenue performance?

WITH m AS (
  SELECT
    p.ProductID,
    AVG(od.Quantity) AS avg_qty,
    STDDEV(od.Quantity) AS std_qty
  FROM products p
  JOIN order_details od ON p.ProductID = od.ProductID
  GROUP BY p.ProductID
)
SELECT
  od.ProductID,
  od.Quantity
FROM order_details od
JOIN m ON od.ProductID = m.ProductID
WHERE od.Quantity > m.avg_qty + 2*m.std_qty;

-- 13)Are there any regional trends in supplier distribution and pricing?

SELECT
  s.Country,
  COUNT(DISTINCT s.SupplierID) AS suppliers,
  ROUND(AVG(p.UnitPrice),2) AS avg_price
FROM suppliers s
JOIN products p ON s.SupplierID = p.SupplierID
GROUP BY s.Country
ORDER BY avg_price DESC;


-- 14)How are suppliers distributed across different product categories?

SELECT
  c.CategoryName,
  COUNT(DISTINCT s.SupplierID) AS suppliers
FROM categories c
JOIN products p ON c.CategoryID = p.CategoryID
JOIN suppliers s ON p.SupplierID = s.SupplierID
GROUP BY c.CategoryName
ORDER BY suppliers DESC;

-- 15)How do supplier pricing and categories relate across different regions?

SELECT
  s.Country,
  c.CategoryName,
  ROUND(AVG(p.UnitPrice),2) AS avg_price
FROM suppliers s
JOIN products p ON s.SupplierID = p.SupplierID
JOIN categories c ON p.CategoryID = c.CategoryID
GROUP BY s.Country, c.CategoryName
ORDER BY s.Country, avg_price DESC;

