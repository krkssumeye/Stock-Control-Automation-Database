CREATE TABLE TBL1_URUN_KATEGOR�(
id INT PRIMARY KEY IDENTITY(1,1),
Kategori VARCHAR(50) NOT NULL
);
-------------------------------------------------------------
CREATE TABLE TBL2_C�NS�YET (
id INT PRIMARY KEY IDENTITY (1,1),
cinsiyet_t�r� VARCHAR(50) NOT NULL
);
---------------------------------------------------------------
CREATE TABLE TBL3_DEPO(
id INT PRIMARY KEY IDENTITY (1,1),
depo_adlar� VARCHAR(50) NOT NULL
);
---------------------------------------------------------------
CREATE TABLE TBL4_DEPO_PERSONEL(
id INT PRIMARY KEY IDENTITY (1,1),
isim VARCHAR (50) NOT NULL,
soyisim VARCHAR (50) NOT NULL,
telefon VARCHAR (50) NOT NULL,
);
-------------------------------------------------------------------
CREATE TABLE TBL5_DEPO_G�R��_�IKI�(
id INT PRIMARY KEY IDENTITY (1,1),
depo_personel INT FOREIGN KEY REFERENCES TBL4_DEPO_PERSONEL(id),
giri�_tarihi datetime,
��k��_tarihi datetime,
depo_ad� INT FOREIGN KEY REFERENCES TBL3_DEPO(id)
);
-----------------------------------------------------------------
CREATE TABLE TBL6_SEZONLAR(
id INT PRIMARY KEY IDENTITY(1,1),
sezon VARCHAR (50) NOT NULL,
);
----------------------------------------------------------------
CREATE TABLE TBL7_�R�NLER(
id INT PRIMARY KEY IDENTITY (1,1),
�r�n_ad� VARCHAR(50) NOT NULL,
�r�n_barkod VARCHAR(50) NOT NULL,
�r�n_fiyat FLOAT (50) NOT NULL,
�r�n_adeti INT NOT NULL,
);ALTER TABLE TBL7_�R�NLER ADD �r�n_kategori INT FOREIGN KEY REFERENCES TBL1_URUN_KATEGOR� (id)


---------------------------------------------------------------------------------
CREATE TABLE TBL8_�R�N_B�LG�LER�(
id INT PRIMARY KEY IDENTITY (1,1),
�r�n_id INT FOREIGN KEY REFERENCES TBL7_�R�NLER (id),
cinsiyet_id INT FOREIGN KEY REFERENCES TBL2_C�NS�YET(id),
sezon_id INT FOREIGN KEY REFERENCES TBL6_SEZONLAR (id)
);
---------------------------------------------------------------------------------------
CREATE TABLE TBL9_�R�N_HAREKETLER�(
�r�n_bilgileri_id INT FOREIGN KEY REFERENCES TBL8_�R�N_B�LG�LER�,
depo_giri�_��k��_id INT FOREIGN KEY REFERENCES TBL5_DEPO_G�R��_�IKI�
);
------------------------------------------------------------------------------------------

INSERT INTO TBL7_�R�NLER VALUES ('PAN�O','PN�01',109.99,51,1) --�r�nler katagorisine �r�n ekledim.
UPDATE TBL7_�R�NLER SET �r�n_ad� = 'CROPTOP' ,�r�n_fiyat=49.99,�r�n_kategori=2, 
�r�n_barkod = 'CRP01' WHERE �r�n_adeti = 51 --daha sonra �r�n�n ad�n�, fiyat�n� ve kategorisini de�i�tirdim
--where komutu kullanarak ko�ul koydum.
DELETE FROM TBL7_�R�NLER WHERE �r�n_adeti= 51-- daha sonra delete komutuyla silme i�lemi ger�ekle�tirdim.

DELETE FROM TBL7_�R�NLER WHERE id=12 --id numars� 12 olan �r�n� sildik

SELECT COUNT (�r�n_ad�) as SAYI FROM TBL7_�R�NLER --�r�n say�s�n� verir
select avg(�r�n_fiyat) from TBL7_�R�NLER -- �r�nlerin fiyat ortalamas�n� al�r.
SELECT DISTINCT isim FROM TBL4_DEPO_PERSONEL --personel tablosundan sadece isimleri �eker.

INSERT INTO TBL4_DEPO_PERSONEL VALUES ('S�MEYYE','KARAKA�',0541-515-1424) -- personel tablosuna veri ekledik
DELETE FROM TBL4_DEPO_PERSONEL WHERE id = 14 --personel tablosundan id numaras�na g�re veri sildik

