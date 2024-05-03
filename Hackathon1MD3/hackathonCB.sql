create database quanlydiemthi;
use quanlydiemthi;
create table if not exists student
(
    studentId   VARCHAR(4) PRIMARY KEY not null,
    studentName VARCHAR(100)           not null,
    birthday    DATE                   not null,
    gender      BIT(1)                 not null,
    phoneNumber VARCHAR(45)            not null,
    address     TEXT                   not null
);
create table if not exists subject
(
    subjectId   VARCHAR(4) PRIMARY KEY,
    subjectName VARCHAR(45),
    priority    int
);

create table if not exists mark
(
    subjectId VARCHAR(4),
    studentId VARCHAR(4),
    PRIMARY KEY (subjectId, studentId),
    point     DOUBLE,
    FOREIGN KEY (subjectId) REFERENCES subject (subjectId),
    FOREIGN KEY (studentId) REFERENCES student (studentId)
);

INSERT INTO student (studentId, studentName, birthday, gender, phoneNumber, address)
VALUES ('S001', 'Nguyễn Thế Anh', '1999-09-11', 1, '984678082', 'Hà Nội'),
       ('S002', 'Đặng Bảo Trâm', '1998-12-22', 0, '984982654', 'Lào Cai'),
       ('S003', 'Trần Hà Phương', '2000-05-05', 0, '987465563', 'Nghệ An'),
       ('S004', 'Đỗ Tiến Mạnh', '1999-03-26', 1, '983652578', 'Hà Nội'),
       ('S005', 'Phạm Duy Nhất', '1998-10-04', 1, '987246268', 'Tuyên Quang'),
       ('S006', 'Mai Văn Thái', '2002-06-22', 1, '982654268', 'Điện Biên'),
       ('S007', 'Giang Gia Hân', '1996-11-10', 0, '983247563', 'Phú Thọ'),
       ('S008', 'Nguyễn Ngọc Bảo My', '1999-11-27', 0, '987746753', 'Hà Tĩnh'),
       ('S009', 'Nguyễn Tiến Đạt', '1998-8-7', 1, '987746754', 'Tuyên Quang'),
       ('S010', 'Nguyễn Thiều Quang', '2000-9-18', 1, '987746757', 'Hà Nội')
;
INSERT INTO subject (subjectId, subjectName, priority)
VALUES ('MH01', 'Toán', 2),
       ('MH02', 'Vật Lý', 1),
       ('MH03', 'Hóa Học', 2),
       ('MH04', 'Ngữ Văn', 1),
       ('MH05', 'Tiếng Anh', 2);

INSERT INTO mark (subjectId, studentId, point)
VALUES ('MH01', 'S001', 8.5),
       ('MH02', 'S001', 7),
       ('MH03', 'S001', 9),
       ('MH04', 'S001', 9),
       ('MH05', 'S001', 5),
       ('MH01', 'S002', 7.9),
       ('MH02', 'S002', 8.5),
       ('MH03', 'S002', 6.5),
       ('MH04', 'S002', 8),
       ('MH05', 'S002', 7),
       ('MH01', 'S003', 6),
       ('MH02', 'S003', 7),
       ('MH03', 'S003', 8),
       ('MH04', 'S003', 6.5),
       ('MH05', 'S003', 8),
       ('MH01', 'S004', 7.6),
       ('MH02', 'S004', 5),
       ('MH03', 'S004', 7),
       ('MH04', 'S004', 8),
       ('MH05', 'S004', 6),
       ('MH01', 'S005', 5.5),
       ('MH02', 'S005', 7.5),
       ('MH03', 'S005', 8.5),
       ('MH04', 'S005', 6.75),
       ('MH05', 'S005', 3.75),
       ('MH01', 'S006', 9.25),
       ('MH02', 'S006', 10),
       ('MH03', 'S006', 9),
       ('MH04', 'S006', 9.25),
       ('MH05', 'S006', 4),
       ('MH01', 'S007', 9.5),
       ('MH02', 'S007', 9),
       ('MH03', 'S007', 6),
       ('MH04', 'S007', 9),
       ('MH05', 'S007', 4),
       ('MH01', 'S008', 10),
       ('MH02', 'S008', 8.5),
       ('MH03', 'S008', 8.5),
       ('MH04', 'S008', 6),
       ('MH05', 'S008', 9.5),
       ('MH01', 'S009', 7.5),
       ('MH02', 'S009', 7),
       ('MH03', 'S009', 9),
       ('MH04', 'S009', 5),
       ('MH05', 'S009', 10),
       ('MH01', 'S010', 6.5),
       ('MH02', 'S010', 8),
       ('MH03', 'S010', 5.5),
       ('MH04', 'S010', 4),
       ('MH05', 'S010', 7);
# 2. Cập nhật dữ liệu [10 điểm]:
# - Sửa tên sinh viên có mã `S004` thành “Đỗ Đức Mạnh”.
UPDATE student SET studentName = 'Đỗ Đức Mạnh' WHERE studentId = 'S004';
# - Sửa tên và hệ số môn học có mã `MH05` thành “Ngoại Ngữ” và hệ số là 1.
UPDATE subject SET subjectName = 'Ngoại Ngữ', priority = 1 WHERE subjectId = 'MH05';
# - Cập nhật lại điểm của học sinh có mã `S009` thành (MH01 : 8.5, MH02 : 7,MH03 : 5.5, MH04 : 6,
# MH05 : 9).
UPDATE mark SET point = 8.5 WHERE studentId = 'S009' AND subjectId = 'MH01';
UPDATE mark SET point = 7 WHERE studentId = 'S009' AND subjectId = 'MH02';
UPDATE mark SET point = 5.5 WHERE studentId = 'S009' AND subjectId = 'MH03';
UPDATE mark SET point = 6 WHERE studentId = 'S009' AND subjectId = 'MH04';
UPDATE mark SET point = 9 WHERE studentId = 'S009' AND subjectId = 'MH05';
# 3. Xoá dữ liệu[10 điểm]:
# - Xoá toàn bộ thông tin của học sinh có mã `S010` bao gồm điểm thi ở bảng MARK và thông tin học sinh
# này ở bảng STUDENT.
DELETE FROM mark WHERE studentId = 'S010';
DELETE FROM student WHERE studentId = 'S010';

