use quanlynhansu;
# Bảng department
INSERT into department(name)
    value ('Truyền thông'),('Bán hàng'),('Vận Hành')
;

# Bảng levels
insert into levels(Name, BasicSalary)
    VALUE ('Master', 35000000), ('Chính thức', 5000000), ('Lâu năm', 10000000);
#Nhân viên
insert into employee(Name, email, phone, address, gender, birthday, levelId, departmentId)
    value
    ('Hoàng Lê Minh Hiếu', 'hieu@gmail.com', '0988385747', '', 1, '1999-10-10', 1, 2),
    ('Hoàng Quỳnh Anh', 'quanh@gmail.com', '0988774677', '', 1, '1999-10-10', 1, 2),
    ('Nguyễn Quang Hưng', 'hung@gmail.com', '0834867543', '', 1, '1999-10-10', 1, 2),
    ('Nguyễn Trung Hiếu', 'hieuthuhai@gmail.com', '0839864747', '', 1, '1999-10-10', 1, 2),
    ('Nguyễn Trường Giang', 'gian@gmail.com', '0784675844', '', 1, '1999-10-10', 1, 2),
    ('Nguyễn Viết Đạt', 'dat@gmail.com', '0893464555', '', 1, '1999-10-10', 1, 2),
    ('Nguyễn Văn Liêm', 'liem@gmail.com', '0999483564', '', 1, '1999-10-10', 1, 2),
    ('Nguyễn Văn Tiến', 'tien@gmail.com', '0947477847', '', 1, '1999-10-10', 1, 2),
    ('Nguyễn Văn Ánh', 'nganh@gmail.com', '0489875746', '', 1, '1999-10-10', 1, 2),
    ('Nguyễn Đức Hùng', 'nghung@gmail.com', '0932846764', '', 1, '1999-10-10', 1, 2),
    ('Ngô Đăng Anh Tôn', 'ton@gmail.com', '0893487444', '', 1, '1999-10-10', 1, 2),
    ('Phan Văn Tự', 'tu@gmail.com', '0984837673', '', 1, '1999-10-10', 1, 2),
    ('Trương Quang Thắng', 'thang@gmail.com', '0737647368', '', 1, '1999-10-10', 1, 2),
    ('Trần Quang Đạo', 'dao@gmail.com', '0934898774', '', 1, '1999-10-10', 1, 2),
    ('Nguyễn Duy Minh', 'minh@gmail.com', '0934877334', '', 1, '1999-10-10', 1, 2),
    ('Nguyễn Đình Tấn Quỳnh', 'quynh@gmail.com', '0938988778', '', 1, '1999-10-10', 1, 2);

insert into timesheets(AttendanceDate, employeeId, value)
    value
    ('2024-3-1', 1, 0.5),
    ('2024-3-2', 1, 1),
    ('2024-3-3', 1, 1),
    ('2024-3-4', 1, 1),
    ('2024-3-5', 1, 0.5),
    ('2024-3-6', 1, 1),
    ('2024-3-7', 1, 1),
    ('2024-3-8', 1, 0.5),
    ('2024-3-9', 1, 1),
    ('2024-3-10', 1, 1),
    ('2024-3-11', 1, 1),
    ('2024-3-1', 2, 0.5),
    ('2024-3-2', 2, 1),
    ('2024-3-3', 2, 1),
    ('2024-3-4', 2, 1),
    ('2024-3-5', 2, 0.5),
    ('2024-3-6', 2, 0),
    ('2024-3-7', 2, 0),
    ('2024-3-8', 2, 0.5),
    ('2024-3-9', 2, 0),
    ('2024-3-10', 2, 0),
    ('2024-3-11', 2, 0),
    ('2024-3-1', 3, 0.5),
    ('2024-3-2', 3, 1),
    ('2024-3-3', 3, 1),
    ('2024-3-4', 3, 1),
    ('2024-3-5', 3, 0.5),
    ('2024-3-6', 3, 0),
    ('2024-3-7', 3, 1),
    ('2024-3-8', 3, 0.5),
    ('2024-3-9', 3, 0),
    ('2024-3-10', 3, 0.5),
    ('2024-3-11', 3, 0);
