USE [Sumber Daya Manusia HMTIF];

-- Table: Status_Keanggotaan
CREATE TABLE Status_Keanggotaan (
    Status_Id TINYINT PRIMARY KEY,
    Status_Sekarang VARCHAR(50) NOT NULL
);

-- Table: Alamat
CREATE TABLE Alamat (
    Alamat_Id INT IDENTITY PRIMARY KEY,
    Domisili VARCHAR(100),
    Kota VARCHAR(30),
    Kode_Pos CHAR(5)
);

-- Table: Jabatan
CREATE TABLE Jabatan (
    Jabatan_Id TINYINT PRIMARY KEY,
    NamaJabatan VARCHAR(100) NOT NULL,
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
    Rapat_Id INT PRIMARY KEY,
    Topik_Rapat VARCHAR(100),
    Tanggal_Dilaksanakan DATE,
    Deskripsi_Rapat TEXT
);

-- Table: Anggota
CREATE TABLE Anggota (
    Anggota_Id INT IDENTITY PRIMARY KEY,
    Nama VARCHAR(100) NOT NULL,
    NIM CHAR(9) UNIQUE NOT NULL,
    No_Handphone VARCHAR(20) NOT NULL,
    Tanggal_Bergabung DATE NOT NULL,
    Tanggal_Keluar DATE,
    Jabatan_Id TINYINT FOREIGN KEY REFERENCES Jabatan(Jabatan_Id),
    Status_Skors CHAR(1),
    Alamat_Id INT FOREIGN KEY REFERENCES Alamat(Alamat_Id),
    Status_Keanggotaan_Id TINYINT FOREIGN KEY REFERENCES Status_Keanggotaan(Status_Id),
    Divisi_Id TINYINT FOREIGN KEY REFERENCES Divisi(Divisi_Id)
);

-- Table: Kehadiran
CREATE TABLE Kehadiran (
    Kehadiran_Id INT PRIMARY KEY,
    Status_Kehadiran CHAR(1),
    Rapat_Id INT FOREIGN KEY REFERENCES Rapat(Rapat_Id),
    Anggota_Id INT FOREIGN KEY REFERENCES Anggota(Anggota_Id)
);

-- Table: Skors
CREATE TABLE Skors (
    Skors_Id INT PRIMARY KEY,
    Kategori_Skors INT FOREIGN KEY REFERENCES Kategori_Skors(Kategori_Skors_Id),
    Anggota_Id INT FOREIGN KEY REFERENCES Anggota(Anggota_Id),
    Alasan VARCHAR(100),
    Tanggal_Skors DATE
);

-- Table: Performa
CREATE TABLE Performa (
    Performa_Id INT PRIMARY KEY,
    Anggota_Id INT FOREIGN KEY REFERENCES Anggota(Anggota_Id),
    Catatan VARCHAR(100),
    Tanggal_Rekap DATE
);