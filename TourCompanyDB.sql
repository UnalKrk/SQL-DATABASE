CREATE DATABASE TourCompany;
---------------------- TABLOLAR OLUÞTURULUYOR --------------------------
GO

USE TourCompany
-- Gender table
CREATE TABLE Gender (
    Id int PRIMARY KEY IDENTITY(1,1) NOT NULL,
    Type nvarchar(50) NOT NULL,
    CreateDate datetime DEFAULT getdate()
);

-- Guide table
CREATE TABLE Guide (
    Id int PRIMARY KEY IDENTITY(1,1) NOT NULL,
    Name nvarchar(50) NOT NULL,
    Surname nvarchar(50) NOT NULL,
    ContactNumber nvarchar(15) NOT NULL,
    Address nvarchar(256) DEFAULT 'Bilinmiyor' NOT NULL,
    MailAddress nvarchar(50) NOT NULL,
    GenderId int NOT NULL,
    CreateDate datetime DEFAULT getdate(),
    FOREIGN KEY (GenderId) REFERENCES Gender(Id)
);

-- Language table
CREATE TABLE Language (
    Id int IDENTITY(1,1) NOT NULL,
    Code nvarchar(10) PRIMARY KEY NOT NULL,
    Name nvarchar(50) NOT NULL,
    CreateDate datetime DEFAULT getdate()
);

-- PriceType table
CREATE TABLE PriceType (
    Id int PRIMARY KEY IDENTITY(1,1) NOT NULL,
    Name nvarchar(50) NOT NULL,
    CreateDate datetime DEFAULT getdate()
);

-- Country table
CREATE TABLE Country (
    Id int IDENTITY(1,1) NOT NULL,
    Code nvarchar(10) PRIMARY KEY NOT NULL,
    Name nvarchar(50) NOT NULL,
    Nationality nvarchar(50) UNIQUE NOT NULL,
    CreateDate datetime DEFAULT getdate()
);

-- Currency table
CREATE TABLE Currency (
    Id int PRIMARY KEY IDENTITY(1,1) NOT NULL,
    Name nvarchar(20) NOT NULL,
    ExchangeRate decimal(15,2) NOT NULL,
    CreateDate datetime DEFAULT getdate()
);

-- Tourist table
CREATE TABLE Tourist (
    Id int PRIMARY KEY IDENTITY(1,1) NOT NULL,
    Name nvarchar(50) NOT NULL,
    Surname nvarchar(50) NOT NULL,
    BirthDate datetime NOT NULL,
    ArrivalDate datetime NOT NULL,
    GenderId int,
    CountryCode nvarchar(10),
    Nationality nvarchar(50),
    CreateDate datetime DEFAULT getdate(),
    FOREIGN KEY (GenderId) REFERENCES Gender(Id),
    FOREIGN KEY (CountryCode) REFERENCES Country(Code),
    FOREIGN KEY (Nationality) REFERENCES Country(Nationality)
);

-- TouristArea table
CREATE TABLE TouristArea (
    Id int PRIMARY KEY IDENTITY(1,1) NOT NULL,
    Name nvarchar(50) NOT NULL,
    Price decimal(15,2) NOT NULL,
    PriceTypeId int NOT NULL,
    CurrencyId int NOT NULL,
    CreateDate datetime DEFAULT getdate(),
    FOREIGN KEY (PriceTypeId) REFERENCES PriceType(Id),
    FOREIGN KEY (CurrencyId) REFERENCES Currency(Id)
);

-- GuideLanguage table
CREATE TABLE GuideLanguage (
    Id int PRIMARY KEY IDENTITY(1,1) NOT NULL,
    GuideId int NOT NULL,
    LanguageCode nvarchar(10) NOT NULL,
    CreateDate datetime DEFAULT getdate(),
    FOREIGN KEY (GuideId) REFERENCES Guide(Id),
    FOREIGN KEY (LanguageCode) REFERENCES Language(Code)
);

-- PaymentType table
CREATE TABLE PaymentType (
    Id int PRIMARY KEY IDENTITY(1,1) NOT NULL,
    Name nvarchar(50) NOT NULL,
    CreateDate datetime DEFAULT getdate()
);

