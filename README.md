# 📊 Retail Sales SQL Analysis Project

This project contains a full SQL workflow including **table creation**, **data cleaning**, **exploration**, and **business analysis queries** using a retail sales dataset.

---

## 📁 Project Structure

* **my_sql_project_1.sql** – Main SQL file containing:

  * Table creation
  * Data cleaning
  * Exploratory queries
  * Business problem solutions
  * Window functions
  * Aggregations

---

## 🛠️ Technologies Used

* **MySQL / PostgreSQL style SQL**
* **SQL aggregation functions**
* **Window functions (RANK, AVG, EXTRACT, etc.)**
* **Data cleaning & validation**

---

## 📂 Dataset Structure

The project uses a `retail_sales` table:

| Column         | Type        |
| -------------- | ----------- |
| transaction_id | INT (PK)    |
| sale_date      | DATE        |
| sale_time      | TIME        |
| customer_id    | INT         |
| gender         | VARCHAR(15) |
| age            | INT         |
| category       | VARCHAR(15) |
| quantity       | INT         |
| price_per_unit | FLOAT       |
| cogs           | FLOAT       |
| total_sale     | FLOAT       |

---

# 🧹 Data Cleaning Queries

Includes checks for:

* Missing `transaction_id`
* Missing date/time values
* Missing gender/category/quantity
* Removing incomplete rows

Example:

```sql
DELETE FROM retail_sales
WHERE 
    transaction_id IS NULL
    OR sale_date IS NULL
    OR sale_time IS NULL
    OR gender IS NULL
    OR category IS NULL
    OR quantity IS NULL
    OR cogs IS NULL
    OR total_sale IS NULL;
```

---

# 🔍 Exploratory Analysis

### ✔ Total number of sales

```sql
SELECT COUNT(*) FROM retail_sales;
```

### ✔ Unique customers

```sql
SELECT COUNT(DISTINCT customer_id) FROM retail_sales;
```

### ✔ Category list

```sql
SELECT DISTINCT category FROM retail_sales;
```

---

# 📈 Business Questions & SQL Solutions

### **Q1. Sales made on `2022-11-05`**

```sql
SELECT *
FROM retail_sales
WHERE sale_date = '2022-11-05';
```

---

### **Q2. Clothing sales with quantity ≥ 4 (Nov 2022)**

```sql
SELECT *
FROM retail_sales
WHERE category = 'Clothing'
  AND TO_CHAR(sale_date, 'YYYY-MM') = '2022-11'
  AND quantity >= 4;
```

---

### **Q3. Total sales by category**

```sql
SELECT category, SUM(total_sale) AS net_sale
FROM retail_sales
GROUP BY category;
```

---

### **Q4. Average age of Beauty customers**

```sql
SELECT ROUND(AVG(age), 2) AS avg_age
FROM retail_sales
WHERE category = 'Beauty';
```

---

### **Q5. High-value transactions (total > 1000)**

```sql
SELECT *
FROM retail_sales
WHERE total_sale > 1000;
```

---

### **Q6. Transactions by gender within each category**

```sql
SELECT category, gender, COUNT(*) AS total_trans
FROM retail_sales
GROUP BY category, gender;
```

---

### **Q7. Best-selling month in each year**

Uses `EXTRACT()` + window functions:

```sql
SELECT year, month, avg_sale
FROM (
    SELECT 
        EXTRACT(YEAR FROM sale_date) AS year,
        EXTRACT(MONTH FROM sale_date) AS month,
        AVG(total_sale) AS avg_sale,
        RANK() OVER (PARTITION BY EXTRACT(YEAR FROM sale_date)
                     ORDER BY AVG(total_sale) DESC) AS rank
    FROM retail_sales
    GROUP BY 1, 2
) t
WHERE rank = 1;
```

---

### **Q8. Top 5 customers by total sales**

```sql
SELECT customer_id, SUM(total_sale) AS total_sales
FROM retail_sales
GROUP BY customer_id
ORDER BY total_sales DESC
LIMIT 5;
```

---

### **Q9. Unique customers per category**

```sql
SELECT category, COUNT(DISTINCT customer_id) AS cnt_unique_cs
FROM retail_sales
GROUP BY category;
```

---

### **Q10. Sales by time shift (Morning, Afternoon, Evening)**

```sql
WITH hourly_sale AS (
    SELECT *,
        CASE
            WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
            WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
            ELSE 'Evening'
        END AS shift
    FROM retail_sales
)
SELECT shift, COUNT(*) AS total_orders
FROM hourly_sale
GROUP BY shift;
```

---

# ✅ How to Use

1. Create the `retail_sales` table using the provided SQL.
2. Import your dataset (CSV/Excel).
3. Run the data-cleaning section.
4. Execute analysis queries and explore insights.

---

# 📦 File Included

* **my_sql_project_1.sql**
  (Full SQL script for cleaning, exploration & analysis)
  → Stored in this repo at:
  `/mnt/data/my_sql_project_1.sql`


---

# ⭐ Author

**Yubraj Shrestha**
Aspiring Data Analyst | SQL • Python • Power BI | Continuous Learner

---
