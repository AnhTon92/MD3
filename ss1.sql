CREATE TABLE `Order` (
    oID INT AUTO_INCREMENT PRIMARY KEY,
    cID INT,
    oDate DATE,
    FOREIGN KEY (cID) REFERENCES Customer(cID)
);
CREATE TABLE Product (
    pID INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255),
    price DECIMAL(10, 2)
);
CREATE TABLE OrderDetail (
    oID INT,
    pID INT,
    quantity INT,
    FOREIGN KEY (oID) REFERENCES `Order`(oID),
    FOREIGN KEY (pID) REFERENCES Product(pID),
    PRIMARY KEY (oID, pID)
);