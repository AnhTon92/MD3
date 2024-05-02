create database if not exists quanlybanhang;
use quanlybanhang;

CREATE TABLE if not exists CUSTOMERS
(
    customer_id VARCHAR(100) PRIMARY KEY,
    name        VARCHAR(100),
    email       VARCHAR(100) NOT NULL UNIQUE,
    phone       VARCHAR(100) NOT NULL UNIQUE,
    address     TEXT
);

CREATE TABLE if not exists ORDERS
(
    order_id     VARCHAR(4) PRIMARY KEY,
    customer_id  VARCHAR(100),
    total_amount DOUBLE,
    order_date   DATE,
    FOREIGN KEY (customer_id) REFERENCES CUSTOMERS (customer_id)
);

CREATE TABLE if not exists PRODUCTS
(
    product_id  VARCHAR(4) PRIMARY KEY,
    name        VARCHAR(255),
    description TEXT,
    price       DOUBLE,
    status      BIT default 1
);

CREATE TABLE if not exists ORDERS_DETAILS
(
    order_id   VARCHAR(4),
    product_id VARCHAR(4),
    PRIMARY KEY (order_id, product_id),
    quantity   INT(11),
    price      DOUBLE,
    FOREIGN KEY (order_id) REFERENCES ORDERS (order_id),
    FOREIGN KEY (product_id) REFERENCES PRODUCTS (product_id)
);

INSERT INTO CUSTOMERS (customer_id, name, email, phone, address)
VALUES ('C001', 'Nguyễn Trung Mạnh', 'manhnt@gmail.com', '984756322', 'Cầu Giấy, Hà Nội'),
       ('C002', 'Hồ Hải Nam', 'namhh@gmail.com', '984758926', 'Ba Đình, Hà Nội'),
       ('C003', 'Tô Ngọc Vũ', 'vutn@gmail.com', '904727584', 'Mỹ Châu, Sơn La'),
       ('C004', 'Phạm Ngọc Anh', 'anhpn@gmail.com', '984635365', 'Vinh, Nghệ An'),
       ('C005', 'Trương Minh Cường', 'cuongtm@gmail.com', '989735624', 'Hai Bà Trưng, Hà Nội');

INSERT INTO PRODUCTS (product_id, name, description, price, status)
VALUES ('P001', 'iphone 13 ProMax', 'Bản 512 GB, xanh lá', 22999999, 1),
       ('P002', 'Dell Vostro V3510', 'Core i5, RAM8GB', 14999999, 1),
       ('P003', 'Macbook Pro M2', 'CPU I9CPU |8GB|256GB|', 18999999, 1),
       ('P004', 'Apple Watch Ultra', 'Titanium Alpine Loop Small', 18999999, 1),
       ('P005', 'Apple Airpods 2', 'Spatial Audio', 409900, 1);

INSERT INTO ORDERS (order_id, customer_id, total_amount, order_date)
VALUES ('H001', 'C001', 52999997, '2023-02-22'),
       ('H002', 'C001', 80999987, '2023-03-11'),
       ('H003', 'C002', 54399958, '2023-01-23'),
       ('H004', 'C003', 102999957, '2023-02-14'),
       ('H005', 'C003', 80999997, '2022-03-13'),
       ('H006', 'C004', 110499994, '2023-02-01'),
       ('H007', 'C004', 17999996, '2023-03-29'),
       ('H008', 'C004', 29999998, '2023-02-14'),
       ('H009', 'C005', 28999999, '2023-01-10'),
       ('H010', 'C005', 14999994, '2023-04-11');

INSERT INTO ORDERS_DETAILS (order_id, product_id, price, quantity)
VALUES ('H001', 'P002', 14999999, 1),
       ('H001', 'P004', 18999999, 2),
       ('H002', 'P001', 22999999, 1),
       ('H002', 'P003', 28999999, 2),
       ('H003', 'P004', 18999999, 2),
       ('H003', 'P005', 40900000, 4),
       ('H004', 'P002', 14999999, 3),
       ('H005', 'P001', 22999999, 1),
       ('H005', 'P003', 28999999, 2),
       ('H006', 'P005', 40900000, 5),
       ('H006', 'P002', 14999999, 6),
       ('H007', 'P004', 18999999, 3),
       ('H007', 'P001', 22999999, 1),
       ('H008', 'P002', 14999999, 2),
       ('H009', 'P003', 28999999, 9),
       ('H010', 'P003', 28999999, 4),
       ('H010', 'P001', 22999999, 4);

