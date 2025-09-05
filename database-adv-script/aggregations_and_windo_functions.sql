SELECT 
    u.user_id,
    u.first_name,
    u.last_name,
    COUNT(b.booking_id) AS total_bookings
FROM Users u
LEFT JOIN Booking b 
    ON u.user_id = b.user_id
GROUP BY u.user_id, u.first_name, u.last_name;


SELECT 
    p.property_id,
    p.name,
    COUNT(b.booking_id) AS total_bookings,
    RANK() OVER (ORDER BY COUNT(b.booking_id) DESC) AS booking_rank
FROM Property p
LEFT JOIN Booking b
    ON p.property_id = b.property_id
GROUP BY p.property_id, p.name
ORDER BY booking_rank;
