-- database-adv-script/perfomance.sql
-- Initial Query: Retrieve all bookings with user, property, and payment details

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
