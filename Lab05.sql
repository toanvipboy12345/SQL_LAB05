--DROP VIEW SinhVienAVTR;
SELECT * FROM SinhVien
SELECT * FROM MonHoc
SELECT * FROM Ketqua
SELECT * FROM Khoa
--1.Liệt kê các sinh viên có học bổng lớn hơn 100,000 và sinh ở Tp HCM:
GO
CREATE VIEW SinhVien_HocBong_HCM AS
SELECT MaSV, TenSV, HocBong, NoiSinh
FROM SinhVien
WHERE HocBong > 100000 AND NoiSinh = N'Tp. HCM';
GO
GO
SELECT * FROM SinhVien_HocBong_HCM;
GO
--2.Danh sách các sinh viên của khoa Anh văn và khoa Triết:
GO
CREATE VIEW SinhVienAVTR AS
SELECT SV.MaSV, SV.TenSV, K.TenKH AS TenKhoa
FROM SinhVien SV
JOIN Khoa K ON SV.MaKH = K.MaKH
WHERE SV.MaKH IN ('AV', 'TR');
GO
GO
SELECT * FROM SinhVienAVTR
GO
--3.Sinh viên có ngày sinh từ 01/01/1986 đến 05/06/1992:
GO
CREATE VIEW sv19861992 AS
SELECT MaSV, NgaySinh, NoiSinh, HocBong
FROM SinhVien
WHERE NgaySinh BETWEEN '1986-01-01' AND '1992-06-05';
GO
SELECT * FROM  sv19861992
--4.Sinh viên có học bổng từ 200,000 đến 800,000:
GO
CREATE VIEW sv200800 AS
SELECT * FROM SinhVien WHERE HocBong BETWEEN 200000 AND 800000;
GO
SELECT * FROM sv200800
-- 5. Liệt kê các môn học có số tiết lớn hơn 40 và nhỏ hơn 60
GO
CREATE VIEW MH_SoTiet_40_60 AS
SELECT MaMH, TenMH, SoTiet
FROM MonHoc
WHERE SoTiet > 40 AND SoTiet < 60;
GO
SELECT * FROM MH_SoTiet_40_60;
GO

-- 6. Liệt kê sinh viên nam của khoa Anh văn
GO
CREATE VIEW SV_Nam_Khoa_AV AS
SELECT MaSV, HoSV + ' ' + TenSV AS HoTen, Phai
FROM SinhVien
WHERE Phai =0 AND MaKH = 'AV';
GO
SELECT * FROM SV_Nam_Khoa_AV;
GO

-- 7. Danh sách sinh viên có nơi sinh ở Hà Nội và ngày sinh sau 01/01/1990
GO
CREATE VIEW SV_HN_NgaySinh_Sau1990 AS
SELECT HoSV + ' ' + TenSV AS HoTen, NoiSinh, NgaySinh
FROM SinhVien
WHERE NoiSinh = N'Hà Nội' AND NgaySinh > '1990-01-01';
GO
SELECT * FROM SV_HN_NgaySinh_Sau1990;
GO

-- 8. Liệt kê sinh viên nữ có tên chứa chữ 'N'
GO
CREATE VIEW SV_Nu_ChuaChuN AS
SELECT MaSV, HoSV + ' ' + TenSV AS HoTen, Phai
FROM SinhVien
WHERE Phai = 0 AND (HoSV LIKE N'%N%' OR TenSV LIKE N'%N%');
GO
SELECT * FROM SV_Nu_ChuaChuN;
GO

-- 9. Danh sách nam sinh viên khoa Tin học có ngày sinh sau ngày 30/5/1986
GO
CREATE VIEW SV_Nam_Khoa_TH_Sau1986 AS
SELECT MaSV, HoSV + ' ' + TenSV AS HoTen, NgaySinh
FROM SinhVien
WHERE Phai = 1 AND MaKH = 'TH' AND NgaySinh > '1986-05-30';
GO
SELECT * FROM SV_Nam_Khoa_TH_Sau1986;
GO
-- 10. Liệt kê danh sách sinh viên gồm các thông tin: Họ và tên, Giới tính, Ngày sinh
GO
CREATE VIEW SV_ThongTin_GioiTinh AS
SELECT HoSV + ' ' + TenSV AS HoTen, 
       CASE WHEN Phai = 1 THEN N'Nam' ELSE N'Nữ' END AS GioiTinh,
       NgaySinh
