# Optimization Report: Refactoring Complex Queries

## 1️⃣ Objective
Retrieve all bookings along with user details, property details, and payment details, and optimize performance by reducing execution time through indexing and query refactoring.

---

## 2️⃣ Initial Query
The initial query is saved in `perfomance.sql`:

```sql
SELECT
    b.booking_id,
    b.start_date,
    b.end_date,
    b.total_price,
    b.status AS booking_status,
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    p.property_id,
    p.name AS property_name,
    p.location,
    p.pricepernight,
    pay.payment_id,
    pay.amount,
    pay.payment_date,
    pay.payment_method
FROM "Booking" b
JOIN "User" u ON b.user_id = u.user_id
JOIN "Property" p ON b.property_id = p.property_id
LEFT JOIN "Payment" pay ON pay.booking_id = b.booking_id;

3️⃣ Performance Analysis with EXPLAIN

Running EXPLAIN ANALYZE revealed the following:

Step	Operation	Cost	Notes
1	Seq Scan on Booking	High	Full table scan, slow for large data
2	Seq Scan on User	Medium	No index on user_id join column
3	Seq Scan on Property	Medium	No index on property_id join column
4	Seq Scan on Payment	Medium	No index on booking_id join column
Execution Time	~15 ms		Would scale poorly with large datasets
Identified Inefficiencies

Sequential scans on all tables

Selecting all columns increases I/O

No filtering → fetches all bookings

Missing indexes on foreign key columns

4️⃣ Refactoring Steps
🔧 4.1 Added Indexes
CREATE INDEX IF NOT EXISTS idx_booking_user_id ON "Booking"(user_id);
CREATE INDEX IF NOT EXISTS idx_booking_property_id ON "Booking"(property_id);
CREATE INDEX IF NOT EXISTS idx_payment_booking_id ON "Payment"(booking_id);


Effect: Index scans replace sequential scans, reducing join cost.

🔧 4.2 Optimized Query (Reduced Columns)
SELECT
    b.booking_id,
    b.start_date,
    b.end_date,
    u.first_name,
    u.last_name,
    p.name AS property_name,
    pay.amount,
    pay.payment_date
FROM "Booking" b
JOIN "User" u ON b.user_id = u.user_id
JOIN "Property" p ON b.property_id = p.property_id
LEFT JOIN "Payment" pay ON pay.booking_id = b.booking_id;


# 3️⃣ Performance Analysis with EXPLAIN

Running `EXPLAIN ANALYZE` revealed the following:

| Step | Operation           | Cost   | Notes                                     |
|------|-------------------|--------|------------------------------------------|
| 1    | Seq Scan on Booking | High   | Full table scan, slow for large data     |
| 2    | Seq Scan on User    | Medium | No index on user_id join column          |
| 3    | Seq Scan on Property| Medium | No index on property_id join column      |
| 4    | Seq Scan on Payment | Medium | No index on booking_id join column       |
|      | Execution Time      | ~15 ms | Would scale poorly with large datasets   |

### Identified Inefficiencies
- Sequential scans on all tables  
- Selecting all columns increases I/O  
- No filtering → fetches all bookings  
- Missing indexes on foreign key columns  

---

# 4️⃣ Refactoring Steps

### 🔧 4.1 Added Indexes
```sql
CREATE INDEX IF NOT EXISTS idx_booking_user_id ON "Booking"(user_id);
CREATE INDEX IF NOT EXISTS idx_booking_property_id ON "Booking"(property_id);
CREATE INDEX IF NOT EXISTS idx_payment_booking_id ON "Payment"(booking_id);
