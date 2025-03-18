CREATE DATABASE QLGBD
GO
CREATE TABLE Khoa (
MaKhoa char(5) PRIMARY KEY, 
TenKhoa nvarchar (50) NOT NULL
)
CREATE TABLE DoiBong (
MaDoi char(5) PRIMARY KEY, 
TenDoi nvarchar (30) NOT NULL,
MSSVDoiTruong char(11) NOT NULL,
MaKhoa char(5) NOT NULl,
) 
CREATE TABLE CauThu (
MSSV char(11) PRIMARY KEY, 
HoTenSV nvarchar(45) NOT NULL,
Khoa int NOT NULL,
SoAo int NOT NULL,
ViTriThiDau char(2) NOT NULL CHECK (ViTriThiDau in ('TM','VT')),
SDTCT char(11),
MaDoi char(5) NOT NULL,
MaKhoa char(5) NOT NULL,
) 

CREATE TABLE San(
MaSan char(3) PRIMARY KEY,
TenSan nvarchar(45) NOT NULL,
DiaDiem nvarchar(100) NOT NULL,
)
CREATE TABLE TrongTai(
MaTT char(5) PRIMARY KEY, 
HoTenTT nvarchar (50) NOT NULL,
SDTTT nvarchar(11) NOT NULL,
)
CREATE TABLE TranDau 
(
MaTD	    CHAR(4)             PRIMARY KEY ,
VongDau	    VARCHAR(2)		NOT NULL,
NgayToChuc	DATE			NOT NULL,
GioThiDau	TIME			NOT NULL,
MaSan	            CHAR(3)		NOT NULL,
MaTT 	            CHAR(5)		NOT NULL,
)

CREATE TABLE ChiTietTranDau (
MaTD            CHAR(4) ,
MaDoi           CHAR(5)  ,
KetQuaDoi     	VARCHAR(1) CHECK (KetQuaDoi IN ('W','L','D')),
XacDinhKQ       VARCHAR(2) CHECK (XacDinhKQ IN ('NT', 'ET', 'PS')),
SoBanGhi       	INT ,
PRIMARY KEY(MaTD, MaDoi),
)
CREATE TABLE BanThang (
MaBT            CHAR(6) PRIMARY KEY,
LoaiBT char (1) CHECK (LoaiBT in ('N','O','P')),
MaTD CHAR(4),
MSSV         char(11),
)
CREATE TABLE ThePhat(

MSSV         char(11) NOT NULL,
MaTD	     CHAR(4) NOT NULL,       
SoTheVang    INT NOT NULL CHECK(SoTheVang in (0,1,2)),
SoTheDo      INT NOT NULL CHECK(SoTheDo in (0,1)),
PRIMARY KEY (MSSV, MATD),
)
CREATE TABLE LuanLuu(
MSSV         char(11), 
MaTD	     CHAR(4),
TinhTrang       VARCHAR(1)   CHECK(TinhTrang in ('S','F')),
PRIMARY KEY (MSSV, MaTD),
) 
-- TẠO KHÓA NGOẠI 
ALTER TABLE DoiBong  ADD CONSTRAINT FK_DB_K FOREIGN KEY (MaKhoa) REFERENCES Khoa(MaKhoa)
ALTER TABLE CauThu  ADD CONSTRAINT FK_CT_K FOREIGN KEY (MaKhoa) REFERENCES Khoa(MaKhoa)
ALTER TABLE CauThu ADD CONSTRAINT FK_CT_DB FOREIGN KEY (MaDoi) REFERENCES DoiBong(MaDoi)
ALTER TABLE TranDau  ADD CONSTRAINT FK_TD_S FOREIGN KEY (MaSan) REFERENCES San(MaSan)
ALTER TABLE TranDau  ADD CONSTRAINT FK_TD_TT FOREIGN KEY (MaTT) REFERENCES TrongTai(MaTT)
ALTER TABLE ChiTietTranDau  ADD CONSTRAINT FK_CTTD_TD FOREIGN KEY (MaTD) REFERENCES TranDau(MaTD)
ALTER TABLE ChiTietTranDau  ADD CONSTRAINT FK_CTTD_DB FOREIGN KEY (MaDoi) REFERENCES DoiBong(MaDoi)
ALTER TABLE ThePhat  ADD CONSTRAINT FK_TP_TD FOREIGN KEY (MaTD) REFERENCES TranDau(MaTD)
ALTER TABLE ThePhat  ADD CONSTRAINT FK_TP_CT FOREIGN KEY (MSSV) REFERENCES CauThu(MSSV)
ALTER TABLE LuanLuu  ADD CONSTRAINT FK_LL_TD FOREIGN KEY (MaTD) REFERENCES TranDau(MaTD)
ALTER TABLE LuanLuu ADD CONSTRAINT FK_LL_CT FOREIGN KEY (MSSV) REFERENCES CauThu(MSSV)
ALTER TABLE BanThang  ADD CONSTRAINT FK_BT_TD FOREIGN KEY (MaTD) REFERENCES TranDau(MaTD)
ALTER TABLE BanThang ADD CONSTRAINT FK_BT_CT FOREIGN KEY (MSSV) REFERENCES CauThu(MSSV)