FROM SinhVien;
GO
SELECT * FROM SV_ThongTin_GioiTinh;
GO

-- 11. Liệt kê danh sách sinh viên gồm: Mã sinh viên, Tuổi, Nơi sinh, Mã khoa
GO
CREATE VIEW SV_ThongTin_Tuoi AS
SELECT MaSV, 
       YEAR(GETDATE()) - YEAR(NgaySinh) AS Tuoi,
       NoiSinh, 
       MaKH
FROM SinhVien;
GO
SELECT * FROM SV_ThongTin_Tuoi;
GO

-- 12. Danh sách những sinh viên có tuổi từ 20 đến 30, thông tin gồm: Họ tên, Tuổi, Tên khoa
GO
CREATE VIEW SV_Tuoi_20_30 AS
SELECT HoSV + ' ' + TenSV AS HoTen, 
       YEAR(GETDATE()) - YEAR(NgaySinh) AS Tuoi,
       TenKH
FROM SinhVien
JOIN Khoa ON SinhVien.MaKH = Khoa.MaKH
WHERE YEAR(GETDATE()) - YEAR(NgaySinh) BETWEEN 20 AND 30;
GO
SELECT * FROM SV_Tuoi_20_30;
GO

-- 13. Thông tin về mức học bổng của sinh viên: Mã sinh viên, Phái, Mã khoa, Mức học bổng
GO
CREATE VIEW SV_MucHocBong AS
SELECT MaSV, 
       CASE WHEN Phai = 1 THEN N'Nam' ELSE N'Nữ' END AS Phai,
       MaKH,
       CASE WHEN HocBong > 500000 THEN N'Học bổng cao' ELSE N'Mức trung bình' END AS MucHocBong
FROM SinhVien;
GO
SELECT * FROM SV_MucHocBong;
GO

-- 14. Danh sách sinh viên của khoa Anh văn, thông tin gồm: Họ tên, Giới tính, Tên khoa
GO
CREATE VIEW SV_Khoa_AV_GioiTinh AS
SELECT HoSV + ' ' + TenSV AS HoTen, 
       CASE WHEN Phai = 1 THEN N'Nam' ELSE N'Nữ' END AS GioiTinh,
       TenKH
FROM SinhVien
JOIN Khoa ON SinhVien.MaKH = Khoa.MaKH
WHERE Khoa.TenKH = N'Anh Văn';
GO
SELECT * FROM SV_Khoa_AV_GioiTinh;
GO

-- 15. Liệt kê bảng điểm của sinh viên khoa Tin Học, gồm: Tên khoa, Họ tên sinh viên, Tên môn học, Số tiết, Điểm
GO
CREATE VIEW BangDiem_Khoa_TH AS
SELECT Khoa.TenKH, 
       SinhVien.HoSV + ' ' + SinhVien.TenSV AS HoTen, 
       MonHoc.TenMH, 
       MonHoc.SoTiet, 
       Ketqua.Diem
FROM SinhVien
JOIN Ketqua ON SinhVien.MaSV = Ketqua.MaSV
JOIN MonHoc ON Ketqua.MaMH = MonHoc.MaMH
JOIN Khoa ON SinhVien.MaKH = Khoa.MaKH
WHERE Khoa.TenKH = N'Tin học';
GO
SELECT * FROM BangDiem_Khoa_TH;
GO

-- 16. Kết quả học tập của sinh viên, gồm: Họ tên, Mã khoa, Tên môn học, Điểm, Loại
GO
CREATE VIEW KetQua_HocTap AS
SELECT SinhVien.HoSV + ' ' + SinhVien.TenSV AS HoTen, 
       SinhVien.MaKH,
       MonHoc.TenMH,
       Ketqua.Diem,
       CASE 
           WHEN Ketqua.Diem > 8 THEN N'Giỏi' 
           WHEN Ketqua.Diem >= 6 THEN N'Khá' 
           ELSE N'Trung Bình' 
       END AS Loai
