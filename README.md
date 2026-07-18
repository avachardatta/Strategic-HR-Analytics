# 📊 Strategic HR Analytics: Enterprise Talent Retention & Risk Modeling

## 📝 Project Overview
This project presents an enterprise-grade SQL framework built to solve workforce stabilization challenges using the **IBM HR Analytics dataset**. The objective is to transition human resources data from an unoptimized flat file into a normalized Relational Database Model (3NF) and build multi-layered diagnostic scripts. By tracking baseline attrition, evaluating structural burnout, mapping structural underpayment, and constructing an **Employee Flight-Risk Matrix**, this database acts as a predictive machine allowing People Operations to mitigate talent losses before they impact organizational revenue.

---

## 🎯 Project Objectives
* **Database Normalization (3NF):** Deconstruct flat HR logs into 6 highly isolated, performance-tuned tables connected via declarative integrity constraints and foreign keys.
* **Proactive Attrition Isolation:** Build structural indicators mapping historical attrition across granular demographic variables (Age, Role, Department).
* **Burnout & Welfare Quantification:** Design diagnostic metrics cross-referencing systemic overtime patterns against qualitative performance evaluations and work-life balance scores.
* **Predictive Risk Assessment:** Engineer a compound weighting algorithm (`Risk Score Matrix`) to classify active employee segments into clear, action-oriented prioritization rings.
* **Executive Visibility Consolidation:** Synthesize complex data points into a single dashboard summary reporting key business metrics directly to C-suite stakeholders (CHRO/CEO).

---

## 🏗️ Project Structure
The repository is systematically divided into a modular lifecycle designed for programmatic deployment:
* **`/Schema_Setup`**: Data Definition Language (DDL) scripts building the foundational tables, primary indexes, and constraint links.
* **`/Module_1_Retention_Engine`**: Quantitative queries evaluating the scale, reach, and velocity of historical talent drain.
* **`/Module_2_Burnout_Red_Flag`**: Behavioral analytics measuring the long-term sustainability of production expectations vs employee health.
* **`/Module_3_Financial_Gap_Analysis`**: Financial and promotional metrics isolating pay stagnation and progression bottlenecks.
* **`/Module_4_Executive_HR_Analytics`**: The composite metrics engine calculating risk scores and serving up the master dashboard parameters.

---

## 🧹 Data Exploration & Cleaning
Before designing the tables, an inspection of the raw flat data was conducted to eliminate structural anomalies:
1. **Normalization Assessment:** The original dataset kept all metrics—from compensation to employee sentiment—on a single row. This was split into discrete entity zones (`employee`, `employee_performance`, `employee_compensation`, `employee_experience`, `employee_attrition`) to ensure zero operational redundancy.
2. **Key Generation & Constraints:** The programmatic `employee_id` was mapped as the absolute Primary Key across all tables, establishing strict 1:1 matching rules for profile expansions.
3. **Data Type Calibration:** Financial figures (`monthly_income`, `daily_rate`) were migrated to fixed-point `DECIMAL(10,2)` parameters to prevent rounding creep, while system flags were cleanly typed as standardized strings (`VARCHAR`) and integers.

---

## 🔍 Data Analysis & Findings

### Module 1: The Retention Engine
* **Overall Attrition:** Establishes the core organizational baseline attrition KPI, enabling macro-level volume tracking.
* **Segmentation Realities:** Evaluates attrition behaviors across department silos, structural job levels, and custom age buckets (e.g., `18–25`, `26–35`). This isolates where tribal knowledge is leaving fastest.

### Module 2: The Overtime & Burnout Red Flag
* **Correlation Mapping:** Explicitly tracks whether intense overtime requirements actually generate superior output or if they simply collapse employee work-life balance vectors.
* **Burnout Tracing:** Dynamically isolates active individuals maintaining maximum performance marks (`PerformanceRating = 4`) while showing high environmental strain and low work-life scores.

### Module 3: The Financial & Promotion Gap Analysis
* **Equity Identification:** Isolates elite internal producers whose current base salaries sit under market standards (the company average).
* **Stagnation Flags:** Pins down veteran workforce populations meeting optimal performance criteria but remaining trapped in identical roles and promotional cycles for 3 or more consecutive years.

---

## 💡 Strategic Business Insights

### 1. The Retention Engine Insights
* **Finding:** Attrition rates vary drastically across specific operational nodes, heavily impacting lower tenure brackets and specific job functions.
* **Business Recommendation:** Standardize structural "Stay Interviews" at critical retention milestones (12 and 24 months) and modernise onboarding programs within high-turnover business units.

### 2. The Overtime & Burnout Red Flag Insights
* **Finding:** Sustained overtime displays an inverse relationship with long-term retention, acting as a leading indicator of turnover among top performers.
* **Business Recommendation:** Deploy automated manager warnings when high-performers run continuous overtime streaks, and couple these with rotating wellness incentives to safeguard institutional memory.

### 3. The Financial & Promotion Gap Analysis Insights
* **Finding:** Compounding promotion delays alongside salary compression acts as a primary vector driving talent straight into competitor pipelines.
* **Business Recommendation:** Implement bi-annual salary adjustment sweeps targeting individuals flagged in the stagnation index to normalize compensation equity against market standards.

---

## 📊 System Generated Reports

### 1. Employee Risk Profile Matrix (Module 4)
This programmatic engine assigns specific risk points (+1 per hazard) across 5 core corporate warning markers:
* **Risk Score 5 (Critical Risk):** Requires immediate HR intervention. Identifies top-tier employees suffering from simultaneous underpayment, promotion delay, intense overtime, and poor work-life balance.
* **Risk Score 3–4 (High Risk):** Requires localized manager mitigation plans before escalating to critical flight paths.

### 2. Executive HR Dashboard Summary (Module 4)
A high-efficiency, single-query executive dashboard designed to report macro organizational health to the CHRO. It surfaces six business-critical values instantly:

| Core Business Metric | KPI Purpose |
| :--- | :--- |
| `total_employees` | Current absolute headcount baseline. |
| `attrition_rate_pct` | Macro historical turnover rate. |
| `promotion_ready_employees` | High-performing talent pipeline primed for upskilling. |
| `burnout_employees` | The volume of active staff running high operational friction. |
| `high_financial_risk_employees` | High performers vulnerable to market poaching due to low pay. |
| `critical_risk_employees` | Total active staff meeting all five flight-risk variables. |
