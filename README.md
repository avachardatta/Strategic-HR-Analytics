# HR Attrition Analysis: Why Employees Leave and Who Is at Risk

PostgreSQL analysis of 1,470 employees (IBM HR Analytics dataset), written for the HR Head who needs to cut employee attrition.

## 1. Business problem

**Who is asking:** the HR Head (People Operations).

**Problem statement:** 16.1% of employees (237 of 1,470) have left the company. The HR Head must decide where to spend the retention budget. Using employee, job, pay, experience and satisfaction data, find which groups leave most and which high performers are at risk, so HR can target retention actions where they cut attrition the most.

**Questions answered:**
1. What is the overall attrition rate?
2. Which departments, job roles, levels and age groups leave most?
3. Does overtime make people leave? Does it improve performance?
4. Which high performers are burned out, underpaid or waiting too long for promotion?

## 2. Data

IBM HR Analytics dataset (public, fictional employees), split from one flat file into 6 related tables. Income has no currency in the source.

| Table | Rows | Key columns |
| --- | --- | --- |
| dept.csv → `department` | 3 | dept_id, department |
| emp.csv → `employee` | 1,470 | age, gender, marital status, job role, job level, overtime, business travel |
| emp_attr.csv → `employee_attrition` | 1,470 | attrition (Yes/No) |
| emp_compensation.csv → `employee_compensation` | 1,470 | monthly income, salary hike %, stock options |
| emp_experience.csv → `employee_experience` | 1,470 | years at company, years in role, years since promotion |
| emp_performance.csv → `employee_performance` | 1,470 | performance rating, job satisfaction, work-life balance |

All tables join on `employee_id` (primary key); `employee.dept_id` links to `department`.

## 3. How I worked (7 steps)

1. **Define:** problem statement and questions above.
2. **Collect:** loaded the IBM HR CSV.
3. **Clean and model:** split the flat file into 6 tables (one subject per table) with primary and foreign keys, so each fact is stored once. Fixed a typo in the department name ("Human Resorces").
4. **Explore:** counts, attrition by department, role and age group.
5. **Analyze:** SQL with JOINs, GROUP BY, CASE (age buckets), subqueries (pay below company average) and business rules for burnout and promotion.
6. **Visualize:** result tables below (dashboard is a next step).
7. **Communicate:** insights and recommendations below.

## 4. Key numbers

| Group | Employees | Left | Attrition |
| --- | --- | --- | --- |
| **Whole company** | 1,470 | 237 | **16.1%** |
| Works overtime | 416 | 127 | **30.5%** |
| No overtime | 1,054 | 110 | 10.4% |
| Job level 1 (entry) | 543 | 143 | **26.3%** |
| First 2 years at company | 342 | 102 | **29.8%** |
| 10+ years at company | 246 | 20 | 8.1% |
| Age 18–25 | 123 | 44 | **35.8%** |
| Single | 470 | 120 | 25.5% |
| Travels frequently | 277 | 69 | 24.9% |
| Sales Representative | 83 | 33 | **39.8%** |
| Laboratory Technician | 259 | 62 | 23.9% |
| Sales department | 446 | 92 | 20.6% |
| R&D department | 961 | 133 | 13.8% |

## 5. Insights

1. **Overtime is the strongest warning sign.** People on overtime leave **3x more** (30.5% vs 10.4%) and make up **54% of all leavers**. Overtime does **not** raise performance (average rating 3.16 vs 3.15), so the company pays the cost without the benefit.
2. **Attrition is an early-career problem.** Job level 1 loses 26.3% and makes up **60% of all leavers**. Employees in their first 2 years leave at 29.8%, against 8.1% after 10 years. Entry-level staff on overtime leave at **52.6%**.
3. **Pay matters.** Median monthly income of leavers is **3,202 vs 5,204** for those who stayed.
4. **Two roles need urgent attention:** Sales Representatives (39.8%) and Laboratory Technicians (23.9%).
5. **High performers at risk can be named.** 155 top-rated employees (rating 4) earn below the company average, and 32 of them (20.6%) have already left. 57 top performers have waited 3+ years for promotion. 24 top performers work overtime with low work-life balance (7 of them left).

**One finding that surprised me:** overtime workers rate their work-life balance almost the same as others (2.73 vs 2.77 out of 4), yet they leave 3x more. The survey score alone would hide this risk.

## 6. Recommendations

| Action | Why (the number) | What to watch |
| --- | --- | --- |
| Cap regular overtime and review teams where it is routine | overtime staff leave 3x more with no performance gain | overtime hours and attrition by team, monthly |
| Strengthen onboarding and check-ins in the first 2 years, starting with level 1 | level 1 = 60% of leavers; 29.8% leave in the first 2 years | 12-month and 24-month retention of new joiners |
| Review pay for the 155 top performers below average income | 20.6% of them have already left | attrition of rating-4 employees |
| Run a focused review of Sales Representative and Lab Technician roles | 39.8% and 23.9% attrition | attrition in these roles each quarter |
| Fast-track promotion decisions for the 57 high performers waiting 3+ years | long waits risk losing proven people | promotions made, and attrition in this group |

## 7. Executive summary

The company loses 16.1% of employees. Most leavers are early-career (level 1 = 60% of leavers) and many work overtime (3x attrition, no performance gain). **Recommendation:** cap routine overtime and invest in the first 2 years of the employee journey; then review pay for the 155 underpaid top performers.

## 8. Files

```
analytics_queries.sql   # table creation (DDL) + all analysis queries
dept.csv, emp*.csv      # the 6 tables' data
```

Load order: create tables from `analytics_queries.sql`, import the CSVs (department first, then employee, then the other 4), then run the queries.

## 9. Limitations and next steps

- One snapshot in time, so I can't see *when* people left or trends over time.
- The dataset is fictional and small (1,470 employees); results show patterns, not proof of cause.
- Next: build an employee risk score (overtime + low pay + no promotion + low work-life balance) and a Power BI dashboard.

**Tools:** PostgreSQL (JOINs, GROUP BY, CASE, subqueries), Excel/CSV.