-- Order table
CREATE TABLE [Order] (
    Id int PRIMARY KEY IDENTITY(1,1) NOT NULL,
    PaymentTypeId int NOT NULL,
    TotalPrice decimal(15,2) NOT NULL,
    WhoPaid int NOT NULL,
    TravelDate datetime NOT NULL,
    CreateDate datetime DEFAULT getdate(),
    FOREIGN KEY (PaymentTypeId) REFERENCES PaymentType(Id),
    FOREIGN KEY (WhoPaid) REFERENCES Tourist(Id)
);


-- OrderDetail table
CREATE TABLE OrderDetail (
    Id int PRIMARY KEY IDENTITY(1,1) NOT NULL,
    OrderId int NOT NULL,
    TouristAreaId int NOT NULL,
    GuideId int NOT NULL,
    TouristId int NOT NULL,
    Price decimal(15,2) NOT NULL,
    CreateDate datetime DEFAULT getdate(),
    FOREIGN KEY (TouristAreaId) REFERENCES TouristArea(Id),
    FOREIGN KEY (GuideId) REFERENCES Guide(Id),
    FOREIGN KEY (TouristId) REFERENCES Tourist(Id),
    FOREIGN KEY (OrderId) REFERENCES [Order](Id),
);

------------------------- KAYITLAR EKLENIIYOR ---------------------------


--Cinsiyet Kayýtlarýný Ekleme
INSERT INTO Gender (Type, CreateDate)
VALUES 
    ('Erkek', GETDATE()),
    ('Kadýn', GETDATE());


--Döviz Kurlarýný Ekleme
INSERT INTO Currency (Name, ExchangeRate, CreateDate)
VALUES 
    ('Dolar', 31.34, GETDATE()),
    ('Euro', 34.02, GETDATE()),
    ('Sterlin', 39.71, GETDATE()),
    ('TL', 1, GETDATE());

--Ülkeleri Ekleme
INSERT INTO Country (Code, Name, Nationality)
VALUES 
    ('GR', 'Germany', 'Dutch'),
    ('UK', 'United Kingdom', 'English'),
    ('FN', 'Finland', 'Finnish'),
    ('GRC', 'Greece', 'Greek'),
    ('IT', 'Italy', 'Italian'),
    ('JA', 'Japan', 'Japanese'),
    ('UKR', 'Ukraine', 'Ukrainian');

--Dilleri Ekleme
INSERT INTO Language (Code, Name, CreateDate)
VALUES 
    ('UK', 'English', GETDATE()),
    ('TR', 'Turkish', GETDATE()),
    ('FR', 'French', GETDATE()),
    ('GR', 'German', GETDATE()),
    ('ES', 'Spanish', GETDATE()),
    ('IT', 'Italian', GETDATE()),
    ('RU', 'Russian', GETDATE()),
    ('ZH', 'Chinese', GETDATE()),
    ('AR', 'Arabic', GETDATE()),
    ('HI', 'Hindi', GETDATE()),
    ('BN', 'Bengali', GETDATE()),
    ('PT', 'Portuguese', GETDATE()),
    ('JA', 'Japanese', GETDATE()),
    ('KO', 'Korean', GETDATE()),
    ('VI', 'Vietnamese', GETDATE()),
    ('FA', 'Persian', GETDATE()),
    ('NL', 'Dutch', GETDATE()),
    ('PL', 'Polish', GETDATE()),
    ('FN', 'Finnish', GETDATE()),
    ('UKR', 'Ukrainian', GETDATE()),
    ('GRC', 'Greece', GETDATE());

--Ödeme Türleri Ekleme
INSERT INTO PaymentType (Name, CreateDate)
VALUES 
    ('Nakit', GETDATE()),
    ('Kredi Kartý', GETDATE());


--Fiyatlandýrma Tipi Ekleme
INSERT INTO PriceType (Name, CreateDate)
VALUES 
    ('Yarým', GETDATE()),
    ('Tam', GETDATE()),
    ('Ýndirimli', GETDATE());


