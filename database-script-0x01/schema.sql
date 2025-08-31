-- ========================================
-- Airbnb Database Schema 
-- ========================================

-- ===========================
-- 1. Users Table
-- ===========================
CREATE TABLE Users (
    user_id UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    first_name NVARCHAR(50) NOT NULL,
    last_name NVARCHAR(50) NOT NULL,
    email NVARCHAR(100) NOT NULL UNIQUE,
    password_hash NVARCHAR(255) NOT NULL,
    phone_number NVARCHAR(20) NULL,
    role NVARCHAR(10) NOT NULL CHECK (role IN ('guest', 'host', 'admin')),
    created_at DATETIME DEFAULT GETDATE()
);

CREATE INDEX idx_users_email ON Users(email);

-- ===========================
-- 2. Property Table
-- ===========================
CREATE TABLE Property (
    property_id UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    host_id UNIQUEIDENTIFIER NOT NULL,
    name NVARCHAR(100) NOT NULL,
    description NVARCHAR(MAX) NOT NULL,
    location NVARCHAR(255) NOT NULL,
    pricepernight DECIMAL(10,2) NOT NULL,
    created_at DATETIME DEFAULT GETDATE(),
    updated_at DATETIME DEFAULT GETDATE(),
    CONSTRAINT fk_property_host FOREIGN KEY (host_id) REFERENCES Users(user_id)
);

CREATE INDEX idx_property_host ON Property(host_id);

-- ===========================
-- 3. Booking Table
-- ===========================
CREATE TABLE Booking (
    booking_id UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    property_id UNIQUEIDENTIFIER NOT NULL,
    user_id UNIQUEIDENTIFIER NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    total_price DECIMAL(10,2) NOT NULL, -- optional, can calculate dynamically
    status NVARCHAR(10) NOT NULL CHECK (status IN ('pending','confirmed','canceled')),
    created_at DATETIME DEFAULT GETDATE(),
    CONSTRAINT fk_booking_property FOREIGN KEY (property_id) REFERENCES Property(property_id),
    CONSTRAINT fk_booking_user FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

CREATE INDEX idx_booking_property ON Booking(property_id);
CREATE INDEX idx_booking_user ON Booking(user_id);

-- ===========================
-- 4. Payment Table
-- ===========================
CREATE TABLE Payment (
    payment_id UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    booking_id UNIQUEIDENTIFIER NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    payment_date DATETIME DEFAULT GETDATE(),
    payment_method NVARCHAR(20) NOT NULL CHECK (payment_method IN ('credit_card','paypal','stripe')),
    CONSTRAINT fk_payment_booking FOREIGN KEY (booking_id) REFERENCES Booking(booking_id)
);

CREATE INDEX idx_payment_booking ON Payment(booking_id);

-- ===========================
-- 5. Review Table
-- ===========================
CREATE TABLE Review (
    review_id UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    property_id UNIQUEIDENTIFIER NOT NULL,
    user_id UNIQUEIDENTIFIER NOT NULL,
    rating INT NOT NULL CHECK (rating >= 1 AND rating <= 5),
    comment NVARCHAR(MAX) NOT NULL,
    created_at DATETIME DEFAULT GETDATE(),
    CONSTRAINT fk_review_property FOREIGN KEY (property_id) REFERENCES Property(property_id),
    CONSTRAINT fk_review_user FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

CREATE INDEX idx_review_property ON Review(property_id);
CREATE INDEX idx_review_user ON Review(user_id);

-- ===========================
-- 6. Message Table
-- ===========================
CREATE TABLE Message (
    message_id UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    sender_id UNIQUEIDENTIFIER NOT NULL,
    recipient_id UNIQUEIDENTIFIER NOT NULL,
    message_body NVARCHAR(MAX) NOT NULL,
    sent_at DATETIME DEFAULT GETDATE(),
    CONSTRAINT fk_message_sender FOREIGN KEY (sender_id) REFERENCES Users(user_id),
    CONSTRAINT fk_message_recipient FOREIGN KEY (recipient_id) REFERENCES Users(user_id)
);

CREATE INDEX idx_message_sender ON Message(sender_id);
CREATE INDEX idx_message_recipient ON Message(recipient_id);
