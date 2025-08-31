# Database Normalization: Airbnb Schema

## Objective
The goal of this work is to apply normalization principles to ensure that the Airbnb database schema is in Third Normal Form (3NF).

---

## Step 1: Reviewing the Current Schema

The database currently has the following entities:

- **User**: user_id, first_name, last_name, email, password_hash, phone_number, role, created_at  
- **Property**: property_id, host_id, name, description, location, pricepernight, created_at, updated_at  
- **Booking**: booking_id, property_id, user_id, start_date, end_date, total_price, status, created_at  
- **Payment**: payment_id, booking_id, amount, payment_date, payment_method  
- **Review**: review_id, property_id, user_id, rating, comment, created_at  
- **Message**: message_id, sender_id, recipient_id, message_body, sent_at  

---

## Step 2: Identifying Potential Redundancies

1. **User Table**  
   All attributes depend only on `user_id`. There are no transitive dependencies.  
   ✅ This table is already in 3NF.

2. **Property Table**  
   All columns depend on `property_id`. The `host_id` references `User(user_id)`, but there are no partial or transitive dependencies.  
   ✅ This table is already in 3NF.

3. **Booking Table**  
   `total_price` can be derived from `pricepernight` × number of nights. Storing it could cause redundancy if the property price changes.  
   I decided to keep it to preserve historical records, but it could also be calculated on demand.

4. **Payment Table**  
   All attributes depend on `payment_id`.  
   ✅ Already in 3NF.

5. **Review Table**  
   Attributes depend only on `review_id`.  
   ✅ Already in 3NF.

6. **Message Table**  
   Attributes depend only on `message_id`.  
   ✅ Already in 3NF.

---

## Step 3: Applying Normalization Principles

- **1NF (First Normal Form)**: All tables have atomic columns. ✅ Satisfied.  
- **2NF (Second Normal Form)**: All non-key attributes depend on the whole primary key. Since all tables have single-column primary keys (`UUID`), there are no partial dependencies. ✅ Satisfied.  
- **3NF (Third Normal Form)**: No non-key attribute depends on another non-key attribute. The only potential issue is `total_price` in `Booking`, which depends on `pricepernight` from `Property`. As mentioned, I kept it for historical consistency. ✅ Satisfied.

---

## Step 4: Adjustments Made

- In the **Booking** table, I added a note that `total_price` could be removed if we wanted to avoid redundancy:
```sql
-- Optionally, remove total_price to avoid redundancy:
-- total_price DECIMAL, NOT NULL
