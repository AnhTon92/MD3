CREATE DATABASE qls_hr; 
use qls_hr;


-- bảng Department  --------------------   	    		| Columns | Data Type      || KsR ||
CREATE TABLE Department (
    Id INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL UNIQUE CHECK (LENGTH(Name) >= 6)
);


-- bảng Levels --------------------   	    		| Columns | Data Type      || KsR ||
CREATE TABLE Levels (
    Id INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL UNIQUE,
    BasicSalary FLOAT NOT NULL CHECK (BasicSalary >= 3500000),
    AllowanceSalary FLOAT DEFAULT 500000
);

-- bảng Employee ------------------   	    		| Columns | Data Type      || KsR ||
CREATE TABLE Employee (
    Id INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(150) NOT NULL,
    Email VARCHAR(150) NOT NULL UNIQUE,
    Phone VARCHAR(50) NOT NULL UNIQUE,
    Address VARCHAR(255),
    Gender TINYINT NOT NULL CHECK (Gender IN (0, 1, 2)),
    BirthDay DATE NOT NULL,
    LevelId INT NOT NULL,
    DepartmentId INT NOT NULL,
    FOREIGN KEY (LevelId) REFERENCES Levels(Id),
    FOREIGN KEY (DepartmentId) REFERENCES Department(Id)
);

-- bảng Timesheets -----------------   	    		| Columns | Data Type      || KsR ||
CREATE TABLE Timesheets (
    Id INT AUTO_INCREMENT PRIMARY KEY,
    AttendanceDate datetime default now() not null, 
    EmployeeId INT NOT NULL,
    Value FLOAT NOT NULL DEFAULT 1 CHECK (Value IN (0, 0.5, 1)),
    FOREIGN KEY (EmployeeId) REFERENCES Employee(Id)
);


-- bảng Salary ---------------------   	    		| Columns | Data Type      || KsR ||
CREATE TABLE Salary (
    Id INT AUTO_INCREMENT PRIMARY KEY,
    EmployeeId INT NOT NULL,
    BonusSalary FLOAT DEFAULT 0,
    Insurrance FLOAT NOT NULL,
    FOREIGN KEY (EmployeeId) REFERENCES Employee(Id)
);

-- ALTER TABLE Employee
-- ADD FOREIGN KEY (LevelId) REFERENCES Levels(Id);

-- ALTER TABLE Employee
-- ADD FOREIGN KEY (DepartmentId) REFERENCES Department(Id),
-- ADD CONSTRAINT FK_Employee_Level FOREIGN KEY (LevelId) REFERENCES Levels(Id),
-- ADD CONSTRAINT FK_Employee_Department FOREIGN KEY (DepartmentId) REFERENCES Department(Id);


-- ALTER TABLE Timesheets
-- ADD FOREIGN KEY (EmployeeId) REFERENCES Employee(Id),
-- ADD CONSTRAINT FK_Timesheets_Employee FOREIGN KEY (EmployeeId) REFERENCES Employee(Id);

-- ALTER TABLE Salary
-- ADD FOREIGN KEY (EmployeeId) REFERENCES Employee(Id),
-- ADD CONSTRAINT FK_Salary_Employee FOREIGN KEY (EmployeeId) REFERENCES Employee(Id);

INSERT INTO Department (Name) VALUES ('Phòng Kỹ Thuật');
INSERT INTO Department (Name) VALUES ('Phòng Nhân Sự');
INSERT INTO Department (Name) VALUES ('Phòng Marketing');

-- Thêm dữ liệu vào bảng Levels
INSERT INTO Levels (Name, BasicSalary) VALUES ('Nhân viên', 5000000);
INSERT INTO Levels (Name, BasicSalary) VALUES ('Trưởng phòng', 7000000);
INSERT INTO Levels (Name, BasicSalary) VALUES ('Giám đốc', 10000000);

