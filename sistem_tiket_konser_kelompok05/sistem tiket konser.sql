CREATE TABLE Users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    nama_user VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    no_telp VARCHAR(15)
);

CREATE TABLE Artists (	
    artist_id INT PRIMARY KEY AUTO_INCREMENT,
    nama_artist VARCHAR(100) NOT NULL,
    genre VARCHAR(50),
    negara_asal VARCHAR(50)
);

CREATE TABLE Venues (
    venue_id INT PRIMARY KEY AUTO_INCREMENT,
    nama_venue VARCHAR(100) NOT NULL,
    kota VARCHAR(50) NOT NULL,
    kapasitas INT NOT NULL
);

CREATE TABLE Concerts (
    concert_id INT PRIMARY KEY AUTO_INCREMENT,
    nama_konser VARCHAR(100) NOT NULL,
    tanggal_konser DATE NOT NULL,
    jam_konser TIME,
    artist_id INT,
    venue_id INT,
    FOREIGN KEY (artist_id) REFERENCES Artists(artist_id),
    FOREIGN KEY (venue_id) REFERENCES Venues(venue_id)
);

CREATE TABLE Ticket_Categories (
    category_id INT PRIMARY KEY AUTO_INCREMENT,
    nama_kategori VARCHAR(50) NOT NULL,
    harga DECIMAL(10, 2) NOT NULL
);

-- 1. Tabel Transaksi: Orders ( status_pembayaran ditambah opsi 'batal' )
CREATE TABLE Orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    tanggal_order DATETIME DEFAULT CURRENT_TIMESTAMP,
    total_bayar DECIMAL(10, 2) NOT NULL,
    status_pembayaran ENUM ('lunas', 'pending', 'batal'),   
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);


-- 2. Tabel Transaksi: Order_Details
CREATE TABLE Order_Details (
    detail_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    concert_id INT,
    category_id INT,
    jumlah_tiket INT NOT NULL,
    subtotal DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (concert_id) REFERENCES Concerts(concert_id),
    FOREIGN KEY (category_id) REFERENCES Ticket_Categories(category_id)
);

-- Insert Users
INSERT INTO Users (nama_user, email, no_telp) VALUES
('Rizky Pratama', 'rizky@email.com', '081234567890'),
('Siti Aminah', 'siti@email.com', '081234567891'),
('Budi Santoso', 'budi@email.com', '081234567892'),
('Dewi Lestari', 'dewi@email.com', '081234567893'),
('Eko Prasetyo', 'eko@email.com', '081234567894'),
('Fitriani', 'fitri@email.com', '081234567895'),
('Gilang Ramadhan', 'gilang@email.com', '081234567896'),
('Hany Handayani', 'hany@email.com', '081234567897'),
('Indra Wijaya', 'indra@email.com', '081234567898'),
('Joko Widodo', 'joko@email.com', '081234567899');

-- Insert Artists
INSERT INTO Artists (nama_artist, genre, negara_asal) VALUES
('SID', 'Punk Rock', 'Indonesia'),
('MCPR', 'Punk Rock', 'Indonesia'),
('The Cloves And The Tobacco', 'Celtic Punk', 'Indonesia'),
('Kelompok Penerbang Roket', 'Rock', 'Indonesia'),
('FSTVLST', 'Art Rock', 'Indonesia'),
('BurgerKill', 'Death Metal', 'Indonesia'),
('Sable Hills', 'Metalcore', 'Tokyo, Jepang'),
('Slank', 'Rock', 'Indonesia'),
('Anthrax', 'Thrash Metal', 'AS'),
('The Jeblogs', 'Rock Alternatif', 'Indonesia');

-- Insert Venues
INSERT INTO Venues (nama_venue, kota, kapasitas) VALUES
('Lapangan Bumi Marinir', 'Surabaya', 75000),
('Tirtayasa Park', 'Kediri', 10000),
('GOR Merdeka', 'Jombang', 15000),
('Jatim Expo', 'Surabaya', 20000),
('Surabaya Expo Center', 'Surabaya', 38000),
('NICE PIK 2', 'Tangerang', 5000),
('Stadion Maguwaharjo Park', 'Lombok', 25000),
('Ancol Beach City', 'Jakarta', 8000),
('Stadion Maguwoharjo', 'Yogyakarta', 30000),
('SM Boomi Carnival', 'Malang', 11000);

