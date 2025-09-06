# Partitioning Performance Report

**Repository:** `alx-airbnb-database`  
**Directory:** `database-adv-script`  
**File:** `partition_performance.md`

---

## 1. Objective

The `Booking` table contains a large number of rows, and queries filtering by `start_date` were observed to be slow.
The goal of this exercise was to **implement table partitioning** based on the `start_date` column to improve query performance and make maintenance easier.

---


## 2. Implementation

### 1. Create ENUM type for booking status:

```sql
CREATE TYPE booking_status AS ENUM ('pending', 'confirmed', 'canceled');
```
### 2. Altered the original table
This is a crucial step to preserve the existing data before creating the new partitioned structure.

### 3. Create monthly partitions:

```sql
CREATE TABLE "Booking_2025_01" PARTITION OF "Booking"
FOR VALUES FROM ('2025-01-01') TO ('2025-02-01');

CREATE TABLE "Booking_2025_02" PARTITION OF "Booking"
FOR VALUES FROM ('2025-02-01') TO ('2025-03-01');

CREATE TABLE "Booking_default" PARTITION OF "Booking" DEFAULT;
```

The DEFAULT partition catches any rows outside the defined ranges.

### 3. Testing Query Performance

Query before partitioning:

```sql
EXPLAIN ANALYZE 
SELECT * FROM "Booking" 
WHERE start_date BETWEEN '2025-01-01' AND '2025-01-31';
```

Full table scan occurred.

Execution time: ~2.3 seconds (for large datasets).