INSERT INTO Employee (Name, Email, Phone, Address, Gender, BirthDay, LevelId, DepartmentId) VALUES ('Nguyễn Văn A', 'nva@gmail.com', '0123456789', 'Hà Nội', 1, '1990-01-01', 1, 1);
INSERT INTO Employee (Name, Email, Phone, Address, Gender, BirthDay, LevelId, DepartmentId) VALUES ('Nguyễn Văn B', 'nvB@gmail.com', '0123456710', 'Hà Nam', 2, '1991-03-10', 1, 1);
INSERT INTO Employee (Name, Email, Phone, Address, Gender, BirthDay, LevelId, DepartmentId) VALUES ('Nguyễn Văn C', 'nvC@gmail.com', '0678912324', 'Hà Nam', 1, '1989-11-11', 2, 2);
INSERT INTO Employee (Name, Email, Phone, Address, Gender, BirthDay, LevelId, DepartmentId) VALUES ('Nguyễn Văn D', 'nvD@gmail.com', '0452341325', 'Hà Nam', 2, '1992-01-01', 1, 2);
INSERT INTO Employee (Name, Email, Phone, Address, Gender, BirthDay, LevelId, DepartmentId) VALUES ('Nguyễn Văn E', 'nvE@gmail.com', '0867464234', 'Hải Phòng', 1, '1993-01-01', 3, 1);
INSERT INTO Employee (Name, Email, Phone, Address, Gender, BirthDay, LevelId, DepartmentId) VALUES ('Nguyễn Văn F', 'nvF@gmail.com', '0436742242', 'Bắc Cạn', 1, '1994-01-01', 3, 2);
INSERT INTO Employee (Name, Email, Phone, Address, Gender, BirthDay, LevelId, DepartmentId) VALUES ('Nguyễn Văn G', 'nvG@gmail.com', '0753523545', 'Vũng Tàu', 2, '1995-01-01', 3, 2);
INSERT INTO Employee (Name, Email, Phone, Address, Gender, BirthDay, LevelId, DepartmentId) VALUES ('Nguyễn Văn H', 'nvH@gmail.com', '0865774652', 'Cần Thơ', 2, '1996-01-01', 2, 1);
INSERT INTO Employee (Name, Email, Phone, Address, Gender, BirthDay, LevelId, DepartmentId) VALUES ('Nguyễn Văn I', 'nvI@gmail.com', '0765853455', 'Tp. Hồ Chí Minh', 2, '1997-01-01', 2, 2);
INSERT INTO Employee (Name, Email, Phone, Address, Gender, BirthDay, LevelId, DepartmentId) VALUES ('Nguyễn Văn K', 'nvK@gmail.com', '0645875645', 'Sài Gòn', 1, '1997-01-01', 1, 1);
INSERT INTO Employee (Name, Email, Phone, Address, Gender, BirthDay, LevelId, DepartmentId) VALUES ('Nguyễn Văn L', 'nvL@gmail.com', '0345621254', 'Hưng Yên', 2, '1998-01-01', 3, 3);
INSERT INTO Employee (Name, Email, Phone, Address, Gender, BirthDay, LevelId, DepartmentId) VALUES ('Nguyễn Văn M', 'nvM@gmail.com', '0876953645', 'Hưng Yên', 2, '1999-01-01', 1, 3);
INSERT INTO Employee (Name, Email, Phone, Address, Gender, BirthDay, LevelId, DepartmentId) VALUES ('Nguyễn Văn N', 'nvN@gmail.com', '0235778999', 'Bắc Giang', 1, '1983-01-01', 2, 3);
INSERT INTO Employee (Name, Email, Phone, Address, Gender, BirthDay, LevelId, DepartmentId) VALUES ('Nguyễn Văn O', 'nvO@gmail.com', '0653457454', 'Nghệ An', 1, '1987-01-01', 2, 1);
INSERT INTO Employee (Name, Email, Phone, Address, Gender, BirthDay, LevelId, DepartmentId) VALUES ('Nguyễn Văn P', 'nvP@gmail.com', '0457563435', 'Hà Tĩnh', 1, '1988-01-01', 2, 1);
INSERT INTO Employee (Name, Email, Phone, Address, Gender, BirthDay, LevelId, DepartmentId) VALUES ('Nguyễn Văn Q', 'nvQ@gmail.com', '0856345356', 'Cao Bằng', 2, '2000-01-01', 3, 1);