FROM SinhVien
JOIN Ketqua ON SinhVien.MaSV = Ketqua.MaSV
JOIN MonHoc ON Ketqua.MaMH = MonHoc.MaMH;
GO
SELECT * FROM KetQua_HocTap;
GO
-- 17. Cho biết học bổng cao nhất của từng khoa, gồm: Mã khoa, Tên khoa, Học bổng cao nhất
GO
CREATE VIEW HocBong_CaoNhat_MoiKhoa AS
SELECT SinhVien.MaKH, 
       Khoa.TenKH, 
       MAX(SinhVien.HocBong) AS HocBongCaoNhat
FROM SinhVien
JOIN Khoa ON SinhVien.MaKH = Khoa.MaKH
GROUP BY SinhVien.MaKH, Khoa.TenKH;
GO
SELECT * FROM HocBong_CaoNhat_MoiKhoa;
GO

-- 18. Thống kê số sinh viên học của từng môn, gồm: Mã môn, Tên môn, Số sinh viên đang học
GO
CREATE VIEW SoLuong_SinhVien_MoiMon AS
SELECT MonHoc.MaMH, 
       MonHoc.TenMH, 
       COUNT(DISTINCT Ketqua.MaSV) AS SoSinhVienDangHoc
FROM MonHoc
JOIN Ketqua ON MonHoc.MaMH = Ketqua.MaMH
GROUP BY MonHoc.MaMH, MonHoc.TenMH;
GO
SELECT * FROM SoLuong_SinhVien_MoiMon;
GO
-- 19. Môn có điểm thi cao nhất, gồm: Tên môn, Số tiết, Tên sinh viên, Điểm
GO
CREATE VIEW Mon_DiemCao AS
SELECT TOP 1 MonHoc.TenMH, MonHoc.SoTiet, SinhVien.HoSV + ' ' + SinhVien.TenSV AS HoTen, Ketqua.Diem
FROM Ketqua
JOIN MonHoc ON Ketqua.MaMH = MonHoc.MaMH
JOIN SinhVien ON Ketqua.MaSV = SinhVien.MaSV
ORDER BY Ketqua.Diem DESC;
GO
SELECT * FROM Mon_DiemCao;
GO

-- 20. Khoa có đông sinh viên nhất, gồm: Mã khoa, Tên khoa, Tổng số sinh viên
GO
CREATE VIEW Khoa_DongSVNhat AS
SELECT TOP 1 SinhVien.MaKH, Khoa.TenKH, COUNT(SinhVien.MaSV) AS TongSV
FROM SinhVien
JOIN Khoa ON SinhVien.MaKH = Khoa.MaKH
GROUP BY SinhVien.MaKH, Khoa.TenKH
ORDER BY COUNT(SinhVien.MaSV) DESC;
GO
SELECT * FROM Khoa_DongSVNhat;
GO

-- 21. Khoa có sinh viên lãnh học bổng cao nhất, gồm: Tên khoa, Họ tên sinh viên, Học bổng
GO
CREATE VIEW Khoa_HBongCaoNhat AS
SELECT TOP 1 Khoa.TenKH, SinhVien.HoSV + ' ' + SinhVien.TenSV AS HoTen, SinhVien.HocBong
FROM SinhVien
JOIN Khoa ON SinhVien.MaKH = Khoa.MaKH
ORDER BY SinhVien.HocBong DESC;
GO
SELECT * FROM Khoa_HBongCaoNhat;
GO

-- 22. Sinh viên của khoa Tin học có học bổng cao nhất, gồm: Mã sinh viên, Họ tên, Tên khoa, Học bổng
GO
CREATE VIEW SV_TH_HBongCao AS
SELECT TOP 1 SinhVien.MaSV, SinhVien.HoSV + ' ' + SinhVien.TenSV AS HoTen, Khoa.TenKH, SinhVien.HocBong
FROM SinhVien
JOIN Khoa ON SinhVien.MaKH = Khoa.MaKH
WHERE Khoa.TenKH = N'Tin học'
ORDER BY SinhVien.HocBong DESC;
GO
SELECT * FROM SV_TH_HBongCao;
GO

