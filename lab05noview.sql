-- 1. Liệt kê các sinh viên có học bổng lớn hơn 100,000 và sinh ở Tp HCM:
SELECT MaSV, TenSV, HocBong, NoiSinh
FROM SinhVien
WHERE HocBong > 100000 AND NoiSinh = N'Tp. HCM';
GO

-- 2. Danh sách các sinh viên của khoa Anh văn và khoa Triết:
SELECT SV.MaSV, SV.TenSV, K.TenKH AS TenKhoa
FROM SinhVien SV
JOIN Khoa K ON SV.MaKH = K.MaKH
WHERE SV.MaKH IN ('AV', 'TR');
GO

-- 3. Sinh viên có ngày sinh từ 01/01/1986 đến 05/06/1992:
SELECT MaSV, NgaySinh, NoiSinh, HocBong
FROM SinhVien
WHERE NgaySinh BETWEEN '1986-01-01' AND '1992-06-05';
GO
-- 4. Sinh viên có học bổng từ 200,000 đến 800,000:
SELECT * 
FROM SinhVien 
WHERE HocBong BETWEEN 200000 AND 800000;
GO

-- 5. Liệt kê các môn học có số tiết lớn hơn 40 và nhỏ hơn 60:
SELECT MaMH, TenMH, SoTiet
FROM MonHoc
WHERE SoTiet > 40 AND SoTiet < 60;
GO

-- 6. Liệt kê sinh viên nam của khoa Anh văn:
SELECT MaSV, HoSV + ' ' + TenSV AS HoTen, Phai
FROM SinhVien
WHERE Phai = 0 AND MaKH = 'AV';
GO

-- 7. Danh sách sinh viên có nơi sinh ở Hà Nội và ngày sinh sau 01/01/1990:
SELECT HoSV + ' ' + TenSV AS HoTen, NoiSinh, NgaySinh
FROM SinhVien
WHERE NoiSinh = N'Hà Nội' AND NgaySinh > '1990-01-01';
GO

-- 8. Liệt kê sinh viên nữ có tên chứa chữ 'N':
SELECT MaSV, HoSV + ' ' + TenSV AS HoTen, Phai
FROM SinhVien
WHERE Phai = 0 AND (HoSV LIKE N'%N%' OR TenSV LIKE N'%N%');
GO

-- 9. Danh sách nam sinh viên khoa Tin học có ngày sinh sau ngày 30/5/1986:
SELECT MaSV, HoSV + ' ' + TenSV AS HoTen, NgaySinh
FROM SinhVien
WHERE Phai = 1 AND MaKH = 'TH' AND NgaySinh > '1986-05-30';
GO

-- 10. Liệt kê danh sách sinh viên gồm các thông tin: Họ và tên, Giới tính, Ngày sinh:
SELECT HoSV + ' ' + TenSV AS HoTen, 
       CASE WHEN Phai = 1 THEN N'Nam' ELSE N'Nữ' END AS GioiTinh,
       NgaySinh
FROM SinhVien;
GO
-- 11. Liệt kê danh sách sinh viên gồm: Mã sinh viên, Tuổi, Nơi sinh, Mã khoa
SELECT MaSV, 
       YEAR(GETDATE()) - YEAR(NgaySinh) AS Tuoi,
       NoiSinh, 
       MaKH
FROM SinhVien;
GO

-- 12. Danh sách những sinh viên có tuổi từ 20 đến 30, thông tin gồm: Họ tên, Tuổi, Tên khoa
SELECT HoSV + ' ' + TenSV AS HoTen, 
       YEAR(GETDATE()) - YEAR(NgaySinh) AS Tuoi,
       TenKH
FROM SinhVien
JOIN Khoa ON SinhVien.MaKH = Khoa.MaKH
WHERE YEAR(GETDATE()) - YEAR(NgaySinh) BETWEEN 20 AND 30;
GO

-- 13. Thông tin về mức học bổng của sinh viên: Mã sinh viên, Phái, Mã khoa, Mức học bổng
SELECT MaSV, 
       CASE WHEN Phai = 1 THEN N'Nam' ELSE N'Nữ' END AS Phai,
       MaKH,
       CASE WHEN HocBong > 500000 THEN N'Học bổng cao' ELSE N'Mức trung bình' END AS MucHocBong
FROM SinhVien;
GO

