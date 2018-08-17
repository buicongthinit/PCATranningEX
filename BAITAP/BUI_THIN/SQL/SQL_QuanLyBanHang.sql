IF NOT EXISTS(SELECT * FROM sys.databases WHERE name = 'QuanLyBanHang')
BEGIN
    CREATE DATABASE QuanLyBanHang
    ON PRIMARY
    (
        NAME = 'QuanLyBanHang',
        FILENAME = 'D:\PCA\CSDL SQL\QuanLyBanHang.mdf',
        size = 5,
        maxsize = 50,
        FILEGROWTH = 5
    )
END

use QuanLyBanHang


CREATE TABLE VatTu
(
    MaVatTu varchar(10) NOT NULL,
    TenVatTu NVARCHAR(255) NOT NULL,
    DonViTinh varchar(10) NOT NULL,
    TiLePhanTram int NOT NULL,
    CONSTRAINT PK_VatTu PRIMARY KEY(MaVatTu)
)

CREATE TABLE NhaCungCap
(
    MaNCC VARCHAR(10) NOT NULL,
    TenNCC NVARCHAR(255) NOT NULL,
    DiaChi NVARCHAR(255) NOT NULL,
    DienThoai INT NOT NULL,
    CONSTRAINT PK_NhaCungCap PRIMARY KEY(MaNCC)
)

CREATE TABLE DonDatHang
(
    MaDDH VARCHAR(10) NOT NULL,
    NgayDat DATE NOT NULL,
    MaNCC VARCHAR(10) NOT NULL,
    CONSTRAINT PK_DonDatHang PRIMARY KEY(MaDDH),
    CONSTRAINT FK_DonDatHang FOREIGN KEY(MaNCC) REFERENCES NhaCungCap(MaNCC)
)

CREATE TABLE ChiTietDonHang
(
    MaDDH VARCHAR(10) NOT NULL,
    MaVatTu VARCHAR(10) NOT NULL,
    SoLuong int NOT NULL,
    CONSTRAINT PK_ChiTietDonDatHang PRIMARY KEY(MaDDH, MaVatTu),
    CONSTRAINT FK_ChiTetDonDatHang1 FOREIGN KEY(MaDDH) REFERENCES DonDatHang(MaDDH),
    CONSTRAINT FK_ChiTietDonDatHang2 FOREIGN KEY(MaVatTu) REFERENCES VatTu(MaVatTu)
)

CREATE TABLE PhieuNhapHang
(
    MaSoPhieuNhap VARCHAR(10) NOT NULL,
    NgayNhap DATE NOT NULL,
    MaDDH VARCHAR(10) NOT NULL,
    CONSTRAINT PK_PhieuNhapHang PRIMARY KEY(MaSoPhieuNhap),
    CONSTRAINT FK_PhieuNhapHang FOREIGN KEY(MaDDH) REFERENCES DonDatHang(MaDDH)
)

CREATE TABLE ChiTietPhieuNhap
(
    MaSoPhieuNhap VARCHAR(10) NOT NULL,
    MaVatTu VARCHAR(10) NOT NULL,
    SoLuongNhap int NOT NULL,
    DonGia INT not NULL,
    CONSTRAINT PK_ChiTietPhieuNhap PRIMARY KEY(MaSoPhieuNhap, MaVatTu),
    CONSTRAINT FK_ChiTietPhieuNhap1 FOREIGN KEY(MaSoPhieuNhap) REFERENCES PhieuNhapHang(MaSoPhieuNhap),
    CONSTRAINT FK_ChiTietPhieuNhap2 FOREIGN KEY(MaVatTu) REFERENCES VatTu(MaVatTu)
)

CREATE TABLE PhieuXuatHang
(
    MaSoPhieuXuat VARCHAR(10) NOT NULL,
    NgayXuat DATE not null,
    TenKhachHang NVARCHAR(30) NOT NULL,
    CONSTRAINT PK_PhieuXuatHang PRIMARY KEY(MaSoPhieuXuat), 
)

CREATE TABLE ChiTietPhieuXuat
(
    MaSoPhieuXuat VARCHAR(10) NOT NULL,
    MaVatTu VARCHAR(10) NOT NULL,
    SoLuongXuat INT NOT NULL,
    DonGia int not null,
    CONSTRAINT PK_ChiTietPhieuXuat PRIMARY KEY(MaSoPhieuXuat, MaVatTu),
    CONSTRAINT FK_ChiTietPhieuXuat1 FOREIGN KEY(MaSoPhieuXuat) REFERENCES PhieuXuatHang(MaSoPhieuXuat),
    CONSTRAINT FK_ChiTietPhieuXuat2 FOREIGN KEY(MaVatTu) REFERENCES VatTu(MaVatTu)
)


--Thêm dữ liệu vào bảng--
INSERT INTO VatTu VALUES('VT01', N'Vật tư số 1', 'kg', '99')
INSERT INTO VatTu VALUES('VT02', N'Vật tư số 2', 'cai', '96')
INSERT INTO VatTu VALUES('VT03', N'Vật tư số 3', 'chiec', '29')
INSERT INTO VatTu VALUES('VT04', N'Vật tư số 4', 'goi', '26')
INSERT INTO VatTu VALUES('VT05', N'Vật tư số 5', 'kg', '90')
INSERT INTO VatTu VALUES('VT06', N'Tê Tê', 'con', '66')
INSERT INTO VatTu VALUES('VT07', N'Tắc', 'qua', '120')
SELECT * FROM VatTu

