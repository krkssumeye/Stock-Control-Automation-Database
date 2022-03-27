CREATE TABLE TBL1_URUN_KATEGORÝ(
id INT PRIMARY KEY IDENTITY(1,1),
Kategori VARCHAR(50) NOT NULL
);
-------------------------------------------------------------
CREATE TABLE TBL2_CÝNSÝYET (
id INT PRIMARY KEY IDENTITY (1,1),
cinsiyet_türü VARCHAR(50) NOT NULL
);
---------------------------------------------------------------
CREATE TABLE TBL3_DEPO(
id INT PRIMARY KEY IDENTITY (1,1),
depo_adlarý VARCHAR(50) NOT NULL
);
---------------------------------------------------------------
CREATE TABLE TBL4_DEPO_PERSONEL(
id INT PRIMARY KEY IDENTITY (1,1),
isim VARCHAR (50) NOT NULL,
soyisim VARCHAR (50) NOT NULL,
telefon VARCHAR (50) NOT NULL,
);
-------------------------------------------------------------------
CREATE TABLE TBL5_DEPO_GÝRÝÞ_ÇIKIÞ(
id INT PRIMARY KEY IDENTITY (1,1),
depo_personel INT FOREIGN KEY REFERENCES TBL4_DEPO_PERSONEL(id),
giriþ_tarihi datetime,
çýkýþ_tarihi datetime,
depo_adý INT FOREIGN KEY REFERENCES TBL3_DEPO(id)
);
-----------------------------------------------------------------
CREATE TABLE TBL6_SEZONLAR(
id INT PRIMARY KEY IDENTITY(1,1),
sezon VARCHAR (50) NOT NULL,
);
----------------------------------------------------------------
CREATE TABLE TBL7_ÜRÜNLER(
id INT PRIMARY KEY IDENTITY (1,1),
ürün_adý VARCHAR(50) NOT NULL,
ürün_barkod VARCHAR(50) NOT NULL,
ürün_fiyat FLOAT (50) NOT NULL,
ürün_adeti INT NOT NULL,
);ALTER TABLE TBL7_ÜRÜNLER ADD ürün_kategori INT FOREIGN KEY REFERENCES TBL1_URUN_KATEGORÝ (id)


---------------------------------------------------------------------------------
CREATE TABLE TBL8_ÜRÜN_BÝLGÝLERÝ(
id INT PRIMARY KEY IDENTITY (1,1),
ürün_id INT FOREIGN KEY REFERENCES TBL7_ÜRÜNLER (id),
cinsiyet_id INT FOREIGN KEY REFERENCES TBL2_CÝNSÝYET(id),
sezon_id INT FOREIGN KEY REFERENCES TBL6_SEZONLAR (id)
);
---------------------------------------------------------------------------------------
CREATE TABLE TBL9_ÜRÜN_HAREKETLERÝ(
ürün_bilgileri_id INT FOREIGN KEY REFERENCES TBL8_ÜRÜN_BÝLGÝLERÝ,
depo_giriþ_çýkýþ_id INT FOREIGN KEY REFERENCES TBL5_DEPO_GÝRÝÞ_ÇIKIÞ
);
------------------------------------------------------------------------------------------

INSERT INTO TBL7_ÜRÜNLER VALUES ('PANÇO','PNÇ01',109.99,51,1) --Ürünler katagorisine ürün ekledim.
UPDATE TBL7_ÜRÜNLER SET ürün_adý = 'CROPTOP' ,ürün_fiyat=49.99,ürün_kategori=2, 
ürün_barkod = 'CRP01' WHERE ürün_adeti = 51 --daha sonra ürünün adýný, fiyatýný ve kategorisini deðiþtirdim
--where komutu kullanarak koþul koydum.
DELETE FROM TBL7_ÜRÜNLER WHERE ürün_adeti= 51-- daha sonra delete komutuyla silme iþlemi gerçekleþtirdim.

DELETE FROM TBL7_ÜRÜNLER WHERE id=12 --id numarsý 12 olan ürünü sildik

SELECT COUNT (ürün_adý) as SAYI FROM TBL7_ÜRÜNLER --ürün sayýsýný verir
select avg(ürün_fiyat) from TBL7_ÜRÜNLER -- ürünlerin fiyat ortalamasýný alýr.
SELECT DISTINCT isim FROM TBL4_DEPO_PERSONEL --personel tablosundan sadece isimleri çeker.

INSERT INTO TBL4_DEPO_PERSONEL VALUES ('SÜMEYYE','KARAKAÞ',0541-515-1424) -- personel tablosuna veri ekledik
DELETE FROM TBL4_DEPO_PERSONEL WHERE id = 14 --personel tablosundan id numarasýna göre veri sildik