insert into salary(employeeId)
    value
    (1),
    (2),
    (3),
    (4),
    (5),
    (6),
    (7),
    (8),
    (9),
    (10),
    (11),
    (12),
    (13),
    (14),
    (15),
    (16);
#
# 1.	Lấy ra danh sách Employee có sắp xếp tăng dần theo Name gồm các cột sau:
# Id, Name, Email, Phone, Address, Gender, BirthDay, Age, DepartmentName, LevelName
select e.Id,
       e.Name,
       Email,
       Phone,
       Address,
       Gender,
       BirthDay,
       year(curdate()) - year(birthday) age,
       d.Name                           DepartmentName,
       l.Name                           LevelName
from employee e
         join department d on e.departmentId = d.Id
         join levels l on e.levelId = l.Id
order by Name;
# 2.	Lấy ra danh sách Salary gồm: Id, EmployeeName, Phone, Email,
# BasicSalary, AllowanceSalary, BonusSalary, Insurrance, TotalSalary
select s.Id,
       e.Name                                                   EmployeeName,
       Phone,
       Email,
       BasicSalary,
       AllowanceSalary,
       BonusSalary,
       Insurrance,
       BasicSalary + AllowanceSalary + BonusSalary - Insurrance TotalSalary
from salary s
         join employee e on s.employeeId = e.Id
         join levels l on e.levelId = l.Id
;

# 3.	Truy vấn danh sách Department gồm: Id, Name, TotalEmployee
select d.Id, d.Name, count(e.Id) TotalEmployee
from department d
         join employee e on d.Id = e.departmentId
group by d.Id;
# 4.	Cập nhật cột BonusSalary lên 10% cho tất cả các Nhân viên có số ngày công >= 5 ngày trong tháng 3 năm 2024
update salary
set BonusSalary = BonusSalary * 1.1
where employeeId in (select employeeId
                     from timesheets
                     where AttendanceDate >= '2024-3-1'
                       and AttendanceDate <= '2024-3-31'
                     group by employeeId
                     having sum(value) >= 5);
# 5.	Truy vấn xóa Phòng ban chưa có nhân viên nào
delete
from department
where id in (select de.id
             from (select distinct d.Id
                   from department d
                            left join employee e
                                      on d.Id = e.departmentId
                   where e.Id is null) de);


# view
# 1.	View v_getEmployeeInfo thực hiện lấy ra danh sách Employee
# gồm: Id, Name, Email, Phone, Address, Gender, BirthDay, DepartmentName,
# LevelName, Trong đó cột Gender hiển thị như sau:
# a.	0 là nữ
# b.	1 là nam

create view v_getEmployeeInfo
as
select e.Id,
       e.Name,
       Email,
       Phone,
       Address,
       case gender
           when 0 then 'Nam'
           when 1 then 'Nữ'
           else 'LGBT' end gen,
       BirthDay,
       d.Name              DepartmentName,
       l.Name              levelName
from employee e
         join department d on e.departmentId = d.Id
         join levels l on e.levelId = l.Id;

select *
from v_getEmployeeInfo;
# 2.	View v_getEmployeeSalaryMax hiển thị danh sách nhân viên có số ngày công trong một
# tháng bất kỳ > 18 gòm: Id, Name, Email, Phone, Birthday, TotalDay (TotalDay là tổng số ngày công trong tháng đó)

select e.Id, Name, Email, Phone, Birthday, month(AttendanceDate) month, sum(value) totalDay
from employee e
         join timesheets t on e.Id = t.employeeId
group by e.Id, month(AttendanceDate)
having totalDay > 5;


#   procedure
# 1.	Thủ tục addEmployeetInfo thực hiện thêm mới nhân viên, khi gọi thủ tục truyền đầy đủ
# các giá trị của bảng Employee ( Trừ cột tự động tăng )
delimiter //
create procedure addEmployeetInfo(Name_in varchar(150), email_IN varchar(150), phone_IN varchar(50),
                                  address_IN varchar(255), gender_IN tinyint, birthday_IN date, levelId_IN int,
                                  departmentId_IN int)