INSERT INTO NhaCungCap VALUES('NCC01', N'Nhà cung cấp số 1', N'Yên Hòa, Cầu Giấy', 0224221223)
INSERT INTO NhaCungCap VALUES('NCC02', N'Nhà cung cấp số 2', N'Trung Hòa, Cầu Giấy', 0224463223)
INSERT INTO NhaCungCap VALUES('NCC03', N'Nhà cung cấp số 3', N'Yên Hòa, Cầu Giấy', 0224221313)
INSERT INTO NhaCungCap VALUES('NCC04', N'Nhà cung cấp số 4', N'Nhân Hòa, Cầu Giấy', 0224285923)
INSERT INTO NhaCungCap VALUES('NCC05', N'Nhà cung cấp số 5', N'Thái Hòa, Cầu Giấy', 0224232123)
SELECT * FROM NhaCungCap

set dateformat dmy
INSERT INTO DonDatHang VALUES('DDH01', '02/12/2018', 'NCC02')
INSERT INTO DonDatHang VALUES('DDH02', '11/02/2018', 'NCC03')
INSERT INTO DonDatHang VALUES('DDH03', '12/12/2018', 'NCC05')
INSERT INTO DonDatHang VALUES('DDH04', '22/11/2018', 'NCC02')
INSERT INTO DonDatHang VALUES('DDH05', '06/12/2018', 'NCC01')
UPDATE DonDatHang SET NgayDat = '25/06/2018' WHERE MaDDH = 'DDH03'
UPDATE DonDatHang SET NgayDat = '11/05/2017' WHERE MaDDH = 'DDH05'
SELECT * FROM DonDatHang
--In ra tháng và năm đặt hàng--
SELECT MONTH(NgayDat) [Tháng], YEAR(NgayDat) [Năm] FROM DonDatHang
--In ra Ngày Đặt theo định dạng dd/mm/yyyy (103)--
SELECT CONVERT([varchar], NgayDat, 103) from DonDatHang

INSERT INTO ChiTietDonHang VALUES('DDH01', 'VT02', 780)
INSERT INTO ChiTietDonHang VALUES('DDH02', 'VT03', 150)
INSERT INTO ChiTietDonHang VALUES('DDH02', 'VT01', 190)
INSERT INTO ChiTietDonHang VALUES('DDH03', 'VT04', 90)
INSERT INTO ChiTietDonHang VALUES('DDH03', 'VT05', 900)
INSERT INTO ChiTietDonHang VALUES('DDH04', 'VT02', 99)
INSERT INTO ChiTietDonHang VALUES('DDH05', 'VT05', 270)
SELECT * FROM ChiTietDonHang

SET DATEFORMAT DMY
INSERT INTO PhieuNhapHang VALUES('PN01', '12/12/2017', 'DDH03')
INSERT INTO PhieuNhapHang VALUES('PN02', '02/11/2017', 'DDH04')
INSERT INTO PhieuNhapHang VALUES('PN03', '18/05/2017', 'DDH03')
INSERT INTO PhieuNhapHang VALUES('PN04', '16/02/2017', 'DDH01')
INSERT INTO PhieuNhapHang VALUES('PN05', '22/12/2017', 'DDH02')
INSERT INTO PhieuNhapHang VALUES('PN06', '21/09/2018', 'DDH05')
SELECT * FROM PhieuNhapHang
SELECT CONVERT([varchar], NgayNhap, 103) FROM PhieuNhapHang

INSERT INTO ChiTietPhieuNhap VALUES('PN01', 'VT04', 131, 205000)
INSERT INTO ChiTietPhieuNhap VALUES('PN02', 'VT01', 123, 315000)
INSERT INTO ChiTietPhieuNhap VALUES('PN02', 'VT03', 150, 300000)
INSERT INTO ChiTietPhieuNhap VALUES('PN02', 'VT05', 269, 198000)
INSERT INTO ChiTietPhieuNhap VALUES('PN03', 'VT04', 193, 200000)
INSERT INTO ChiTietPhieuNhap VALUES('PN03', 'VT05', 623, 500000)
INSERT INTO ChiTietPhieuNhap VALUES('PN04', 'VT02', 99, 20000)
SELECT * FROM ChiTietPhieuNhap

INSERT INTO PhieuXuatHang VALUES('PX01', '22/02/2018', N'Khách hàng 01')
INSERT INTO PhieuXuatHang VALUES('PX02', '12/05/2018', N'Khách hàng 03')
INSERT INTO PhieuXuatHang VALUES('PX03', '19/02/2018', N'Khách hàng 02')
INSERT INTO PhieuXuatHang VALUES('PX04', '18/07/2018', N'Khách hàng 05')
INSERT INTO PhieuXuatHang VALUES('PX05', '21/03/2018', N'Khách hàng 03')
SELECT * FROM PhieuXuatHang

INSERT INTO ChiTietPhieuXuat VALUES('PX03', 'VT02', 70, 200000)
INSERT INTO ChiTietPhieuXuat VALUES('PX04', 'VT01', 27, 200000)
INSERT INTO ChiTietPhieuXuat VALUES('PX01', 'VT03', 22, 200000)
INSERT INTO ChiTietPhieuXuat VALUES('PX03', 'VT05', 12, 200000)
INSERT INTO ChiTietPhieuXuat VALUES('PX02', 'VT05', 32, 200000)
INSERT INTO ChiTietPhieuXuat VALUES('PX05', 'VT03', 93, 190000)
SELECT * FROM ChiTietPhieuXuat
DELETE FROM ChiTietPhieuXuat WHERE MaSoPhieuXuat = 'PX04' AND MaVatTu = 'VT06'

--Câu 6: Lấy ra danh sách những đơn đặt hàng từ tháng 1/2018 đến tháng 6/2018--
--Cách 1--
SELECT * FROM DonDatHang
WHERE (Month(NgayDat) BETWEEN 1 AND 6) AND YEAR(NgayDat) = 2018
-- Cách 2--
SELECT * FROM DonDatHang
WHERE MONTH(NgayDat) >= 1 AND MONTH(NgayDat) <=6 AND YEAR(NgayDat) = 2018
--Lấy ra danh sách những đơn đặt hàng từ 1/1/2018 đến 1/6/2018--
SELECT * FROM DonDatHang
WHERE NgayDat BETWEEN '1/1/2018' AND '1/6/2018'

