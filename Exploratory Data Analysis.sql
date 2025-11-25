Perfect 👍 You’ve moved from **data cleaning** into **data exploration / analysis**.

---


### **1. See all cleaned data**

select * 
from layoffs_temp2;


👉 Just shows the full table after cleaning.

---

### **2. Find maximum layoffs (absolute + percentage)**


select max(total_laid_off),max(percentage_laid_off)
from layoffs_temp2;


👉 Finds:

* The largest number of employees laid off in one event
* The largest layoff percentage (like “100% = company shut down”).

---

### **3. Companies with 100% layoffs (sorted by number)**


select *
from layoffs_temp2
where percentage_laid_off='1'
order by total_laid_off desc;


👉 Shows companies that laid off **100% of staff**.
Then sorts by `total_laid_off` → the biggest full shutdowns appear first.

---

### **4. Companies with 100% layoffs (sorted by funding)**


select *
from layoffs_temp2
where percentage_laid_off='1'
order by funds_raised_millions desc;


👉 Same as above, but sorted by how much funding they had.
Shows shocking cases → well-funded companies that still fired everyone.

---

### **5. Total layoffs by company**


select company,sum(total_laid_off)
from layoffs_temp2
group by company
order by 2 desc;


👉 Groups data **by company** and sums up all layoffs.
Orders by column **2** (the sum) from highest → lowest.
➡️ Biggest layoffs per company.

---

### **6. Average percentage of layoffs per company**


select company,avg(percentage_laid_off)
from layoffs_temp2
group by company
order by 2 desc;


👉 Calculates the **average percentage of staff laid off** per company.
High values mean that company usually fires a big portion of its employees.

---

### **7. Total layoffs by industry**


select industry,sum(total_laid_off)
from layoffs_temp2
group by industry
order by 2 desc;


👉 Groups by industry → shows which industries fired the most people.

---

### **8. Total layoffs by country**


select country,sum(total_laid_off)
from layoffs_temp2
group by country
order by 2 desc;


👉 Groups by country → compares which country had the most layoffs.

---

### **9. Total layoffs by stage**


select stage,sum(total_laid_off)
from layoffs_temp2
group by stage
order by 2 desc;


👉 Groups by startup funding stage (`Seed`, `Series A`, `IPO`, etc.).
Helps see which stage of companies laid off the most.

---

### **10. Find earliest and latest layoff dates**


select min(`date`),max(`date`)
from layoffs_temp2;


👉 Finds the time range → first and last layoff events in your data.

---

### **11. Total layoffs by year**


select year(`date`),sum(total_laid_off)
from layoffs_temp2
group by year(`date`)
order by 1 desc;


👉 Groups layoffs by year → shows yearly totals.
Ordered by year (latest first).

---

### **12. Total layoffs by month**


select substring(`date`,1,7) as month,sum(total_laid_off) as total_laid
from layoffs_temp2
where substring(`date`,1,7) is not null
group by `month`
order by  1 asc;


👉 Takes only year + month (`YYYY-MM`) from date.
Sums layoffs per month → gives monthly trend.
Ordered oldest → newest.

---

### **13. Rolling total (cumulative sum over months)**


with rolling_total as 
(
select substring(`date`,1,7) as month,sum(total_laid_off) as total_laid
from layoffs_temp2
where substring(`date`,1,7) is not null
group by `month`
order by  1 asc
)
select `month`,
total_laid,
sum(total_laid) over(order by `month`) 
from rolling_total;


👉 Step by step:

1. CTE `rolling_total` = monthly layoffs.
2. Final query = adds a **running total** (`sum(...) over order by month`).
   → Example:

   * Jan = 100 layoffs
   * Feb = 200 layoffs
   * Mar = 50 layoffs
     Rolling total = Jan 100, Feb 300, Mar 350.

👉 Helps you see **cumulative layoffs trend over time**.

---

✅ **In short:**

* You explored layoffs by company, industry, country, and stage.
* Looked at extremes (100% layoffs, max layoffs).
* Checked time trends (yearly, monthly, cumulative).

---