INSERT INTO Timesheets (EmployeeId, Value) VALUES (1, 1);
INSERT INTO Timesheets (EmployeeId, Value) VALUES (2, 0.5);
INSERT INTO Timesheets (EmployeeId, Value) VALUES (3, 0);
INSERT INTO Timesheets (EmployeeId, Value) VALUES (4, 1);
INSERT INTO Timesheets (EmployeeId, Value) VALUES (5, 0.5);
INSERT INTO Timesheets (EmployeeId, Value) VALUES (6, 0);
INSERT INTO Timesheets (EmployeeId, Value) VALUES (7, 1);
INSERT INTO Timesheets (EmployeeId, Value) VALUES (8, 0.5);
INSERT INTO Timesheets (EmployeeId, Value) VALUES (9, 0);
INSERT INTO Timesheets (EmployeeId, Value) VALUES (10, 1);
INSERT INTO Timesheets (EmployeeId, Value) VALUES (11, 0.5);
INSERT INTO Timesheets (EmployeeId, Value) VALUES (12, 0);
INSERT INTO Timesheets (EmployeeId, Value) VALUES (13, 1);
INSERT INTO Timesheets (EmployeeId, Value) VALUES (14, 0.5);
INSERT INTO Timesheets (EmployeeId, Value) VALUES (15, 1);
INSERT INTO Timesheets (EmployeeId, Value) VALUES (1, 0);
INSERT INTO Timesheets (EmployeeId, Value) VALUES (2, 1);
INSERT INTO Timesheets (EmployeeId, Value) VALUES (3, 1);
INSERT INTO Timesheets (EmployeeId, Value) VALUES (4, 0.5);
INSERT INTO Timesheets (EmployeeId, Value) VALUES (5, 0);
INSERT INTO Timesheets (EmployeeId, Value) VALUES (6, 1);
INSERT INTO Timesheets (EmployeeId, Value) VALUES (7, 0.5);
INSERT INTO Timesheets (EmployeeId, Value) VALUES (8, 1);
INSERT INTO Timesheets (EmployeeId, Value) VALUES (9, 1);
INSERT INTO Timesheets (EmployeeId, Value) VALUES (10, 0);
INSERT INTO Timesheets (EmployeeId, Value) VALUES (11, 1);
INSERT INTO Timesheets (EmployeeId, Value) VALUES (12, 0.5);
INSERT INTO Timesheets (EmployeeId, Value) VALUES (13, 0.5);
INSERT INTO Timesheets (EmployeeId, Value) VALUES (14, 0);
INSERT INTO Timesheets (EmployeeId, Value) VALUES (15, 0.5);
INSERT INTO Timesheets (EmployeeId, Value) VALUES (1, 0.5);

INSERT INTO Salary (EmployeeId, Insurrance) VALUES (1, 5000000);
INSERT INTO Salary (EmployeeId, Insurrance) VALUES (8, 8000000);
INSERT INTO Salary (EmployeeId, Insurrance) VALUES (10, 22000000);

SELECT 
    e.Id, 
    e.Name, 
    e.Email, 
    e.Phone, 
    e.Address, 
    e.Gender, 
    e.BirthDay, 
    TIMESTAMPDIFF(YEAR, e.BirthDay, CURDATE()) AS Age, 
    d.Name AS DepartmentName, 
    l.Name AS LevelName
FROM 
    Employee e
JOIN 
    Department d ON e.DepartmentId = d.Id
JOIN 
    Levels l ON e.LevelId = l.Id
ORDER BY 
    e.Name ASC;

SELECT 
    s.Id, 
    e.Name AS EmployeeName, 
    e.Phone, 
    e.Email, 
    l.BasicSalary, 
    l.AllowanceSalary, 
    s.BonusSalary, 
    s.Insurrance, 
    (l.BasicSalary + l.AllowanceSalary + IFNULL(s.BonusSalary, 0) - s.Insurrance) AS TotalSalary
FROM 
    Salary s
JOIN 
    Employee e ON s.EmployeeId = e.Id
JOIN 
    Levels l ON e.LevelId = l.Id;

SELECT 
    d.Id, 
    d.Name, 
    COUNT(e.Id) AS TotalEmployee
FROM 
    Department d
LEFT JOIN 
    Employee e ON d.Id = e.DepartmentId
GROUP BY 
    d.Id, d.Name;
    
#group by của employeeId đếm số công trên bảng timesheets trên 20(dùng sum)
#dùng select để trả về tất cả giá trị của employeeId mà tổng số công lớn hơn 20
 SELECT e.Id
FROM Employee e
JOIN Timesheets t ON e.Id = t.EmployeeId
WHERE MONTH(t.AttendanceDate) = 10 AND YEAR(t.AttendanceDate) = 2020
GROUP BY e.Id
HAVING SUM(t.Value) >= 20;
UPDATE Salary s
JOIN (
    SELECT e.Id
    FROM Employee e
    JOIN Timesheets t ON e.Id = t.EmployeeId
    WHERE MONTH(t.AttendanceDate) = 10 AND YEAR(t.AttendanceDate) = 2020
    GROUP BY e.Id
    HAVING SUM(t.Value) >= 20
) AS EligibleEmployees ON s.EmployeeId = EligibleEmployees.Id
JOIN Levels l ON EligibleEmployees.Id = l.Id 
SET s.BonusSalary = s.BonusSalary + (l.BasicSalary * 0.10);

