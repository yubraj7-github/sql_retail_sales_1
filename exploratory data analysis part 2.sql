select company ,year(`date`),sum(total_laid_off)
from layoffs_temp2
group by company,year(`date`)
order by 3 desc;

with Company_year (company,year,total_laid_off) as
(
select company ,year(`date`),sum(total_laid_off)
from layoffs_temp2
group by company,year(`date`)
),Company_year_rank as
(select *,
dense_rank () over (partition by year order by total_laid_off desc) as ranking
from Company_year
where year is not null
)
select *
from Company_year_rank
where ranking <=5;