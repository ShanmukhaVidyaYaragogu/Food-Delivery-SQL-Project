# Food Delivery Sales and Customer Analytics Using SQL

A beginner-friendly portfolio project using PostgreSQL to analyze a fictional food-delivery business. It demonstrates relational database design, constraints, joins, aggregations, CTEs, CASE expressions, window functions, and data-quality checks.

> **Dataset note:** All records are fictional and created for learning. Do not present this as production-company data.

## Business questions
- How much food revenue comes from delivered orders?
- Which restaurants and menu items perform best?
- What is the average food order value?
- Which customers order repeatedly?
- How many orders are cancelled or still in progress?
- Which customers have never ordered?

## Tools
- PostgreSQL 13+
- pgAdmin or DBeaver (or another PostgreSQL client)

## Files
- `sql/01_create_tables.sql` — tables and constraints
- `sql/02_insert_sample_data.sql` — fictional sample data
- `sql/03_business_analysis.sql` — analytical queries
- `sql/04_data_quality_checks.sql` — data-quality checks
- `docs/PROJECT_EXPLANATION.md` — design and interview notes
- `docs/ERD.md` — table relationships

## How to run
1. Create an empty practice database, e.g. `food_delivery_db`.
2. Run `sql/01_create_tables.sql`.
3. Run `sql/02_insert_sample_data.sql`.
4. Run `sql/03_business_analysis.sql`.
5. Run `sql/04_data_quality_checks.sql`.

**Warning:** The create script drops these project tables if they already exist. Run it only in a dedicated practice database.

## Metric definitions
- **Food revenue:** Sum of `quantity * unit_price` for line items in `Delivered` orders. Delivery fees are excluded.
- **Average food order value:** Average of each delivered order's food subtotal, after first aggregating item lines to one row per order.
- **Units sold:** Sum of item quantities in delivered orders.
- **Cancellation rate:** Cancelled orders divided by all orders in the chosen period. Always state the denominator.

## SQL skills demonstrated
`CREATE TABLE` · Primary/foreign keys · `CHECK` constraints · `INSERT` · `JOIN` · `GROUP BY` · `HAVING` · `CASE` · CTEs · Window functions · Date aggregation · Data-quality checks

## Design decisions
- Primary keys uniquely identify rows.
- Foreign keys preserve relationships.
- `order_items` stores one row per item line in an order.
- `unit_price` is stored at sale time so historical sales remain meaningful if a menu price changes.
- This is a simplified learning schema. A production system could include payments, discounts, refunds, tax, delivery timestamps, and status history.

## Next improvements
- Add pickup and delivery-completion timestamps.
- Add payments, discounts, refunds, and tax.
- Analyze delivery duration and cancellation reasons.
- Evaluate indexes using query plans on larger data.
- Connect validated outputs to a dashboard.

## Interview tip
Explain the business question, relationships, metric definitions, SQL logic, and limitations. Only claim results you have personally run and verified.
