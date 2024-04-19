#create schema quanlybanhang;
use quanlybanhang;
create table khachhang
(
    makh     nvarchar(4) primary key not null,
    tenkh    nvarchar(30)            not null,
    diachi   nvarchar(50),
    ngaysinh datetime,
    sodt     nvarchar(15) unique
);
create table nhanvien
(
    manv       nvarchar(4) primary key not null,
    hoten      nvarchar(30)            not null,
    gioitinh   bit                     not null,
    diachi     nvarchar(50)            not null,
    ngaysinh   datetime                not null,
    dienthoai  nvarchar(15),
    email      tinytext,
    noisinh    nvarchar(20)            not null,
    ngayvaolam datetime,
    manql      nvarchar(4)
);
create table nhacungcap
(
    mancc     nvarchar(5) primary key not null,
    tenncc    nvarchar(50)            not null,
    diachi    nvarchar(50)            not null,
    dienthoai nvarchar(15)            not null,
    email     nvarchar(30)            not null,
    website   nvarchar(30)
);
create table loaisp
(
    maloaisp  nvarchar(4) primary key not null,
    tenloaisp nvarchar(30)            not null,
    ghichu    nvarchar(100)
);
create table sanpham
(
    masp      nvarchar(4) primary key not null,
    maloaisp  nvarchar(4)             not null,
    tensp     nvarchar(50)            not null,
    donvitinh nvarchar(10)            not null,
    ghichu    nvarchar(100)
);
create table phieunhap
(
    sopn     nvarchar(5) primary key not null,
    manv     nvarchar(4)             not null,
    mancc    nvarchar(5)             not null,
    ngaynhap datetime                not null,
    ghichu   nvarchar(100)
);
create table ctphieunhap
(
    masp    nvarchar(4) not null,
    sopn    nvarchar(5) not null,
    primary key (masp, sopn),
    soluong smallint    not null,
    gianhap real        not null
);
create table phieuxuat
(
    sopx    nvarchar(5) primary key not null,
    manv    nvarchar(4)             not null,
    makh    nvarchar(4)             not null,
    ngayban datetime                not null,
    ghichu  tinytext
);
create table ctphieuxuat
(
    sopx    nvarchar(5) not null,
    masp    nvarchar(4) not null,
    primary key (sopx, masp),
    soluong smallint    not null,
    giaban  real        not null
);
alter table phieunhap
    add constraint fk_mancc
        foreign key (mancc) references nhacungcap (mancc),
    add constraint fk_manv
        foreign key (manv) references nhanvien (manv)
;
alter table ctphieunhap
    add constraint fk_masp
        foreign key (masp) references sanpham (masp),
    add constraint fk_sopn
        foreign key (sopn) references phieunhap (sopn)
;
alter table sanpham
    add constraint fk_maloaisp
        foreign key (maloaisp) references loaisp (maloaisp)
;
alter table phieuxuat
    add constraint fk_manvpx
        foreign key (manv) references nhanvien (manv),
    add constraint fk_makhpx
        foreign key (makh) references khachhang (makh)
;
alter table ctphieuxuat
    add constraint fk_sopx
        foreign key (sopx) references phieuxuat (sopx),
    add constraint fk_masppx
        foreign key (masp) references sanpham (masp)
;

insert into nhanvien(manv, hoten, gioitinh, diachi, ngaysinh, dienthoai, email, noisinh, ngayvaolam, manql)
values (1, 'nguyen van a', 1, 'ha noi', '2002-09-26 12:12:12', 0942351245, 'ex@gmail.com', 'ha noi', null, null);
insert into nhacungcap(mancc, tenncc, diachi, dienthoai, email, website)
values (1, 'ncca', 'Ha noi', '0921235621', 'email@email.com', null);
insert into khachhang(makh, tenkh, diachi, ngaysinh, sodt)
values (1, 'nguyen thi b', null, null, null);
insert into phieunhap(sopn, manv, mancc, ngaynhap, ghichu)
values (1, 1, 1, now(), null);
insert into phieunhap(sopn, manv, mancc, ngaynhap, ghichu)
values (2, 1, 1, now(), null);
insert into phieuxuat(sopx, manv, makh, ngayban, ghichu)
values (1, 1, 1, now(), null);
insert into phieuxuat(sopx, manv, makh, ngayban, ghichu)
values (2, 1, 1, now(), null);
update khachhang
set  sodt = '0123456789' where makh = 1;
update nhanvien
set diachi = 'Hai phong' where manv = 1;