-- 23. Sinh viên có điểm môn Cơ sở dữ liệu lớn nhất, gồm: Họ tên sinh viên, Tên môn, Điểm
GO
CREATE VIEW SV_DiemCao_CSDL AS
SELECT TOP 1 SinhVien.HoSV + ' ' + SinhVien.TenSV AS HoTen, MonHoc.TenMH, Ketqua.Diem
FROM Ketqua
JOIN MonHoc ON Ketqua.MaMH = MonHoc.MaMH
JOIN SinhVien ON Ketqua.MaSV = SinhVien.MaSV
WHERE MonHoc.TenMH = N'Cơ sở dữ liệu'
ORDER BY Ketqua.Diem DESC;
GO
SELECT * FROM SV_DiemCao_CSDL;
GO

-- 24. 3 sinh viên có điểm thi môn Đồ họa thấp nhất, gồm: Họ tên sinh viên, Tên khoa, Tên môn, Điểm
GO
CREATE VIEW SV_3DiemThap_DH AS
SELECT TOP 3 SinhVien.HoSV + ' ' + SinhVien.TenSV AS HoTen, Khoa.TenKH, MonHoc.TenMH, Ketqua.Diem
FROM Ketqua
JOIN MonHoc ON Ketqua.MaMH = MonHoc.MaMH
JOIN SinhVien ON Ketqua.MaSV = SinhVien.MaSV
JOIN Khoa ON SinhVien.MaKH = Khoa.MaKH
WHERE MonHoc.TenMH = N'Đồ họa ứng dụng'
ORDER BY Ketqua.Diem ASC;
GO
SELECT * FROM SV_3DiemThap_DH;
GO

-- 25. Khoa có nhiều sinh viên nữ nhất, gồm: Mã khoa, Tên khoa, Tổng số sinh viên nữ
GO
CREATE VIEW Khoa_NhieuSVNu AS
SELECT TOP 1 SinhVien.MaKH, Khoa.TenKH, COUNT(SinhVien.MaSV) AS TongSVNu
FROM SinhVien
JOIN Khoa ON SinhVien.MaKH = Khoa.MaKH
WHERE SinhVien.Phai = 0
GROUP BY SinhVien.MaKH, Khoa.TenKH
ORDER BY COUNT(SinhVien.MaSV) DESC;
GO
SELECT * FROM Khoa_NhieuSVNu;
GO

-- 26. Thống kê sinh viên nữ theo khoa, gồm: Mã khoa, Tên khoa, Tổng số sinh viên nữ
GO
CREATE VIEW TK_SVNu_Khoa AS
SELECT SinhVien.MaKH, Khoa.TenKH, COUNT(SinhVien.MaSV) AS TongSVNu
FROM SinhVien
JOIN Khoa ON SinhVien.MaKH = Khoa.MaKH
WHERE SinhVien.Phai = 0
GROUP BY SinhVien.MaKH, Khoa.TenKH;
GO
SELECT * FROM TK_SVNu_Khoa;
GO

-- 27. Kết quả học tập của sinh viên, gồm: Họ tên sinh viên, Tên khoa, Kết quả (Đậu/Rớt)
GO
CREATE VIEW KQ_DauRot AS
SELECT SinhVien.HoSV + ' ' + SinhVien.TenSV AS HoTen, Khoa.TenKH,
       CASE 
           WHEN MIN(Ketqua.Diem) >= 4 THEN N'Đậu' 
           ELSE N'Rớt' 
       END AS KetQua
FROM SinhVien
JOIN Ketqua ON SinhVien.MaSV = Ketqua.MaSV
JOIN Khoa ON SinhVien.MaKH = Khoa.MaKH
GROUP BY SinhVien.HoSV, SinhVien.TenSV, Khoa.TenKH;
GO
SELECT * FROM KQ_DauRot;
GO