--Thống kê số lượng mặt hàng (số loại mặt hàng) mà công ty đã đặt theo nhà cung cấp muốn tìm kiếm--
SELECT ncc.TenNCC [Tên nhà cung cấp], COUNT(MaVatTu) [Số loại mặt hàng]
FROM (NhaCungCap ncc INNER JOIN DonDatHang ddh ON ncc.MaNCC = ddh.MaNCC)
    INNER JOIN ChiTietDonHang ctdh ON ddh.MaDDH = ctdh.MaDDH
    WHERE ncc.MaNCC = 'NCC03'
GROUP BY ncc.TenNCC

--Thống kê tổng số lượng hàng hóa (theo từng loại mặt hàng) thực tế mà công ty đã nhập theo nhà cung cấp--
SELECT ncc.TenNCC [Tên nhà cung cấp], SUM(SoLuongNhap) [Số lượng hàng đã nhập]
FROM (NhaCungCap ncc INNER JOIN DonDatHang ddh ON ncc.MaNCC = ddh.MaNCC)
    INNER JOIN PhieuNhapHang pnh on pnh.MaDDH = ddh.MaDDH
    INNER JOIN ChiTietPhieuNhap ctpn on ctpn.MaSoPhieuNhap = pnh.MaSoPhieuNhap
    -- WHERE ncc.MaNCC = 'NCC02'
GROUP BY ncc.TenNCC

--Thống kê tổng số lượng vật tư đã xuất theo từng mã vật tư--
SELECT TenVatTu, SUM(SoLuongXuat) [Số lượng xuất]
FROM VatTu INNER JOIN ChiTietPhieuXuat ctpx on ctpx.MaVatTu = VatTu.MaVatTu
GROUP BY TenVatTu


/*                                          */
/*           EX2 - 09/08/2018               */

--Câu 6: Kiểm tra xem mặt hàng nào được đặt nhiều nhất  --
--Cách 1: Sắp xếp bảng dựa theo tổng số lượng giảm dần rồi lấy ra bản ghi đầu tiên--
SELECT TOP 1 VatTu.MaVatTu, TenVatTu, SUM(SoLuong)[Số lượng] 
FROM ChiTietDonHang INNER JOIN VatTu ON VatTu.MaVatTu = ChiTietDonHang.MaVatTu
GROUP BY VatTu.MaVatTu, TenVatTu
ORDER BY SUM(SoLuonG) DESC
/*Cách 2: Tạo ra 1 bảng tạm có tên là BangTam lưu trữ mã vật tư kèm tổng số lượng của vật tư đó.
Sau đó sử dụng hàm MAX để lấy ra giá trị 'tổng số lượng' lớn nhất*/
SELECT MAX(TongSoLuong)[Số lượng] from
(
SELECT MaVatTu, SUM(SoLuong) AS [TongSoLuong] from ChiTietDonHang
GROUP BY MaVatTu
) AS BangTam

--Câu 7: Tìm tất cả các mặt hàng bắt đầu bằng chữ T--
SELECT * FROM VatTu
WHERE TenVatTu Like 'T%'


--Câu 8: Thống kê các mặt hàng mà có tổng số lượng đặt hàng nhiều hơn 1000--
--Cách 1: Nhóm theo TênVậtTư rồi đếm tổng số lượng. Sau đó dùng Having để lọc kết quả--
SELECT TenVatTu, SUM(SoLuong)[Tổng số lượng]
FROM VatTu INNER JOIN ChiTietDonHang ON VatTu.MaVatTu = ChiTietDonHang.MaVatTu
GROUP BY TenVatTu
HAVING SUM(SoLuong) > 1000
--Cách 2: Tạo ra 1 bảng tạm để lưu tổng số lượng theo Mã vật tư. Sau đó dùng Where để lọc kết quả--
SELECT MaVatTu, BangTam.tong [Tổng số lượng]
FROM (
    SELECT MaVatTu, SUM(SoLuong) AS [tong] FROM ChiTietDonHang
    GROUP BY MaVatTu
) AS BangTam
WHERE tong > 1000


--Câu 9: Tìm tất cả các mặt hàng đã nhập về nhưng chưa xuất--
SELECT DISTINCT VatTu.MaVatTu, TenVatTu
FROM ChiTietPhieuNhap INNER JOIN VatTu on VatTu.MaVatTu = ChiTietPhieuNhap.MaVatTu
WHERE ChiTietPhieuNhap.MaVatTu NOT IN
(
    SELECT MaVatTu FROM ChiTietPhieuXuat
)


--Câu 10: Tìm tất cả các mặt hàng đã nhập về và đã xuất--
SELECT DISTINCT VatTu.MaVatTu, TenVatTu
FROM ChiTietPhieuNhap INNER JOIN VatTu on VatTu.MaVatTu = ChiTietPhieuNhap.MaVatTu
WHERE ChiTietPhieuNhap.MaVatTu IN
(
    SELECT MaVatTu FROM ChiTietPhieuXuat
)


                /*                                      */
                /*           EXP 10/08/2018             */
