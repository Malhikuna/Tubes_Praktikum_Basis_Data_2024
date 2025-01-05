IF OBJECT_ID('PersentaseKehadiranAnggota', 'P') IS NOT NULL
DROP PROC PersentaseKehadiranAnggota
GO
CREATE PROCEDURE PersentaseKehadiranAnggota 
	@NIM CHAR (9),
	@numrows AS INT OUTPUT
AS
	DECLARE @Anggota_Id AS INT = (SELECT Anggota_Id FROM Anggota WHERE NIM = @NIM)
	DECLARE @Tanggal_Bergabung AS DATE = (SELECT Tanggal_Bergabung FROM Anggota WHERE NIM = @NIM)
	DECLARE @JumlahAbsen AS INT = (SELECT COUNT(Kehadiran_Id) FROM Kehadiran WHERE Anggota_Id = @Anggota_Id AND Status_Kehadiran = '1')
	DECLARE @TotalRapat AS INT = (SELECT COUNT(Rapat_Id) FROM Rapat WHERE Tanggal_Dilaksanakan > @Tanggal_Bergabung)

	SET NOCOUNT ON;
	SELECT A.Nama, dbo.HitungPersentase(@JumlahAbsen, @TotalRapat)  AS Persentase
	FROM Anggota AS A JOIN Kehadiran AS K ON A.Anggota_Id = K.Anggota_Id JOIN Rapat AS R ON R.Rapat_Id = K.Rapat_Id
	WHERE A.NIM = @NIM
	GROUP BY A.Nama
	SET @numrows = @@rowcount;
GO

DECLARE @rc AS INT;

EXEC PersentaseKehadiranAnggota
@NIM = '233040091',
@numrows = @rc OUTPUT;
SELECT @rc AS numrows;