-- 28. Danh sách sinh viên không có môn nào dưới 4 điểm, gồm: Họ tên sinh viên, Tên khoa, Phái
GO
CREATE VIEW SV_KhongDiemDuoi4 AS
SELECT SinhVien.HoSV + ' ' + SinhVien.TenSV AS HoTen, Khoa.TenKH, 
       CASE WHEN SinhVien.Phai = 1 THEN N'Nam' ELSE N'Nữ' END AS Phai
FROM SinhVien
JOIN Ketqua ON SinhVien.MaSV = Ketqua.MaSV
JOIN Khoa ON SinhVien.MaKH = Khoa.MaKH
GROUP BY SinhVien.HoSV, SinhVien.TenSV, Khoa.TenKH, SinhVien.Phai
HAVING MIN(Ketqua.Diem) >= 4;
GO
SELECT * FROM SV_KhongDiemDuoi4;
GO

-- 29. Danh sách những môn không có điểm thi nhỏ hơn 4, gồm: Mã môn, Tên Môn
GO
CREATE VIEW Mon_KhongDiemDuoi4 AS
SELECT DISTINCT MonHoc.MaMH, MonHoc.TenMH
FROM MonHoc
JOIN Ketqua ON MonHoc.MaMH = Ketqua.MaMH
GROUP BY MonHoc.MaMH, MonHoc.TenMH
HAVING MIN(Ketqua.Diem) >= 4;
GO
SELECT * FROM Mon_KhongDiemDuoi4;
GO

-- 30. Những khoa không có sinh viên rớt (rớt nếu điểm thi của môn nhỏ hơn 5), gồm: Mã khoa, Tên khoa
GO
CREATE VIEW Khoa_KhongSVRot AS
SELECT DISTINCT Khoa.MaKH, Khoa.TenKH
FROM Khoa
JOIN SinhVien ON Khoa.MaKH = SinhVien.MaKH
JOIN Ketqua ON SinhVien.MaSV = Ketqua.MaSV
GROUP BY Khoa.MaKH, Khoa.TenKH
HAVING MIN(Ketqua.Diem) >= 5;
GO
SELECT * FROM Khoa_KhongSVRot;
GO
-- 31. Thống kê số sinh viên đậu và rớt của từng môn
GO
CREATE VIEW ThongKe_DauRot_Mon AS
SELECT MonHoc.MaMH AS MaMon, MonHoc.TenMH AS TenMon, COUNT(CASE WHEN Ketqua.Diem >= 5 THEN 1 END) AS SoSinhVienDau, COUNT(CASE WHEN Ketqua.Diem < 5 THEN 1 END) AS SinhVienRot
FROM MonHoc
JOIN Ketqua ON MonHoc.MaMH = Ketqua.MaMH
GROUP BY MonHoc.MaMH, MonHoc.TenMH;
GO
SELECT * FROM ThongKe_DauRot_Mon
GO

-- 32. Các môn không có sinh viên rớt
GO
CREATE VIEW Mon_KhongRot AS
SELECT MonHoc.MaMH AS MaMon, MonHoc.TenMH AS TenMon
FROM MonHoc
JOIN Ketqua ON MonHoc.MaMH = Ketqua.MaMH
GROUP BY MonHoc.MaMH, MonHoc.TenMH
HAVING MIN(Ketqua.Diem) >= 5;
GO
SELECT * FROM Mon_KhongRot
GO

-- 33. Các sinh viên không có môn nào rớt
GO
CREATE VIEW SV_KhongRot AS
SELECT SinhVien.MaSV AS MaSinhVien, SinhVien.HoSV + ' ' + SinhVien.TenSV AS HoTen, SinhVien.MaKH AS MaKhoa
FROM SinhVien
JOIN Ketqua ON SinhVien.MaSV = Ketqua.MaSV
GROUP BY SinhVien.MaSV, SinhVien.HoSV, SinhVien.TenSV, SinhVien.MaKH
HAVING MIN(Ketqua.Diem) >= 5;
GO
SELECT * FROM SV_KhongRot
GO