--Turistik Yerleri Ekleme
INSERT INTO TouristArea (Name, Price, PriceTypeId, CurrencyId)
VALUES 
    ('Adalar', 100, 1, 4), ('Adalar', 200, 2, 4), ('Adalar', 150, 3, 4),
    ('Anadolu Hisarý', 150, 1, 4), ('Anadolu Hisarý', 300, 2, 4), ('Anadolu Hisarý', 225, 3, 4),
    ('Atatürk Arboretumu', 200, 1, 4), ('Atatürk Arboretumu', 400, 2, 4), ('Atatürk Arboretumu', 300, 3, 4),
    ('Ayasofya', 250, 1, 4), ('Ayasofya', 500, 2, 4), ('Ayasofya', 375, 3, 4),
    ('Dolmabahçe Sarayý', 300, 1, 4), ('Dolmabahçe Sarayý', 600, 2, 4), ('Dolmabahçe Sarayý', 450, 3, 4),
    ('Eyüp Sultan Camii', 350, 1, 4), ('Eyüp Sultan Camii', 700, 2, 4), ('Eyüp Sultan Camii', 525, 3, 4),
    ('Kapalý çarþý', 400, 1, 4), ('Kapalý çarþý', 800, 2, 4), ('Kapalý çarþý', 600, 3, 4),
    ('Kýz kulesi', 450, 1, 4), ('Kýz kulesi', 900, 2, 4), ('Kýz kulesi', 675, 3, 4),
    ('Mýsýr Çarþýsý', 500, 1, 4), ('Mýsýr Çarþýsý', 1000, 2, 4), ('Mýsýr Çarþýsý', 750, 3, 4),
    ('Miniatürk', 550, 1, 4), ('Miniatürk', 1100, 2, 4), ('Miniatürk', 875, 3, 4),
    ('Pierre Loti', 600, 1, 4), ('Pierre Loti', 1200, 2, 4), ('Pierre Loti', 900, 3, 4),
    ('Rumeli Hisarý', 650, 1, 4), ('Rumeli Hisarý', 1300, 2, 4), ('Rumeli Hisarý', 975, 3, 4),
    ('Sultan Ahmet Camii', 700, 1, 4), ('Sultan Ahmet Camii', 1400, 2, 4), ('Sultan Ahmet Camii', 1100, 3, 4),
    ('Yerebatan Sarnýcý', 750, 1, 4), ('Yerebatan Sarnýcý', 1500, 2, 4), ('Yerebatan Sarnýcý', 1125, 3, 4);


-- Rehberleri Ekleme
INSERT INTO Guide (Name, Surname, ContactNumber, Address, MailAddress, GenderId, CreateDate)
VALUES 
    ('Ozan', 'Temiz', '5556544343', 'Bodrum', 'ozan@example.com', 1, GETDATE()),
    ('Bahar', 'Sevgin', '5556544344', 'Adana', 'bahar@example.com', 2, GETDATE()),
    ('Ömer', 'Uçar', '5556544345', 'Bilinmiyor', 'omer@example.com', 1, GETDATE()),
    ('Sevgi', 'Çakmak', '5556544346', 'Ýstanbul', 'sevgi@example.com', 2, GETDATE()),
    ('Linda', 'Callahan', '5556544349', 'Antalya', 'linda@example.com', 2, GETDATE());


-- Turistleri Ekleme
INSERT INTO Tourist (Name, Surname, BirthDate, ArrivalDate, GenderId, CountryCode, Nationality)
VALUES
('Levi', 'Acevedo', '2001-11-06', '2022-01-11', 2, 'IT', 'Japanese'),
('Basil', 'Aguilar', '2005-04-22', '2022-08-11', 1, 'GRC', 'Greek'),
('Zenaida', 'Holder', '1990-09-01', '2022-04-02', 1, 'GRC', 'Finnish'),
('Illana', 'Browning', '2001-01-28', '2023-01-05', 2, 'UK', 'Greek'),
('Raja', 'Duke', '1993-07-27', '2021-08-09', 1, 'GR', 'Dutch'),
('Isaiah', 'Valdez', '2012-01-16', '2022-08-09', 1, 'FN', 'Finnish'),
('Gray', 'Marshall', '1990-11-21', '2022-07-08', 2, 'JA', 'Japanese'),
('Ora', 'Fletcher', '2008-01-19', '2023-03-04', 2, 'UK', 'English'),
('Lavinia', 'Lloyd', '1996-10-26', '2021-06-03', 2, 'UK', 'English'),
('Jenna', 'Williams', '1992-05-01', '2022-06-11', 2, 'GRC', 'Greek'),
('Christian', 'Nash', '1990-09-08', '2022-05-02', 1, 'UK', 'English'),
('Basil', 'Aguilar', '2020-04-22', '2021-09-09', 1, 'GRC', 'Greek'),
('Brianna', 'Everett', '1988-09-03', '2022-09-04', 1, 'JA', 'Japanese'),
('Geoffrey', 'Knowles', '1995-02-17', '2022-06-01', 1, 'UKR', 'Ukrainian'),
('Quinn', 'Hamilton', '1950-07-10', '2021-04-12', 1, 'UK', 'English');