--Câu 11: Tạo bảng TonKho--
CREATE TABLE TonKho
(
    ID int PRIMARY key,
    NamThang VARCHAR(255) not null,
    MaVatTu VARCHAR(10) not null UNIQUE,
    SLDau int not null,
    TongSLNhap INT not null,
    TongSLXuat int not null,
    SLCuoi INT NOT NULL,
    CONSTRAINT FK_TonKho FOREIGN KEY(MaVatTu) REFERENCES VatTu(MaVatTu)
)
drop TABLE TonKho
--Câu 12: Đặt điều kiện ràng buộc giá trị ngày tháng nhập vào lớn hơn 1/1/1999 và nhỏ hơn 31/12/2999--
    --Bước 1: Đổi kiểu dữ liệu cho trường NamThang về kiểu date--
    ALTER TABLE TonKho ALTER COLUMN NamThang date
    --Bước 2: Thiết lập ràng buộc nhập vào cho trường NamThang bằng ràng buộc CHECK--
    ALTER TABLE TonKho ADD CONSTRAINT chk_NamThang CHECK(NamThang > '01/01/1999' AND NamThang < '31/12/2999')
    --    ALTER TABLE TonKho DROP CONSTRAINT chk_NamThang
    set dateformat dmy
    INSERT INTO TonKho VALUES(1, '10/08/2018', 'VT01', 30, 130, 70, 0)
    INSERT INTO TonKho VALUES(2, '21/09/2018', 'VT02', 110, 20, 90, 0)
    INSERT INTO TonKho VALUES(3, '02/07/2017', 'VT03', 130, 50, 110, 0)
    UPDATE TonKho SET SLCuoi = SLDau + TongSLNhap - TongSLXuat
    select * from TonKho
--Đặt điều kiện ràng buộc giá trị nhập vào cho các trường số lượng lớn hơn 0--
    ALTER TABLE TonKho ADD CONSTRAINT chk_SL CHECK(SLDau >= 0 AND TongSLNhap >= 0 AND TongSLXuat >= 0 AND SLCuoi >= 0)  
--Câu 13: Truy vấn danh sách các phiếu đặt hàng nhưng chưa được nhập hàng--
SELECT * FROM DonDatHang
WHERE MaDDH NOT IN
(
    SELECT MaDDH FROM PhieuNhapHang
)
--Câu 14: Lấy thông tin nhà cung cấp có nhiều đơn đặt hàng nhất--
SELECT TOP 1 NhaCungCap.MaNCC, TenNCC, DiaChi, COUNT(MaDDH) [Số lượng đơn đặt hàng]
FROM NhaCungCap INNER JOIN DonDatHang ON NhaCungCap.MaNCC = DonDatHang.MaNCC
GROUP BY NhaCungCap.MaNCC, TenNCC, DiaChi
ORDER BY COUNT(MaDDH) DESC
--Câu 15: Lấy thông tin vật tư được xuất bán nhiều nhất--
SELECT TOP 10 VatTu.MaVatTu, TenVatTu, SUM(SoLuongXuat)[Tổng số lượng xuất]
FROM VatTu INNER JOIN ChiTietPhieuXuat ON VatTu.MaVatTu = ChiTietPhieuXuat.MaVatTu
GROUP BY VatTu.MaVatTu, TenVatTu
ORDER BY SUM(SoLuongXuat) DESC
--Câu 16: Tính tổng tiền của các đơn đặt hàng, đưa ra đơn đặt hàng có giá trị lớn nhất--
SELECT TOP 10 MaDDH,ChiTietDonHang.MaVatTu ,SUM(SoLuongNhap*DonGia) [Tổng tiền]
FROM ChiTietPhieuNhap INNER JOIN ChiTietDonHang ON ChiTietDonHang.MaVatTu = ChiTietPhieuNhap.MaVatTu
GROUP BY MaDDH, ChiTietDonHang.MaVatTu
ORDER BY SUM(SoLuongNhap*DonGia) DESC


SELECT TOP 1 MaDDH from ChiTietDonHang
WHERE MaVatTu IN
(
    select TOP 1 MaVatTu from ChiTietPhieuNhap
    GROUP by MaVatTu
    ORDER by SUM(SoLuongNhap*DonGia) DESC
)

--Câu 17: Thống kê những đơn đặt hàng nhập chưa đủ số lượng--
SELECT DISTINCT MaDDH, ChiTietDonHang.MaVatTu, (SoLuong) [Số lượng hàng đặt], (SoLuongNhap) [Số lượng hàng nhập về]
FROM ChiTietDonHang INNER JOIN ChiTietPhieuNhap ON ChiTietDonHang.MaVatTu = ChiTietPhieuNhap.MaVatTu
WHERE SoLuong > SoLuongNhap
-- GROUP BY MaDDH, ChiTietDonHang.MaVatTu, SoLuong, SoLuongNhap


/*  View - Bài tập ngày 13/08/2018    */
--Câu 18: Tạo View vw_DMVT gồm Mã vật tư và Tên vật tư dùng liệt kê sanh sách trong bảng vật tư--
CREATE VIEW vw_DMVT AS
SELECT MaVatTu, TenVatTu FROM VatTu
WITH CHECK OPTION
SELECT * FROM vw_DMVT
/*Câu 19: Tao View vw_DonDH_TongSLDatNhap gồmm Mã hóa đơn, Số lượng đặt, Tổng số lượng nhập
dùng để thống kê những đơn đặt hàng đã được nhập hàng đầy đủ*/
CREATE VIEW vw_DonDH_TongSLDatNhap AS
SELECT MaDDH, SoLuong, SoLuongNhap FROM ChiTietDonHang INNER JOIN ChiTietPhieuNhap ON ChiTietDonHang.MaVatTu = ChiTietPhieuNhap.MaVatTu
WHERE SoLuongNhap = SoLuong
-- DROP VIEW vw_DonDH_TongSLDatNhap
SELECT * FROM vw_DonDH_TongSLDatNhap
/*Câu 20: Tạo View vw_DonDH_DaNhapDu gồm (Số DH, DaNhapDu) có hai giá trị là 
- “Da Nhap Du” nếu đơn hàng đó đã nhập đủ.
- “Chua Nhap Du” nếu đơn đặt hàng chưa nhập đủ*/
CREATE VIEW vw_DonDH_DaNhapDu AS
SELECT DISTINCT MaDDH, ChiTietDonHang.MaVatTu, CASE
WHEN SoLuong = SoLuongNhap THEN N'Đã nhập đủ'
ELSE N'Chưa nhập đủ'
END
AS [Tình trạng]
FROM ChiTietDonHang INNER JOIN ChiTietPhieuNhap ON ChiTietDonHang.MaVatTu = ChiTietPhieuNhap.MaVatTu