# Bài 3: Truy vấn dữ liệu [25 điểm]:
# 1. Lấy ra tất cả thông tin của sinh viên trong bảng Student . [4 điểm]
select * from student;
# 2. Hiển thị tên và mã môn học của những môn có hệ số bằng 1. [4 điểm]
SELECT subjectName, subjectId
FROM subject
WHERE priority = 1;
# 3. Hiển thị thông tin học sinh bào gồm: mã học sinh, tên học sinh, tuổi (bằng năm hiện tại trừ
# năm sinh) , giới tính (hiển thị nam hoặc nữ) và quê quán của tất cả học sinh. [4 điểm]
SELECT studentId, studentName,
       YEAR(CURRENT_DATE) - YEAR(birthday) AS tuổi,
       CASE WHEN gender = 1 THEN 'Nam' ELSE 'Nữ' END AS gender,
       address
FROM student;
# 4. Hiển thị thông tin bao gồm: tên học sinh, tên môn học , điểm thi của tất cả học sinh của môn
# Toán và sắp xếp theo điểm giảm dần. [4 điểm]
SELECT s.studentName, sub.subjectName, m.point
FROM student s
         JOIN mark m ON s.studentId = m.studentId
         JOIN subject sub ON m.subjectId = sub.subjectId
WHERE sub.subjectName = 'Toán'
ORDER BY m.point DESC;
# 5. Thống kê số lượng học sinh theo giới tính ở trong bảng (Gồm 2 cột: giới tính và số lượng).
# [4 điểm]
SELECT CASE WHEN gender = 1 THEN 'Nam' ELSE 'Nữ' END AS gender,
       COUNT(*) AS quantity
FROM student
GROUP BY gender;
# 6. Tính tổng điểm và điểm trung bình của các môn học theo từng học sinh (yêu cầu sử dụng hàm
# để tính toán) , bảng gồm mã học sinh, tên hoc sinh, tổng điểm và điểm trung bình. [5 điểm]
SELECT m.studentId, s.studentName,
       SUM(m.point) AS totalPoint,
       AVG(m.point) AS averagePoint
FROM mark m
         JOIN student s ON m.studentId = s.studentId
GROUP BY m.studentId, s.studentName;


# Tạo View, Index, Procedure [20 điểm]:
# 1. Tạo VIEW có tên STUDENT_VIEW lấy thông tin sinh viên bao gồm : mã học sinh, tên học
# sinh, giới tính , quê quán . [3 điểm]
CREATE VIEW STUDENT_VIEW AS
SELECT studentId, studentName, CASE WHEN gender = 1 THEN 'Nam' ELSE 'Nữ' END AS gender, address
FROM student;
# 2. Tạo VIEW có tên AVERAGE_MARK_VIEW lấy thông tin gồm:mã học sinh, tên học sinh,
# điểm trung bình các môn học . [3 điểm]
CREATE VIEW AVERAGE_MARK_VIEW AS
SELECT m.studentId, s.studentName, AVG(m.point) AS averageMark
FROM mark m
         JOIN student s ON m.studentId = s.studentId
GROUP BY m.studentId, s.studentName;

# 3. Đánh Index cho trường `phoneNumber` của bảng STUDENT. [2 điểm]
CREATE INDEX idx_phoneNumber ON student (phoneNumber);

# 4. Tạo các PROCEDURE sau:
# - Tạo PROC_INSERTSTUDENT dùng để thêm mới 1 học sinh bao gồm tất cả
# thông tin học sinh đó. [3 điểm]
delimiter //
CREATE PROCEDURE PROC_INSERTSTUDENT(
    IN p_studentId VARCHAR(4),
    IN p_studentName VARCHAR(100),
    IN p_birthday DATE,
    IN p_gender BIT(1),
    IN p_phoneNumber VARCHAR(45),
    IN p_address TEXT
)
BEGIN
    INSERT INTO student (studentId, studentName, birthday, gender, phoneNumber, address)
    VALUES (p_studentId, p_studentName, p_birthday, p_gender, p_phoneNumber, p_address);
END //
delimiter ;
call PROC_INSERTSTUDENT('S010','Ngô Đăng Anh Tôn','1992-12-03',1,'0988928930','Hà Nội');

# - Tạo PROC_UPDATESUBJECT dùng để cập nhật tên môn học theo mã môn học.
# [3 điểm]
delimiter //
CREATE PROCEDURE PROC_UPDATESUBJECT(
    IN p_subjectId VARCHAR(4),
    IN p_newSubjectName VARCHAR(45)
)
BEGIN
    UPDATE subject SET subjectName = p_newSubjectName WHERE subjectId = p_subjectId;
END//
delimiter ;
call PROC_UPDATESUBJECT('MH01','Math');
# - Tạo PROC_DELETEMARK dùng để xoá toàn bộ điểm các môn học theo mã học
# sinh. [3 điểm]
delimiter //
CREATE PROCEDURE PROC_DELETEMARK(
    IN p_studentId VARCHAR(4)
)
BEGIN
    DELETE FROM mark WHERE studentId = p_studentId;
END//
delimiter ;
call PROC_DELETEMARK('S010');