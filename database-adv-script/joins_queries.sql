
-- Retrieve all bookings and their respective users
SELECT 
    b.booking_id,
    b.property_id,
    b.start_date,
    b.end_date,
    b.total_price,
    b.status,
    b.created_at AS booking_created_at,
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    u.phone_number,
    u.role,
    u.created_at AS user_created_at
FROM Booking b
INNER JOIN User u
    ON b.user_id = u.user_id
ORDER BY b.created_at DESC;



-- Retrieve all properties and their reviews (if any)
SELECT
    p.property_id,
    p.host_id,
    p.name AS property_name,
    p.description,
    p.location,
    p.pricepernight,
    p.created_at AS property_created_at,
    p.updated_at AS property_updated_at,
    r.review_id,
    r.user_id AS reviewer_id,
    r.rating,
    r.comment,
    r.created_at AS review_created_at
FROM Property p
LEFT JOIN Review r
    ON p.property_id = r.property_id
ORDER BY p.created_at DESC;


-- Retrieve all users and all bookings, including users with no bookings
-- and bookings with no users linked
SELECT
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    u.phone_number,
    u.role,
    u.created_at AS user_created_at,
    b.booking_id,
    b.property_id,
    b.start_date,
    b.end_date,
    b.total_price,
    b.status,
    b.created_at AS booking_created_at
FROM User u
FULL OUTER JOIN Booking b
    ON u.user_id = b.user_id
ORDER BY u.created_at NULLS LAST, b.created_at NULLS LAST;