-- dữ liệu bảng Khoa
INSERT INTO Khoa (MaKhoa, TenKhoa ) VALUES ('BIT', N'Khoa Công nghệ thông tin kinh doanh ');
INSERT INTO Khoa (MaKhoa, TenKhoa ) VALUES ('SOF', N'Khoa Tài chính ');
INSERT INTO Khoa (MaKhoa, TenKhoa ) VALUES ('KET', N'Khoa Kế toán ');
INSERT INTO Khoa (MaKhoa, TenKhoa ) VALUES ('SOM', N'Khoa Quản trị ');
INSERT INTO Khoa (MaKhoa, TenKhoa ) VALUES ('KQM', N'Khoa Kinh doanh quốc tế – Marketing ');
INSERT INTO Khoa (MaKhoa, TenKhoa ) VALUES ('TTK', N'Khoa Toán – Thống kê ');
INSERT INTO Khoa (MaKhoa, TenKhoa ) VALUES ('SOE', N'Khoa Kinh tế ');
INSERT INTO Khoa (MaKhoa, TenKhoa ) VALUES ('SOB', N'Khoa Ngân hàng');
-- dữ liệu bảng DoiBong
INSERT INTO DoiBong (MaDoi, TenDoi, MSSVDoiTruong, MaKhoa ) VALUES ('D01', 'WINX', '31221021005', 'BIT ');
INSERT INTO DoiBong (MaDoi, TenDoi, MSSVDoiTruong, MaKhoa ) VALUES ('D02', 'THE LIGHT ', '31211025124', 'SOF ');
INSERT INTO DoiBong (MaDoi, TenDoi, MSSVDoiTruong, MaKhoa ) VALUES ('D03', 'Nucleus', '31221025922', 'KET ');
INSERT INTO DoiBong (MaDoi, TenDoi, MSSVDoiTruong, MaKhoa ) VALUES ('D04', 'New Empire', '31211020938', 'SOM ');
INSERT INTO DoiBong (MaDoi, TenDoi, MSSVDoiTruong, MaKhoa ) VALUES ('D05', 'Bright FC', '31221022728', 'KQM ');
INSERT INTO DoiBong (MaDoi, TenDoi, MSSVDoiTruong, MaKhoa ) VALUES ('D06', 'TXT', '31221025227', 'TTK ');
INSERT INTO DoiBong (MaDoi, TenDoi, MSSVDoiTruong, MaKhoa ) VALUES ('D07', 'SM', '31231026429', 'SOE ');
INSERT INTO DoiBong (MaDoi, TenDoi, MSSVDoiTruong, MaKhoa ) VALUES ('D08', 'JYP', '31231024819', 'SOB');
-- dữ liệu bảng San
INSERT INTO San (MaSan, TenSan, DiaDiem ) VALUES ('S01', 'Sân bóng đá Phạm Hùng 2', '4d Hẻm C11, Bình Hưng, Bình Chánh ');
INSERT INTO San (MaSan, TenSan, DiaDiem ) VALUES ('S02', 'Sân bóng đá UEH cơ sở N', 'Khu Chức Năng Số 15, Đô Thị Mới Nam Thành Phố, Phong Phú, Bình Chánh ');
INSERT INTO San (MaSan, TenSan, DiaDiem ) VALUES ('S03', 'Sân Bóng Đá Phạm Hùng', 'C7D, Phạm Hùng, Bình Hưng, Bình Chánh ');
INSERT INTO San (MaSan, TenSan, DiaDiem ) VALUES ('S04', 'Sân vận động Phú Thọ', '221 Lý Thường Kiệt, Phường 9, Quận 11');
-- dữ liệu bảng TrongTai
INSERT INTO TrongTai (MaTT, HoTenTT, SDTTT ) VALUES ('TT01', 'Lê Đình Phong', '0873342413 ');
INSERT INTO TrongTai (MaTT, HoTenTT, SDTTT ) VALUES ('TT02', 'Nguyễn Hoàng Minh', '0987654321 ');
INSERT INTO TrongTai (MaTT, HoTenTT, SDTTT ) VALUES ('TT03', 'Nguyễn Hữu Long', '0945432342 ');
INSERT INTO TrongTai (MaTT, HoTenTT, SDTTT ) VALUES ('TT04', 'Hoàng Đức Dũng', '0923425245 ');
INSERT INTO TrongTai (MaTT, HoTenTT, SDTTT ) VALUES ('TT05', 'Nguyễn Đăng Tài', '0424524525');
-- Them thong tin bang TranDau
INSERT INTO TranDau (MaTD, VongDau, NgayToChuc, GioThiDau, MaSan, MaTT ) VALUES ('TD1', 'GS', '2023-9-10', '19:00', 'S02', 'TT04 ');
INSERT INTO TranDau (MaTD, VongDau, NgayToChuc, GioThiDau, MaSan, MaTT ) VALUES ('TD2', 'GS', '2023-9-11', '17:00', 'S03', 'TT03 ');
INSERT INTO TranDau (MaTD, VongDau, NgayToChuc, GioThiDau, MaSan, MaTT ) VALUES ('TD3', 'GS', '2023-9-11', '16:00', 'S01', 'TT03 ');
INSERT INTO TranDau (MaTD, VongDau, NgayToChuc, GioThiDau, MaSan, MaTT ) VALUES ('TD4', 'GS', '2023-9-12', '18:00', 'S02', 'TT05 ');
INSERT INTO TranDau (MaTD, VongDau, NgayToChuc, GioThiDau, MaSan, MaTT ) VALUES ('TD5', 'GS', '2023-9-15', '7:00', 'S02', 'TT01 ');
INSERT INTO TranDau (MaTD, VongDau, NgayToChuc, GioThiDau, MaSan, MaTT ) VALUES ('TD6', 'GS', '2023-9-15', '8:30', 'S04', 'TT03 ');
INSERT INTO TranDau (MaTD, VongDau, NgayToChuc, GioThiDau, MaSan, MaTT ) VALUES ('TD7', 'GS', '2023-9-16', '15:30', 'S04', 'TT05 ');
INSERT INTO TranDau (MaTD, VongDau, NgayToChuc, GioThiDau, MaSan, MaTT ) VALUES ('TD8', 'GS', '2023-9-17', '17:00', 'S02', 'TT04 ');
INSERT INTO TranDau (MaTD, VongDau, NgayToChuc, GioThiDau, MaSan, MaTT ) VALUES ('TD9', 'GS', '2023-9-23', '08:30', 'S04', 'TT01 ');
INSERT INTO TranDau (MaTD, VongDau, NgayToChuc, GioThiDau, MaSan, MaTT ) VALUES ('TD10', 'GS', '2023-9-23', '17:00', 'S04', 'TT05 ');
INSERT INTO TranDau (MaTD, VongDau, NgayToChuc, GioThiDau, MaSan, MaTT ) VALUES ('TD11', 'GS', '2023-9-24', '17:00', 'S02', 'TT03 ');
INSERT INTO TranDau (MaTD, VongDau, NgayToChuc, GioThiDau, MaSan, MaTT ) VALUES ('TD12', 'GS', '2023-9-25', '16:00', 'S04', 'TT02 ');
INSERT INTO TranDau (MaTD, VongDau, NgayToChuc, GioThiDau, MaSan, MaTT ) VALUES ('TD13', 'SF', '2023-9-30', '16:00', 'S02', 'TT04 ');
INSERT INTO TranDau (MaTD, VongDau, NgayToChuc, GioThiDau, MaSan, MaTT ) VALUES ('TD14', 'SF', '2023-10-1', '15:30', 'S02', 'TT01 ');
INSERT INTO TranDau (MaTD, VongDau, NgayToChuc, GioThiDau, MaSan, MaTT ) VALUES ('TD15', 'TP', '2023-10-7', '18:00', 'S02', 'TT03 ');
INSERT INTO TranDau (MaTD, VongDau, NgayToChuc, GioThiDau, MaSan, MaTT ) VALUES ('TD16', 'GF', '2023-10-8', '19:00', 'S02', 'TT05');
--du lieu bang ChiTietTranDau
INSERT INTO ChiTietTranDau (MaTD, MaDoi, KetQuaDoi, XacDinhKQ, SoBanGhi ) VALUES ('TD1', 'D01', 'W', 'NT', '2 ');
INSERT INTO ChiTietTranDau (MaTD, MaDoi, KetQuaDoi, XacDinhKQ, SoBanGhi ) VALUES ('TD1', 'D02', 'L', 'NT', '1 ');
INSERT INTO ChiTietTranDau (MaTD, MaDoi, KetQuaDoi, XacDinhKQ, SoBanGhi ) VALUES ('TD2', 'D03', 'L', 'NT', '0 ');
INSERT INTO ChiTietTranDau (MaTD, MaDoi, KetQuaDoi, XacDinhKQ, SoBanGhi ) VALUES ('TD2', 'D04', 'W', 'NT', '3 ');
INSERT INTO ChiTietTranDau (MaTD, MaDoi, KetQuaDoi, XacDinhKQ, SoBanGhi ) VALUES ('TD3', 'D05', 'W', 'NT', '3 ');
INSERT INTO ChiTietTranDau (MaTD, MaDoi, KetQuaDoi, XacDinhKQ, SoBanGhi ) VALUES ('TD3', 'D06', 'L', 'NT', '1 ');
INSERT INTO ChiTietTranDau (MaTD, MaDoi, KetQuaDoi, XacDinhKQ, SoBanGhi ) VALUES ('TD4', 'D07', 'D', 'NT', '2 ');
INSERT INTO ChiTietTranDau (MaTD, MaDoi, KetQuaDoi, XacDinhKQ, SoBanGhi ) VALUES ('TD4', 'D08', 'D', 'NT', '2 ');
INSERT INTO ChiTietTranDau (MaTD, MaDoi, KetQuaDoi, XacDinhKQ, SoBanGhi ) VALUES ('TD5', 'D02', 'L', 'NT', '0 ');
INSERT INTO ChiTietTranDau (MaTD, MaDoi, KetQuaDoi, XacDinhKQ, SoBanGhi ) VALUES ('TD5', 'D04', 'W', 'NT', '3 ');
INSERT INTO ChiTietTranDau (MaTD, MaDoi, KetQuaDoi, XacDinhKQ, SoBanGhi ) VALUES ('TD6', 'D06', 'W', 'NT', '1 ');
INSERT INTO ChiTietTranDau (MaTD, MaDoi, KetQuaDoi, XacDinhKQ, SoBanGhi ) VALUES ('TD6', 'D08', 'L', 'NT', '0 ');
INSERT INTO ChiTietTranDau (MaTD, MaDoi, KetQuaDoi, XacDinhKQ, SoBanGhi ) VALUES ('TD7', 'D01', 'W', 'NT', '2 ');
INSERT INTO ChiTietTranDau (MaTD, MaDoi, KetQuaDoi, XacDinhKQ, SoBanGhi ) VALUES ('TD7', 'D03', 'L', 'NT', '1 ');
INSERT INTO ChiTietTranDau (MaTD, MaDoi, KetQuaDoi, XacDinhKQ, SoBanGhi ) VALUES ('TD8', 'D05', 'W', 'NT', '1 ');
INSERT INTO ChiTietTranDau (MaTD, MaDoi, KetQuaDoi, XacDinhKQ, SoBanGhi ) VALUES ('TD8', 'D07', 'L', 'NT', '0 ');
INSERT INTO ChiTietTranDau (MaTD, MaDoi, KetQuaDoi, XacDinhKQ, SoBanGhi ) VALUES ('TD9', 'D01', 'D', 'NT', '0 ');
INSERT INTO ChiTietTranDau (MaTD, MaDoi, KetQuaDoi, XacDinhKQ, SoBanGhi ) VALUES ('TD9', 'D04', 'D', 'NT', '0 ');
INSERT INTO ChiTietTranDau (MaTD, MaDoi, KetQuaDoi, XacDinhKQ, SoBanGhi ) VALUES ('TD10', 'D02', 'L', 'NT', '0 ');
INSERT INTO ChiTietTranDau (MaTD, MaDoi, KetQuaDoi, XacDinhKQ, SoBanGhi ) VALUES ('TD10', 'D03', 'W', 'NT', '2 ');
INSERT INTO ChiTietTranDau (MaTD, MaDoi, KetQuaDoi, XacDinhKQ, SoBanGhi ) VALUES ('TD11', 'D05', 'L', 'NT', '0 ');
INSERT INTO ChiTietTranDau (MaTD, MaDoi, KetQuaDoi, XacDinhKQ, SoBanGhi ) VALUES ('TD11', 'D08', 'W', 'NT', '2 ');
INSERT INTO ChiTietTranDau (MaTD, MaDoi, KetQuaDoi, XacDinhKQ, SoBanGhi ) VALUES ('TD12', 'D06', 'D', 'NT', '1 ');
INSERT INTO ChiTietTranDau (MaTD, MaDoi, KetQuaDoi, XacDinhKQ, SoBanGhi ) VALUES ('TD12', 'D07', 'D', 'NT', '1 ');
INSERT INTO ChiTietTranDau (MaTD, MaDoi, KetQuaDoi, XacDinhKQ, SoBanGhi ) VALUES ('TD13', 'D01', 'W', 'ET', '3 ');
INSERT INTO ChiTietTranDau (MaTD, MaDoi, KetQuaDoi, XacDinhKQ, SoBanGhi ) VALUES ('TD13', 'D08', 'L', 'ET', '1 ');
INSERT INTO ChiTietTranDau (MaTD, MaDoi, KetQuaDoi, XacDinhKQ, SoBanGhi ) VALUES ('TD14', 'D04', 'W', 'PS', '1 ');
INSERT INTO ChiTietTranDau (MaTD, MaDoi, KetQuaDoi, XacDinhKQ, SoBanGhi ) VALUES ('TD14', 'D05', 'L', 'PS', '1 ');
INSERT INTO ChiTietTranDau (MaTD, MaDoi, KetQuaDoi, XacDinhKQ, SoBanGhi ) VALUES ('TD15', 'D08', 'W', 'PS', '2 ');
INSERT INTO ChiTietTranDau (MaTD, MaDoi, KetQuaDoi, XacDinhKQ, SoBanGhi ) VALUES ('TD15', 'D05', 'L', 'PS', '2 ');
INSERT INTO ChiTietTranDau (MaTD, MaDoi, KetQuaDoi, XacDinhKQ, SoBanGhi ) VALUES ('TD16', 'D01', 'W', 'ET', '2 ');
INSERT INTO ChiTietTranDau (MaTD, MaDoi, KetQuaDoi, XacDinhKQ, SoBanGhi ) VALUES ('TD16', 'D04', 'L', 'ET', '1');

