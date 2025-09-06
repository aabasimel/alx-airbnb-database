ALTER TABLE "Booking" RENAME TO "Booking_backup";

CREATE TYPE booking_status AS ENUM ('pending', 'confirmed', 'canceled');

create table "Booking"(

booking_id UUID not null,
user_id UUID NOT NULL,
property_id UUID NOT NULL,
start_date DATE NOT NULL,
end_date DATE NOT NULL,
total_price NUMERIC(10,2) NOT NULL,
status booking_status NOT NULL,
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

CONSTRAINT booking_pk PRIMARY KEY (booking_id, start_date),
CONSTRAINT fk_user FOREIGN KEY (user_id) REFERENCES "user"(user_id),
CONSTRAINT fk_property FOREIGN KEY (property_id) REFERENCES "property"(property_id)

)
PARTITION BY RANGE(start_date)

CREATE TABLE "Booking_2025_01" PARTITION OF "Booking"
FOR VALUES FROM ('2025-01-01') TO ('2025-02-01');

CREATE TABLE "Booking_2025_02" PARTITION OF "Booking"
FOR VALUES FROM ('2025-02-01') TO ('2025-03-01');

CREATE TABLE "Booking_default" PARTITION OF "Booking" DEFAULT;


CREATE TABLE "Booking_2025_01" PARTITION OF "Booking"
FOR VALUES FROM ('2025-01-01') TO ('2025-02-01');

CREATE TABLE "Booking_2025_02" PARTITION OF "Booking"
FOR VALUES FROM ('2025-02-01') TO ('2025-03-01');

CREATE TABLE "Booking_default" PARTITION OF "Booking" DEFAULT;