SELECT*FROM TBL7_�R�NLER WHERE �r�n_fiyat BETWEEN 49.99 AND 109.99 --istedi�imiz fiyat arala��nda �r�n listeledik
SELECT*FROM TBL7_�R�NLER WHERE �r�n_kategori= 3 --kategori numaras� 3 olan� listeler
select CEILING (AVG(�r�n_fiyat)) as usteyuvarla from TBL7_�R�NLER -- �r�n�n fiyat�n� yuvarlar
SELECT*FROM TBL7_�R�NLER ORDER BY �r�n_barkod --alfabetik s�raya g�re barkod s�ralar

SELECT*FROM TBL4_DEPO_PERSONEL WHERE isim LIKE '%e%' --isminde e harfi ge�enleri yazar.

UPDATE TBL4_DEPO_PERSONEL SET isim= 'NER�MAN', soyisim='G�L' WHERE �D =3 
--Personel tablosunda 3. id s�ras�nda yazan ismi NER�MAN olarak g�ncelledik.

SELECT  TBL4_DEPO_PERSONEL.isim, TBL4_DEPO_PERSONEL.soyisim, TBL5_DEPO_G�R��_�IKI�.depo_ad�
FROM TBL4_DEPO_PERSONEL INNER JOIN TBL5_DEPO_G�R��_�IKI� ON TBL4_DEPO_PERSONEL.id = TBL5_DEPO_G�R��_�IKI�.depo_personel
--inner join kullanarak iki tablodan istedi�imiz verileri id numars�na ve depo personeline g�re birle�tirdik.


SELECT TBL9_�R�N_HAREKETLER�.�r�n_bilgileri_id , TBL7_�R�NLER.�r�n_ad� 
FROM TBL9_�R�N_HAREKETLER� INNER JOIN TBL7_�R�NLER ON TBL9_�R�N_HAREKETLER�.�r�n_bilgileri_id = TBL7_�R�NLER.id
--�r�n bilgileriyle �r�n isimlerini birle�tridik.

SELECT TBL4_DEPO_PERSONEL.isim, TBL9_�R�N_HAREKETLER�.depo_giri�_��k��_id 
FROM TBL4_DEPO_PERSONEL INNER JOIN TBL9_�R�N_HAREKETLER� ON TBL4_DEPO_PERSONEL.id =TBL9_�R�N_HAREKETLER�.depo_giri�_��k��_id
--�r�n hareketleri tablosundan giri� ��k�� yap�lan depo personellerini id numars�yla isimlerini birle�tirdik

SELECT TBL2_C�NS�YET.cinsiyet_t�r�, TBL8_�R�N_B�LG�LER�.cinsiyet_id 
FROM TBL2_C�NS�YET INNER JOIN TBL8_�R�N_B�LG�LER� ON TBL2_C�NS�YET.id= TBL8_�R�N_B�LG�LER�.cinsiyet_id
--�r�nlerin hangi cinsiyete ait oldu�unu �r�n hareketleri tablosunda id numaras�na g�re �ektik daha sonra 
--bu id lere kar��l�k gelen cinsiyetleri yazd�rd�k.


SELECT TBL6_SEZONLAR.sezon, TBL8_�R�N_B�LG�LER�.sezon_id FROM TBL6_SEZONLAR 
INNER JOIN TBL8_�R�N_B�LG�LER� ON TBL6_SEZONLAR.id=TBL8_�R�N_B�LG�LER�.sezon_id
--�r�n bilgileri tablosundan �r�nlerin hangi sezona denk geldi�ini ald�k daha sonra 
--sezonlar�n id numaras�na kar��l�k gelen verileri yazd�rd�k.

SELECT TBL8_�R�N_B�LG�LER�.�r�n_id, TBL6_SEZONLAR.sezon 
FROM TBL8_�R�N_B�LG�LER� INNER JOIN TBL6_SEZONLAR ON TBL8_�R�N_B�LG�LER�.�r�n_id = TBL6_SEZONLAR.id WHERE sezon = 'YAZ'
--yaz mevsiminin id sine g�re �r�n bilgilerinden ayn� id ye sahip veriyi birle�tirdik.



SELECT*FROM TBL1_URUN_KATEGOR�
SELECT*FROM TBL2_C�NS�YET
SELECT*FROM TBL3_DEPO
SELECT*FROM TBL4_DEPO_PERSONEL
SELECT*FROM TBL5_DEPO_G�R��_�IKI�
SELECT*FROM TBL6_SEZONLAR
SELECT*FROM TBL7_�R�NLER
SELECT*FROM TBL8_�R�N_B�LG�LER�
SELECT*FROM TBL9_�R�N_HAREKETLER�
--tablolar� g�rmek i�in select komutuyla �a��rd�k