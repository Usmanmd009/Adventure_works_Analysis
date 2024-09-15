CREATE TABLE FactSales (
	"OrderDate"	TEXT,
	"StockDate"	TEXT,
	"OrderNumber" TEXT,
	"ProductKey" INTEGER,
	"CustomerKey" INTEGER,
	"TerritoryKey" INTEGER,
	"OrderLineItem" INTEGER,
	"OrderQuantity" INTEGER,
	PRIMARY KEY (OrderNumber, OrderLineItem)
);

INSERT INTO FactSales(OrderDate,StockDate, OrderNumber, ProductKey, CustomerKey, TerritoryKey, OrderLineItem, OrderQuantity)
SELECT OrderDate,StockDate, OrderNumber, ProductKey, CustomerKey, TerritoryKey, OrderLineItem, OrderQuantity
FROM sales_2015;





 CREATE TABLE "sale_2015" (
	"OrderNumber"	TEXT,
	"ProductKey"	INTEGER,
	"CustomerKey"	INTEGER,
	"TerritoryKey"	INTEGER,
	"OrderLineItem"	INTEGER,
	"OrderQuantity"	INTEGER,
	"order_date"	TEXT,
	"stock_date"	TEXT
);

--ALTER TABLE returns RENAME TO FactReturns;

--ALTER TABLE calendar RENAME TO DimCalendar;
--ALTER TABLE customers RENAME TO DimCustomer;
--ALTER TABLE productcategories RENAME TO DimProductCategories;
--ALTER TABLE productsubcategories RENAME TO DimProduct_Subcategories;
--ALTER TABLE products RENAME TO DimProducts;
 ALTER table territories RENAME to DimTerritories;
 
 CREATE TABLE DimCalendars (
  OrderDate TEXT,
  Year TEXT,
  Month TEXT,
  PRIMARY KEY (OrderDate)
);
 
INSERT INTO DimCalendars(OrderDate, Year, Month)
SELECT 
  Date, 
  CAST(substr(Date, length(Date)-3, 4) AS INTEGER) AS Year, 
  CAST(substr(Date, 1, 2) AS INTEGER) AS Month
FROM DimCalendar;
 
-- Identify Sales Trends: Analyze sales data to uncover trends over time, including peak periods and sales dips.




-- Understand Customer Behavior: Examine customer demographics and purchasing patterns to identify key customer segments and behaviors.

SELECT 
  BirthDate,
  gender,
  COUNT(*) AS customer_count
FROM DimCustomer
GROUP BY BirthDate, gender;





-- Evaluate Product Performance: Assess the performance of different products, including best-sellers and underperforming items

-- Best-Selling Products

 SELECT 
  ProductName,
  SUM(ProductCost * ProductPrice) AS total_sales,
  SUM(ProductCost * ProductPrice) AS total_revenue
FROM DimProducts
GROUP BY ProductName
ORDER BY total_sales DESC
LIMIT 10;

-- Underperforming Products
 SELECT 
  ProductName,
  SUM(ProductCost * ProductPrice) AS total_sales,
  SUM(ProductCost * ProductPrice) AS total_revenue
FROM DimProducts
GROUP BY ProductName
ORDER BY total_sales ASC
LIMIT 10;


-- Analyze Territorial Differences: Compare sales performance across different regions to identify high and low-performing areas

-- high-performing 

SELECT T.Region, SUM(R.ReturnQuantity) AS TotalReturns
FROM FactReturns R
JOIN DimTerritories T ON R.TerritoryKey = T.SalesTerritoryKey
GROUP BY T.Region
ORDER by TotalReturns DESC;

-- low-performing

SELECT T.Region, SUM(R.ReturnQuantity) AS TotalReturns
FROM FactReturns R
JOIN DimTerritories T ON R.TerritoryKey = T.SalesTerritoryKey
GROUP BY T.Region
ORDER by TotalReturns ASC;



-- Seasonal Impact: Determine the influence of seasonal trends on sales for various product categories.




-- Optimize Sales Strategies: Provide recommendations for improving sales strategies based on data insights.

-- top-selling products:

 SELECT ProductName, SUM(ProductCost * ProductPrice ) AS Total_Sales
FROM FactSales
JOIN DimProducts USING (ProductKey)
GROUP BY ProductName
ORDER BY total_sales DESC;

-- recommendations
-- Foster strong relationships with customers through personalized communication and tailored sales approaches.
-- Consider price adjustments for products with high demand or low sales to optimize revenue.
-- Develop personalized sales strategies for high-value customers to increase loyalty and retention.



-- Enhance Product Offerings: Suggest optimizations for product offerings based on performance and customer preferences.

-- Product Performance Analysis

SELECT
ProductName,
  SUM(ProductCost * ProductPrice ) AS total_sales,
  SUM(ProductCost * ProductPrice) AS total_revenue
  FROM FactSales
JOIN DimProducts USING (ProductKey)
GROUP BY ProductName
ORDER BY total_sales DESC;

--Customer preferences
  
SELECT 
  ProductName,
  COUNT(DISTINCT CustomerKey) AS unique_customers,
  SUM(ProductCost * ProductPrice ) AS total_sales
FROM FactSales
JOIN DimProducts USING (ProductKey)
GROUP BY ProductName
ORDER BY unique_customers DESC;

 



 
	 