SELECT * FROM vw_DonDH_DaNhapDu

/*Câu 21: Tạo View vw_TongNhap gồm (NamThang, MaVTu và TongSLNhap) 
dùng để thống kê số lượng nhập của các vật tư trong năm tháng tương ứng (Không sử dụng bảng tồn kho)*/
--Cách 1: Sử dụng CAST để chuyển đổi kiểu dữ liệu--
CREATE VIEW vw_TongNhap1 AS
SELECT CAST(MONTH(NgayNhap) AS varchar)+'/'+CAST(YEAR(NgayNhap) AS VARCHAR) AS [Thời gian], MaVatTu [Mã vật tư], SUM(SoLuongNhap) [Tổng số lượng nhập] FROM ChiTietPhieuNhap INNER JOIN PhieuNhapHang ON ChiTietPhieuNhap.MaSoPhieuNhap = PhieuNhapHang.MaSoPhieuNhap
WHERE MONTH(NgayNhap) = '12' AND YEAR(NgayNhap) = '2017'
GROUP BY MONTH(NgayNhap), YEAR(NgayNhap), MaVatTu

SELECT * FROM vw_TongNhap1
--Cách 2: Sử dụng CONCAT để nối Tháng và Năm--
CREATE VIEW vw_TongNhap2 AS
SELECT CONCAT(MONTH(NgayNhap),'/',YEAR(NgayNhap)) AS [Thời gian],MaVatTu [Mã vật tư] ,SUM(SoLuongNhap) [Tổng số lượng nhập] 
FROM ChiTietPhieuNhap INNER JOIN PhieuNhapHang ON ChiTietPhieuNhap.MaSoPhieuNhap = PhieuNhapHang.MaSoPhieuNhap
WHERE MONTH(NgayNhap) = '12' AND YEAR(NgayNhap) = '2017'
GROUP BY MONTH(NgayNhap), YEAR(NgayNhap), MaVatTu

SELECT * from vw_TongNhap2
/*Câu 22: Tạo View vw_TongXuat gồm (NamThang, MaVTu và TongSLXuat) 
dùng để thống kê SL xuất của vật tư trong từng năm tương ứng (Không sử dụng bảng tồn kho)*/
CREATE VIEW vw_TongXuat AS
SELECT CONCAT(MONTH(NgayXuat), '/', YEAR(NgayXuat)) [Thời gian], MaVatTu [Mã vật tư], SUM(SoLuongXuat) [Tổng số lượng]
FROM PhieuXuatHang INNER JOIN ChiTietPhieuXuat ON PhieuXuatHang.MaSoPhieuXuat = ChiTietPhieuXuat.MaSoPhieuXuat
WHERE MONTH(NgayXuat) = '2' AND YEAR(NgayXuat) = '2018'
GROUP BY MONTH(NgayXuat), YEAR(NgayXuat), MaVatTu

SELECT * FROM vw_TongXuat

/*                  15/08/2018                  */
--Câu 23. Tạo Stored procedure (SP) cho biết tổng số lượng cuối của vật tư với mã vật tư là tham số vào--
CREATE PROCEDURE sp_SoLuongCuoi_TonKho @MaVT VARCHAR(10)
AS
SELECT SLCuoi FROM TonKho WHERE MaVatTu = @MaVT

EXEC sp_SoLuongCuoi_TonKho @MaVT = 'VT01'
--Câu 24. Tạo SP cho biết tổng tiền xuất của vật tư với mã vật tư là tham số vào--
CREATE PROCEDURE sp_TongTienXuat_ChiTietPhieuXuat @MaVT VARCHAR(10)
AS
SELECT MaVatTu, SUM(SoLuongXuat*DonGia)[Tổng tiền xuất] FROM ChiTietPhieuXuat
WHERE MaVatTu = @MaVT
GROUP BY MaVatTu

EXEC sp_TongTienXuat_ChiTietPhieuXuat @MaVT = 'VT03'
--Câu 25. Tạo SP cho biết tổng số lượng đặt theo số đơn hàng với số đơn hàng là tham số vào--
CREATE PROCEDURE sp_TongSLDat_ChiTietDonHang @MaDDH VARCHAR(255)
AS
SELECT MaDDH, SUM(SoLuong) FROM ChiTietDonHang
WHERE MaDDH = @MaDDH
GROUP BY MaDDH

EXEC sp_TongSLDat_ChiTietDonHang 'DDH03'
--Câu 26. Tạo SP dùng để thêm một đơn đặt hàng--
ALTER PROCEDURE sp_Them_DonDatHang 
    @MaDDH VARCHAR(10),
    @NgayDat date,
    @MaNCC VARCHAR(10)
AS 
INSERT INTO DonDatHang(MaDDH, NgayDat, MaNCC) VALUES(@MaDDH, @NgayDat, @MaNCC)

sp_Them_DonDatHang 'DDH07','21/01/2018','NCC05'
SELECT * FROM DonDatHang
--Câu 27. Tạo SP dùng để thêm một chi tiết đơn đặt hàng--
CREATE PROCEDURE sp_Them_ChiTietDonHang
    @MaDDH VARCHAR(10),
    @MaVT VARCHAR(10),
    @SL INT
AS
INSERT INTO ChiTietDonHang VALUES(@MaDDH, @MaVT, @SL)

