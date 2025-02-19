-- This query selects all columns from the Bookings table where the Status column has the value 'In Progress'.
SELECT * 
FROM Bookings 
WHERE Status = 'In Progress';

-- This query selects all columns from the Cabs table where the VehicleType is 'SUV' and the DriverID is 5.
SELECT * 
FROM Cabs 
WHERE VehicleType = 'SUV' 
AND DriverID = 5;

-- The SQL query to select all customers whose LastName contains 'Smith'
SELECT * 
FROM Customers 
WHERE LastName LIKE '%Smith%';

-- The SQL query to select the Fare from the Bookings table along with a new column FareStatus
SELECT Fare, 
       CASE 
           WHEN Fare > 50 THEN 'High' 
           ELSE 'Low' 
       END AS FareStatus
FROM Bookings;

-- All drivers who have received a rating higher than the average rating of all drivers
SELECT * FROM Drivers 
WHERE Rating > (SELECT AVG(Rating) FROM Drivers);

-- The total fare collected by each driver
SELECT d.DriverID, d.FirstName, d.LastName, SUM(b.Fare) AS TotalFare
FROM Drivers d
JOIN Cabs c ON d.DriverID = c.DriverID
JOIN Bookings b ON c.CabID = b.CabID
WHERE b.Status = 'Completed'
GROUP BY d.DriverID, d.FirstName, d.LastName
ORDER BY TotalFare DESC;

-- The total number of completed bookings for each customer (only those with more than 3 completed bookings)
SELECT b.CustomerID, c.FirstName, c.LastName, COUNT(*) AS TotalCompletedBookings
FROM Bookings b
JOIN Customers c ON b.CustomerID = c.CustomerID
WHERE b.Status = 'Completed'
GROUP BY b.CustomerID, c.FirstName, c.LastName
HAVING COUNT(*) > 3
ORDER BY TotalCompletedBookings DESC;

-- The Top 5 Drivers with the Highest Average Ratings
SELECT DriverID, FirstName, LastName, Rating
FROM Drivers
ORDER BY Rating DESC
LIMIT 5;

-- Get a List of All Bookings with PickupLocation, DropoffLocation, and LicensePlate
SELECT b.BookingID, b.PickupLocation, b.DropoffLocation, c.LicensePlate
FROM Bookings b
JOIN Cabs c ON b.CabID = c.CabID;

-- List of All Drivers and Any Associated Bookings include drivers with No bookings
SELECT d.DriverID, d.FirstName, d.LastName, b.BookingID, b.PickupLocation, b.DropoffLocation, b.Status
FROM Drivers d
LEFT JOIN Cabs c ON d.DriverID = c.DriverID
LEFT JOIN Bookings b ON c.CabID = b.CabID
ORDER BY d.DriverID, b.BookingID;

-- The total distance covered by each cab
SELECT c.CabID, c.LicensePlate, SUM(td.Distance) AS TotalDistanceCovered
FROM Cabs c
INNER JOIN Bookings b ON c.CabID = b.CabID
INNER JOIN TripDetails td ON b.BookingID = td.BookingID
GROUP BY c.CabID, c.LicensePlate
ORDER BY TotalDistanceCovered DESC;

-- Bookings where the fare is higher than the average fare for all completed bookings
SELECT * FROM Bookings 
WHERE Fare > (SELECT AVG(Fare) FROM Bookings WHERE Status = 'Completed');

-- Customer and driver names along with pickup and dropoff locations for all bookings
SELECT c.FirstName AS CustomerFirstName, c.LastName AS CustomerLastName, 
       d.FirstName AS DriverFirstName, d.LastName AS DriverLastName, 
       b.PickupLocation, b.DropoffLocation
FROM Bookings b
INNER JOIN Customers c ON b.CustomerID = c.CustomerID
INNER JOIN Cabs cb ON b.CabID = cb.CabID
LEFT JOIN Drivers d ON cb.DriverID = d.DriverID;
