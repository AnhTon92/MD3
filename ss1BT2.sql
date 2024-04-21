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
select manv, hoten, gioitinh, ngaysinh, diachi, dienthoai, timestampdiff(year, ngaysinh, curdate()) as tuoi
from nhanvien 
order by tuoi;

select pn.sopn, pn.manv, nv.hoten as nhanvien, ncc.tenncc as nhacungcap, pn.ngaynhap, pn.ghichu
from phieunhap pn
join nhanvien nv on pn.manv = nv.manv
join nhacungcap ncc on pn.mancc = ncc.mancc
where month(pn.ngaynhap) = 6 and year(pn.ngaynhap) =2018;

select * from sanpham where donvitinh = 'chai';

select ctpn.sopn, ctpn.masp, sp.tensp, lsp.tenloaisp, sp.donvitinh, ctpn.soluong, ctpn.gianhap,
(ctpn.soluong * ctpn.gianhap) as thanhtien
from ctphieunhap ctpn
join sanpham sp on ctpn.masp = sp.masp
join loaisp lsp on sp.maloaisp = lsp.maloaisp
where month((select ngaynhap from phieunhap where sopn = ctpn.sopn)) = month(curdate());

select ncc.mancc, ncc.tenncc, ncc.diachi, ncc.dienthoai, ncc.email, pn.sopn, pn.ngaynhap
from nhacungcap ncc
join phieunhap pn on ncc.mancc = pn.mancc
where month(pn.ngaynhap) = month(curdate())
order by pn.ngaynhap;
#9
select px.sopx, px.ngayban, kh.makh, kh.tenkh, sum(ctpx.soluong * ctpx.giaban) as giatri
from phieuxuat px
join khachhang kh on px.makh = kh.makh
join ctphieuxuat ctpx on px.sopx = ctpx.sopx
group by px.sopx, px.ngayban, kh.makh, kh.tenkh
order by kh.makh;
#10
select sum(ctpx.soluong)as tongsoluong
from ctphieuxuat ctpx
join sanpham sp on ctpx.masp = sp.masp
join phieuxuat px on ctpx.sopx = px.sopx
where sp.tensp = 'comfort'
and sp.donvitinh = 'chai'
and year(px.ngayban) = '2018'
and month(px.ngayban) between 1 and 6;
#11
SELECT YEAR(px.ngayban) AS nam, MONTH(px.ngayban) AS thang,
       kh.makh, kh.tenkh, kh.diachi, SUM(ctpx.soluong * ctpx.giaban) AS tongtien
FROM phieuxuat px
JOIN khachhang kh ON px.makh = kh.makh
JOIN ctphieuxuat ctpx ON px.sopx = ctpx.sopx
GROUP BY YEAR(px.ngayban), MONTH(px.ngayban), kh.makh, kh.tenkh, kh.diachi
ORDER BY nam, thang;
#12
SELECT YEAR(px.ngayban) AS nam, MONTH(px.ngayban) AS thang,
       sp.masp, sp.tensp, sp.donvitinh, SUM(ctpx.soluong) AS tong_soluong
FROM phieuxuat px
JOIN ctphieuxuat ctpx ON px.sopx = ctpx.sopx
JOIN sanpham sp ON ctpx.masp = sp.masp
GROUP BY YEAR(px.ngayban), MONTH(px.ngayban), sp.masp, sp.tensp, sp.donvitinh
ORDER BY nam, thang;
#13
SELECT YEAR(px.ngayban) AS nam, MONTH(px.ngayban) AS thang,
       SUM(ctpx.soluong * ctpx.giaban) AS doanhthu
FROM phieuxuat px
JOIN ctphieuxuat ctpx ON px.sopx = ctpx.sopx
WHERE YEAR(px.ngayban) = 2018 AND MONTH(px.ngayban) BETWEEN 1 AND 6
GROUP BY YEAR(px.ngayban), MONTH(px.ngayban)
ORDER BY nam, thang;
#14
SELECT px.sopx AS 'sopx', px.ngayban AS 'ngayban',
       nv.hoten AS 'nhanvienban', kh.tenkh AS 'khachhang',
       SUM(ctpx.soluong * ctpx.giaban) AS 'tonggiatri'
FROM phieuxuat px
JOIN nhanvien nv ON px.manv = nv.manv
JOIN khachhang kh ON px.makh = kh.makh
JOIN ctphieuxuat ctpx ON px.sopx = ctpx.sopx
WHERE YEAR(px.ngayban) = 2018 AND MONTH(px.ngayban) IN (5, 6)
GROUP BY px.sopx, px.ngayban, nv.hoten, kh.tenkh
ORDER BY px.ngayban;
#15
SELECT px.sopx AS 'Số Phiếu Xuất', kh.makh AS 'Mã Khách Hàng', kh.tenkh AS 'Tên Khách Hàng',
       nv.hoten AS 'Nhân Viên Bán Hàng', px.ngayban AS 'Ngày Bán',
       SUM(ctpx.soluong * ctpx.giaban) AS 'Trị Giá'
FROM phieuxuat px
JOIN khachhang kh ON px.makh = kh.makh
JOIN nhanvien nv ON px.manv = nv.manv
JOIN ctphieuxuat ctpx ON px.sopx = ctpx.sopx
WHERE px.ngayban = CURDATE()
GROUP BY px.sopx, kh.makh, kh.tenkh, nv.hoten, px.ngayban
ORDER BY px.ngayban;