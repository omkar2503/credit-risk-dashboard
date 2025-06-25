# Credit Risk Scoring Dashboard  

SQL-driven assessment of borrower risk, visualised with Metabase  

---

## Overview  
The project simulates how a bank or fintech evaluates loan applicants in real time by combining transactional behaviour, loan history and repayment discipline.  
Everything runs inside PostgreSQL, so decisions stay fast, transparent and fully auditable—no external ML services required.

---

## Key Features  
- Advanced SQL logic using CTEs, CASE expressions, correlated subqueries and aggregate filtering  
- Rule-based score (0 – 100) derived from income stability, repayment punctuality, employment type, high-value loan track record and default history  
- Metabase dashboard with four interactive cards  
  - Credit-score distribution by range  
  - High-risk user table (lowest scores first)  
  - Employment-status split  
  - Income-versus-score scatter plot  
- Mock dataset (10 000+ profiles) for realistic performance testing  
- One-click reload: run the provided scripts, open Metabase and start exploring

---

## Repository Layout  
credit-risk-dashboard/
│
├─ data/ CSVs for users, transactions, loans, repayments

├─ sql/

│ ├─ create_tables.sql DDL for all tables

│ ├─ insert_data.sql COPY commands for loading the CSVs

│ └─ view_credit_scores.sql logic that builds the user_credit_scores view

├─ dashboard/

│ └─ screenshots/ sample images of each Metabase card

└─ README.md

---

## Quick-Start  

1. **Spin up PostgreSQL**

createdb credit_risk_system
psql -d credit_risk_system -f sql/create_tables.sql
psql -d credit_risk_system -f sql/insert_data.sql
psql -d credit_risk_system -f sql/view_credit_scores.sql

 **Launch Metabase** (stand-alone JAR)  
 First-time setup appears at `http://localhost:3000`.

3. **Connect Metabase to the database**  
- Host `localhost`, port `5432`, database `credit_risk_system`.  

4. **Import the dashboard**  
- Create four questions from the `user_credit_scores` view (steps documented in `dashboard/README_steps.md`).  
- Add them to a new dashboard called **Credit Risk Scoring Dashboard**.  

---

## Scoring Logic (summary)  

| Condition                                                                  | Points |
|-----------------------------------------------------------------------------|-------:|
| Six-month average monthly income ≥ ₹30 000                                  | **+30**|
| No late repayments                                                          | **+30**|
| Employment status = Salaried or Business                                    | **+20**|
| Closed loan > ₹1 00 000                                                     | **+10**|
| Any defaulted loan                                                          | **−50**|

Total score = sum of points (range 0 – 100).  
All calculations are performed inside the `user_credit_scores` view for easy querying and dashboarding.

---

## Why Rule-Based SQL over ML?  

* Full transparency for regulators and auditors  
* Immediate explainability during customer interactions  
* Lightweight deployment—no model training pipeline or specialised hardware  
* Quick rule tweaks as lending policy evolves  

---

## Screenshots  
Added images in `dashboard/screenshots/