-- Insert Concerts
INSERT INTO Concerts (nama_konser, tanggal_konser, jam_konser, artist_id, venue_id) VALUES
('Rock In Surabaya', '2026-06-15','15:00:00', 1, 3),
('Festik', '2026-07-20','14:00:00', 2, 1),
('Utarakan Fest', '2026-06-28','18:00:00', 3, 10),
('NostalGila', '2026-08-05','15:00:00', 4, 1),
('Nicey Nice', '2026-06-10','14:00:00', 5, 5),
('HammerSonic', '2026-09-12','16:00:00', 6, 1),
('OriginFest', '2026-05-25','15:00:00', 7, 4),
('HS Slank', '2026-11-18','14:00:00', 8, 1),
('Jogja Rockarta', '2026-06-02','16:00:00', 9, 6),
('Rasvara Festival', '2026-10-01','18:00:00', 10, 2);

-- Insert Ticket_Categories (Data sudah dibersihkan dari typo koma)
INSERT INTO Ticket_Categories (nama_kategori, harga) VALUES
('Early Entry', 500000),
('Presale 1', 1000000),
('Presale 2', 1500000),
('Early Entry VIP', 3000000),
('VIP', 5000000),
('Early Bird', 1200000),
('Early Entry Regular', 850000),
('Presale 2 v2', 750000),
('Presale 1 v2', 2000000),
('Early Bird Premium', 3500000);

-- Insert Orders (Menggunakan value enum huruf kecil)
INSERT INTO Orders (user_id, tanggal_order, total_bayar, status_pembayaran) VALUES
(1, '2026-05-01 10:00:00', 3000000, 'lunas'),
(2, '2026-05-02 11:30:00', 1500000, 'lunas'),
(3, '2026-05-02 14:15:00', 6000000, 'lunas'),
(4, '2026-05-03 09:00:00', 1000000, 'pending'),
(5, '2026-05-04 19:45:00', 3500000, 'lunas'),
(6, '2026-05-05 08:20:00', 500000, 'lunas'),
(7, '2026-05-05 13:10:00', 2000000, 'batal'),
(8, '2026-05-06 16:00:00', 1500000, 'lunas'),
(9, '2026-05-07 21:05:00', 7000000, 'lunas'),
(10, '2026-05-08 11:50:00', 1200000, 'lunas');


-- Insert Order_Details
INSERT INTO Order_Details (order_id, concert_id, category_id, jumlah_tiket, subtotal) VALUES
(1, 2, 3, 2, 3000000),
(2, 3, 3, 1, 1500000),
(3, 4, 4, 2, 6000000),
(4, 1, 2, 1, 1000000),
(5, 6, 10, 1, 3500000),
(6, 7, 1, 1, 500000),
(7, 5, 9, 1, 2000000),
(8, 9, 3, 1, 1500000),
(9, 8, 10, 2, 7000000),
(10, 10, 6, 1, 1200000);

-- UPDATE: Mengubah status pembayaran order ID 4 menjadi 'lunas'
UPDATE Orders SET status_pembayaran = 'lunas' WHERE order_id = 4;

-- DELETE: Menghapus data order yang batal
DELETE FROM Order_Details WHERE order_id = 7;
DELETE FROM Orders WHERE order_id = 7;

-- QUERY 1: Menampilkan konser (Kolom typo sudah diperbaiki)
SELECT concert_id, nama_konser, tanggal_konser 
FROM Concerts 
WHERE tanggal_konser >= '2026-07-01';

-- QUERY 2: Detail Transaksi Lengkap
SELECT 
    o.order_id,
    u.nama_user,
    c.nama_konser,
    tc.nama_kategori,
    od.jumlah_tiket,
    od.subtotal,
    o.status_pembayaran
FROM Order_Details od
JOIN Orders o ON od.order_id = o.order_id
JOIN Users u ON o.user_id = u.user_id
JOIN Concerts c ON od.concert_id = c.concert_id
JOIN Ticket_Categories tc ON od.category_id = tc.category_id;

-- QUERY 3: Subquery User dengan pengeluaran di atas rata-rata
SELECT nama_user, email 
FROM Users 
WHERE user_id IN (
    SELECT user_id 
    FROM Orders 
    WHERE total_bayar > (SELECT AVG(total_bayar) FROM Orders)
);
	
-- VIEW: Laporan Penjualan Konser
CREATE OR REPLACE VIEW Laporan_Penjualan_Konser AS
SELECT 
    c.nama_konser AS 'Nama Konser',
    a.nama_artist AS 'Artis',
    SUM(od.jumlah_tiket) AS 'Total Tiket Terjual',
    SUM(od.subtotal) AS 'Total Pendapatan'
FROM Order_Details od
JOIN Concerts c ON od.concert_id = c.concert_id
JOIN Artists a ON c.artist_id = a.artist_id
JOIN Orders o ON od.order_id = o.order_id
WHERE o.status_pembayaran = 'lunas'
GROUP BY c.concert_id, c.nama_konser, a.nama_artist;

-- Test jalankan View
SELECT * FROM Laporan_Penjualan_Konser;