-- Rehberlerin Dil Bilgisini Ekleme
INSERT INTO GuideLanguage (GuideId, LanguageCode)
VALUES 
    (1, 'IT'),
    (1, 'UK'),
    (1, 'FN'),
    (2, 'GRC'),
    (2, 'UK'),
    (2, 'GR'),
    (3, 'GRC'),
    (3, 'UK'),
    (4, 'GRC'),
    (4, 'UK'),
    (5, 'JA'),
    (5, 'UKR');


-- Order tablosuna 20 kayýt ekleme
INSERT INTO [dbo].[Order] (PaymentTypeId, TotalPrice, WhoPaid, TravelDate, CreateDate)
VALUES
(1, 1850.00, 3, '2024-03-06 23:13:03.657', '2024-03-01 23:13:03.657'),
(2, 1525.00, 7, '2024-03-21 23:13:03.657', '2024-03-01 23:13:03.657'),
(1, 675.00, 7, '2024-03-15 23:13:03.657', '2024-03-01 23:13:03.657'),
(2, 3200.00, 15, '2024-03-11 23:13:03.657', '2024-03-01 23:13:03.657'),
(1, 400.00, 8, '2024-03-03 23:13:03.657', '2024-03-01 23:13:03.657'),
(2, 900.00, 11, '2024-03-30 23:13:03.657', '2024-03-01 23:13:03.657'),
(1, 2700.00, 13, '2024-03-25 23:13:03.657', '2024-03-01 23:13:03.657'),
(2, 1300.00, 14, '2024-03-04 23:13:03.657', '2024-03-01 23:13:03.657'),
(1, 1525.00, 5, '2024-03-29 23:13:03.657', '2024-03-01 23:13:03.657'),
(1, 300.00, 10, '2024-03-02 23:13:03.660', '2024-03-01 23:13:03.660'),
(2, 1400.00, 1, '2024-03-17 23:13:03.660', '2024-03-01 23:13:03.660'),
(1, 325.00, 11, '2024-03-13 23:13:03.660', '2024-03-01 23:13:03.660'),
(1, 2100.00, 4, '2024-03-24 23:13:03.660', '2024-03-01 23:13:03.660'),
(2, 2750.00, 14, '2024-03-18 23:13:03.660', '2024-03-01 23:13:03.660'),
(2, 4100.00, 1, '2024-03-19 23:13:03.660', '2024-03-01 23:13:03.660'),
(2, 1725.00, 9, '2024-03-25 23:13:03.660', '2024-03-01 23:13:03.660'),
(2, 3750.00, 13, '2024-03-19 23:13:03.660', '2024-03-01 23:13:03.660'),
(2, 3725.00, 14, '2024-03-25 23:13:03.660', '2024-03-01 23:13:03.660');




