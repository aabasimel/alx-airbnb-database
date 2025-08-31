# Airbnb Database Schema

## About
This folder has all the SQL scripts and documentation for my Airbnb database project.  
The database is set up to manage users, properties, bookings, payments, reviews, and messages.

---
## Database Tables

Here’s a quick rundown of the main tables:

1. **Users** – Stores info about guests, hosts, and admins.  
2. **Property** – Stores property details like host, location, description, and price.  
3. **Booking** – Tracks bookings for properties, including dates, total price, and status.  
4. **Payment** – Keeps a record of payments for each booking.  
5. **Review** – Stores ratings and comments from users for properties.  
6. **Message** – Stores messages sent between users.

All tables have primary keys, foreign keys, and extra indexes for better performance. I also made sure the database follows **3NF** to reduce redundancy and keep things clean.

---

## How to Use

1. First, create the database in SQL Server:

```sql
CREATE DATABASE airbnb_db;
USE airbnb_db;

