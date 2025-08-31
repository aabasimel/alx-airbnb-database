USE airbnb_db;  

-- ===========================
-- 1. Users
-- ===========================
INSERT INTO Users (user_id, first_name, last_name, email, password_hash, phone_number, role)
VALUES
(NEWID(), 'Ahmed', 'Ali', 'ahmed@example.com', 'hashed_password1', '1234567890', 'guest'),
(NEWID(), 'Sara', 'Khan', 'sara@example.com', 'hashed_password2', '2345678901', 'host'),
(NEWID(), 'John', 'Doe', 'john@example.com', 'hashed_password3', '3456789012', 'guest'),
(NEWID(), 'Lisa', 'Smith', 'lisa@example.com', 'hashed_password4', '4567890123', 'host');

-- ===========================
-- 2. Property
-- ===========================
INSERT INTO Property (property_id, host_id, name, description, location, pricepernight)
VALUES
(NEWID(), (SELECT user_id FROM Users WHERE email='sara@example.com'), 'Cozy Apartment', 'A nice apartment in the city center', 'Berlin, Germany', 80.00),
(NEWID(), (SELECT user_id FROM Users WHERE email='lisa@example.com'), 'Beach House', 'House with ocean view', 'Barcelona, Spain', 150.00);

-- ===========================
-- 3. Booking
-- ===========================
INSERT INTO Booking (booking_id, property_id, user_id, start_date, end_date, total_price, status)
VALUES
(NEWID(), (SELECT property_id FROM Property WHERE name='Cozy Apartment'), 
         (SELECT user_id FROM Users WHERE email='ahmed@example.com'), 
         '2025-09-10', '2025-09-15', 80*5, 'confirmed'),

(NEWID(), (SELECT property_id FROM Property WHERE name='Beach House'), 
         (SELECT user_id FROM Users WHERE email='john@example.com'), 
         '2025-10-01', '2025-10-07', 150*6, 'pending');

-- ===========================
-- 4. Payment
-- ===========================
INSERT INTO Payment (payment_id, booking_id, amount, payment_method)
VALUES
(NEWID(), (SELECT booking_id FROM Booking WHERE total_price = 80*5), 400, 'credit_card'),
(NEWID(), (SELECT booking_id FROM Booking WHERE total_price = 150*6), 900, 'paypal');

-- ===========================
-- 5. Review
-- ===========================
INSERT INTO Review (review_id, property_id, user_id, rating, comment)
VALUES
(NEWID(), (SELECT property_id FROM Property WHERE name='Cozy Apartment'), 
         (SELECT user_id FROM Users WHERE email='ahmed@example.com'), 
         5, 'Amazing stay, highly recommended!'),

(NEWID(), (SELECT property_id FROM Property WHERE name='Beach House'), 
         (SELECT user_id FROM Users WHERE email='john@example.com'), 
         4, 'Great view but a bit noisy at night.');

-- ===========================
-- 6. Message
-- ===========================
INSERT INTO Message (message_id, sender_id, recipient_id, message_body)
VALUES
(NEWID(), (SELECT user_id FROM Users WHERE email='ahmed@example.com'), 
          (SELECT user_id FROM Users WHERE email='sara@example.com'), 
          'Hi Sara, I am excited about my stay next week!'),

(NEWID(), (SELECT user_id FROM Users WHERE email='john@example.com'), 
          (SELECT user_id FROM Users WHERE email='lisa@example.com'), 
          'Hello Lisa, can I check in a bit earlier?');
