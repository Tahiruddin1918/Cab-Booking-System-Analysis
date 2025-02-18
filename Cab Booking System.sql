-- Creating Database for Case Study: Cab Booking System for Data Analysis
CREATE DATABASE Cab_Booking_System;

-- To create tables and perform the queries we need to use the database
USE Cab_Booking_System;

-- Creating Customers Table
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    Phone VARCHAR(15) UNIQUE NOT NULL,
    RegistrationDate DATE NOT NULL
);

-- Creating Drivers Table
CREATE TABLE Drivers (
    DriverID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    Phone VARCHAR(15) UNIQUE NOT NULL,
    LicenseNumber VARCHAR(20) UNIQUE NOT NULL,
    VehicleType VARCHAR(20) NOT NULL,
    Rating DECIMAL(3,2) CHECK (Rating BETWEEN 0 AND 5) DEFAULT 0
);

-- Creating Cabs Table
CREATE TABLE Cabs (
    CabID INT PRIMARY KEY AUTO_INCREMENT,
    DriverID INT UNIQUE NOT NULL,
    LicensePlate VARCHAR(20) UNIQUE NOT NULL,
    VehicleType VARCHAR(20) NOT NULL,
    FOREIGN KEY (DriverID) REFERENCES Drivers(DriverID) ON DELETE CASCADE
);

-- Creating Bookings Table
CREATE TABLE Bookings (
    BookingID INT PRIMARY KEY AUTO_INCREMENT,
    CustomerID INT NOT NULL,
    CabID INT NOT NULL,
    BookingDate DATE NOT NULL,
    PickupLocation VARCHAR(255) NOT NULL,
    DropoffLocation VARCHAR(255) NOT NULL,
    Fare DECIMAL(10,2) NOT NULL,
    Status VARCHAR(20) CHECK (Status IN ('Completed', 'Cancelled', 'In Progress')) NOT NULL,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID) ON DELETE CASCADE,
    FOREIGN KEY (CabID) REFERENCES Cabs(CabID) ON DELETE CASCADE
);

-- Creating TripDetails Table
CREATE TABLE TripDetails (
    TripID INT PRIMARY KEY AUTO_INCREMENT,
    BookingID INT NOT NULL UNIQUE,
    StartTime DATETIME NOT NULL,
    EndTime DATETIME,
    Distance DECIMAL(10,2) NOT NULL CHECK (Distance >= 0),
    TripFare DECIMAL(10,2) NOT NULL CHECK (TripFare >= 0),
    FOREIGN KEY (BookingID) REFERENCES Bookings(BookingID) ON DELETE CASCADE
);

-- Creating Feedback Table
CREATE TABLE Feedback (
    FeedbackID INT PRIMARY KEY AUTO_INCREMENT,
    BookingID INT NOT NULL,
    CustomerID INT NOT NULL,
    DriverID INT NOT NULL,
    Rating DECIMAL(3,2) CHECK (Rating BETWEEN 0 AND 5) NOT NULL,
    Comments TEXT,
    FeedbackDate DATE NOT NULL,
    FOREIGN KEY (BookingID) REFERENCES Bookings(BookingID) ON DELETE CASCADE,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID) ON DELETE CASCADE,
    FOREIGN KEY (DriverID) REFERENCES Drivers(DriverID) ON DELETE CASCADE
);