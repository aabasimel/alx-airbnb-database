# Database Normalization: Airbnb Schema

## Objective
Apply normalization principles to ensure the Airbnb database schema is in Third Normal Form (3NF).

---

## Step 1: Review Current Schema

The current schema consists of the following entities:

- **User** (user_id, first_name, last_name, email, password_hash, phone_number, role, created_at)
- **Property** (property_id, host_id, name, description, location, pricepernight, created_at, updated_at)
- **Booking** (booking_id, property_id, user_id, start_date, end_date, total_price, status, created_at)
- **Payment** (payment_id, booking_id, amount, payment_date, payment_method)
- **Review** (review_id, property_id, user_id, rating, comment, created_at)
- **Message** (message_id, sender_id, recipient_id, message_body, sent_at)

---

## Step 2: Identify Potential Redundancies

1. **User Table**  
   - No transitive dependencies; attributes depend only on `user_id`.
   - ✅ Already in 3NF.

2. **Property Table**  
   - All attributes depend on `property_id`.
   - `host_id` references `User(user_id)`; no partial or transitive dependency.
   - ✅ Already in 3NF.

3. **Booking Table**  
   - `total_price` is derivable from `pricepernight` * `number_of_nights`.
   - Storing `total_price` can cause redundancy if `pricepernight` changes.  
   - Suggestion: Either calculate `total_price` dynamically or keep it for historical integrity.  

4. **Payment Table**  
   - Attributes depend only on `payment_id`.  
   - ✅ Already in 3NF.

5. **Review Table**  
   - Attributes depend only on `review_id`.  
   - ✅ Already in 3NF.

6. **Message Table**  
   - Attributes depend only on `message_id`.  
   - ✅ Already in 3NF.

---

## Step 3: Apply Normalization Principles

### 1NF (Eliminate repeating groups)
- Each table has atomic columns.
- ✅ Already satisfied.

### 2NF (Eliminate partial dependency)
- All non-key attributes depend on the whole primary key.
- All tables use single-column primary keys (`UUID`), so no partial dependencies.
- ✅ Already satisfied.

### 3NF (Eliminate transitive dependency)
- No non-key attribute depends on another non-key attribute.
- Only potential issue: `total_price` in `Booking` depends on `pricepernight` from `Property`.
- Options:
  1. Keep `total_price` for historical consistency (recommended).
  2. Remove `total_price` and calculate on demand (less storage, dynamic calculation).

---

## Step 4: Adjustments Made

1. **Booking Table**: Added note for `total_price`:
   ```sql
   -- Optionally, remove total_price to avoid redundancy:
   -- total_price DECIMAL, NOT NULL