-- 14. Danh sách sinh viên của khoa Anh văn, thông tin gồm: Họ tên, Giới tính, Tên khoa
SELECT HoSV + ' ' + TenSV AS HoTen, 
       CASE WHEN Phai = 1 THEN N'Nam' ELSE N'Nữ' END AS GioiTinh,
       TenKH
FROM SinhVien
JOIN Khoa ON SinhVien.MaKH = Khoa.MaKH
WHERE Khoa.TenKH = N'Anh Văn';
GO

-- 15. Liệt kê bảng điểm của sinh viên khoa Tin Học, gồm: Tên khoa, Họ tên sinh viên, Tên môn học, Số tiết, Điểm
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

-- 16. Kết quả học tập của sinh viên, gồm: Họ tên, Mã khoa, Tên môn học, Điểm, Loại
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

-- 17. Cho biết học bổng cao nhất của từng khoa, gồm: Mã khoa, Tên khoa, Học bổng cao nhất
SELECT SinhVien.MaKH, 
       Khoa.TenKH, 
       MAX(SinhVien.HocBong) AS HocBongCaoNhat
FROM SinhVien
JOIN Khoa ON SinhVien.MaKH = Khoa.MaKH
GROUP BY SinhVien.MaKH, Khoa.TenKH;
GO

-- 18. Thống kê số sinh viên học của từng môn, gồm: Mã môn, Tên môn, Số sinh viên đang học
SELECT MonHoc.MaMH, 
       MonHoc.TenMH, 
       COUNT(DISTINCT Ketqua.MaSV) AS SoSinhVienDangHoc
FROM MonHoc
JOIN Ketqua ON MonHoc.MaMH = Ketqua.MaMH
GROUP BY MonHoc.MaMH, MonHoc.TenMH;
GO

-- 19. Môn có điểm thi cao nhất, gồm: Tên môn, Số tiết, Tên sinh viên, Điểm
SELECT TOP 1 MonHoc.TenMH, MonHoc.SoTiet, SinhVien.HoSV + ' ' + SinhVien.TenSV AS HoTen, Ketqua.Diem
FROM Ketqua
JOIN MonHoc ON Ketqua.MaMH = MonHoc.MaMH
JOIN SinhVien ON Ketqua.MaSV = SinhVien.MaSV
ORDER BY Ketqua.Diem DESC;
GO

-- 20. Khoa có đông sinh viên nhất, gồm: Mã khoa, Tên khoa, Tổng số sinh viên
SELECT TOP 1 SinhVien.MaKH, Khoa.TenKH, COUNT(SinhVien.MaSV) AS TongSV
FROM SinhVien
JOIN Khoa ON SinhVien.MaKH = Khoa.MaKH
GROUP BY SinhVien.MaKH, Khoa.TenKH
ORDER BY COUNT(SinhVien.MaSV) DESC;
GO
-- 21. Khoa có sinh viên lãnh học bổng cao nhất, gồm: Tên khoa, Họ tên sinh viên, Học bổng
SELECT TOP 1 Khoa.TenKH, SinhVien.HoSV + ' ' + SinhVien.TenSV AS HoTen, SinhVien.HocBong
FROM SinhVien
JOIN Khoa ON SinhVien.MaKH = Khoa.MaKH
ORDER BY SinhVien.HocBong DESC;
GO

-- 22. Sinh viên của khoa Tin học có học bổng cao nhất, gồm: Mã sinh viên, Họ tên, Tên khoa, Học bổng
SELECT TOP 1 SinhVien.MaSV, SinhVien.HoSV + ' ' + SinhVien.TenSV AS HoTen, Khoa.TenKH, SinhVien.HocBong
FROM SinhVien
JOIN Khoa ON SinhVien.MaKH = Khoa.MaKH
WHERE Khoa.TenKH = N'Tin học'
ORDER BY SinhVien.HocBong DESC;
GO

-- 23. Sinh viên có điểm môn Cơ sở dữ liệu lớn nhất, gồm: Họ tên sinh viên, Tên môn, Điểm
SELECT TOP 1 SinhVien.HoSV + ' ' + SinhVien.TenSV AS HoTen, MonHoc.TenMH, Ketqua.Diem
FROM Ketqua
JOIN MonHoc ON Ketqua.MaMH = MonHoc.MaMH
JOIN SinhVien ON Ketqua.MaSV = SinhVien.MaSV
WHERE MonHoc.TenMH = N'Cơ sở dữ liệu'
ORDER BY Ketqua.Diem DESC;
GO

