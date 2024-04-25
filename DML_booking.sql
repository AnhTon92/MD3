use quanlydatphong;

-- Dữ liệu mẫu cho bảng Category
INSERT INTO Category (Name, Status)
VALUES ('Standard', 1),
       ('Superior', 1),
       ('Deluxe', 1),
       ('Suite', 1),
       ('Family', 1);

-- Dữ liệu mẫu cho bảng Room
INSERT INTO Room (Name, Status, Price, SalePrice, CreatedDate, CategoryId)
VALUES ('Room 101', 1, 200000, 180000, CURDATE(), 1),
       ('Room 102', 1, 200000, 180000, CURDATE(), 1),
       ('Room 103', 1, 200000, 180000, CURDATE(), 1),
       ('Room 201', 1, 300000, 270000, CURDATE(), 2),
       ('Room 202', 1, 300000, 270000, CURDATE(), 2),
       ('Room 203', 1, 300000, 270000, CURDATE(), 2),
       ('Room 301', 1, 400000, 360000, CURDATE(), 3),
       ('Room 302', 1, 400000, 360000, CURDATE(), 3),
       ('Room 303', 1, 400000, 360000, CURDATE(), 3),
       ('Room 401', 1, 500000, 450000, CURDATE(), 4),
       ('Room 402', 1, 500000, 450000, CURDATE(), 4),
       ('Room 403', 1, 500000, 450000, CURDATE(), 4),
       ('Room 501', 1, 600000, 540000, CURDATE(), 5),
       ('Room 502', 1, 600000, 540000, CURDATE(), 5),
       ('Room 503', 1, 600000, 540000, CURDATE(), 5);

-- Dữ liệu mẫu cho bảng Customer
INSERT INTO Customer (Name, Email, Phone, Address, CreatedDate, Gender, BirthDay)
VALUES ('Nguyen Van A', 'nguyenvana@example.com', '0123456789', '123 Đường ABC, TP.HCM', CURDATE(), 1, '1990-01-01'),
       ('Tran Thi B', 'tranthib@example.com', '0987654321', '456 Đường XYZ, Hà Nội', CURDATE(), 0, '1992-02-02'),
       ('Le Van C', 'levanc@example.com', '0112233445', '789 Đường QWE, Đà Nẵng', CURDATE(), 1, '1994-03-03');

-- Dữ liệu mẫu cho bảng Booking
INSERT INTO Booking (CustomerId, Status, BookingDate)
VALUES (1, 1, NOW()),
       (2, 1, NOW()),
       (3, 1, NOW());

-- Dữ liệu mẫu cho bảng BookingDetail
INSERT INTO BookingDetail (BookingId, RoomId, Price, StartDate, EndDate)
VALUES (1, 1, 200000, NOW(), DATE_ADD(NOW(), INTERVAL 2 DAY)),
       (1, 2, 200000, NOW(), DATE_ADD(NOW(), INTERVAL 2 DAY)),
       (2, 3, 300000, NOW(), DATE_ADD(NOW(), INTERVAL 3 DAY)),
       (2, 4, 300000, NOW(), DATE_ADD(NOW(), INTERVAL 3 DAY)),
       (3, 5, 400000, NOW(), DATE_ADD(NOW(), INTERVAL 1 DAY)),
       (3, 6, 400000, NOW(), DATE_ADD(NOW(), INTERVAL 1 DAY));

-- Lấy ra danh sách phòng (Room) sắp xếp giảm dần theo Price:
SELECT R.Id, R.Name, R.Price, R.SalePrice, R.Status, C.Name AS CategoryName, R.CreatedDate
FROM Room R
         JOIN Category C ON R.CategoryId = C.Id
ORDER BY R.Price DESC;
-- Lấy ra danh sách Category:
SELECT C.Id, C.Name, COUNT(R.Id) AS TotalRoom, C.Status
FROM Category C
         LEFT JOIN Room R ON C.Id = R.CategoryId
GROUP BY C.Id, C.Name, C.Status;
-- Truy vấn danh sách Customer:
SELECT Id, Name, Email, Phone, Address, CreatedDate, Gender,
       BirthDay, TIMESTAMPDIFF(YEAR, BirthDay, CURDATE()) AS Age
