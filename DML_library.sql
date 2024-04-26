use thuvienonline;
-- Thêm dữ liệu mẫu cho bảng Category
INSERT INTO Category (Name)
VALUES ('Khoa học máy tính'),
       ('Lịch sử'),
       ('Nghệ thuật'),
       ('Thể thao'),
       ('Du lịch');

-- Thêm dữ liệu mẫu cho bảng Author
INSERT INTO Author (Name)
VALUES ('Neil Gaiman'),
       ('Agatha Christie'),
       ('J.R.R. Tolkien'),
       ('Isaac Asimov'),
       ('Arthur Conan Doyle');

-- Thêm dữ liệu mẫu cho bảng Book
-- Lưu ý: Giá trị cho CategoryId và AuthorId cần phải được thay đổi cho phù hợp với ID thực tế trong cơ sở dữ liệu của bạn
INSERT INTO Book (Name, Price, CategoryId, AuthorId)
VALUES ('Norse Mythology', 150000, 1, 1),
       ('Murder on the Orient Express', 180000, 2, 2),
       ('The Hobbit', 200000, 3, 3),
       ('Foundation', 170000, 4, 4),
       ('Sherlock Holmes', 160000, 5, 5),
       ('American Gods', 150000, 1, 1),
       ('The ABC Murders', 180000, 2, 2),
       ('The Lord of the Rings', 250000, 3, 3),
       ('I, Robot', 170000, 4, 4),
       ('The Adventures of Sherlock Holmes', 160000, 5, 5),
       ('Good Omens', 150000, 1, 1),
       ('And Then There Were None', 180000, 2, 2),
       ('The Silmarillion', 200000, 3, 3),
       ('The Caves of Steel', 170000, 4, 4),
       ('The Hound of the Baskervilles', 160000, 5, 5);

-- Thêm dữ liệu mẫu cho bảng Customer
INSERT INTO Customer (Name, Email, Phone, Gender, Birthday, CreatedDate)
VALUES ('Lê Thị C', 'lethic@gmail.com', '01234567819', '2', '1990-02-03', curdate()),
       ('Phạm Văn D', 'phamvand@gmail.com', '01234567828', '2', '1991-02-02', curdate()),
       ('Nguyễn Thị E', 'nguyenthiE@gmail.com', '0123456787', '1', '1992-06-07', curdate());

-- Thêm dữ liệu mẫu cho bảng Ticket
-- Lưu ý: Giá trị cho CustomerId cần phải được thay đổi cho phù hợp với ID thực tế trong cơ sở dữ liệu của bạn
INSERT INTO Ticket (CustomerId)
VALUES (1),
       (2),
       (3);

-- Thêm dữ liệu mẫu cho bảng TicketDetail
-- Lưu ý: Giá trị cho TicketId và BookId cần phải được thay đổi cho phù hợp với ID thực tế trong cơ sở dữ liệu của bạn
-- Giả sử DeposiPrice là giá của sách và RentCost là 10% giá của sách
INSERT INTO TicketDetail (TicketId, BookId, Quantity, DeposiPrice, RentCost)
VALUES (1, 1, 2, 300000, 30000),
       (1, 2, 1, 180000, 18000),
       (2, 3, 2, 400000, 40000),
       (2, 4, 1, 170000, 17000),
       (3, 5, 2, 320000, 32000),
       (3, 6, 1, 150000, 15000);
-- 1.	Lấy ra danh sách Book có sắp xếp giảm dần theo Price gồm các cột sau: Id, Name, Price, Status, CategoryName, AuthorName, CreatedDate
SELECT Book.Id,
       Book.Name,
       Book.Price,
       Book.Status,
       Category.Name AS CategoryName,
       Author.Name   AS AuthorName,
       Book.CreatedDate
FROM Book
         JOIN Category ON Book.CategoryId = Category.Id
         JOIN Author ON Book.AuthorId = Author.Id
ORDER BY Book.Price DESC;

-- 2.	Lấy ra danh sách Category gồm: Id, Name, TotalProduct, Status (Trong đó cột Status nếu = 0, Ẩn, = 1 là Hiển thị )
SELECT Category.Id,
       Category.Name,
       (SELECT COUNT(*) FROM Book WHERE Book.CategoryId = Category.Id) AS TotalProduct,
       CASE WHEN Category.Status = 0 THEN 'Ẩn' ELSE 'Hiển thị' END     AS Status
FROM Category;

-- 3.	Truy vấn danh sách Customer gồm: Id, Name, Email, Phone, Address, CreatedDate, Gender, BirthDay, Age (Age là cột suy ra từ BirthDay, Gender nếu = 0 là Nam, 1 là Nữ,2 là khác )
SELECT Customer.Id,
       Customer.Name,
       Customer.Email,
       Customer.Phone,
       Customer.Address,
       Customer.CreatedDate,
       CASE
           WHEN Customer.Gender = 0 THEN 'Nam'
           WHEN Customer.Gender = 1 THEN 'Nữ'
           ELSE 'Khác' END                               AS Gender,
       Customer.BirthDay,
       TIMESTAMPDIFF(YEAR, Customer.BirthDay, CURDATE()) AS Age
