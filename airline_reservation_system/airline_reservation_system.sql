use airline_reserve_system;
-- Create Schemas;
CREATE TABLE Flights(
 flight_id INT AUTO_INCREMENT PRIMARY KEY,
 airline VARCHAR(50),
 source VARCHAR(50),
 destination VARCHAR(50),
 departure_time DATETIME,
 arrival_time DATETIME,
 status VARCHAR(20),
 aircraft_type VARCHAR(50)
 );
 
CREATE  TABLE Customers(
 customer_id INT AUTO_INCREMENT PRIMARY KEY,
 cust_name VARCHAR(100),
 email VARCHAR(100),
 phone VARCHAR(100),
 passport_numer VARCHAR(20) UNIQUE
 );
 
ALTER TABLE Customers
CHANGE COLUMN passport_numer passport_number VARCHAR(20);

CREATE TABLE Seats(
 seat_id INT AUTO_INCREMENT PRIMARY KEY,
 flight_id INT,
 seat_number VARCHAR(10),
 class VARCHAR(10),
 is_available BOOLEAN DEFAULT TRUE,
 FOREIGN KEY (flight_id) REFERENCES Flights(flight_id) ON DELETE CASCADE
 );
 
CREATE TABLE Bookings(
 booking_id INT AUTO_INCREMENT PRIMARY KEY,
 customer_id INT,
 flight_id INT,
 seat_id INT,
 booking_date DATETIME DEFAULT NOW(),
 status VARCHAR(20) DEFAULT 'Booked',
 payment_status VARCHAR(20) DEFAULT 'Paid',
 FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
 FOREIGN KEY (flight_id) REFERENCES Flights(flight_id),
 FOREIGN KEY (seat_id) REFERENCES Seats(seat_id)
 );
 
 CREATE TABLE Prices (
    price_id INT AUTO_INCREMENT PRIMARY KEY,
    flight_id INT,
    class VARCHAR(20),
    price DECIMAL(10,2),
    FOREIGN KEY (flight_id) REFERENCES Flights(flight_id)
);

-- Insert values to Tables;
INSERT INTO Flights (
 airline, source, destination, departure_time, arrival_time, status, aircraft_type
) VALUES
('IndiGo', 'Delhi', 'Mumbai', '2025-08-01 08:00:00', '2025-08-01 10:00:00', 'On Time', 'A320'),
('Air India', 'Mumbai', 'Bangalore', '2025-08-01 11:00:00', '2025-08-01 13:00:00', 'On Time', 'B737'),
('SpiceJet', 'Kolkata', 'Delhi', '2025-08-02 09:30:00', '2025-08-02 12:30:00', 'On Time', 'A320'),
('Vistara', 'Chennai', 'Hyderabad', '2025-08-03 14:00:00', '2025-08-03 15:30:00', 'Delayed', 'A320neo'),
('GoAir', 'Pune', 'Ahmedabad', '2025-08-04 06:00:00', '2025-08-04 07:45:00', 'Cancelled', 'ATR 72');

INSERT INTO Customers(
 cust_name,email,phone,passport_number
 ) VALUES
('Navneet Sharma', 'navneet@gmail.com', '9123456780', 'A1234567'),
('Dimple Mundhra', 'dimple7@gmail.com', '9123677646', 'B7654321'),
('Atif Zubair', 'atifz@gmail.com', '9911002200', 'C5432109'),
('Maya Kanwar', 'kanwarmaya@mail.com', '9988776655', 'D1010101'),
('Arjun Singh', 'arjun.singh@mail.com', '9001122334', 'E2020202'); 

-- Seats for flight_id = 1
INSERT INTO Seats (flight_id, seat_number, class) VALUES
(1, '1A', 'Economy'),
(1, '1B', 'Economy'),
(1, '2A', 'Business'),
(1, '2B', 'Business'),
(1, '3A', 'Economy');

-- Seats for flight_id = 2
INSERT INTO Seats (flight_id, seat_number, class) VALUES
(2, '1A', 'Economy'),
(2, '1B', 'Economy'),
(2, '2A', 'Business'),
(2, '2B', 'Business'),
(2, '3A', 'Economy');

-- Seats for flight_id = 3
INSERT INTO Seats (flight_id, seat_number, class) VALUES
(3, '1A', 'Economy'),
(3, '1B', 'Economy'),
(3, '2A', 'Business'),
(3, '2B', 'Business'),
(3, '3A', 'Economy');

-- Seats for flight_id = 4
INSERT INTO Seats (flight_id, seat_number, class) VALUES
(4, '1A', 'Economy'),
(4, '1B', 'Economy'),
(4, '2A', 'Business'),
(4, '2B', 'Business'),
(4, '3A', 'Economy');

-- Booking with real seat_id from above entries (assuming IDs are 1 to 10)
INSERT INTO Bookings (customer_id, flight_id, seat_id, booking_date, status, payment_status) VALUES
(1, 1, 1, '2025-07-01 10:00:00', 'Booked', 'Paid'),
(2, 1, 2, '2025-07-01 10:30:00', 'Booked', 'Paid'),
(3, 1, 3, '2025-07-02 09:00:00', 'Cancelled', 'Refunded'),
(4, 2, 6, '2025-07-03 08:45:00', 'Booked', 'Paid'),
(5, 2, 7, '2025-07-03 09:15:00', 'Booked', 'Pending');