begin
    insert into employee(Name, email, phone, address, gender, birthday, levelId, departmentId)
        value
        (Name_in, email_IN, phone_IN, address_IN, gender_IN, birthday_IN, levelId_IN, departmentId_IN);
end;
delimiter //
call addEmployeetInfo('Hoàng Lê Minh Hiếu 1', 'hieuq@gmail.com', '0984385747', '', 1, '1999-10-10', 1, 2);

# 2.	Thủ tục getSalaryByEmployeeId hiển thị danh sách các bảng lương từng nhân viên theo id
# của nhân viên gồm: Id, EmployeeName, Phone, Email, BaseSalary,  BasicSalary, AllowanceSalary,
# BonusSalary, Insurrance, TotalDay, TotalSalary (trong đó TotalDay là tổng số ngày công, TotalSalary
# là tổng số lương thực lãnh) trong tháng hiện hành
# Khi gọi thủ tục truyền vào id của nhân viên

delimiter //
create procedure getSalaryByEmployeeId(employeeId_IN int)
begin
    select e.Id,
           e.Name                                                                       EmployeeName,
           Phone,
           Email,
           BasicSalary,
           AllowanceSalary,
           BonusSalary,
           Insurrance,
           sum(value)
                                                                                        TotalDay,
           (BasicSalary + BonusSalary + AllowanceSalary - Insurrance) * sum(value) / 24 TotalSalary
    from salary s
             join employee e on s.employeeId = e.Id
             join levels l on e.levelId = l.Id
             join timesheets t on e.Id = t.employeeId
    where month(curdate()) = month(AttendanceDate)
      and year(curdate()) = year(AttendanceDate)
      and e.Id = employeeId_IN
    group by e.Id, s.BonusSalary, s.Insurrance;
end;
delimiter //
call getSalaryByEmployeeId(1);
# 3.	Thủ tục getEmployeePaginate lấy ra danh sách nhân viên có phân trang gồm: Id, Name, Email,
# Phone, Address, Gender, BirthDay, Khi gọi thủ tuc truyền vào limit và page

delimiter //
create procedure getEmployeePaginate(page int, size int)
begin
    declare off_set int;
    set off_set = page * size;
    select Id, Name, Email, Phone, Address, Gender, BirthDay
    from employee
    limit off_set,size;
end;
delimiter //

call getEmployeePaginate(0, 3);


# trigger
# 1.	Tạo trigger tr_Check_ Insurrance_value sao cho khi thêm hoặc sửa trên
# bảng Salary nếu cột Insurrance có giá trị != 10% của BasicSalary thì không
# cho thêm mới hoặc chỉnh sửa và in thông báo ‘Giá trị cảu Insurrance phải = 10%
# của BasicSalary’
create trigger tr_Check_Insurrance_value_before_insert
    before insert
    on salary
    for each row
begin
    declare baseSalary float;
    select BasicSalary
    into baseSalary
    from levels l
             join employee e on l.Id = e.levelId
    where e.Id = NEW.employeeId;
    if baseSalary * 0.1 <> NEW.Insurrance then
        signal sqlstate '45000' set message_text = 'Giá trị của Insurance phải = 10% của BasicSalary';
    end if;
end;

insert into salary(employeeId, BonusSalary, Insurrance) VALUE (17, 1000000, 10000);


# 2.	Tạo trigger tr_check_basic_salary khi thêm mới hoặc chỉnh sửa bảng Levels
# nếu giá trị cột BasicSalary > 10000000 thì tự động dưa về giá trị 10000000 và
# thông báo ‘Lương cơ bản không vượt quá 10 triệu’
create trigger tr_check_basic_salary
    before insert
    on levels
    for each row
begin
    if NEW.BasicSalary > 10000000
    then
        begin
            set NEW.BasicSalary = 10000000;
        end;
    end if;
end;