-- 34. Các sinh viên rớt trên 2 môn
GO
CREATE VIEW SV_RotHon2Mon AS
SELECT SinhVien.MaSV AS MaSinhVien, SinhVien.HoSV + ' ' + SinhVien.TenSV AS HoTen, Khoa.TenKH AS TenKhoa, SinhVien.MaKH AS MaKhoa
FROM SinhVien
JOIN Ketqua ON SinhVien.MaSV = Ketqua.MaSV
JOIN Khoa ON SinhVien.MaKH = Khoa.MaKH
GROUP BY SinhVien.MaSV, SinhVien.HoSV, SinhVien.TenSV, Khoa.TenKH, SinhVien.MaKH
HAVING SUM(CASE WHEN Ketqua.Diem < 5 THEN 1 ELSE 0 END) > 2;
GO
SELECT * FROM SV_RotHon2Mon
GO

-- 35. Các khoa có hơn 10 sinh viên
GO
CREATE VIEW Khoa_Tren10SV AS
SELECT SinhVien.MaKH AS MaKhoa, Khoa.TenKH AS TenKhoa, COUNT(SinhVien.MaSV) AS TongSoSV
FROM SinhVien
JOIN Khoa ON SinhVien.MaKH = Khoa.MaKH
GROUP BY SinhVien.MaKH, Khoa.TenKH
HAVING COUNT(SinhVien.MaSV) > 10;
GO
SELECT * FROM Khoa_Tren10SV
GO

-- 36. Sinh viên thi nhiều hơn 4 môn
GO
CREATE VIEW SV_ThiHon4Mon AS
SELECT SinhVien.MaSV AS MaSinhVien, SinhVien.HoSV + ' ' + SinhVien.TenSV AS HoTen, COUNT(Ketqua.MaMH) AS SoMonThi
FROM SinhVien
JOIN Ketqua ON SinhVien.MaSV = Ketqua.MaSV
GROUP BY SinhVien.MaSV, SinhVien.HoSV, SinhVien.TenSV
HAVING COUNT(Ketqua.MaMH) > 4;
GO
SELECT * FROM SV_ThiHon4Mon
GO

-- 37. Các khoa có từ 5 sinh viên nam trở lên
GO
CREATE VIEW Khoa_Tren5Nam AS
SELECT SinhVien.MaKH AS MaKhoa, Khoa.TenKH AS TenKhoa, COUNT(SinhVien.MaSV) AS TongSoNam
FROM SinhVien
JOIN Khoa ON SinhVien.MaKH = Khoa.MaKH
WHERE SinhVien.Phai = 1
GROUP BY SinhVien.MaKH, Khoa.TenKH
HAVING COUNT(SinhVien.MaSV) >= 5;
GO
SELECT * FROM Khoa_Tren5Nam
GO

-- 38. Sinh viên có điểm trung bình thi lớn hơn 4
GO
CREATE VIEW SV_TrungBinhHon4 AS
SELECT SinhVien.HoSV + ' ' + SinhVien.TenSV AS HoTen, Khoa.TenKH AS TenKhoa, CASE WHEN SinhVien.Phai = 1 THEN N'Nam' ELSE N'Nữ' END AS Phai, AVG(Ketqua.Diem) AS DiemTB
FROM SinhVien
JOIN Ketqua ON SinhVien.MaSV = Ketqua.MaSV
JOIN Khoa ON SinhVien.MaKH = Khoa.MaKH
GROUP BY SinhVien.HoSV, SinhVien.TenSV, Khoa.TenKH, SinhVien.Phai
HAVING AVG(Ketqua.Diem) > 4;
GO
SELECT * FROM SV_TrungBinhHon4
GO

-- 39. Trung bình điểm của từng môn (chỉ lấy môn có trung bình điểm trên 6)
GO
CREATE VIEW Mon_TrungBinhHon6 AS
SELECT MonHoc.MaMH AS MaMonHoc, MonHoc.TenMH AS TenMonHoc, AVG(Ketqua.Diem) AS DiemTB
FROM MonHoc
JOIN Ketqua ON MonHoc.MaMH = Ketqua.MaMH
GROUP BY MonHoc.MaMH, MonHoc.TenMH
HAVING AVG(Ketqua.Diem) > 6;
GO
SELECT * FROM Mon_TrungBinhHon6
GO