# Truy vấn dữ liệu [30 điểm]:
# 1. Lấy ra tất cả thông tin gồm: tên, email, số điện thoại và địa chỉ trong bảng Customers .
# [4 điểm]
SELECT name, email, phone, address
FROM Customers;


# 2. Thống kê những khách hàng mua hàng trong tháng 3/2023 (thông tin bao gồm tên, số điện
# thoại và địa chỉ khách hàng). [4 điểm]
SELECT c.name, c.phone, c.address
FROM Customers c
         INNER JOIN Orders o ON c.customer_id = o.customer_id
WHERE MONTH(o.order_date) = 3 AND YEAR(o.order_date) = 2023;

# 3. Thống kê doanh thua theo từng tháng của cửa hàng trong năm 2023 (thông tin bao gồm
# tháng và tổng doanh thu ). [4 điểm]
SELECT MONTH(order_date) AS month, SUM(total_amount) AS total_revenue
FROM Orders
WHERE YEAR(order_date) = 2023
GROUP BY MONTH(order_date);


# 4. Thống kê những người dùng không mua hàng trong tháng 2/2023 (thông tin gồm tên khách
# hàng, địa chỉ , email và số điên thoại). [4 điểm]
SELECT c.name, c.phone, c.address, c.email
FROM Customers c
WHERE c.customer_id NOT IN (
    SELECT DISTINCT customer_id
    FROM Orders
    WHERE MONTH(order_date) = 2 AND YEAR(order_date) = 2023
);


# 5. Thống kê số lượng từng sản phẩm được bán ra trong tháng 3/2023 (thông tin bao gồm mã
# sản phẩm, tên sản phẩm và số lượng bán ra). [4 điểm]
SELECT p.product_id, name, SUM(od.quantity) AS total_sold
FROM Products p
         INNER JOIN ORDERS_DETAILS od ON p.product_id = od.product_id
         INNER JOIN Orders o ON od.order_id = o.order_id
WHERE MONTH(o.order_date) = 3 AND YEAR(o.order_date) = 2023
GROUP BY p.product_id, p.name;

# 6. Thống kê tổng chi tiêu của từng khách hàng trong năm 2023 sắp xếp giảm dần theo mức chi
# tiêu (thông tin bao gồm mã khách hàng, tên khách hàng và mức chi tiêu). [5 điểm]
SELECT c.customer_id, c.name, SUM(o.total_amount) AS total_spending
FROM Customers c
         INNER JOIN Orders o ON c.customer_id = o.customer_id
WHERE YEAR(o.order_date) = 2023
GROUP BY c.customer_id, c.name
ORDER BY total_spending DESC;


# 7. Thống kê những đơn hàng mà tổng số lượng sản phẩm mua từ 5 trở lên (thông tin bao gồm
# tên người mua, tổng tiền , ngày tạo hoá đơn, tổng số lượng sản phẩm) . [5 điểm]
SELECT o.order_id, c.name AS customer_name, o.total_amount, o.order_date, SUM(od.quantity) AS total_quantity
FROM ORDERS_DETAILS od
         JOIN ORDERS o ON od.order_id = o.order_id
         JOIN CUSTOMERS c ON o.customer_id = c.customer_id
GROUP BY o.order_id, c.name, o.total_amount, o.order_date
HAVING SUM(od.quantity) >= 5;

# Tạo View, Procedure [30 điểm]:
# 1. Tạo VIEW lấy các thông tin hoá đơn bao gồm : Tên khách hàng, số điện thoại, địa chỉ, tổng
# tiền và ngày tạo hoá đơn . [3 điểm]
CREATE VIEW BillInfo AS
SELECT c.name, c.phone, c.address, o.total_amount, o.order_date
FROM ORDERS o
         JOIN CUSTOMERS c ON o.customer_id = c.customer_id;

# 2. Tạo VIEW hiển thị thông tin khách hàng gồm : tên khách hàng, địa chỉ, số điện thoại và tổng
# số đơn đã đặt. [3 điểm]
CREATE VIEW CustomerInfo AS
SELECT c.name, c.address, c.phone, COUNT(o.order_id) AS total_orders
FROM CUSTOMERS c
         LEFT JOIN ORDERS o ON c.customer_id = o.customer_id
GROUP BY c.customer_id;

# 3. Tạo VIEW hiển thị thông tin sản phẩm gồm: tên sản phẩm, mô tả, giá và tổng số lượng đã
# bán ra của mỗi sản phẩm.
CREATE VIEW ProductInfo AS
SELECT p.name, p.description, p.price, SUM(od.quantity) AS total_sold
FROM PRODUCTS p
         LEFT JOIN ORDERS_DETAILS od ON p.product_id = od.product_id
