*********ÖDEV***********

ÖDEVVVV-1: 1- Mart
-----------------------------------------------------------------------------

--1.developers tablosundaki kayıtların maaşını %50 artırınız.
SELECT * FROM developers
UPDATE developers SET salary = salary * 1.5



--2.calisanlar3 tablosunda Pierre Cardinde çalışan Ayse Gul'un maaşını
--tablodaki max maaş ile güncelleyiniz.
SELECT * FROM calisanlar3;
SELECT * FROM calisanlar3 WHERE isyeri='Pierre Cardin' AND isim='Ayse Gul';
SELECT MAX(maas) FROM calisanlar3

UPDATE calisanlar3 SET maas = (SELECT MAX(maas) FROM calisanlar3)
WHERE isim='Ayse Gul' AND isyeri='Pierre Cardin';



--3.calisanlar3 tablosunda Ali Seker'in maaşını tablodaki min maaşın 2 katı kadar artırın.
SELECT MIN(maas) FROM calisanlar3;

UPDATE calisanlar3 SET maas = maas + 2 * (SELECT MIN(maas) FROM calisanlar3)
WHERE isim='Ali Seker';

SELECT * FROM calisanlar3;



--4.calisanlar3 tablosunda maaşı ortalama maaşdan az olanların maaşını tablodaki ort. maaş olarak güncelleyin.
SELECT AVG(maas) FROM calisanlar3;

UPDATE calisanlar3 SET maas=(SELECT AVG(maas) FROM calisanlar3)
WHERE maas < (SELECT AVG(maas) FROM calisanlar3);

SELECT * FROM calisanlar3;




ÖDEVVVV-2:sunum Practice 8
-----------------------------------------------------------------------------

CREATE TABLE personel(
	id int,
	isim varchar(20),
	soyisim varchar(20),
	email varchar(30),
	ise_baslama_tarihi date,
	is_unvani varchar(20),
	maas int
)
SELECT * FROM personel;
INSERT INTO personel VALUES(123456789, 'Ali', 'Can', 'alican@gmail.com',
						   '10.04.2010', 'isci', 5000);
INSERT INTO personel VALUES(123456788, 'Veli', 'Cem', 'velicem@gmail.com',
						   '10.01.2012', 'isci', 5500);
INSERT INTO personel VALUES(123456787, 'Ayse', 'Gul', 'aysegul@gmail.com',
						   '01.05.2014', 'muhasebeci', 4500);
INSERT INTO personel VALUES(123456789, 'Fatma', 'Yasa', 'fatmayasa@gmail.com',
						   '10.04.2009', 'muhendis', 7500);

SELECT isim FROM personel WHERE is_unvani='isci' OR maas<5000;

SELECT * FROM personel;

SELECT is_unvani,maas FROM personel WHERE soyisim IN ('Can', 'Cem', 'Gul');

SELECT email,ise_baslama_tarihi FROM personel WHERE maas > 5000;

--SELECT * FROM personel WHERE maas BETWEEN 5000 AND 7000;
SELECT * FROM personel WHERE maas<7000 OR maas>5000;







ÖDEVVVV-3

update,is null,order
