DROP TRIGGER IF EXISTS dbo.after_insert_update_delete_anggota;
CREATE TRIGGER dbo.after_insert_update_delete_anggota ON dbo.Anggota
AFTER INSERT, UPDATE, DELETE
AS 
	IF UPDATE(Divisi_Id)
	BEGIN
		DECLARE @Divisi_Id_Inserted AS INT
		DECLARE @Divisi_Id_Deleted AS INT

		DECLARE InsertedRow CURSOR FOR SELECT Divisi_Id FROM inserted
		OPEN InsertedRow
			FETCH NEXT FROM InsertedRow INTO @Divisi_Id_Inserted 
			WHILE @@FETCH_STATUS = 0
			BEGIN
				UPDATE Divisi
				SET Jumlah_Anggota = (SELECT COUNT(Anggota_Id) FROM Anggota WHERE Divisi_Id = @Divisi_Id_Inserted AND Status_Keanggotaan_Id = 1)
				WHERE Nama_Divisi = (SELECT Nama_Divisi FROM Divisi WHERE Divisi_Id = @Divisi_Id_Inserted);
				FETCH NEXT FROM InsertedRow INTO @Divisi_Id_Inserted 
			END
		CLOSE InsertedRow
		DEALLOCATE InsertedRow

		DECLARE DeletedRow CURSOR FOR SELECT Divisi_Id FROM deleted
		OPEN DeletedRow
			FETCH NEXT FROM DeletedRow INTO @Divisi_Id_Deleted 
			WHILE @@FETCH_STATUS = 0
			BEGIN
				UPDATE Divisi
				SET Jumlah_Anggota = (SELECT COUNT(Anggota_Id) FROM Anggota WHERE Divisi_Id = @Divisi_Id_Deleted AND Status_Keanggotaan_Id = 1)
				WHERE Nama_Divisi = (SELECT Nama_Divisi FROM Divisi WHERE Divisi_Id = @Divisi_Id_Deleted);
				FETCH NEXT FROM DeletedRow INTO @Divisi_Id_Deleted 
			END
			CLOSE DeletedRow
		DEALLOCATE DeletedRow
	END
GO

DROP TRIGGER IF EXISTS dbo.after_insert_anggota;
CREATE TRIGGER dbo.after_insert_anggota ON dbo.Anggota
AFTER INSERT
AS
	SELECT COUNT(*) FROM (SELECT TOP (1) * FROM inserted) AS I;
GO

DROP TRIGGER IF EXISTS dbo.after_insert_skors;
CREATE TRIGGER dbo.after_insert_skors ON dbo.Skors
AFTER INSERT
AS
	DECLARE @Anggota_Id AS INT

	DECLARE SkorsRow CURSOR FOR SELECT Anggota_Id FROM inserted
	OPEN SkorsRow
	FETCH NEXT FROM SkorsRow INTO @Anggota_Id 
	WHILE @@FETCH_STATUS = 0
	BEGIN
		UPDATE Anggota
		SET Status_Skors_Id = (SELECT TOP(1) Kategori_Skors FROM Skors WHERE Anggota_Id = @Anggota_Id ORDER BY Tanggal_Rekap DESC)
		WHERE Anggota_Id = @Anggota_Id
		FETCH NEXT FROM SkorsRow INTO @Anggota_Id 
	END
	CLOSE SkorsRow
	DEALLOCATE SkorsRow
GO