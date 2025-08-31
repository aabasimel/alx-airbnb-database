# alx-airbnb-database


# Airbnb Database Project

## About
This repository contains the database design and scripts for a simplified Airbnb system.  
It covers users, properties, bookings, payments, reviews, and messages. The project includes:

1. Database schema (`schema.sql`)  
2. Normalization documentation (`normalization.md`)  
3. Sample data scripts (`seed.sql`)

The database is designed to follow **Third Normal Form (3NF)** to reduce redundancy and maintain data integrity.

---

## Folder Structure

- `database-script-0x01/`  
  - `schema.sql` – SQL script to create all tables, constraints, and indexes.  
  - `README.md` – Documentation for schema setup and usage.  
  - `normalization.md` – Explains the normalization steps applied to the database.  

- `database-script-0x02/`  
  - `seed.sql` – SQL script to insert sample data for testing and development.  
  - `README.md` – Notes about the sample data and usage instructions.

---

## Database Overview

The database includes the following main tables:

1. **Users** – Stores info about guests, hosts, and admins.  
2. **Property** – Stores property details including host, location, description, and price.  
3. **Booking** – Tracks bookings with start/end dates, total price, and status.  
4. **Payment** – Tracks payments linked to bookings.  
5. **Review** – Stores ratings and comments for properties.  
6. **Message** – Stores messages between users.

All tables include primary keys, foreign keys, and indexes for better performance.

---

## How to Set Up

### 1. Create the database

```sql
CREATE DATABASE airbnb_db;
USE airbnb_db;
