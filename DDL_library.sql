create database if not exists thuvienonline;
use thuvienonline;

-- bảng danh mục
create table if not exists Category(
    Id int auto_increment primary key ,
    Name varchar(100) not null,
    Status tinyint default 1 check ( Status in (0,1))
);
-- bảng tác giả
create table if not exists Author (
    Id int auto_increment primary key ,
    Name varchar(100) not null unique ,
    TotalBook int default 0
);
-- bảng sách
create table if not exists Book (
    Id int auto_increment primary key ,
    Name varchar(150) not null ,
    Status tinyint default 1 check ( Status in (0,1)) ,
    Price float not null check ( Price >= 100000  ),
    CreatedDate DATE default (curdate()),
    CategoryId int not null ,
    AuthorId int not null ,
    foreign key (CategoryId) references Category(Id),
    foreign key (AuthorId) references Author(Id)
);
-- bảng khách hàng
create table if not exists Customer (
    Id int auto_increment primary key ,
    Name varchar(150) not null ,
    Email varchar(150) not null unique check ( Email  regexp '^[a-zA-Z0-9][a-zA-Z0-9.!#$%&''*+-/=?^_`{|}~]*?[a-zA-Z0-9._-]?@[a-zA-Z0-9][a-zA-Z0-9._-]*?[a-zA-Z0-9]?\\.[a-zA-Z]{2,63}$') ,
    Phone varchar(50) not null unique ,
    Address varchar(255),
    CreatedDate DATE default (curdate()),
    Gender tinyint not null check ( Gender in (0,1,2) ),
    Birthday date not null
);

-- bảng vé
create table if not exists Ticket (
    Id int auto_increment primary key ,
    CustomerId int not null ,
    Status tinyint default 1 check ( Status in (0,1,2,3)),
    TicketDate datetime default current_timestamp ,
    foreign key (CustomerId) references Customer(Id)
);
-- bảng chi tiết vé
create table if not exists TicketDetail (
    TicketId int not null ,
    BookId int not null ,
    Quantity int not null check ( Quantity > 0 ),
    DeposiPrice float not null ,
    RentCost float not null ,
    PRIMARY KEY (TicketId, BookId) ,
    foreign key (TicketId) references Ticket(Id),
    foreign key (BookId) references Book(Id)
);
-- thêm dữ liệu mẫu