# Index Performance Report

## Objective
Improve query performance by creating indexes on frequently used columns in the **Users**, **Booking**, and **Property** tables.

---

## Indexes Created
- **Users Table**
  - `role` → Speeds up queries filtering users by role (e.g., guest, host, admin)
  - `created_at` → Optimizes queries sorting or filtering users by signup date

- **Booking Table**
  - `user_id` → Speeds up joins between Booking and Users
  - `property_id` → Speeds up joins between Booking and Property
  - `start_date` → Optimizes queries filtering bookings by date range
  - `status` → Improves lookups for bookings with a specific status (confirmed, pending, canceled)

- **Property Table**
  - `location` → Optimizes queries filtering properties by city/location
  - `pricepernight` → Speeds up price-based filtering (e.g., price range searches)
  - `created_at` → Improves sorting properties by newest listings

---

## Performance Analysis

### Before Adding Indexes
- **EXPLAIN** showed **sequential scans** on large tables (Booking, Property).
- Join queries between Booking, Users, and Property had high cost values due to full table scans.

### After Adding Indexes
- **EXPLAIN** showed use of **index scans** instead of sequential scans.
- Query cost and estimated execution time decreased significantly.
- Example:
  ```sql
  EXPLAIN SELECT *
  FROM Booking b
  JOIN Users u ON b.user_id = u.user_id
  WHERE u.role = 'guest';
