# Airbnb Sample Data

## Overview
This folder contains the SQL script to populate the Airbnb database with sample data.  
The data includes multiple users, properties, bookings, payments, reviews, and messages to simulate real-world usage.

---

## File

- `seed.sql` – SQL script to insert sample data into all tables.

---

## How to Use

1. Make sure the database is already created and the schema (`schema.sql`) has been run.  
2. Run the seed script in SQL Server:

```sql
USE airbnb_db;
:r .\seed.sql
