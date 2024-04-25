create database if not exists quanlynhansu;
use quanlynhansu;

create table if not exists Department
(
    Id   int auto_increment primary key,
    Name varchar(100) unique not null check ( length(Name) >= 6 )
);
create table if not exists levels
(
    Id              int auto_increment primary key,
    Name            Varchar(100) unique not null,
    BasicSalary     float               not null check (BasicSalary >= 3500000 ),
    AllowanceSalary float default 500000
);
create table if not exists Employee
(
    Id           int auto_increment primary key,
    Name         Varchar(150) not null,
    email        varchar(150) not null unique check ( email regexp '%@%'),
    phone        varchar(50)  not null unique,
    address      varchar(255),
    gender       tinyint check ( gender in (0, 1, 2)),
    birthday     date         not null,
    levelId      int          not null,
    departmentId int          not null
);

create table if not exists TimeSheets
(
    Id             int auto_increment primary key,
    AttendanceDate date    default(curdate()),
    employeeId     int   not null,
    value          float not null default 1 check ( value in (0, 0.5, 1) )
);

create table if not exists Salary
(
    Id          int auto_increment primary key,
    employeeId  int   not null,
    BonusSalary int   not null default 0,
    Insurrance  float not null
);

alter table Employee
    add foreign key (levelId) references Levels (id),
    add foreign key (departmentId) references Department (Id);
alter table TimeSheets
    add foreign key (employeeId) references Employee (id);
alter table Salary
    add foreign key (employeeId) references Employee (id);


# Khi thêm mới salary thì tự động cập nhật insurrance  = 10% basicSalary
create trigger before_insert_into_salary
    before  insert
    on Salary
    for each row
begin
    declare baseSalary float ;
    select BasicSalary into  baseSalary from Levels l join Employee e
                                                           on l.Id = e.levelId where e.Id = NEW.employeeId;
    set NEW.Insurrance = 0.1*baseSalary;
end;