GROUP BY p.product_id;

# 4. Đánh Index cho trường `phone` và `email` của bảng Customer. [3 điểm]
CREATE INDEX idx_phone ON CUSTOMERS(phone);
CREATE INDEX idx_email ON CUSTOMERS(email);

# 5. Tạo PROCEDURE lấy tất cả thông tin của 1 khách hàng dựa trên mã số khách hàng.[3 điểm]
delimiter //
CREATE PROCEDURE GetCustomerInfo(IN customerID VARCHAR(100))
BEGIN
    SELECT * FROM CUSTOMERS WHERE customer_id = customerID;
END;
delimiter //
call GetCustomerInfo('C001');
# 6. Tạo PROCEDURE lấy thông tin của tất cả sản phẩm. [3 điểm]
delimiter //
CREATE PROCEDURE GetAllProducts()
BEGIN
    SELECT * FROM PRODUCTS;
END;
delimiter //
call GetAllProducts();
# 7. Tạo PROCEDURE hiển thị danh sách hoá đơn dựa trên mã người dùng. [3 điểm]
delimiter //
CREATE PROCEDURE GetCustomerOrders(IN customerID VARCHAR(100))
BEGIN
    SELECT * FROM ORDERS WHERE customer_id = customerID;
END;
delimiter //
call GetCustomerOrders('C002');
# 8. Tạo PROCEDURE tạo mới một đơn hàng với các tham số là mã khách hàng, tổng
# tiền và ngày tạo hoá đơn, và hiển thị ra mã hoá đơn vừa tạo. [3 điểm]
DELIMITER //
CREATE PROCEDURE CreateOrder(IN customerID VARCHAR(100), IN totalAmount DOUBLE, IN orderDate DATE)
BEGIN
    DECLARE newOrderID INT;
    DECLARE orderPrefix CHAR(1) DEFAULT 'H';
    DECLARE lastOrderNum INT;
    DECLARE newOrderCode VARCHAR(4);

    -- Lấy số thứ tự lớn nhất từ order_id hiện tại
    SELECT IFNULL(MAX(CAST(SUBSTRING(order_id, 2) AS UNSIGNED)), 0) INTO lastOrderNum
    FROM ORDERS
    WHERE order_id LIKE CONCAT(orderPrefix, '%');

    -- Tăng số thứ tự lên 1
    SET lastOrderNum = lastOrderNum + 1;

    -- Tạo mã đơn hàng mới
    SET newOrderCode = CONCAT(orderPrefix, LPAD(lastOrderNum, 3, '0'));

    -- Thêm đơn hàng mới vào bảng ORDERS
    INSERT INTO ORDERS (order_id, customer_id, total_amount, order_date)
    VALUES (newOrderCode, customerID, totalAmount, orderDate);

    -- Trả về mã đơn hàng mới
    SELECT newOrderCode AS NewOrderID;
END;
DELIMITER //
CALL CreateOrder('C001', 1000000, '2024-05-02');
# 9. Tạo PROCEDURE thống kê số lượng bán ra của mỗi sản phẩm trong khoảng
# thời gian cụ thể với 2 tham số là ngày bắt đầu và ngày kết thúc. [3 điểm]
delimiter //
CREATE PROCEDURE GetProductSales(IN startDate DATE, IN endDate DATE)
BEGIN
    SELECT p.product_id, p.name, SUM(od.quantity) AS total_sold
    FROM PRODUCTS p
             JOIN ORDERS_DETAILS od ON p.product_id = od.product_id
             JOIN ORDERS o ON od.order_id = o.order_id
    WHERE o.order_date BETWEEN startDate AND endDate
    GROUP BY p.product_id;
END;
delimiter //
call GetProductSales('2023-02-22', '2023-07-07');
# 10. Tạo PROCEDURE thống kê số lượng của mỗi sản phẩm được bán ra theo thứ tự
# giảm dần của tháng đó với tham số vào là tháng và năm cần thống kê. [3 điểm]
delimiter //
CREATE PROCEDURE GetMonthlyProductSales(IN salesMonth INT, IN salesYear INT)
BEGIN
    SELECT p.product_id, p.name, SUM(od.quantity) AS total_sold
    FROM PRODUCTS p
             JOIN ORDERS_DETAILS od ON p.product_id = od.product_id
             JOIN ORDERS o ON od.order_id = o.order_id
    WHERE MONTH(o.order_date) = salesMonth AND YEAR(o.order_date) = salesYear
    GROUP BY p.product_id
    ORDER BY total_sold DESC;
END;
delimiter //
call GetMonthlyProductSales('03','2023');