-- 24. 3 sinh viên có điểm thi môn Đồ họa thấp nhất, gồm: Họ tên sinh viên, Tên khoa, Tên môn, Điểm
SELECT TOP 3 SinhVien.HoSV + ' ' + SinhVien.TenSV AS HoTen, Khoa.TenKH, MonHoc.TenMH, Ketqua.Diem
FROM Ketqua
JOIN MonHoc ON Ketqua.MaMH = MonHoc.MaMH
JOIN SinhVien ON Ketqua.MaSV = SinhVien.MaSV
JOIN Khoa ON SinhVien.MaKH = Khoa.MaKH
WHERE MonHoc.TenMH = N'Đồ họa ứng dụng'
ORDER BY Ketqua.Diem ASC;
GO

-- 25. Khoa có nhiều sinh viên nữ nhất, gồm: Mã khoa, Tên khoa, Tổng số sinh viên nữ
SELECT TOP 1 SinhVien.MaKH, Khoa.TenKH, COUNT(SinhVien.MaSV) AS TongSVNu
FROM SinhVien
JOIN Khoa ON SinhVien.MaKH = Khoa.MaKH
WHERE SinhVien.Phai = 0
GROUP BY SinhVien.MaKH, Khoa.TenKH
ORDER BY COUNT(SinhVien.MaSV) DESC;
GO

-- 26. Thống kê sinh viên nữ theo khoa, gồm: Mã khoa, Tên khoa, Tổng số sinh viên nữ
SELECT SinhVien.MaKH, Khoa.TenKH, COUNT(SinhVien.MaSV) AS TongSVNu
FROM SinhVien
JOIN Khoa ON SinhVien.MaKH = Khoa.MaKH
WHERE SinhVien.Phai = 0
GROUP BY SinhVien.MaKH, Khoa.TenKH;
GO

-- 27. Kết quả học tập của sinh viên, gồm: Họ tên sinh viên, Tên khoa, Kết quả (Đậu/Rớt)
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

-- 28. Danh sách sinh viên không có môn nào dưới 4 điểm, gồm: Họ tên sinh viên, Tên khoa, Phái
SELECT SinhVien.HoSV + ' ' + SinhVien.TenSV AS HoTen, Khoa.TenKH, 
       CASE WHEN SinhVien.Phai = 1 THEN N'Nam' ELSE N'Nữ' END AS Phai
FROM SinhVien
JOIN Ketqua ON SinhVien.MaSV = Ketqua.MaSV
JOIN Khoa ON SinhVien.MaKH = Khoa.MaKH
GROUP BY SinhVien.HoSV, SinhVien.TenSV, Khoa.TenKH, SinhVien.Phai
HAVING MIN(Ketqua.Diem) >= 4;
GO

-- 29. Danh sách những môn không có điểm thi nhỏ hơn 4, gồm: Mã môn, Tên Môn
SELECT DISTINCT MonHoc.MaMH, MonHoc.TenMH
FROM MonHoc
JOIN Ketqua ON MonHoc.MaMH = Ketqua.MaMH
GROUP BY MonHoc.MaMH, MonHoc.TenMH
HAVING MIN(Ketqua.Diem) >= 4;
GO

-- 30. Những khoa không có sinh viên rớt (rớt nếu điểm thi của môn nhỏ hơn 5), gồm: Mã khoa, Tên khoa
SELECT DISTINCT Khoa.MaKH, Khoa.TenKH
FROM Khoa
JOIN SinhVien ON Khoa.MaKH = SinhVien.MaKH
JOIN Ketqua ON SinhVien.MaSV = Ketqua.MaSV
GROUP BY Khoa.MaKH, Khoa.TenKH
HAVING MIN(Ketqua.Diem) >= 5;
GO
-- 31. Thống kê số sinh viên đậu và rớt của từng môn
SELECT MonHoc.MaMH AS MaMon, MonHoc.TenMH AS TenMon, 
       COUNT(CASE WHEN Ketqua.Diem >= 5 THEN 1 END) AS SoSinhVienDau, 
       COUNT(CASE WHEN Ketqua.Diem < 5 THEN 1 END) AS SinhVienRot
FROM MonHoc
JOIN Ketqua ON MonHoc.MaMH = Ketqua.MaMH
GROUP BY MonHoc.MaMH, MonHoc.TenMH;
GO