-- Prices for flight_id = 1
INSERT INTO Prices (flight_id, class, price) VALUES
(1, 'Economy', 4500.00),
(1, 'Business', 9500.00);

-- Prices for flight_id = 2
INSERT INTO Prices (flight_id, class, price) VALUES
(2, 'Economy', 4000.00),
(2, 'Business', 9000.00);

-- Prices for flight_id = 3
INSERT INTO Prices (flight_id, class, price) VALUES
(3, 'Economy', 4800.00),
(3, 'Business', 10000.00);

-- Joining seats to show Pricing Info;
SELECT s.seat_number, s.class, p.price
FROM Seats s
JOIN Prices p ON s.flight_id = p.flight_id AND s.class = p.class
WHERE s.flight_id = 1 AND s.is_available = TRUE;

-- Total cost of Booking for a Customer;
SELECT c.cust_name, f.airline, s.seat_number, s.class, p.price
FROM Bookings b
JOIN Customers c ON b.customer_id = c.customer_id
JOIN Flights f ON b.flight_id = f.flight_id
JOIN Seats s ON b.seat_id = s.seat_id
JOIN Prices p ON f.flight_id = p.flight_id AND s.class = p.class
WHERE b.booking_id = 1;

-- Find available seats on a flight;
SELECT s.seat_number, s.class
FROM Seats s
JOIN Flights f ON s.flight_id = f.flight_id
WHERE s.is_available = TRUE AND f.flight_id = 1;

-- Search for flights between two cities on a specific date
SELECT * FROM Flights WHERE source= 'Delhi' AND destination= 'Mumbai' 
AND DATE(departure_time)='2025-08-01';

-- Show customer bookings history;
SELECT b.booking_id, f.airline, f.source, f.destination, f.departure_time, b.status
FROM Bookings b
JOIN Flights f ON b.flight_id = f.flight_id
WHERE b.customer_id = 1;

-- Add Trigger to mark seat unavailable after booking
DELIMITER $$

CREATE TRIGGER after_booking_insert
AFTER INSERT ON Bookings
FOR EACH ROW
BEGIN
 UPDATE Seats
 SET is_available = FALSE
 WHERE seat_id = NEW.seat_id;
END $$

-- Create Views for Available Flights and seats
CREATE VIEW available_flights_view AS 
SELECT f.flight_id,f.airline,f.source,f.destination,f.departure_time,
COUNT(s.seat_id) AS avaialable_Seats
FROM Flights f
JOIN Seats s ON f.flight_id = s.flight_id WHERE s.is_available= TRUE 
GROUP BY f.flight_id;

-- Create Views for Booking Summary
CREATE VIEW booking_summary_view AS
SELECT b.booking_id, c.cust_name AS customer_name, f.airline, f.source, f.destination,
s.seat_number, b.status, b.payment_status
FROM Bookings b
JOIN Customers c ON b.customer_id = c.customer_id
JOIN Flights f ON b.flight_id = f.flight_id
JOIN Seats s ON b.seat_id = s.seat_id;

-- Add Total Price in a Booking view;
CREATE VIEW booking_with_price AS
SELECT b.booking_id, c.cust_name AS customer_name, f.airline, f.source, f.destination,
       s.seat_number, s.class, p.price AS fare, b.status
FROM Bookings b
JOIN Customers c ON b.customer_id = c.customer_id
JOIN Flights f ON b.flight_id = f.flight_id
JOIN Seats s ON b.seat_id = s.seat_id
JOIN Prices p ON f.flight_id = p.flight_id AND s.class = p.class;

-- Functions for calculating fares,discounts or durations
CREATE FUNCTION FlightDuration(start DATETIME, end DATETIME)
RETURNS INT
DETERMINISTIC
RETURN TIMESTAMPDIFF(MINUTE, start, end);

SELECT flight_id, FlightDuration(departure_time, arrival_time) AS duration_minutes
FROM Flights;

-- Add price Column to Booking Summary Report;
SELECT f.flight_id, f.airline, COUNT(*) AS total_bookings, 
       SUM(p.price) AS total_revenue
FROM Bookings b
JOIN Flights f ON b.flight_id = f.flight_id
JOIN Seats s ON b.seat_id = s.seat_id
JOIN Prices p ON f.flight_id = p.flight_id AND s.class = p.class
WHERE b.status = 'Booked'
GROUP BY f.flight_id;


-- Top 3 most Popular Routes;
SELECT source, destination, COUNT(*) AS total_bookings
FROM Flights f
JOIN Bookings b ON f.flight_id = b.flight_ids
GROUP BY source, destination
ORDER BY total_bookings DESC
LIMIT 3;

-- Add Security;
CREATE USER 'staff_user'@'localhost' IDENTIFIED BY 'staffpass';
GRANT SELECT, INSERT, UPDATE ON AirlineDB.* TO 'staff_user'@'localhost';








 
 