FROM Customer;

-- 4.	Truy vấn xóa Author chưa có sách nào
DELETE
FROM Author
WHERE Id NOT IN (SELECT AuthorId FROM Book);

-- 5.	Cập nhật Cột ToalBook trong bảng Auhor = Tổng số Book của mỗi Author theo Id của Author
UPDATE Author
SET TotalBook = (SELECT COUNT(*) FROM Book WHERE Book.AuthorId = Author.Id);

-- Tạo View v_getBookInfo để lấy ra danh sách các Book được mượn nhiều hơn 3 cuốn:
create view v_getBookInfo as
select book.Id,
       book.Name,
       sum(ticketdetail.Quantity) as TotalQuantity
from book
         join ticketdetail on book.Id = ticketdetail.BookId
group by book.Id, book.Name
having TotalQuantity > 3;

-- Tạo View v_getTicketList để hiển thị danh sách Ticket với thông tin yêu cầu:
create view v_getTicketList as
select ticket.Id,
       ticket.TicketDate,
       case
           when ticket.Status = 0 then 'Chưa trả'
           when ticket.Status = 1 then 'Đã trả'
           when ticket.Status = 2 then 'Quá hạn'
           when ticket.Status = 3 then 'Đã hủy'
           end as Status,
       customer.Name cusName,
       customer.Email,
       customer.Phone,
       sum(ticketdetail.Quantity * ticketdetail.DeposiPrice) as TotalAmount
from ticket
         join customer on ticket.CustomerId = customer.Id
         join ticketdetail on ticket.Id = ticketdetail.TicketId
group by ticket.Id, ticket.TicketDate, ticket.Status, customer.Name, customer.Email, customer.Phone;

-- Thủ tục addBookInfo để thêm mới Book:
delimiter //
CREATE PROCEDURE addBookInfo(IN p_Name VARCHAR(150), IN p_Status TINYINT, IN p_Price FLOAT, IN p_CreatedDate DATE, IN p_CategoryId INT, IN p_AuthorId INT)
begin
    insert into book (Name, Status, Price, CreatedDate, CategoryId, AuthorId) VALUES (p_Name, p_Status, p_Price, p_CreatedDate, p_CategoryId, p_AuthorId);

end //
delimiter ;


--  Thủ tục getTicketByCustomerId để hiển thị danh sách đơn hàng của khách hàng theo Id:
DELIMITER //
CREATE PROCEDURE getTicketByCustomerId(IN p_CustomerId INT)
BEGIN
    SELECT Ticket.Id, Ticket.TicketDate,
           CASE
               WHEN Ticket.Status = 0 THEN 'Chưa trả'
               WHEN Ticket.Status = 1 THEN 'Đã trả'
               WHEN Ticket.Status = 2 THEN 'Quá hạn'
               WHEN Ticket.Status = 3 THEN 'Đã hủy'
               END AS Status,
           (SELECT SUM(TicketDetail.Quantity * TicketDetail.DeposiPrice)
            FROM TicketDetail
            WHERE TicketDetail.TicketId = Ticket.Id) AS TotalAmount
    FROM Ticket
    WHERE Ticket.CustomerId = p_CustomerId;
END //
DELIMITER ;
call getTicketByCustomerId(3);

-- 2.	Thủ tục getBookPaginate lấy ra danh sách sản phẩm có phân trang gồm: Id, Name, Price, Sale_price, Khi gọi thủ tuc truyền vào limit và page
DELIMITER //
CREATE PROCEDURE getBookPaginate(IN p_Limit INT, IN p_Page INT)
BEGIN
    DECLARE off_set INT;
    SET off_set = (p_Page - 1) * p_Limit;

    SELECT Id, Name, Price, Price AS Sale_price
    FROM Book
    ORDER BY Id
    LIMIT off_set, p_Limit;
END //
DELIMITER ;

-- 1.	Tạo trigger tr_Check_total_book_author sao cho khi thêm Book nếu Author đang tham chiếu có tổng số sách > 5 thì không cho thêm mưới và thông báo “Tác giả này có số lượng sách đạt tới giới hạn 5 cuốn, vui long chọn tác giả khác”
DELIMITER //
CREATE TRIGGER tr_Check_total_book_author
    BEFORE INSERT ON Book FOR EACH ROW
BEGIN
    DECLARE total_books INT;
    SELECT COUNT(*) INTO total_books FROM Book WHERE AuthorId = NEW.AuthorId;
    IF total_books >= 5 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Tác giả này có số lượng sách đạt tới giới hạn 5 cuốn, vui lòng chọn tác giả khác';
    END IF;
END;
//
DELIMITER ;

-- 2. Tạo trigger tr_Update_TotalBook khi thêm mới Book thì cập nhật cột TotalBook rong bảng Author = tổng của Book theo AuthorId
DELIMITER //
CREATE TRIGGER tr_Update_TotalBook
    AFTER INSERT ON Book FOR EACH ROW
BEGIN
    UPDATE Author SET TotalBook = TotalBook + 1 WHERE Id = NEW.AuthorId;
END;
//
DELIMITER ;







