-- Find total customers by countries
SELECT 
country,
COUNT(DISTINCT(customer_key)) as total_customers
FROM gold.dim_customers
GROUP BY country
ORDER BY total_customers DESC

-- Find total customers by gender
SELECT
gender,
COUNT(customer_key) as total_customers
FROM gold.dim_customers
GROUP BY gender
ORDER BY total_customers DESC

-- Find total products by category
SELECT
category,
COUNT(product_key) as total_products
FROM gold.dim_products
GROUP BY category
ORDER BY total_products DESC

-- What is the average costs in each category?
SELECT
category,
AVG(cost) as avg_cost
FROM gold.dim_products
GROUP BY category
ORDER BY avg_cost DESC

-- What is the total revenue generated for each category?
SELECT
p.category,
SUM(s.sales_amount) as total_revenue
FROM gold.fact_sales s
LEFT JOIN gold.dim_products p
ON p.product_key = s.product_key
GROUP BY p.category
ORDER BY total_revenue DESC

-- Find the total reveneue generated by each customer
SELECT
c.customer_key,
c.first_name,
c.last_name,
SUM(s.sales_amount) as total_revenue
FROM gold.fact_sales s
LEFT JOIN gold.dim_customers c
ON s.customer_key = c.customer_key
GROUP BY c.customer_key, c.first_name, c.last_name
ORDER BY total_revenue DESC

-- What is the distribution of sold items across countries?
SELECT
c.country,
SUM(s.quantity) as total_sold_items
FROM gold.fact_sales s
LEFT JOIN gold.dim_customers c
ON s.customer_key = c.customer_key
GROUP BY c.country
ORDER BY total_sold_items DESC
