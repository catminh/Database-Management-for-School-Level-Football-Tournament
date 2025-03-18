--Một đội đá tối đa 3 trận vòng bảng

--Update ChiTietTranDau set MaDoi = 'D01' WHERE MaTD = 'TD02' and MaDoi = 'D03'

CREATE TRIGGER MAXGSD ON ChiTietTranDau
AFTER INSERT, UPDATE
AS
BEGIN
DECLARE @SoTran int;
DECLARE @MaTD CHAR (4);
DECLARE @MaDoi CHAR (5);
DECLARE @MaDoikt CHAR (5);

SELECT @MaTD = MaTD, @MaDoi = MaDoi
from inserted	
SELECT @MaDoikt = i.MaDoi ,@SoTran = Count(@MaDoi) 
from 
(SELECT c.MaDoi, t.MaTD
FROM (SELECT MaTD
FROM TranDau
WHERE VongDau = 'GS') t
join ChiTietTranDau c on t.MaTD = c.MaTD) c
JOIN inserted I ON  C.MaDoi = I.MaDoi
GROUP BY i.MaDoi
IF @SoTran > 3 
begin
PRINT (N'Một đội đá tối đa 3 trận vòng bảng')
rollback transaction
end
END

--Giờ thi đấu của trận đấu phải sau 7h và trước 9h sáng hoặc sau 15h và trước 21h

-- UPDATE TranDau SET GioThiDau = '6:00' WHERE MaTD = 'TD01'

CREATE TRIGGER giothidau1 ON TranDau
AFTER INSERT, DELETE, UPDATE
AS
BEGIN
    DECLARE @giothidau TIME;
  
    SELECT @giothidau = GioThiDau
    FROM inserted;

    IF NOT ((DATEPART(HOUR, @giothidau) >= 7 AND DATEPART(HOUR, @giothidau) <= 9) OR (DATEPART(HOUR, @giothidau) >= 15 AND DATEPART(HOUR, @giothidau) <= 21))
    BEGIN
        PRINT(N' Khung giờ thi đấu không hợp lệ');
		ROLLBACK TRANSACTION
	END;
END;

--Cầu thủ trong một đội không được trùng số áo

--UPDATE CauThu set SoAo = '4' where MaDoi = 'D01' and SoAo = '10'

CREATE TRIGGER soao ON CauThu
AFTER INSERT, DELETE, UPDATE

AS
BEGIN
	DECLARE @soao INT, @mssv char(11), @doibong char(5);
	SELECT @soao = SoAo, @mssv = MSSV, @doibong = MaDoi
	FROM inserted
	 
	DECLARE @count INT;
	SELECT @count = COUNT(*)
	FROM CauThu
	WHERE SoAo = @soao and MaDoi = @doibong
	IF @count > 1
	BEGIN
		PRINT(N'Cầu thủ không được trùng số áo');
		ROLLBACK TRANSACTION
	END;
END



--Mỗi đội tối đa 12 cầu thủ

CREATE TRIGGER soluongcauthu1 ON CauThu
AFTER INSERT, UPDATE
AS
DECLARE @MaDoi CHAR(5), @songuoi int;

SELECT @MaDoi = MaDoi
FROM inserted

SELECT @songuoi = COUNT(*)
FROM CauThu
WHERE MaDoi = @MaDoi;

print (@songuoi);

IF NOT( @songuoi <= 12)
	BEGIN
		PRINT (N'Mỗi đội có 5 đến 12 cầu thủ');
		rollback transaction
	END;


--Mỗi đội có tối thiểu 5 cầu thủ
CREATE TRIGGER soluongcauthu2 ON CauThu
AFTER DELETE, UPDATE
AS
DECLARE @MaDoi CHAR(5), @songuoi int;

SELECT @MaDoi = MaDoi
FROM inserted

SELECT @songuoi = COUNT(*)
FROM CauThu
WHERE MaDoi = @MaDoi;

print (@songuoi);

IF NOT(@songuoi >= 5)
	BEGIN
		PRINT (N'Mỗi đội có 5 đến 12 cầu thủ');
		rollback transaction
	END;


--Trận đấu bán kết, tranh hạng ba và chung kết chỉ có kết quả là thắng hoặc thua không có hòa

update ChiTietTranDau
set ketquadoi = 'D'
where Matd = 'TD14' AND MaDoi = 'D04'