-- Them Thong Tin bang ThePhat
INSERT INTO ThePhat (MSSV, MaTD, SoTheVang, SoTheDo ) VALUES ('31221021005', 'TD1', '1', '1 ');
INSERT INTO ThePhat (MSSV, MaTD, SoTheVang, SoTheDo ) VALUES ('31221026375', 'TD1', '1', '0 ');
INSERT INTO ThePhat (MSSV, MaTD, SoTheVang, SoTheDo ) VALUES ('31211025124', 'TD1', '1', '0 ');
INSERT INTO ThePhat (MSSV, MaTD, SoTheVang, SoTheDo ) VALUES ('31211021303', 'TD1', '2', '1 ');
INSERT INTO ThePhat (MSSV, MaTD, SoTheVang, SoTheDo ) VALUES ('31221026440', 'TD3', '1', '0 ');
INSERT INTO ThePhat (MSSV, MaTD, SoTheVang, SoTheDo ) VALUES ('31221021685', 'TD3', '0', '1 ');
INSERT INTO ThePhat (MSSV, MaTD, SoTheVang, SoTheDo ) VALUES ('31231026472', 'TD4', '1', '0 ');
INSERT INTO ThePhat (MSSV, MaTD, SoTheVang, SoTheDo ) VALUES ('31221021159', 'TD6', '1', '1 ');
INSERT INTO ThePhat (MSSV, MaTD, SoTheVang, SoTheDo ) VALUES ('31221022206', 'TD6', '1', '0 ');
INSERT INTO ThePhat (MSSV, MaTD, SoTheVang, SoTheDo ) VALUES ('31231027351', 'TD6', '1', '0 ');
INSERT INTO ThePhat (MSSV, MaTD, SoTheVang, SoTheDo ) VALUES ('31231024877', 'TD6', '0', '1 ');
INSERT INTO ThePhat (MSSV, MaTD, SoTheVang, SoTheDo ) VALUES ('31231022098', 'TD6', '1', '0 ');
INSERT INTO ThePhat (MSSV, MaTD, SoTheVang, SoTheDo ) VALUES ('31211021597', 'TD10', '1', '0 ');
INSERT INTO ThePhat (MSSV, MaTD, SoTheVang, SoTheDo ) VALUES ('31221026825', 'TD10', '0', '1 ');
INSERT INTO ThePhat (MSSV, MaTD, SoTheVang, SoTheDo ) VALUES ('31221023643', 'TD10', '1', '0 ');
INSERT INTO ThePhat (MSSV, MaTD, SoTheVang, SoTheDo ) VALUES ('31221026270', 'TD12', '2', '1 ');
INSERT INTO ThePhat (MSSV, MaTD, SoTheVang, SoTheDo ) VALUES ('31221026310', 'TD12', '1', '0 ');
INSERT INTO ThePhat (MSSV, MaTD, SoTheVang, SoTheDo ) VALUES ('31221022206', 'TD12', '1', '0 ');
INSERT INTO ThePhat (MSSV, MaTD, SoTheVang, SoTheDo ) VALUES ('31231027209', 'TD12', '0', '1 ');
INSERT INTO ThePhat (MSSV, MaTD, SoTheVang, SoTheDo ) VALUES ('31221024364', 'TD13', '2', '1 ');
INSERT INTO ThePhat (MSSV, MaTD, SoTheVang, SoTheDo ) VALUES ('31231026832', 'TD13', '1', '0 ');
INSERT INTO ThePhat (MSSV, MaTD, SoTheVang, SoTheDo ) VALUES ('31231024808', 'TD13', '1', '0 ');
INSERT INTO ThePhat (MSSV, MaTD, SoTheVang, SoTheDo ) VALUES ('31231027351', 'TD13', '1', '0 ');
INSERT INTO ThePhat (MSSV, MaTD, SoTheVang, SoTheDo ) VALUES ('31231024877', 'TD13', '0', '1 ');
INSERT INTO ThePhat (MSSV, MaTD, SoTheVang, SoTheDo ) VALUES ('31211023903', 'TD14', '1', '0 ');
INSERT INTO ThePhat (MSSV, MaTD, SoTheVang, SoTheDo ) VALUES ('31221025530', 'TD14', '1', '0 ');
INSERT INTO ThePhat (MSSV, MaTD, SoTheVang, SoTheDo ) VALUES ('31231027358', 'TD15', '1', '1 ');
INSERT INTO ThePhat (MSSV, MaTD, SoTheVang, SoTheDo ) VALUES ('31221025159', 'TD16', '1', '0 ');
INSERT INTO ThePhat (MSSV, MaTD, SoTheVang, SoTheDo ) VALUES ('31221026375', 'TD16', '2', '1 ');
INSERT INTO ThePhat (MSSV, MaTD, SoTheVang, SoTheDo ) VALUES ('31211023903', 'TD16', '1', '1 ');
INSERT INTO ThePhat (MSSV, MaTD, SoTheVang, SoTheDo ) VALUES ('31201022007', 'TD16', '1', '0 ');
INSERT INTO ThePhat (MSSV, MaTD, SoTheVang, SoTheDo ) VALUES ('31211026730', 'TD16', '0', '1');