-- 32. Các môn không có sinh viên rớt
SELECT MonHoc.MaMH AS MaMon, MonHoc.TenMH AS TenMon
FROM MonHoc
JOIN Ketqua ON MonHoc.MaMH = Ketqua.MaMH
GROUP BY MonHoc.MaMH, MonHoc.TenMH
HAVING MIN(Ketqua.Diem) >= 5;
GO

-- 33. Các sinh viên không có môn nào rớt
SELECT SinhVien.MaSV AS MaSinhVien, SinhVien.HoSV + ' ' + SinhVien.TenSV AS HoTen, SinhVien.MaKH AS MaKhoa
FROM SinhVien
JOIN Ketqua ON SinhVien.MaSV = Ketqua.MaSV
GROUP BY SinhVien.MaSV, SinhVien.HoSV, SinhVien.TenSV, SinhVien.MaKH
HAVING MIN(Ketqua.Diem) >= 5;
GO

-- 34. Các sinh viên rớt trên 2 môn
SELECT SinhVien.MaSV AS MaSinhVien, SinhVien.HoSV + ' ' + SinhVien.TenSV AS HoTen, Khoa.TenKH AS TenKhoa, SinhVien.MaKH AS MaKhoa
FROM SinhVien
JOIN Ketqua ON SinhVien.MaSV = Ketqua.MaSV
JOIN Khoa ON SinhVien.MaKH = Khoa.MaKH
GROUP BY SinhVien.MaSV, SinhVien.HoSV, SinhVien.TenSV, Khoa.TenKH, SinhVien.MaKH
HAVING SUM(CASE WHEN Ketqua.Diem < 5 THEN 1 ELSE 0 END) > 2;
GO

-- 35. Các khoa có hơn 10 sinh viên
SELECT SinhVien.MaKH AS MaKhoa, Khoa.TenKH AS TenKhoa, COUNT(SinhVien.MaSV) AS TongSoSV
FROM SinhVien
JOIN Khoa ON SinhVien.MaKH = Khoa.MaKH
GROUP BY SinhVien.MaKH, Khoa.TenKH
HAVING COUNT(SinhVien.MaSV) > 10;
GO

-- 36. Sinh viên thi nhiều hơn 4 môn
SELECT SinhVien.MaSV AS MaSinhVien, SinhVien.HoSV + ' ' + SinhVien.TenSV AS HoTen, COUNT(Ketqua.MaMH) AS SoMonThi
FROM SinhVien
JOIN Ketqua ON SinhVien.MaSV = Ketqua.MaSV
GROUP BY SinhVien.MaSV, SinhVien.HoSV, SinhVien.TenSV
HAVING COUNT(Ketqua.MaMH) > 4;
GO

-- 37. Các khoa có từ 5 sinh viên nam trở lên
SELECT SinhVien.MaKH AS MaKhoa, Khoa.TenKH AS TenKhoa, COUNT(SinhVien.MaSV) AS TongSoNam
FROM SinhVien
JOIN Khoa ON SinhVien.MaKH = Khoa.MaKH
WHERE SinhVien.Phai = 1
GROUP BY SinhVien.MaKH, Khoa.TenKH
HAVING COUNT(SinhVien.MaSV) >= 5;
GO

-- 38. Sinh viên có điểm trung bình thi lớn hơn 4
SELECT SinhVien.HoSV + ' ' + SinhVien.TenSV AS HoTen, Khoa.TenKH AS TenKhoa, 
       CASE WHEN SinhVien.Phai = 1 THEN N'Nam' ELSE N'Nữ' END AS Phai, 
       AVG(Ketqua.Diem) AS DiemTB
FROM SinhVien
JOIN Ketqua ON SinhVien.MaSV = Ketqua.MaSV
JOIN Khoa ON SinhVien.MaKH = Khoa.MaKH
GROUP BY SinhVien.HoSV, SinhVien.TenSV, Khoa.TenKH, SinhVien.Phai
HAVING AVG(Ketqua.Diem) > 4;
GO

-- 39. Trung bình điểm của từng môn (chỉ lấy môn có trung bình điểm trên 6)
SELECT MonHoc.MaMH AS MaMonHoc, MonHoc.TenMH AS TenMonHoc, AVG(Ketqua.Diem) AS DiemTB
FROM MonHoc
JOIN Ketqua ON MonHoc.MaMH = Ketqua.MaMH
GROUP BY MonHoc.MaMH, MonHoc.TenMH
HAVING AVG(Ketqua.Diem) > 6;
GO