CREATE TRIGGER kiemtraketquatd
ON ChiTietTranDau
AFTER INSERT, UPDATE
AS
BEGIN
    DECLARE @VongDau VARCHAR(2);
    DECLARE @KetQuaDoi VARCHAR(2);
    
    
    SELECT @VongDau = t.VongDau, @KetQuaDoi = i.KetQuaDoi
    FROM inserted i
    JOIN TranDau  t ON i.MaTD = t.MaTD; 
    IF (@VongDau <> 'GS' ) AND (@KetQuaDoi= 'D')
    BEGIN
        PRINT (N'Trận đấu ở vòng loại trực tiếp không có kết quả hòa');
        ROLLBACK TRANSACTION;
        RETURN;
    END
END


--Luân lưu chỉ tồn tại vào những trận đấu bán kết, tranh hạng ba và chung kết 

--INSERT INTO LuanLuu (MaLL, MSSV, MaTD, TinhTrang ) VALUES ('LL30','31211020938', 'TD01', 'S');


update LuanLuu 
set MaTD = 'TD01'
where MaTD = 'TD14' and MaLL = 'LL01'


CREATE TRIGGER CheckPenaltyShootout
ON LuanLuu 
AFTER INSERT, UPDATE
AS
BEGIN
    DECLARE @VongDau VARCHAR(2);
    DECLARE @TinhTrang VARCHAR(1);
    

    SELECT @VongDau = t.VongDau, @TinhTrang = i.TinhTrang
    FROM inserted i
    JOIN TranDau  t ON i.MaTD = t.MaTD; 

    
    IF @VongDau = 'GS' AND (@TinhTrang = 'S' or @TinhTrang = 'F')
    BEGIN
        PRINT (N'Trận đấu ở vòng bảng không được có loạt đá luân lưu.');
        ROLLBACK TRANSACTION;
        RETURN;
    END
END

--Một cầu thủ bị 2 thẻ vàng trong trận đấu là xuất hiện 1 thẻ đỏ gián tiếp

update ThePhat 
set SoTheVang = '2' 
where MaTD = 'TD16' and mssv = '31221025159'


create trigger Themthe  ON ThePhat
After INSERT, UPDATE
AS 
DECLARE @SoTheVang INT;
DECLARE @SOTHE INT;
DECLARE @SoTheDo INT;

SELECT @SoTheVang = SoTheVang
FROM inserted

select @SoTheDo = SoTheDo
From inserted

IF @SoTheVang  = 2 AND @SoTheDo = 0
BEGIN
print (N'2 thẻ vàng sẽ trở thành 1 thẻ đỏ gián tiếp')
rollback transaction
end


--Mỗi trận đấu vòng bảng phải diễn ra giữa 2 đội cùng bảng 

/*
update  ChiTietTranDau 
set maDoi  = 'D05' 
where  MaTD = 'TD01' AND MaDoi = 'D01'
*/

create trigger TG_GS on ChiTietTranDau
for insert,update
as
begin
	declare @VongDau char(2)
	declare @MaTD char (4)
	declare @MaDoi1 char (3)
	declare @tenbang char (1)
	declare @tenbang1 char (1)
	select @VongDau=TranDau.VongDau from inserted, TranDau where inserted.MaTD=TranDau.MaTD

	select @tenbang=DoiBong.Bang, @MaTD = inserted.MaTD, @MaDoi1 = inserted.MaDoi
	from inserted join DoiBong
	on inserted.MaDoi=DoiBong.MaDoi

	select @tenbang1=DoiBong.Bang 
	from DoiBong join ChiTietTranDau
	on ChiTietTranDau.MaTD = @MaTD and ChiTietTranDau.MaDoi=DoiBong.MaDoi and ChiTietTranDau.MaDoi <> @MaDoi1

	if (@VongDau ='GS' and @tenbang <> @tenbang1)
		begin 
			print N' Hai đội không cùng bảng'
			rollback transaction
		end
end

--Ràng buộc một trận phải có 2 đội

/*
INSERT INTO ChiTietTranDau (MaTD, MaDoi, KetQuaDoi, XacDinhKQ ) VALUES ('TD01', 'D03', 'W', 'NT ');
*/
Create trigger mottr2d
on ChiTietTranDau
for insert,update
as
begin
	declare @sl int	
	select @sl=count(*)
	from inserted
	where inserted.MaTD in
		(select  MaTD 
		from ChiTietTranDau
		group by MaTD
		having count(*)>2) 
	
	if(@sl > 0)
		begin
			Print N'Mỗi trận chỉ có 2 đội bóng'
			rollback transaction
		end
end

-- Ngày tổ chức chung kết,  trận tranh hạng 3 phải sau bán kết; ngày tổ chức bán kết phải sau vòng bảng 

