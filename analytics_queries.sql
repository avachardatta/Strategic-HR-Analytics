CREATE TABLE department (
    dept_id SERIAL PRIMARY KEY,
    department_name VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE employee (
    employee_id INT PRIMARY KEY,
    dept_id INT NOT NULL,
    age INT NOT NULL,
    gender VARCHAR(20) NOT NULL,
    marital_status VARCHAR(30),
    education INT,
    education_field VARCHAR(100),
    business_travel VARCHAR(50),
    distance_from_home INT,
    job_role VARCHAR(100),
    job_level INT,
    overtime VARCHAR(5),
    CONSTRAINT fk_department
        FOREIGN KEY (dept_id)
        REFERENCES department(dept_id)
);



CREATE TABLE employee_compensation (
    employee_id INT PRIMARY KEY,

    daily_rate DECIMAL(10,2),
    hourly_rate DECIMAL(10,2),
    monthly_rate DECIMAL(10,2),
    monthly_income DECIMAL(10,2),

    percent_salary_hike DECIMAL(5,2),
    stock_option_level INT,

    CONSTRAINT fk_employee_compensation
        FOREIGN KEY (employee_id)
        REFERENCES employee(employee_id)
);


CREATE TABLE employee_performance (

    employee_id INT PRIMARY KEY,

    environment_satisfaction INT,
    job_involvement INT,
    job_satisfaction INT,
    relationship_satisfaction INT,

    performance_rating INT,

    work_life_balance INT,
    training_times_last_year INT,

    CONSTRAINT fk_employee_performance
        FOREIGN KEY (employee_id)
        REFERENCES employee(employee_id)
);


CREATE TABLE employee_experience (

    employee_id INT PRIMARY KEY,

    num_companies_worked INT,
    total_working_years INT,

    years_at_company INT,
    years_in_current_role INT,
    years_since_last_promotion INT,
    years_with_curr_manager INT,

    CONSTRAINT fk_employee_experience
        FOREIGN KEY (employee_id)
        REFERENCES employee(employee_id)
);


CREATE TABLE employee_attrition (

    employee_id INT PRIMARY KEY,

    attrition VARCHAR(10),

    CONSTRAINT fk_employee_attrition
        FOREIGN KEY (employee_id)
        REFERENCES employee(employee_id)
);


select * from department

select * from employee

select * from employee_attrition

select * from employee_experience

select * from employee_performance

select * from employee_compensation



-- Question 1:
-- What is the overall employee attrition rate

-- Attrition Rate (%) = Number of Churned Employees ÷ Average Number of Employees

SELECT
    COUNT(*) AS total_employees,
    COUNT(CASE WHEN attrition = 'Yes' THEN 1 END) AS employees_left,
    ROUND(
        COUNT(CASE WHEN attrition = 'Yes' THEN 1 END)::NUMERIC
        / COUNT(*) * 100,
        2
    ) AS attrition_rate
FROM employee_attrition;


-- Business Objective:
-- Calculate the company's overall attrition rate to establish
-- a baseline KPI for future retention analysis.

-- Question 2
-- Which departments are losing the most employees?

SELECT
	d.department_name,
	COUNT(*) AS no_of_emp,
	COUNT(CASE WHEN ea.attrition = 'Yes' THEN 1 END ) AS emp_left,
	ROUND(
        COUNT(CASE WHEN ea.attrition = 'Yes' THEN 1 END)::NUMERIC
        / COUNT(*) * 100,
        2
    ) AS attrition_rate
FROM employee e
JOIN department d
	ON e.dept_id = d.dept_id
JOIN employee_attrition ea
	ON e.employee_id = ea.employee_id
GROUP BY d.department_name
ORDER BY attrition_rate DESC;		



-- Question 3: Which Job Roles have the highest attrition rate?

SELECT
	e.job_role,
	COUNT(*) AS no_of_emp,
	COUNT(CASE WHEN ea.attrition = 'Yes' THEN 1 END) AS emp_left,
	ROUND(
        COUNT(CASE WHEN ea.attrition = 'Yes' THEN 1 END)::NUMERIC
        / COUNT(*) * 100,
        2
    ) AS attrition_rate
FROM employee e
JOIN employee_attrition ea
	ON e.employee_id = ea.employee_id
GROUP BY e.job_role
ORDER BY attrition_rate DESC;		



-- Question 4	
-- "Which age groups have the highest attrition rate?"


-- 18–25
-- 26–35
-- 36–45
-- 46–55
-- 56+


SELECT
	CASE
		WHEN e.age BETWEEN 18 AND 25 THEN '18-25'
	    WHEN e.age BETWEEN 26 AND 35 THEN '26-35'
	 	WHEN e.age BETWEEN 36 AND 45 THEN '36-45'
	    WHEN e.age BETWEEN 46 AND 55 THEN '46-55'
		ELSE '56+'
	END AS Age_group,
	COUNT(*) AS no_of_emp,
	COUNT(CASE WHEN ea.attrition = 'Yes' THEN 1 END) AS emp_left,
	ROUND(
        COUNT(CASE WHEN ea.attrition = 'Yes' THEN 1 END)::NUMERIC
        / COUNT(*) * 100,
        2
    ) AS attrition_rate
FROM employee e
JOIN employee_attrition ea
	ON e.employee_id = ea.employee_id
GROUP BY 1
ORDER BY attrition_rate DESC;		




-- Question 5
-- "Does working overtime increase the likelihood of employees leaving the company?"


SELECT
	e.overtime,
	COUNT(*) AS no_of_emp,
	COUNT(CASE WHEN ea.attrition = 'Yes' THEN 1 END) AS emp_left,
	ROUND(
        COUNT(CASE WHEN ea.attrition = 'Yes' THEN 1 END)::NUMERIC
        / COUNT(*) * 100,
        2
    ) AS attrition_rate
FROM employee e
JOIN employee_attrition ea
	ON e.employee_id = ea.employee_id
GROUP BY 1
ORDER BY attrition_rate DESC;		


-- Question 6
-- "Which departments have the highest burnout risk?"


SELECT
	d.department_name,
	COUNT(CASE WHEN e.overtime = 'Yes' AND ep.work_life_balance <= 2 THEN 1 END) AS burnout_emp,
	COUNT(*) AS no_of_emp,
	ROUND(COUNT(CASE WHEN e.overtime = 'Yes' AND ep.work_life_balance <= 2 THEN 1 END)::NUMERIC/ COUNT(*) * 100,2) AS burnout_rate
FROM employee e
JOIN department d
	ON e.dept_id = d.dept_id
JOIN employee_performance ep
	ON e.employee_id = ep.employee_id
GROUP BY 1
ORDER BY burnout_rate DESC;






-- Module 2: The Overtime & Burnout Red Flag
-- Which high-performing employees are at risk of burnout?"

-- Business Rule

-- A High Performer at Burnout Risk is an employee who satisfies all of these:

-- PerformanceRating = 4
-- OverTime = 'Yes'
-- WorkLifeBalance <= 2






SELECT * FROM employee

select * from employee_performance

select * from department



SELECT
	e.employee_id,
	d.department_name,
	e.job_role,
	ea.performance_rating,
	ea.work_life_balance,
	e.overtime
FROM employee e
JOIN employee_performance ea
	ON e.employee_id = ea.employee_id
JOIN department d
	ON e.dept_id = d.dept_id
WHERE
	ea.performance_rating = 4
	AND e.overtime = 'Yes'
	AND ea.work_life_balance <= 2




-- "Which departments have the highest number of high-performing employees at burnout risk?"

-- Business Rule

-- A burnout-risk employee satisfies:

-- PerformanceRating = 4
-- OverTime = 'Yes'
-- WorkLifeBalance <= 2

SELECT
    d.department_name,
    COUNT(*) AS burnout_employees
FROM employee e
JOIN employee_performance ea
	ON e.employee_id = ea.employee_id
JOIN department d
	ON e.dept_id = d.dept_id
WHERE
	ea.performance_rating = 4
	AND e.overtime = 'Yes'
	AND ea.work_life_balance <= 2
GROUP BY 1;


-- "Does overtime improve employee performance, or are employees simply working longer hours?"

SELECT * FROM employee

select * from employee_performance


SELECT
	e.overtime,
	ea.performance_rating,
	COUNT(*) AS employee_count
FROM employee e
JOIN employee_performance ea
	ON e.employee_id = ea.employee_id
GROUP BY
	e.overtime,
	ea.performance_rating
ORDER BY
	e.overtime ASC,
	ea.performance_rating DESC;



-- "Does overtime negatively impact employees' work-life balance?"

SELECT * FROM employee

select * from employee_performance

SELECT
	e.overtime,
	ea.work_life_balance,
	COUNT(*) AS employee_count
FROM employee e
JOIN employee_performance ea
	ON e.employee_id = ea.employee_id
GROUP BY
	e.overtime,
	ea.work_life_balance
ORDER BY
	e.overtime ASC,
	ea.work_life_balance ASC ;



-- ⏳ Module 3: The Financial & Promotion Gap Analysis (Next)

-- Question 9: Who are the high-performing employees that may be underpaid?


select * from department

select * from employee

select * from employee_attrition

select * from employee_experience

select * from employee_performance

select * from employee_compensation


SELECT
	e.employee_id,
	d.department_name,
	e.job_role,
	ec.monthly_income,
	ep.performance_rating
FROM employee e
JOIN department d
	ON e.dept_id = d.dept_id
JOIN employee_performance ep
	ON e.employee_id = ep.employee_id
JOIN employee_compensation ec
	ON e.employee_id = ec.employee_id
WHERE
	ep.performance_rating = 4
	AND ec.monthly_income < (SELECT AVG(monthly_income) FROM employee_compensation)
	


-- "Which employees should be considered for promotion in the next review cycle?"

-- For this project, an employee is promotion-ready if:
-- PerformanceRating = 4
-- YearsInCurrentRole >= 3
-- YearsSinceLastPromotion >= 3


SELECT
	e.employee_id,
	d.department_name,
	e.job_role,
	ep.performance_rating,	
	ec.years_in_current_role,
	ec.years_since_last_promotion
FROM employee e
JOIN department d
	ON e.dept_id = d.dept_id
JOIN employee_performance ep
	ON e.employee_id = ep.employee_id
JOIN  employee_experience ec
	ON e.employee_id = ec.employee_id
WHERE
	ep.performance_rating = 4
	AND ec.years_in_current_role >= 3
	AND ec.years_since_last_promotion >=3;







select * from department

select * from employee

select * from employee_experience

select * from employee_performance