-- Thêm thông tin LuanLuu
INSERT INTO LuanLuu (MSSV, MaTD, TinhTrang ) VALUES ('31211020938', 'TD14', 'S ');
INSERT INTO LuanLuu (MSSV, MaTD, TinhTrang ) VALUES ('31211025257', 'TD14', 'S ');
INSERT INTO LuanLuu (MSSV, MaTD, TinhTrang ) VALUES ('31211026730', 'TD14', 'S ');
INSERT INTO LuanLuu (MSSV, MaTD, TinhTrang ) VALUES ('31191025722', 'TD14', 'S ');
INSERT INTO LuanLuu (MSSV, MaTD, TinhTrang ) VALUES ('31191023166', 'TD14', 'S ');
INSERT INTO LuanLuu (MSSV, MaTD, TinhTrang ) VALUES ('31221022728', 'TD14', 'S ');
INSERT INTO LuanLuu (MSSV, MaTD, TinhTrang ) VALUES ('31221026440', 'TD14', 'S ');
INSERT INTO LuanLuu (MSSV, MaTD, TinhTrang ) VALUES ('31221021685', 'TD14', 'S ');
INSERT INTO LuanLuu (MSSV, MaTD, TinhTrang ) VALUES ('31221020637', 'TD14', 'S ');
INSERT INTO LuanLuu (MSSV, MaTD, TinhTrang ) VALUES ('31221022399', 'TD14', 'F ');
INSERT INTO LuanLuu (MSSV, MaTD, TinhTrang ) VALUES ('31231026832', 'TD15', 'S ');
INSERT INTO LuanLuu (MSSV, MaTD, TinhTrang ) VALUES ('31231024808', 'TD15', 'S ');
INSERT INTO LuanLuu (MSSV, MaTD, TinhTrang ) VALUES ('31231027351', 'TD15', 'S ');
INSERT INTO LuanLuu (MSSV, MaTD, TinhTrang ) VALUES ('31231024877', 'TD15', 'S ');
INSERT INTO LuanLuu (MSSV, MaTD, TinhTrang ) VALUES ('31231022098', 'TD15', 'F ');
INSERT INTO LuanLuu (MSSV, MaTD, TinhTrang ) VALUES ('31231024811', 'TD15', 'S ');
INSERT INTO LuanLuu (MSSV, MaTD, TinhTrang ) VALUES ('31221026440', 'TD15', 'S ');
INSERT INTO LuanLuu (MSSV, MaTD, TinhTrang ) VALUES ('31221021685', 'TD15', 'S ');
INSERT INTO LuanLuu (MSSV, MaTD, TinhTrang ) VALUES ('31221022399', 'TD15', 'S ');
INSERT INTO LuanLuu (MSSV, MaTD, TinhTrang ) VALUES ('31221025530', 'TD15', 'S ');
INSERT INTO LuanLuu (MSSV, MaTD, TinhTrang ) VALUES ('31221020637', 'TD15', 'F ');
INSERT INTO LuanLuu (MSSV, MaTD, TinhTrang ) VALUES ('31221023999', 'TD15', 'F');
--Thong tin bang BanThang
INSERT INTO BanThang (MaBT, LoaiBT, MSSV, MaTD ) VALUES ('BT1', 'N', '31221021005', 'TD1 ');
INSERT INTO BanThang (MaBT, LoaiBT, MSSV, MaTD ) VALUES ('BT2', 'N', '31221020808', 'TD1 ');
INSERT INTO BanThang (MaBT, LoaiBT, MSSV, MaTD ) VALUES ('BT3', 'N', '31211025487', 'TD1 ');
INSERT INTO BanThang (MaBT, LoaiBT, MSSV, MaTD ) VALUES ('BT4', 'O', '31211022525', 'TD2 ');
INSERT INTO BanThang (MaBT, LoaiBT, MSSV, MaTD ) VALUES ('BT5', 'N', '31201022279', 'TD2 ');
INSERT INTO BanThang (MaBT, LoaiBT, MSSV, MaTD ) VALUES ('BT6', 'N', '31211025702', 'TD2 ');
INSERT INTO BanThang (MaBT, LoaiBT, MSSV, MaTD ) VALUES ('BT7', 'N', '31221020695', 'TD3 ');
INSERT INTO BanThang (MaBT, LoaiBT, MSSV, MaTD ) VALUES ('BT8', 'P', '31221021204', 'TD3 ');
INSERT INTO BanThang (MaBT, LoaiBT, MSSV, MaTD ) VALUES ('BT9', 'N', '31221020695', 'TD3 ');
INSERT INTO BanThang (MaBT, LoaiBT, MSSV, MaTD ) VALUES ('BT10', 'N', '31221020458', 'TD3 ');
INSERT INTO BanThang (MaBT, LoaiBT, MSSV, MaTD ) VALUES ('BT11', 'N', '31231026424', 'TD4 ');
INSERT INTO BanThang (MaBT, LoaiBT, MSSV, MaTD ) VALUES ('BT12', 'N', '31231024811', 'TD4 ');
INSERT INTO BanThang (MaBT, LoaiBT, MSSV, MaTD ) VALUES ('BT13', 'N', '31231021976', 'TD4 ');
INSERT INTO BanThang (MaBT, LoaiBT, MSSV, MaTD ) VALUES ('BT14', 'N', '31231027358', 'TD4 ');
INSERT INTO BanThang (MaBT, LoaiBT, MSSV, MaTD ) VALUES ('BT15', 'N', '31211025702', 'TD5 ');
INSERT INTO BanThang (MaBT, LoaiBT, MSSV, MaTD ) VALUES ('BT16', 'N', '31211025702', 'TD5 ');
INSERT INTO BanThang (MaBT, LoaiBT, MSSV, MaTD ) VALUES ('BT17', 'N', '31201022279', 'TD5 ');
INSERT INTO BanThang (MaBT, LoaiBT, MSSV, MaTD ) VALUES ('BT18', 'P', '31221024375', 'TD6 ');
INSERT INTO BanThang (MaBT, LoaiBT, MSSV, MaTD ) VALUES ('BT19', 'N', '31221026655', 'TD7 ');
INSERT INTO BanThang (MaBT, LoaiBT, MSSV, MaTD) VALUES ('BT20', 'N', '31221025534', 'TD7 ');
INSERT INTO BanThang (MaBT, LoaiBT, MSSV, MaTD) VALUES ('BT21', 'N', '31231025912', 'TD7 ');
INSERT INTO BanThang (MaBT, LoaiBT, MSSV, MaTD) VALUES ('BT22', 'N', '31221021204', 'TD8 ');
INSERT INTO BanThang (MaBT, LoaiBT, MSSV, MaTD) VALUES ('BT23', 'N', '31221024608', 'TD10 ');
INSERT INTO BanThang (MaBT, LoaiBT, MSSV, MaTD) VALUES ('BT24', 'N', '31221025534', 'TD10 ');
INSERT INTO BanThang (MaBT, LoaiBT, MSSV, MaTD) VALUES ('BT25', 'N', '31231024819', 'TD11 ');
INSERT INTO BanThang (MaBT, LoaiBT, MSSV, MaTD) VALUES ('BT26', 'N', '31231027358', 'TD11 ');
INSERT INTO BanThang (MaBT, LoaiBT, MSSV, MaTD) VALUES ('BT27', 'N', '31221022206', 'TD12 ');
INSERT INTO BanThang (MaBT, LoaiBT, MSSV, MaTD) VALUES ('BT28', 'P', '31231026429', 'TD12 ');
INSERT INTO BanThang (MaBT, LoaiBT, MSSV, MaTD) VALUES ('BT29', 'N', '31221024364', 'TD13 ');
INSERT INTO BanThang (MaBT, LoaiBT, MSSV, MaTD) VALUES ('BT30', 'N', '31231025912', 'TD13 ');
INSERT INTO BanThang (MaBT, LoaiBT, MSSV, MaTD) VALUES ('BT31', 'O', '31231023073', 'TD13 ');
INSERT INTO BanThang (MaBT, LoaiBT, MSSV, MaTD) VALUES ('BT32', 'N', '31221026655', 'TD13 ');
INSERT INTO BanThang (MaBT, LoaiBT, MSSV, MaTD) VALUES ('BT33', 'N', '31201022509', 'TD14 ');
INSERT INTO BanThang (MaBT, LoaiBT, MSSV, MaTD) VALUES ('BT34', 'N', '31221022728', 'TD14 ');
INSERT INTO BanThang (MaBT, LoaiBT, MSSV, MaTD) VALUES ('BT35', 'P', '31221020695', 'TD15 ');
INSERT INTO BanThang (MaBT, LoaiBT, MSSV, MaTD) VALUES ('BT36', 'N', '31221021204', 'TD15 ');
INSERT INTO BanThang (MaBT, LoaiBT, MSSV, MaTD) VALUES ('BT37', 'N', '31231024819', 'TD15 ');
INSERT INTO BanThang (MaBT, LoaiBT, MSSV, MaTD) VALUES ('BT38', 'N', '31231027358', 'TD15 ');
INSERT INTO BanThang (MaBT, LoaiBT, MSSV, MaTD) VALUES ('BT39', 'N', '31221021005', 'TD16 ');
INSERT INTO BanThang (MaBT, LoaiBT, MSSV, MaTD) VALUES ('BT40', 'N', '31231024819', 'TD16 ');
INSERT INTO BanThang (MaBT, LoaiBT, MSSV, MaTD) VALUES ('BT41', 'N', '31221024364', 'TD16');