EXEC sp_Them_ChiTietDonHang @MaDDH = 'DDH05', @MaVT = 'VT02', @SL = '60'
EXEC sp_Them_ChiTietDonHang 'DDH06', 'VT06', 191
SELECT * FROM ChiTietDonHang
--Câu 28. Tạo trigger kiểm soát quá trình thêm dữ liệu vào bảng vật tư, đưa ra thông báo khi số lượng vật tư vượt quá 100 sp--

--Cách 1: Sử dụng AFTER INSERT--
CREATE TRIGGER trg_Them_VatTu on VatTu
AFTER INSERT
AS
BEGIN
    DECLARE @a int, @b int, @dem int;
    SELECT @a= COUNT(*) FROM inserted
    SELECT @b = COUNT(*) FROM VatTu
    SET @dem = @a + @b - 1
    IF @dem > 10
    BEGIN
        ROLLBACK TRANSACTION
        RAISERROR('Số lượng vật tư không vượt quá 10 sản phẩm', 16, 1)
    END
END

--Cách 2: Sử dụng FOR INSERT--
ALTER TRIGGER trg_Them1_VatTu on VatTu
FOR INSERT
AS
BEGIN
    IF(SELECT COUNT(*) FROM VatTu) > 10
    BEGIN
        PRINT N'Không thể thêm bản ghi'
        ROLLBACK
    END
END

INSERT INTO VatTu VALUES('VT08', N'Vật tư số 8', 'cai', '99')
INSERT INTO VatTu VALUES('VT09', N'Vật tư số 9', 'con', '96')
INSERT INTO VatTu VALUES('VT10', N'Vật tư số 10', 'kg', '100')
INSERT INTO VatTu VALUES('VT11', N'Vật tư số 11', 'chiec', '89')
INSERT INTO VatTu VALUES('VT12', N'Vật tư số 12', 'chiec', '87')
INSERT INTO VatTu VALUES('VT13', N'Vật tư số 13', 'chiec', '76')
INSERT INTO VatTu VALUES('VT14', N'Vật tư số 14', 'chiec', '69')
INSERT INTO VatTu VALUES('VT15', N'Vật tư số 15', 'chiec', '97')
INSERT INTO VatTu VALUES('VT16', N'Vật tư số 16', 'chiec', '79')
DELETE FROM VatTu WHERE MaVatTu = 'VT08'
DELETE FROM VatTu WHERE MaVatTu = 'VT09'
DELETE FROM VatTu WHERE MaVatTu = 'VT10'
DELETE FROM VatTu WHERE MaVatTu = 'VT11'
DELETE FROM VatTu WHERE MaVatTu = 'VT12'
DELETE FROM VatTu WHERE MaVatTu = 'VT13'
DELETE FROM VatTu WHERE MaVatTu = 'VT14'
DELETE FROM VatTu WHERE MaVatTu = 'VT15'
DELETE FROM VatTu WHERE MaVatTu = 'VT16'

SELECT * FROM VatTu

/*Câu 29: Thêm cột thành tiền  cho bảng Chi tiết phiếu nhập.
 viết hàm tính thành tiền với biến đầu vào là đơn giá và số lượng.
 Tạo trigger cho phép tự động tính thành tiền trong bảng Chi tiết phiếu nhập mỗi khi có 1 bảng ghi mới được thêm vào*/
 --Thêm cột ThanhTien cho bảng Chi tiết phiếu nhập--
 ALTER TABLE ChiTietPhieuNhap ADD ThanhTien int 
 SELECT * from ChiTietPhieuNhap
--Viết hàm tính thành tiền với biến đầu vào là đơn giá và số lượng--
CREATE FUNCTION fn_ThanhTien_ChiTietPhieuNhap(@SL int, @DG int)
RETURNS int AS
BEGIN
DECLARE @TT INT
SET @TT = @SL * @DG
RETURN @TT
END
SELECT dbo.fn_ThanhTien_ChiTietPhieuNhap(5,10)
--Tạo trigger cho phép tự động tính thành tiền trong bảng Chi tiết phiếu nhập mỗi khi có 1 bảng ghi mới được thêm vào--
ALTER TRIGGER trg_ThanhTien_ChiTietPhieuNhap ON ChiTietPhieuNhap
AFTER INSERT
AS
BEGIN
    DECLARE @SL int, @DG int, @TT INT, @MPN VARCHAR(10), @MVT VARCHAR(10)
    SELECT @MPN = MaSoPhieuNhap FROM inserted
    SELECT @MVT = MaVatTu FROM inserted
    SELECT @SL = SoLuongNhap FROM inserted
    SELECT @DG = DonGia FROM inserted
    -- SET @TT = @SL * @DG
    -- PRINT(@TT)
    UPDATE ChiTietPhieuNhap SET ThanhTien = dbo.fn_ThanhTien_ChiTietPhieuNhap(@SL, @DG) 
    WHERE MaSoPhieuNhap = @MPN AND MaVatTu = @MVT
END

INSERT INTO ChiTietPhieuNhap(MaSoPhieuNhap, MaVatTu, SoLuongNhap, DonGia) VALUES('PN02', 'VT03', 100, 10000)
SELECT * FROM ChiTietPhieuNhap
/*Câu 30: Thêm cột tinhtrang (tình trạng) vào bảng Vattu (quy định 0 = “hết hàng’, 1=”còn hàng”).
 Viết thủ tục kiểm tra trạng thái của các vật tư hiện đang có*/
--Thêm cột TinhTrang vào bảng VậtTư--
ALTER TABLE VatTu ADD TinhTrang Bit
update VatTu set TinhTrang = 0 WHERE MaVatTu = 'VT01'
SELECT * FROM VatTu
--Viết thủ tục kiểm tra trạng thái của các vật tư hiện đang có trong bảng VậtTư--
ALTER PROCEDURE sp_Check_VatTu AS
BEGIN
    SELECT MaVatTu, CASE
    WHEN TinhTrang = 0 THEN N'Hết hàng'
    ELSE N'Còn hàng'
    END
    AS [Tình trạng]
    FROM VatTu