#Truy vấn xóa phòng ban không có nhân viên
DELETE FROM Department d
WHERE d.Id NOT IN (SELECT DISTINCT DepartmentId FROM Employee);

# tạo view lấy ra danh sách nhân viên
CREATE VIEW v_getEmployeeInfo AS
SELECT 
    e.Id, 
    e.Name, 
    e.Email, 
    e.Phone, 
    e.Address, 
    CASE 
        WHEN e.Gender = 0 THEN 'nữ'
        WHEN e.Gender = 1 THEN 'nam'
        ELSE 'pê đê'
    END AS Gender, 
    e.BirthDay, 
    d.Name AS DepartmentName, 
    l.Name AS LevelName
FROM 
    Employee e
JOIN 
    Department d ON e.DepartmentId = d.Id
JOIN 
    Levels l ON e.LevelId = l.Id;
    SELECT * FROM v_getEmployeeInfo;

# tạo view hiển thị nhân viên có số ngày công trong tháng lớn hơn 18
CREATE VIEW v_getEmployeeSalaryMax AS
SELECT 
    e.Id, 
    e.Name, 
    e.Email, 
    e.Phone, 
    e.BirthDay, 
    SUM(t.Value) AS TotalDay
FROM 
    Employee e
JOIN 
    Timesheets t ON e.Id = t.EmployeeId
    WHERE MONTH(t.AttendanceDate) = 4 AND YEAR(t.AttendanceDate) = 2024
GROUP BY 
    e.Id, e.Name, e.Email, e.Phone, e.BirthDay
HAVING 
    SUM(t.Value) > 18;
    SELECT * FROM v_getEmployeeSalaryMax;
#Tạo thủ tục thêm nhân viên mới
DELIMITER //
CREATE PROCEDURE addEmployeeInfo(
    IN p_Name VARCHAR(150),
    IN p_Email VARCHAR(150),
    IN p_Phone VARCHAR(50),
    IN p_Address VARCHAR(255),
    IN p_Gender TINYINT,
    IN p_BirthDay DATE,
    IN p_LevelId INT,
    IN p_DepartmentId INT
)
BEGIN
    INSERT INTO Employee (Name, Email, Phone, Address, Gender, BirthDay, LevelId, DepartmentId)
    VALUES (p_Name, p_Email, p_Phone, p_Address, p_Gender, p_BirthDay, p_LevelId, p_DepartmentId);
END //
DELIMITER ;
CALL addEmployeeInfo('Ngô Đăng Anh Tôn', 'ndat@gmail.com', '0988928930', 'Hà Nội', 1, '1992-12-03', 2, 3);
# hiển thị danh sách bảng lương nhân viên
DELIMITER //
CREATE PROCEDURE getSalaryByEmployeeId(IN p_EmployeeId INT)
BEGIN
    SELECT distinct
        e.Id, 
        e.Name AS EmployeeName, 
        e.Phone, 
        e.Email, 
        l.BasicSalary AS BaseSalary,
        l.BasicSalary, 
        l.AllowanceSalary, 
        s.BonusSalary, 
        s.Insurrance, 
        sum(ts.Value) AS TotalDays, 
        (l.BasicSalary + l.AllowanceSalary + IFNULL(s.BonusSalary, 0) - s.Insurrance) AS TotalSalary
    FROM 
        Employee e
    JOIN 
        Levels l ON e.LevelId = l.Id
    JOIN 
        Salary s ON e.Id = s.EmployeeId
	JOIN
		timesheets ts on ts.EmployeeId = e.Id
    
	GROUP BY 
    e.Id, e.Name, e.Phone, e.Email, l.BasicSalary, l.AllowanceSalary, s.BonusSalary, s.Insurrance;
END //
DELIMITER ;
call getSalaryByEmployeeId(10);
drop procedure getSlaryByEmployeeId;
drop database qls_hr;
create trigger before_insert_into_salary
before insert
on salary
for each row
begin
declare baseSalary float ;
select BasicSalary into baseSalary from levels l join employee e
on l. Id = e.levelId where e.Id = NEW.employeeId;
set NEW.Insurance =0.1*baseSalary;

end;
