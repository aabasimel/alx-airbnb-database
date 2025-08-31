# alx-airbnb-database

# ER Diagram Requirements

## Objective
Create an **Entity-Relationship (ER) Diagram** for the Airbnb-style booking system based on the provided database specification.

---

## Entities and Attributes

### User
- **user_id**: Primary Key, UUID, Indexed  
- first_name: VARCHAR, NOT NULL  
- last_name: VARCHAR, NOT NULL  
- email: VARCHAR, UNIQUE, NOT NULL  
- password_hash: VARCHAR, NOT NULL  
- phone_number: VARCHAR, NULL  
- role: ENUM (guest, host, admin), NOT NULL  
- created_at: TIMESTAMP, DEFAULT CURRENT_TIMESTAMP  

### Property
- **property_id**: Primary Key, UUID, Indexed  
- host_id: Foreign Key → User(user_id)  
- name: VARCHAR, NOT NULL  
- description: TEXT, NOT NULL  
- location: VARCHAR, NOT NULL  
- price_per_night: DECIMAL, NOT NULL  
- created_at: TIMESTAMP, DEFAULT CURRENT_TIMESTAMP  
- updated_at: TIMESTAMP, ON UPDATE CURRENT_TIMESTAMP  

### Booking
- **booking_id**: Primary Key, UUID, Indexed  
- property_id: Foreign Key → Property(property_id)  
- user_id: Foreign Key → User(user_id)  
- start_date: DATE, NOT NULL  
- end_date: DATE, NOT NULL  
- total_price: DECIMAL, NOT NULL  
- status: ENUM (pending, confirmed, canceled), NOT NULL  
- created_at: TIMESTAMP, DEFAULT CURRENT_TIMESTAMP  

### Payment
- **payment_id**: Primary Key, UUID, Indexed  
- booking_id: Foreign Key → Booking(booking_id)  
- amount: DECIMAL, NOT NULL  
- payment_date: TIMESTAMP, DEFAULT CURRENT_TIMESTAMP  
- payment_method: ENUM (credit_card, paypal, stripe), NOT NULL  

### Review
- **review_id**: Primary Key, UUID, Indexed  
- property_id: Foreign Key → Property(property_id)  
- user_id: Foreign Key → User(user_id)  
- rating: INTEGER, CHECK (1–5), NOT NULL  
- comment: TEXT, NOT NULL  
- created_at: TIMESTAMP, DEFAULT CURRENT_TIMESTAMP  

### Message
- **message_id**: Primary Key, UUID, Indexed  
- sender_id: Foreign Key → User(user_id)  
- recipient_id: Foreign Key → User(user_id)  
- message_body: TEXT, NOT NULL  
- sent_at: TIMESTAMP, DEFAULT CURRENT_TIMESTAMP  

---

## Relationships

| From Entity | To Entity | Relationship Name | Cardinality | Notes |
|------------|-----------|-----------------|------------|-------|
| User | Property | Hosts | 1 : N | One user can host multiple properties |
| User | Booking | Makes | 1 : N | One user can make multiple bookings |
| Property | Booking | Is Booked In | 1 : N | A property can have many bookings |
| Booking | Payment | Has Payment | 1 : N | One booking can have multiple payments |
| Property | Review | Receives | 1 : N | A property can have many reviews |
| User | Review | Writes | 1 : N | One user can write multiple reviews |
| User | Message | Sends | 1 : N | User can send messages to other users (self-referencing) |

---