END

sp_Check_VatTu
 /*Câu 31: Viết trigger cho phép tự động cập nhật trạng thái của vật tư mỗi khi có sự thay đổi nhập hoặc xuất.*/
CREATE TRIGGER trg_Update_Stt_VatTu ON ChiTietPhieuNhap
FOR INSERT, UPDATE
AS
BEGIN
    DECLARE @SLN int, @SLX INT
    SELECT @SLN = SUM(ChiTietPhieuNhap.SoLuongNhap) FROM ChiTietPhieuNhap INNER JOIN inserted i ON i.MaVatTu = ChiTietPhieuNhap.MaVatTu
    SELECT @SLX = SUM(ChiTietPhieuXuat.SoLuongXuat) FROM ChiTietPhieuXuat INNER JOIN inserted i ON i.MaVatTu = ChiTietPhieuXuat.MaVatTu
    IF(@SLN > @SLX)
    UPDATE VatTu
        SET TinhTrang = 1
        FROM inserted
        WHERE VatTu.MaVatTu = inserted.MaVatTu
    ELSE
    UPDATE VatTu 
        SET TinhTrang = 0
        FROM inserted
        WHERE VatTu.MaVatTu = inserted.MaVatTu
END

INSERT INTO ChiTietPhieuNhap(MaSoPhieuNhap, MaVatTu, SoLuongNhap, DonGia) VALUES('PN05', 'VT10', 100000, 2000)
INSERT INTO ChiTietPhieuNhap(MaSoPhieuNhap, MaVatTu, SoLuongNhap, DonGia) VALUES('PN03', 'VT01', 1000, 1950)

SELECT * FROM VatTu
SELECT * FROM ChiTietPhieuNhap
SELECT * FROM ChiTietPhieuXuat

CREATE TRIGGER trg_Update_Stt_VatTu1 ON ChiTietPhieuXuat
FOR INSERT, UPDATE
AS
BEGIN
    DECLARE @SLN int, @SLX INT
    SELECT @SLN = SUM(ChiTietPhieuNhap.SoLuongNhap) FROM ChiTietPhieuNhap INNER JOIN inserted i ON i.MaVatTu = ChiTietPhieuNhap.MaVatTu
    SELECT @SLX = SUM(ChiTietPhieuXuat.SoLuongXuat) FROM ChiTietPhieuXuat INNER JOIN inserted i ON i.MaVatTu = ChiTietPhieuXuat.MaVatTu
    IF(@SLN > @SLX)
    UPDATE VatTu
        SET TinhTrang = 1
        FROM inserted
        WHERE VatTu.MaVatTu = inserted.MaVatTu
    ELSE
    UPDATE VatTu 
        SET TinhTrang = 0
        FROM inserted
        WHERE VatTu.MaVatTu = inserted.MaVatTu
END


-- SELECT * FROM sys.columns WHERE object_id = OBJECT_ID('dbo.VatTu')


 /*Câu 32: Viết thủ tục tính lượng hàng tồn kho hiện tại cho mỗi loại vật tư và áp dụng lên bảng vật tư*/
ALTER PROCEDURE sp_HangTonKho_Vattu AS
BEGIN
    DECLARE @TB TABLE(MaVTu VARCHAR(10), TongNhap INT, TongXuat INT)
    INSERT INTO @TB(MaVTu, TongNhap, TongXuat) 
    SELECT VatTu.MaVatTu, CASE 
    WHEN SUM(SoLuongNhap) IS NULL THEN 0
    ELSE SUM(SoLuongNhap)
    END, CASE 
    WHEN SUM(SoLuongXuat) IS NULL THEN 0
    ELSE SUM(SoLuongXuat)
    END
    from VatTu FULL join ChiTietPhieuNhap on VatTu.MaVatTu = ChiTietPhieuNhap.MaVatTu
    FULL JOIN ChiTietPhieuXuat ON ChiTietPhieuNhap.MaVatTu = ChiTietPhieuXuat.MaVatTu
    GROUP BY VatTu.MaVatTu
    UPDATE VatTu SET TinhTrang = 1 WHERE MaVatTu IN (SELECT MaVTu FROM @TB WHERE TongNhap > TongXuat)
    UPDATE VatTu SET TinhTrang = 0 WHERE MaVatTu IN (SELECT MaVTu FROM @TB WHERE TongNhap <= TongXuat)
    -- SELECT * FROM @TB
    SELECT * FROM VatTu
   EXEC sp_Check_VatTu
    --Hàng tồn kho = Tồn đầu kỳ + Số lượng nhập - Số lượng xuất--
END
sp_HangTonKho_Vattu
 /*Câu 33: Tạo trigger cho phép thay đổi số lượng tồn kho vật tư mỗi khi có sự thay đổi vể nhập xuất. 
 Đưa ra thông báo “Không Đủ Vật Tư Đề Xuất” trong trường hợp không đủ vật tư theo phiếu chi tiết xuất*/
--Trigger on ChiTietPhieuNhap--
CREATE TRIGGER trg_TonKho_Nhap ON ChiTietPhieuNhap
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
SET NOCOUNT ON;
    DECLARE @tb_TonKho TABLE(MVT VARCHAR(10), TN INT, TX INT)
    INSERT INTO @tb_TonKho(MVT, TN, TX)
    SELECT ChiTietPhieuXuat.MaVatTu,CASE 
    WHEN TongNhap IS NULL THEN 0
    ELSE TongNhap END,CASE 
    WHEN SUM(SoLuongXuat) IS NULL THEN 0
    ELSE SUM(SoLuongXuat) END
    FROM
    (SELECT MaVatTu, SUM(SoLuongNhap)[TongNhap]
    from ChiTietPhieuNhap
    GROUP BY MaVatTu) AS [tam] 
    INNER JOIN ChiTietPhieuXuat on tam.MaVatTu = ChiTietPhieuXuat.MaVatTu
    WHERE tam.MaVatTu in
    (SELECT MaVatTu FROM TonKho)
    GROUP BY ChiTietPhieuXuat.MaVatTu, TongNhap
 