/*
update trandau 
set NgayToChuc = '2023-8-7' 
where MaTD = 'TD15'
*/

--LỖI


CREATE TRIGGER CheckNTD
ON TranDau 
AFTER INSERT, UPDATE
AS
BEGIN
    DECLARE @GSDate DATE;
    DECLARE @SFDate DATE;
    DECLARE @TPDate DATE;
    DECLARE @GFDate DATE;
    DECLARE @GSGDate DATE;
    DECLARE @SFGDate DATE;
    DECLARE @TPGDate DATE;
    DECLARE @GFGDate DATE;
    -- Lấy dữ liệu ngày của trận đấu từ bảng dữ liệu đã chèn
    SELECT @GSDate = i.NgayToChuc
    FROM inserted i
    WHERE i.VongDau = 'GS';
	SELECT @SFDate = i.NgayToChuc
    FROM inserted i
    WHERE i.VongDau = 'SF';
	SELECT @TPDate = i.NgayToChuc
    FROM inserted i
    WHERE i.VongDau = 'TP';
	SELECT @GFDate = i.NgayToChuc
    FROM inserted i
    WHERE i.VongDau = 'GF';
   -- Lấy dữ liệu ngày của trận đấu từ bảng dữ liệu co san
   SELECT @GSGDate = t.NgayToChuc
    FROM TranDau t
    WHERE t.VongDau = 'GS';
	SELECT @SFGDate = t.NgayToChuc
    FROM TranDau t
    WHERE t.VongDau = 'SF';
	SELECT @TPGDate = t.NgayToChuc
    FROM TranDau t
    WHERE t.VongDau = 'TP';
	SELECT @GFGDate = t.NgayToChuc
    FROM TranDau t
    WHERE t.VongDau = 'GF';
    
    -- Kiểm tra điều kiện ngày thi đấu
    IF @GSDate >= @SFDate OR @SFDate >= @TPDate OR @TPDate > @GFDate
    BEGIN
        PRINT (N'Ngày tổ chức trận đấu không hợp lệ.');
        ROLLBACK TRANSACTION;
    END
	 IF @GSDate >= @SFGDate OR @SFDate >= @TPGDate OR @TPDate > @GFGDate
	 BEGIN
        PRINT (N'Ngày tổ chức trận đấu không hợp lệ.');
        ROLLBACK TRANSACTION;
    END
END;

--Giải có tối đa 12 trận vòng bảng, 2 trận vòng bán kết, 1 trận vòng tranh hạng 3 và 1 trận chung kết 

--INSERT INTO TranDau (MaTD, VongDau, NgayToChuc, GioThiDau, MaSan, MaTT ) VALUES ('TD20', 'GS', '2023-8-10', '19:00', 'S02', 'TT05');

CREATE TRIGGER KIEMTRASOTRAN ON TranDau
AFTER INSERT,UPDATE
AS 
BEGIN 
DECLARE @MaTD char(4);
DECLARE @VongDau varchar(2);
DECLARE @SoTran int;

SELECT  @VongDau = VongDau
FROM inserted

SELECT @SoTran = COUNT(*)
from TranDau 
Where VongDau = @VongDau;

IF @SoTran = 12 AND @VongDau ='GS'
BEGIN
PRINT (N'Số trận vòng bảng tối đa là 12 trận')
rollback transaction
end
IF @SoTran = 2 AND @VongDau ='SF'
BEGIN
PRINT (N'Số trận bán kết tối đa là 2 trận')
rollback transaction
end
IF @SoTran = 1 AND @VongDau ='TP'
BEGIN
PRINT (N'Số trận tranh hạng 3 tối đa là 1 trận')
rollback transaction
end
IF @SoTran = 1 AND  @VongDau ='GF'
BEGIN
PRINT (N'Số trận  chung kết tối đa là 1 trận')
rollback transaction
end
end

--Mỗi bảng có 4 đội 

update DoiBong set Bang = 'B' where MaDoi = 'DO1'

CREATE TRIGGER SoDoiBang ON DoiBong
AFTER INSERT, UPDATE 
AS
BEGIN
DECLARE @Bang char(1);
DECLARE @SoDoi int; 

SELECT @Bang = Bang 
FROM inserted

SELECT @SoDoi = COUNT (*)
FROM DoiBong 
WHERE Bang = @Bang

IF (@SoDoi > 4) 
BEGIN 
PRINT (N'Mỗi bảng có 4 đội');
rollback transaction
end
end