SELECT*FROM TBL7_ÜRÜNLER WHERE ürün_fiyat BETWEEN 49.99 AND 109.99 --istediðimiz fiyat aralaðýnda ürün listeledik
SELECT*FROM TBL7_ÜRÜNLER WHERE ürün_kategori= 3 --kategori numarasý 3 olaný listeler
select CEILING (AVG(ürün_fiyat)) as usteyuvarla from TBL7_ÜRÜNLER -- ürünün fiyatýný yuvarlar
SELECT*FROM TBL7_ÜRÜNLER ORDER BY ürün_barkod --alfabetik sýraya göre barkod sýralar

SELECT*FROM TBL4_DEPO_PERSONEL WHERE isim LIKE '%e%' --isminde e harfi geçenleri yazar.

UPDATE TBL4_DEPO_PERSONEL SET isim= 'NERÝMAN', soyisim='GÜL' WHERE ÝD =3 
--Personel tablosunda 3. id sýrasýnda yazan ismi NERÝMAN olarak güncelledik.

SELECT  TBL4_DEPO_PERSONEL.isim, TBL4_DEPO_PERSONEL.soyisim, TBL5_DEPO_GÝRÝÞ_ÇIKIÞ.depo_adý
FROM TBL4_DEPO_PERSONEL INNER JOIN TBL5_DEPO_GÝRÝÞ_ÇIKIÞ ON TBL4_DEPO_PERSONEL.id = TBL5_DEPO_GÝRÝÞ_ÇIKIÞ.depo_personel
--inner join kullanarak iki tablodan istediðimiz verileri id numarsýna ve depo personeline göre birleþtirdik.


SELECT TBL9_ÜRÜN_HAREKETLERÝ.ürün_bilgileri_id , TBL7_ÜRÜNLER.ürün_adý 
FROM TBL9_ÜRÜN_HAREKETLERÝ INNER JOIN TBL7_ÜRÜNLER ON TBL9_ÜRÜN_HAREKETLERÝ.ürün_bilgileri_id = TBL7_ÜRÜNLER.id
--ürün bilgileriyle ürün isimlerini birleþtridik.

SELECT TBL4_DEPO_PERSONEL.isim, TBL9_ÜRÜN_HAREKETLERÝ.depo_giriþ_çýkýþ_id 
FROM TBL4_DEPO_PERSONEL INNER JOIN TBL9_ÜRÜN_HAREKETLERÝ ON TBL4_DEPO_PERSONEL.id =TBL9_ÜRÜN_HAREKETLERÝ.depo_giriþ_çýkýþ_id
--ürün hareketleri tablosundan giriþ çýkýþ yapýlan depo personellerini id numarsýyla isimlerini birleþtirdik

SELECT TBL2_CÝNSÝYET.cinsiyet_türü, TBL8_ÜRÜN_BÝLGÝLERÝ.cinsiyet_id 
FROM TBL2_CÝNSÝYET INNER JOIN TBL8_ÜRÜN_BÝLGÝLERÝ ON TBL2_CÝNSÝYET.id= TBL8_ÜRÜN_BÝLGÝLERÝ.cinsiyet_id
--ürünlerin hangi cinsiyete ait olduðunu ürün hareketleri tablosunda id numarasýna göre çektik daha sonra 
--bu id lere karþýlýk gelen cinsiyetleri yazdýrdýk.


SELECT TBL6_SEZONLAR.sezon, TBL8_ÜRÜN_BÝLGÝLERÝ.sezon_id FROM TBL6_SEZONLAR 
INNER JOIN TBL8_ÜRÜN_BÝLGÝLERÝ ON TBL6_SEZONLAR.id=TBL8_ÜRÜN_BÝLGÝLERÝ.sezon_id
--ürün bilgileri tablosundan ürünlerin hangi sezona denk geldiðini aldýk daha sonra 
--sezonlarýn id numarasýna karþýlýk gelen verileri yazdýrdýk.

SELECT TBL8_ÜRÜN_BÝLGÝLERÝ.ürün_id, TBL6_SEZONLAR.sezon 
FROM TBL8_ÜRÜN_BÝLGÝLERÝ INNER JOIN TBL6_SEZONLAR ON TBL8_ÜRÜN_BÝLGÝLERÝ.ürün_id = TBL6_SEZONLAR.id WHERE sezon = 'YAZ'
--yaz mevsiminin id sine göre ürün bilgilerinden ayný id ye sahip veriyi birleþtirdik.



SELECT*FROM TBL1_URUN_KATEGORÝ
SELECT*FROM TBL2_CÝNSÝYET
SELECT*FROM TBL3_DEPO
SELECT*FROM TBL4_DEPO_PERSONEL
SELECT*FROM TBL5_DEPO_GÝRÝÞ_ÇIKIÞ
SELECT*FROM TBL6_SEZONLAR
SELECT*FROM TBL7_ÜRÜNLER
SELECT*FROM TBL8_ÜRÜN_BÝLGÝLERÝ
SELECT*FROM TBL9_ÜRÜN_HAREKETLERÝ
--tablolarý görmek için select komutuyla çaðýrdýk