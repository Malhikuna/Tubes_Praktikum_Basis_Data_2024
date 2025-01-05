CREATE DATABASE [Sumber Daya Manusia HMTIF];

USE master;
GO
ALTER DATABASE [Sumber Daya Manusia HMTIF] SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
GO
DROP DATABASE [Sumber Daya Manusia HMTIF];
GO


USE [Sumber Daya Manusia HMTIF];

-- Table: Status_Keanggotaan
CREATE TABLE Status_Keanggotaan (
    Status_Keanggotaan_Id TINYINT PRIMARY KEY,
    Status_Sekarang VARCHAR(50) NOT NULL
);

-- Table: Alamat
CREATE TABLE Alamat (
    Alamat_Id INT IDENTITY PRIMARY KEY,
	Kecamatan VARCHAR(100),
	Kabupaten VARCHAR(100),
	Kota VARCHAR(30),
	Provinsi VARCHAR(100),
    Kode_Pos CHAR(5)
);

-- Table: Jabatan
CREATE TABLE Jabatan (
    Jabatan_Id TINYINT PRIMARY KEY,
    Nama_Jabatan VARCHAR(100) NOT NULL,
    Deskripsi_Jabatan TEXT
);

-- Table: Kategori_Skors
CREATE TABLE Kategori_Skors (
    Kategori_Skors_Id INT PRIMARY KEY,
    Nama_Kategori VARCHAR(100),
    Deskripsi_Kategori_Skors TEXT
);

-- Table: Divisi
CREATE TABLE Divisi (
    Divisi_Id TINYINT PRIMARY KEY,
    Nama_Divisi VARCHAR(100) NOT NULL,
    Jumlah_Anggota INT,
    Deskripsi_Divisi TEXT
);

-- Table: Rapat
CREATE TABLE Rapat (
    Rapat_Id INT PRIMARY KEY IDENTITY,
    Topik_Rapat VARCHAR(100) NOT NULL,
    Tanggal_Dilaksanakan DATE NOT NULL,
    Deskripsi_Rapat TEXT
);

ALTER TABLE Anggota
ALTER COLUMN Status_Skors_Id Int;

-- Table: Anggota
CREATE TABLE Anggota (
    Anggota_Id INT PRIMARY KEY IDENTITY,
    Nama VARCHAR(100) NOT NULL,
	First_Name VARCHAR(100) NOT NULL,
	Last_Name VARCHAR(100) NULL,
	Jenis_Kelamin VARCHAR (20) NOT NULL,
    NIM CHAR(9) UNIQUE NOT NULL,
    No_Handphone VARCHAR(20) NOT NULL,
    Tanggal_Bergabung DATE NOT NULL,
    Tanggal_Keluar DATE,
    Jabatan_Id TINYINT FOREIGN KEY REFERENCES Jabatan(Jabatan_Id),
    Status_Skors_Id INT,
    Alamat_Id INT FOREIGN KEY REFERENCES Alamat(Alamat_Id),
    Status_Keanggotaan_Id TINYINT FOREIGN KEY REFERENCES Status_Keanggotaan(Status_Keanggotaan_Id),
    Divisi_Id TINYINT FOREIGN KEY REFERENCES Divisi(Divisi_Id)
);

-- Table: Kehadiran
CREATE TABLE Kehadiran (
    Kehadiran_Id INT PRIMARY KEY IDENTITY,
    Status_Kehadiran CHAR(1) NOt NULL,
    Rapat_Id INT FOREIGN KEY REFERENCES Rapat(Rapat_Id) NOt NULL,
    Anggota_Id INT FOREIGN KEY REFERENCES Anggota(Anggota_Id) NOt NULL
);

-- Table: Skors
CREATE TABLE Skors (
    Skors_Id INT PRIMARY KEY IDENTITY,
    Kategori_Skors INT FOREIGN KEY REFERENCES Kategori_Skors(Kategori_Skors_Id) NOt NULL,
    Anggota_Id INT FOREIGN KEY REFERENCES Anggota(Anggota_Id) NOt NULL,
    Alasan VARCHAR(100) NOt NULL,
    Tanggal_Rekap DATE NOt NULL
);



-- Table: Performa
CREATE TABLE Performa (
    Performa_Id INT PRIMARY KEY IDENTITY,
    Anggota_Id INT FOREIGN KEY REFERENCES Anggota(Anggota_Id) NOt NULL,
    Catatan VARCHAR(100) NOT NULL,
    Tanggal_Rekap DATE NOT NULL
);

ALTER TABLE Skors
ALTER COLUMN Alasan Text;

ALTER TABLE Anggota 
DROP COLUMN Nama;