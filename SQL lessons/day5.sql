--------------DAY'5---------------------
--24.veriyi UPDATE etme:
--SYNTAX:UPDATE table_name SET column1=yeni değer,colum2=yeni değer2  WHERE koşul

CREATE TABLE tedarikciler -- parent
(
vergi_no int PRIMARY KEY,
firma_ismi VARCHAR(50),
irtibat_ismi VARCHAR(50)
);
INSERT INTO tedarikciler VALUES (101, 'IBM', 'Kim Yon');
INSERT INTO tedarikciler VALUES (102, 'Huawei', 'Çin Li');
INSERT INTO tedarikciler VALUES (103, 'Erikson', 'Maki Tammen');
INSERT INTO tedarikciler VALUES (104, 'Apple', 'Adam Eve');

CREATE TABLE urunler -- child
(
ted_vergino int, 
urun_id int, 
urun_isim VARCHAR(50), 
musteri_isim VARCHAR(50),
CONSTRAINT fk_urunler FOREIGN KEY(ted_vergino) REFERENCES tedarikciler(vergi_no)
on delete cascade
);   
INSERT INTO urunler VALUES(101, 1001,'Laptop', 'Ayşe Can');
INSERT INTO urunler VALUES(102, 1002,'Phone', 'Fatma Aka');
INSERT INTO urunler VALUES(102, 1003,'TV', 'Ramazan Öz');
INSERT INTO urunler VALUES(102, 1004,'Laptop', 'Veli Han');
INSERT INTO urunler VALUES(103, 1005,'Phone', 'Canan Ak');
INSERT INTO urunler VALUES(104, 1006,'TV', 'Ali Bak');
INSERT INTO urunler VALUES(104, 1007,'Phone', 'Aslan Yılmaz');

--  vergi_no’su 102 olan tedarikcinin firma ismini 'Vestel' olarak güncelleyeniz.
UPDATE tedarikciler
SET firma_ismi='Vestel'
WHERE vergi_no=102;

-- vergi_no’su 101 olan tedarikçinin firma ismini 'casper' ve irtibat_ismi’ni 'Ali Veli' olarak güncelleyiniz.

UPDATE tedarikciler
SET firma_ismi='Casper',irtibat_ismi='Ali Veli'
WHERE vergi_no=101;

--  urunler tablosundaki 'Phone' değerlerini 'Telefon' olarak güncelleyiniz.

UPDATE urunler
SET urun_isim='Telefon'
WHERE urun_isim='Phone'

--  urunler tablosundaki urun_id değeri 1004'ten büyük olanların urun_id’sini 1 arttırın.

UPDATE urunler
SET urun_id=urun_id+1
WHERE urun_id>1004;

-- urunler tablosundaki tüm ürünlerin urun_id değerini ted_vergino sutun değerleri ile toplayarak güncelleyiniz.
UPDATE urunler
SET urun_id=urun_id+ted_vergino;

--urunler tablosundan Ali Bak’in aldigi urunun ismini, 'Ayşe Can' ın aldığı ürün ismi ile güncelleyiniz.

UPDATE urunler
SET urun_isim=(SELECT urun_isim FROM urunler WHERE musteri_isim='Ayşe Can' )
WHERE musteri_isim='Ali Bak';

--Urunler tablosunda laptop satin alan musterilerin ismini, tedarikci  tablosunda
--firma_ismi Apple’in irtibat_isim'i ile degistirin.--ÖDEV--


--urunler tablosundaki urun_id değeri 1111 olan kaydın musteri_isim bilgisinin başına 'GOLD ' ekleyiniz.

UPDATE urunler
SET musteri_isim='GOLD ' || musteri_isim
WHERE urun_id=1111;

UPDATE urunler
SET musteri_isim=concat('GOLD ',musteri_isim)
WHERE urun_id=1112;


SELECT * FROM tedarikciler;
SELECT * FROM urunler;


--25. IS NULL cond.


CREATE TABLE insanlar
(
ssn char(9),
name varchar(50),
address varchar(50)
);
INSERT INTO insanlar VALUES(123456789, 'Ali Can', 'Istanbul');
INSERT INTO insanlar VALUES(234567890, 'Veli Cem', 'Ankara');
INSERT INTO insanlar VALUES(345678901, 'Mine Bulut', 'Izmir');
INSERT INTO insanlar (ssn, address) VALUES(456789012, 'Bursa');
INSERT INTO insanlar (ssn, address) VALUES(567890123, 'Denizli');
INSERT INTO insanlar (ssn, name) VALUES(567890123, 'Veli Han');


SELECT * FROM insanlar;

--insanlar tablosunda name sütunu null olanları listeleyiniz.

SELECT *
FROM insanlar
WHERE name IS NULL;

--insanlar tablosunda name sütunu null olmayanları listeleyiniz.
 
SELECT *
FROM insanlar
WHERE name IS NOT NULL;

--insanlar tablosunda name sütunu null olanların name değerini 
--'MISSING...' olarak güncelleyiniz..

UPDATE insanlar
SET name='MISSING..'
WHERE name IS NULL;


--insanlar tablosunda address sütunu null olanların adress değerini
-- 'MISSING...' olarak güncelleyiniz..ÖDEVVVV

UPDATE insanlar
SET address='MISSING...'
WHERE address IS NULL;



--26. ORDER BY komutu:kayıtları belirli bir fielda göre veya bir ifadeye göre defaultta artan sıralar.

CREATE TABLE people
(
ssn char(9),
isim varchar(50),
soyisim varchar(50),  
adres varchar(50)
);

INSERT INTO people VALUES(123456789, 'Ali','Can', 'Istanbul');
INSERT INTO people VALUES(234567890, 'Veli','Cem', 'Ankara');  
INSERT INTO people VALUES(345678901, 'Mine','Bulut', 'Ankara');  
INSERT INTO people VALUES(256789012, 'Mahmut','Bulut', 'Istanbul'); 
INSERT INTO people VALUES (344678901, 'Mine','Yasa', 'Ankara');  
INSERT INTO people VALUES (345678901, 'Veli','Yilmaz', 'Istanbul');

--people tablosundaki kayıtları ssn e göre sıralayınız.
SELECT * 
FROM people
ORDER BY ssn;


--People tablosundaki ismi Mine olanlari soyisim sirali olarak listeleyin

SELECT *
FROM people
WHERE isim='Mine'
ORDER BY soyisim;--recommended--tavsiye edilir

--People tablosundaki soyismi Bulut olanlari isim sirali olarak listeleyin 

SELECT *
FROM people
WHERE soyisim='Bulut'
ORDER BY 2;--sütun ismi yerine numarası yazılabilir. ancak tavsiye edilmez


--People tablosundaki tum kayitlari SSN numarasi azalan şekilde siralayin

SELECT * 
FROM people
ORDER BY ssn DESC;---DESC:azalan ASC:artan

/*SELECT * 
FROM people
ORDER BY ssn ASC;--defaultta zaten ASC*/

--People tablosundaki tum kayitlari isimler Natural sirali(ASC,artan), Soyisimler ters sirali olarak listeleyin
SELECT * 
FROM people
ORDER BY isim ASC, soyisim DESC;

--isim ve soyisim değerlerini soyisim kelime uzunluklarına göre sıralayınız

SELECT isim,soyisim
FROM people
ORDER BY LENGTH(soyisim)



