CREATE TABLE listings(id SERIAL PRIMARY KEY, title VARCHAR(50), description VARCHAR(100), creator_id INTEGER, renter_id INTEGER, available_from DATE, available_to DATE);