IF EXISTS (SELECT * FROM inserted) AND NOT EXISTS(SELECT * FROM deleted)
BEGIN

    UPDATE TonKho SET
        TongSLNhap = TB.TN,
        TongSLXuat = TB.TX,
        SLCuoi = SLDau + TongSLNhap - TongSLXuat + inserted.SoLuongNhap
    FROM TonKho, @tb_TonKho TB, inserted
    WHERE TonKho.MaVatTu = TB.MVT AND inserted.MaVatTu = TonKho.MaVatTu
END
IF EXISTS (SELECT * FROM deleted) AND NOT EXISTS (SELECT * FROM inserted)
BEGIN
    UPDATE TonKho SET
        TongSLNhap = TB.TN,
        TongSLXuat = TB.TX,
        SLCuoi = SLDau + TongSLNhap - TongSLXuat - deleted.SoLuongNhap
    FROM TonKho, @tb_TonKho TB, deleted
    WHERE TonKho.MaVatTu = TB.MVT AND deleted.MaVatTu = TonKho.MaVatTu
END
END 
INSERT INTO ChiTietPhieuNhap(MaSoPhieuNhap, MaVatTu, SoLuongNhap, DonGia) VALUES('PN05', 'VT01', 500, 201000)
INSERT INTO ChiTietPhieuNhap(MaSoPhieuNhap, MaVatTu, SoLuongNhap, DonGia) VALUES('PN06', 'VT01', 1500, 250000)
INSERT INTO ChiTietPhieuNhap(MaSoPhieuNhap, MaVatTu, SoLuongNhap, DonGia) VALUES('PN05', 'VT03', 2500, 250000)
INSERT INTO ChiTietPhieuNhap(MaSoPhieuNhap, MaVatTu, SoLuongNhap, DonGia) VALUES('PN06', 'VT05', 225, 112000)
SELECT CONCAT(MONTH(NamThang), '/', YEAR(NamThang)) [Thời gian], MaVatTu, SLDau[Số lượng tồn đầu kỳ], TongSLNhap, TongSLXuat, SLCuoi[Số lượng tồn cuối kỳ] FROM TonKho

DELETE FROM ChiTietPhieuNhap WHERE MaSoPhieuNhap = 'PN05' AND MaVatTu = 'VT01'
DELETE FROM ChiTietPhieuNhap WHERE MaSoPhieuNhap = 'PN06' AND MaVatTu = 'VT01'
DELETE FROM ChiTietPhieuNhap WHERE MaSoPhieuNhap = 'PN05' AND MaVatTu = 'VT03'
DELETE FROM ChiTietPhieuNhap WHERE MaSoPhieuNhap = 'PN06' AND MaVatTu = 'VT05'
SELECT CONCAT(MONTH(NamThang), '/', YEAR(NamThang)) [Thời gian], MaVatTu, SLDau[Số lượng tồn đầu kỳ], TongSLNhap, TongSLXuat, SLCuoi[Số lượng tồn cuối kỳ] FROM TonKho

SELECT * FROM ChiTietPhieuNhap ORDER BY MaVatTu
SELECT * FROM ChiTietPhieuXuat ORDER BY MaVatTu

--Trigger on ChiTietPhieuXuat--
CREATE TRIGGER trg_TonKho_Xuat ON ChiTietPhieuXuat
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
SET NOCOUNT ON;
    DECLARE @tb_TonKho_Xuat TABLE(MaVT VARCHAR(10), TNhap INT, TXuat INT)
    INSERT INTO @tb_TonKho_Xuat(MaVT, TXuat, TNhap)
    SELECT ChiTietPhieuNhap.MaVatTu,CASE 
    WHEN TongXuat IS NULL THEN 0
    ELSE TongXuat END,CASE 
    WHEN SUM(SoLuongNhap) IS NULL THEN 0
    ELSE SUM(SoLuongNhap) END
    FROM
    (SELECT MaVatTu, SUM(SoLuongXuat)[TongXuat]
    from ChiTietPhieuXuat
    GROUP BY MaVatTu) AS [tam] 
    INNER JOIN ChiTietPhieuNhap on tam.MaVatTu = ChiTietPhieuNhap.MaVatTu
    WHERE tam.MaVatTu in
    (SELECT MaVatTu FROM TonKho)
    GROUP BY ChiTietPhieuNhap.MaVatTu, TongXuat
    
IF EXISTS (SELECT * FROM inserted) AND NOT EXISTS(SELECT * FROM deleted)
BEGIN

    UPDATE TonKho SET
        TongSLNhap = TB1.TNhap,
        TongSLXuat = TB1.TXuat,
        SLCuoi = SLDau + TongSLNhap - TongSLXuat + inserted.SoLuongXuat
    FROM TonKho, @tb_TonKho_Xuat TB1, inserted
    WHERE TonKho.MaVatTu = TB1.MaVT AND inserted.MaVatTu = TonKho.MaVatTu
END
IF EXISTS (SELECT * FROM deleted) AND NOT EXISTS (SELECT * FROM inserted)
BEGIN
    UPDATE TonKho SET
        TongSLNhap = TB1.TNhap,
        TongSLXuat = TB1.TXuat,
        SLCuoi = SLDau + TongSLNhap - TongSLXuat - deleted.SoLuongXuat
    FROM TonKho, @tb_TonKho_Xuat TB1, deleted
    WHERE TonKho.MaVatTu = TB1.MaVT AND deleted.MaVatTu = TonKho.MaVatTu
END
END 


