--create table
DROP TABLE IF EXISTS retail_sales;
CREATE TABLE retail_sales
	(
	transactions_id INT PRIMARY KEY,
	sale_date DATE,
	sale_time TIME,
	customer_id INT,
	gender VARCHAR(15),
	age INT,
	category VARCHAR(25),
	quantiy INT,
	price_per_unit FLOAT,
	cogs FLOAT,
	total_sale FLOAT
    );


select * FROM retail_sales;

select count(*) FROM retail_sales;

--
SELECT * FROM retail_sales
WHERE transactions_id  IS NULL

--
SELECT * FROM retail_sales
WHERE   sale_date  IS NULL
		or
		sale_time  IS NULL
		or
		customer_id is null
		or 
		gender is null
		or 
		age is null
		or 
		price_per_unit is null
		or 
		category is null
		or 
		quantiy is null
		or
		total_sale is null
		or
		cogs is null
		
--
DELETE FROM retail_sales
WHERE   sale_date  IS NULL
		or
		sale_time  IS NULL
		or
		customer_id is null
		or 
		gender is null
		or 
		age is null
		or 
		price_per_unit is null
		or 
		category is null
		or 
		quantiy is null
		or
		total_sale is null
		or
		cogs is null
		
select count(*) FROM retail_sales;
		
		
-- data exploration
-- How many sales we have?
SELECT COUNT(*) AS total_sales
FROM retail_sales

--How many customer we have?
select count(distinct(customer_id))
from retail_sales;


--How many category we have?
select count(distinct(category))
from retail_sales;

--How many category we have?
select *
from retail_sales;

--!!Business Problems

-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
SELECT *
FROM retail_sales
WHERE sale_date = '2022-11-05'



-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022
SELECT 
  *
FROM retail_sales
WHERE 
    category = 'Clothing'
    AND 
    TO_CHAR(sale_date, 'YYYY-MM') = '2022-11'
    AND
    quantity >= 4

"Beauty"	286790
"Clothing"	309995
"Electronics"	311445
-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.

SELECT category, sum(total_sale) as sale
from retail_sales
group by category;


-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
SELECT avg(age)
FROM retail_sales
where category = 'Beauty'

-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
SELECT *
FROM retail_sales
WHERE total_sale > 1000;

-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
SELECT count(transactions_id) as total_transactions_id, gender, category 
FROM retail_sales
GROUP BY category, gender
order by 3

-- -- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
select sale_year, sale_month, avg_sale
from
(
	SELECT EXTRACT(YEAR FROM sale_date) as sale_year, EXTRACT(MONTH FROM sale_date) as sale_month, avg(total_sale) as avg_sale, 
	Rank() over(partition by extract(year from sale_date) order by avg(total_sale) desc) as rank
	from retail_sales
	Group by sale_year, sale_month
) as t1
	where rank = 1

-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
select customer_id, sum(total_sale) as net_sale
from retail_sales
group by customer_id
order by net_sale desc
limit 5;

-- -- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
select category, count(distinct(customer_id))
from retail_Sales
group by category



-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)

with hourly_sale
as (select *,
	case
	when extract(hour from sale_time) < 12 then 'morning'
	when extract(hour from sale_time) between 12 and 17 then 'afternoon'
	else 'evening'
	end as shift
from retail_Sales
)
select  shift,
count(*) as total_orders
from hourly_sale
group by shift
order by shift 