-- OrderDetail tablosuna 55 kayýt ekleme
INSERT INTO OrderDetail (OrderId, TouristAreaId, GuideId, TouristId, Price, CreateDate)
VALUES
(1, 1, 1, 15, 100.00, '2024-03-01 23:13:03.663'),
(1, 28, 4, 3, 550.00, '2024-03-01 23:13:03.667'),
(1, 25, 1, 4, 500.00, '2024-03-01 23:13:03.667'),
(1, 17, 5, 2, 700.00, '2024-03-01 23:13:03.670'),
(2, 14, 1, 15, 600.00, '2024-03-01 23:13:03.670'),
(2, 19, 5, 12, 400.00, '2024-03-01 23:13:03.663'),
(2, 18, 3, 7, 525.00, '2024-03-01 23:13:03.663'),
(3, 24, 2, 7, 675.00, '2024-03-01 23:13:03.663'),
(4, 29, 3, 8, 1100.00, '2024-03-01 23:13:03.667'),
(4, 25, 2, 15, 500.00, '2024-03-01 23:13:03.667'),
(4, 26, 1, 4, 1000.00, '2024-03-01 23:13:03.670'),
(4, 31, 2, 10, 600.00, '2024-03-01 23:13:03.670'),
(5, 8, 1, 8, 400.00, '2024-03-01 23:13:03.670'),
(6, 23, 3, 11, 900.00, '2024-03-01 23:13:03.663'),
(7, 24, 1, 9, 675.00, '2024-03-01 23:13:03.667'),
(7, 14, 1, 13, 600.00, '2024-03-01 23:13:03.667'),
(7, 36, 4, 10, 975.00, '2024-03-01 23:13:03.670'),
(7, 15, 5, 11, 450.00, '2024-03-01 23:13:03.670'),
(8, 35, 5, 14, 1300.00, '2024-03-01 23:13:03.670'),
(9, 42, 1, 10, 1125.00, '2024-03-01 23:13:03.667'),
(9, 19, 1, 5, 400.00, '2024-03-01 23:13:03.663'),
(10, 13, 4, 10, 300.00, '2024-03-01 23:13:03.670'),
(11, 31, 1, 11, 600.00, '2024-03-01 23:13:03.667'),
(11, 8, 3, 2, 400.00, '2024-03-01 23:13:03.667'),
(11, 19, 1, 1, 400.00, '2024-03-01 23:13:03.663'),
(12, 6, 2, 11, 225.00, '2024-03-01 23:13:03.663'),
(12, 1, 5, 11, 100.00, '2024-03-01 23:13:03.667'),
(13, 9, 5, 13, 300.00, '2024-03-01 23:13:03.667'),
(13, 20, 1, 4, 800.00, '2024-03-01 23:13:03.663'),
(13, 1, 2, 14, 100.00, '2024-03-01 23:13:03.670'),
(13, 14, 1, 5, 600.00, '2024-03-01 23:13:03.670'),
(13, 9, 2, 6, 300.00, '2024-03-01 23:13:03.670'),
(14, 8, 3, 15, 400.00, '2024-03-01 23:13:03.670'),
(14, 40, 1, 7, 750.00, '2024-03-01 23:13:03.663'),
(14, 29, 5, 14, 1100.00, '2024-03-01 23:13:03.667'),
(14, 25, 1, 5, 500.00, '2024-03-01 23:13:03.670'),
(15, 39, 5, 2, 1100.00, '2024-03-01 23:13:03.667'),
(15, 22, 5, 1, 450.00, '2024-03-01 23:13:03.663'),
(15, 16, 4, 8, 350.00, '2024-03-01 23:13:03.667'),
(15, 26, 4, 11, 1000.00, '2024-03-01 23:13:03.670'),
(15, 32, 5, 9, 1200.00, '2024-03-01 23:13:03.670'),
(16, 18, 2, 7, 525.00, '2024-03-01 23:13:03.670'),
(16, 26, 3, 9, 1000.00, '2024-03-01 23:13:03.663'),
(16, 7, 1, 9, 200.00, '2024-03-01 23:13:03.667'),
(17, 24, 5, 1, 675.00, '2024-03-01 23:13:03.663'),
(17, 35, 5, 8, 1300.00, '2024-03-01 23:13:03.667'),
(17, 40, 5, 10, 750.00, '2024-03-01 23:13:03.670'),
(17, 30, 3, 13, 875.00, '2024-03-01 23:13:03.670'),
(17, 3, 1, 14, 150.00, '2024-03-01 23:13:03.670'),
(18, 23, 2, 9, 900.00, '2024-03-01 23:13:03.670'),
(18, 36, 2, 7, 975.00, '2024-03-01 23:13:03.667'),
(18, 4, 3, 2, 150.00, '2024-03-01 23:13:03.670'),
(18, 37, 5, 14, 700.00, '2024-03-01 23:13:03.670'),
(18, 26, 1, 11, 1000.00, '2024-03-01 23:13:03.670');