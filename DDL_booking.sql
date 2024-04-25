CREATE DATABASE if not exists quanlydatphong;
use quanlydatphong;
CREATE TABLE if not exists Category
(
    Id     INT AUTO_INCREMENT PRIMARY KEY,
    Name   VARCHAR(100) NOT NULL UNIQUE,
    Status TINYINT DEFAULT 1
);
CREATE TRIGGER trg_Category_Status
    BEFORE INSERT
    ON Category
    FOR EACH ROW
BEGIN
    IF NEW.Status NOT IN (0, 1) THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Invalid Status value for Category';
    END IF;
END;
CREATE TABLE Room
(
    Id          INT AUTO_INCREMENT PRIMARY KEY,
    Name        VARCHAR(150) NOT NULL,
    Status      TINYINT DEFAULT 1,
    Price       FLOAT        NOT NULL,
    SalePrice   FLOAT   DEFAULT 0,
    CreatedDate DATE    DEFAULT (curdate()),
    CategoryId  INT          NOT NULL,
    FOREIGN KEY (CategoryId) REFERENCES Category (Id)
);

CREATE TRIGGER trg_Room_Price
    BEFORE INSERT
    ON Room
    FOR EACH ROW
BEGIN
    IF NEW.Price < 100000 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Price must be greater than or equal to 100000';
    END IF;
END;

CREATE TRIGGER trg_Room_SalePrice
    BEFORE INSERT
    ON Room
    FOR EACH ROW
BEGIN
    IF NEW.SalePrice > NEW.Price THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'SalePrice cannot be greater than Price';
    END IF;
END;
CREATE TABLE Customer
(
    Id          INT AUTO_INCREMENT PRIMARY KEY,
    Name        VARCHAR(150) NOT NULL,
    Email       VARCHAR(150) NOT NULL UNIQUE,
    Phone       VARCHAR(50)  NOT NULL UNIQUE,
    Address     VARCHAR(255),
    CreatedDate DATE DEFAULT (curdate()),
    Gender      TINYINT      NOT NULL,
    BirthDay    DATE         NOT NULL
);

CREATE TRIGGER trg_Customer_Gender
    BEFORE INSERT
    ON Customer
    FOR EACH ROW
BEGIN
    IF NEW.Gender NOT IN (0, 1, 2) THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Invalid Gender value for Customer';
    END IF;
END;

CREATE TABLE Booking
(
    Id          INT AUTO_INCREMENT PRIMARY KEY,
    CustomerId  INT NOT NULL,
    Status      TINYINT  DEFAULT 1,
    BookingDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (CustomerId) REFERENCES Customer (Id)
);

CREATE TRIGGER trg_Booking_Status
    BEFORE INSERT
    ON Booking
    FOR EACH ROW
BEGIN
    IF NEW.Status NOT IN (0, 1, 2, 3) THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Invalid Status value for Booking';
    END IF;
END;
CREATE TABLE BookingDetail
(
    BookingId INT      NOT NULL,
    RoomId    INT      NOT NULL,
    Price     FLOAT    NOT NULL,
    StartDate DATETIME NOT NULL,
    EndDate   DATETIME NOT NULL,
    PRIMARY KEY (BookingId, RoomId),
    FOREIGN KEY (BookingId) REFERENCES Booking (Id),
    FOREIGN KEY (RoomId) REFERENCES Room (Id)
);

CREATE TRIGGER trg_BookingDetail_EndDate
    BEFORE INSERT
    ON BookingDetail
    FOR EACH ROW
BEGIN
    IF NEW.EndDate <= NEW.StartDate THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'EndDate must be greater than StartDate';
    END IF;
END;