FROM Customer;
-- Truy vấn xóa các sản phẩm chưa được bán (BookingDetail):
DELETE FROM BookingDetail
WHERE BookingId NOT IN (SELECT BookingId FROM Booking);
-- Cập nhật Cột SalePrice tăng thêm 10% cho tất cả các phòng có Price >= 250000
UPDATE Room
SET SalePrice = Price * 1.1
WHERE Price >= 250000;
-- tạo View v_getRoomInfo - Lấy ra danh sách 10 phòng có giá cao nhất:
CREATE VIEW v_getRoomInfo AS
SELECT R.Id, R.Name, R.Price, R.SalePrice, R.Status, C.Name AS CategoryName, R.CreatedDate
FROM Room R
         JOIN Category C ON R.CategoryId = C.Id
ORDER BY R.Price DESC
LIMIT 10;


-- View v_getBookingList - Hiển thị danh sách phiếu đặt hàng:
CREATE VIEW v_getBookingList AS
SELECT B.Id, B.BookingDate, B.Status,
       C.Name AS CusName, C.Email, C.Phone,
       SUM(BD.Price) AS TotalAmount
FROM Booking B
         JOIN Customer C ON B.CustomerId = C.Id
         LEFT JOIN BookingDetail BD ON B.Id = BD.BookingId
GROUP BY B.Id, B.BookingDate, B.Status, C.Name, C.Email, C.Phone;


-- Thủ tục addRoomInfo để thêm mới Room:
DELIMITER //
CREATE PROCEDURE addRoomInfo(
    IN p_Name VARCHAR(150),
    IN p_Status TINYINT,
    IN p_Price FLOAT,
    IN p_SalePrice FLOAT,
    IN p_CreatedDate DATE,
    IN p_CategoryId INT
)
BEGIN
    INSERT INTO Room (Name, Status, Price, SalePrice, CreatedDate, CategoryId)
    VALUES (p_Name, p_Status, p_Price, p_SalePrice, p_CreatedDate, p_CategoryId);
END //
DELIMITER ;



-- Thủ tục getBookingByCustomerId để hiển thị danh sách phiếu đặt phòng của khách hàng:
DELIMITER //
CREATE PROCEDURE getBookingByCustomerId(
    IN p_CustomerId INT
)
BEGIN
    SELECT B.Id, B.BookingDate, B.Status,
           (CASE
                WHEN B.Status = 0 THEN 'Chưa duyệt'
                WHEN B.Status = 1 THEN 'Đã duyệt'
                WHEN B.Status = 2 THEN 'Đã thanh toán'
                WHEN B.Status = 3 THEN 'Đã hủy'
               END) AS StatusText,
           SUM(BD.Price) AS TotalAmount
    FROM Booking B
             LEFT JOIN BookingDetail BD ON B.Id = BD.BookingId
    WHERE B.CustomerId = p_CustomerId
    GROUP BY B.Id, B.BookingDate, B.Status;
END //
DELIMITER ;
call getBookingByCustomerId(1);

-- Thủ tục getRoomPaginate để lấy ra danh sách phòng có phân trang:
DELIMITER //
CREATE PROCEDURE getRoomPaginate(
    IN p_Limit INT,
    IN p_Page INT
)
BEGIN
    DECLARE off_set INT;
    SET off_set = (p_Page - 1) * p_Limit;
    SELECT Id, Name, Price, SalePrice
    FROM Room
    ORDER BY Id
    LIMIT off_set, p_Limit;
END //
DELIMITER ;
call getRoomPaginate(1,2);



-- Trigger tr_Check_Price_Value - Điều chỉnh giá phòng nếu lớn hơn 5 triệu và thông báo:
DELIMITER //
CREATE TRIGGER tr_Check_Price_Value
    BEFORE INSERT ON Room
    FOR EACH ROW
BEGIN
    IF NEW.Price > 5000000 THEN
        SET NEW.Price = 5000000;
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Giá phòng lớn nhất 5 triệu';
    END IF;
END;
//
DELIMITER ;


-- Trigger tr_check_Room_NotAllow - Kiểm tra xem phòng đã được đặt trong khoảng thời gian đó chưa:
DELIMITER //
CREATE TRIGGER tr_check_Room_NotAllow
    BEFORE INSERT ON BookingDetail
    FOR EACH ROW
BEGIN
    DECLARE room_booked INT;
    SELECT COUNT(*)
    INTO room_booked
    FROM BookingDetail
    WHERE RoomId = NEW.RoomId
      AND NOT (NEW.StartDate >= EndDate OR NEW.EndDate <= StartDate);

    IF room_booked > 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Phòng này đã có người đặt trong thời gian này, vui lòng chọn thời gian khác';
    END IF;
END;
//
DELIMITER ;

