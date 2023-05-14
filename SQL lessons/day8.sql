--------------DAY'8---------------------
--37-String fonk.
SELECT * FROM developers;

--developers tablosundaki isimlere 'Developer ' kelimesini ekleyiniz.
UPDATE developers
SET name=CONCAT('Developer ',name);

--developers tablosunda tüm isimleri büyük harfe çevirerek görüntüleyiniz.
SELECT UPPER(name)
FROM developers;

--developers tablosunda tüm sehirleri küçük harfe çevirerek görüntüleyiniz.
SELECT LOWER(city)
FROM developers;


--words tablosunda tüm kelimelerin ilk harfini büyük harfe çevirerek görüntüleyiniz.

SELECT INITCAP(word) 
FROM words;

--developers tablosunda isim ve isimlerin ilk 3 harfini listeleyiniz.

SELECT name,SUBSTRING(name,1,3)
FROM developers;

--developers tablosunda isim ve isimlerin uzunluklarını listeleyiniz.

SELECT name, LENGTH(name) as karakter_sayisi
FROM developers;


--38.FETCH NEXT n ROW ONLY: ilk n tane satırı getirir.
   --LIMIT n : ilk n tane satırı getirir. 
   --OFFSET n : ilk n satırı atlar sonrakileri getirir


--developers tablosundan idye göre ilk 3 kaydı getiriniz.

SELECT * 
FROM developers
FETCH NEXT 3 ROW ONLY;
 
SELECT * 
FROM developers
LIMIT 3;


--developers tablosundan ilk 2 kayıttan sonraki ilk 3 kaydı getiriniz.

SELECT * 
FROM developers
OFFSET 2 ROW
FETCH NEXT 3 ROW ONLY;
 
SELECT * 
FROM developers
OFFSET 2 
LIMIT 3;

--developers tablosundan maaşı en düşük ilk 3 kaydı getiriniz.

SELECT * 
FROM developers
ORDER BY salary 
LIMIT 3;

--developers tablosundan maaşı en yüksek 2. developerın tüm bilgilerini getiriniz.

SELECT * 
FROM developers
ORDER BY salary DESC
OFFSET 1
LIMIT 1;

--39.ALTER TABLE:tabloyu güncellemek için kullanılır. -DDL-
--ADD COLUMN:yeni sütun ekler
--DROP COLUMN:mevcut olan sütunu kaldırır.
--RENAME COLUMN .. TO ..:mevcut sütunun ismini değiştirir.
--RENAME .. TO .. =tablonun ismini değiştirir

SELECT * FROM calisanlar3;

--calisanlar3 tablosuna yas int seklinde yeni sutun ekleyiniz

ALTER TABLE calisanlar3
ADD COLUMN yas int;

--calisanlar3 tablosuna remote boolean seklinde yeni sutun ekleyiniz

ALTER TABLE calisanlar3
ADD COLUMN remote boolean;

--calisanlar3 tablosuna prog_dili varchar seklinde yeni sutun ekleyiniz
-- default degeri 'java' olsun

ALTER TABLE calisanlar3
ADD COLUMN prog_dili varchar(20) DEFAULT 'java'

--calisanlar3 tablosunda yas sutununu siliniz

ALTER TABLE calisanlar3
DROP COLUMN yas;

--calisanlar3 tablosundaki maas sutununun ismini gelir olarak güncelleyiniz

ALTER TABLE calisanlar3
RENAME COLUMN maas TO gelir;

--calisanlar3 tablosunun ismini employees olarak güncelleyiniz

ALTER TABLE calisanlar3 RENAME TO employees;

--employees tablosunda gelir sütunun data tipini real olarak güncelleyiniz.

ALTER TABLE employees
ALTER COLUMN gelir TYPE real;

--employees tablosunda isim sütunun data tipini VARCHAR(50) olarak güncelleyiniz.

ALTER TABLE employees
ALTER COLUMN isim TYPE VARCHAR(50);


--employees tablosunda id sütunun data tipini VARCHAR(20) olarak güncelleyiniz.

ALTER TABLE employees
ALTER COLUMN id TYPE VARCHAR(20);

--employees tablosunda isim sütununa NOT NULL constrainti ekleyiniz.

ALTER TABLE employees
ALTER COLUMN isim SET NOT NULL;

INSERT INTO employees(sehir) VALUES('Bursa');--NOT NULL constraintinden kabul etmez
INSERT INTO employees(isim,sehir) VALUES('Jack Sparrow','Bursa');

ALTER TABLE employees
ALTER COLUMN gelir SET NOT NULL;

UPDATE employees
SET gelir=99999
WHERE gelir IS NULL

ALTER TABLE employees
ALTER COLUMN gelir SET NOT NULL;

SELECT * FROM employees;

--employees tablosunda id sütununa PRIMARY KEY constrainti ekleyiniz.

DELETE FROM employees
WHERE isim='Ayse Gul'

ALTER TABLE employees
ADD PRIMARY KEY(id);


--ALTER TABLE table_name ADD CONSTRAINT column_name constraint;


--40.Transaction-Rollback

--1.BEGIN komutu ile transaction başlar.
--2.COMMIT komutu ile transaction sonlandırlır.
--3.ROLLBACK TO x: tüm kayıtlar x noktasındaki haline döndürülür. 

BEGIN;
CREATE TABLE hesaplar
(
hesap_no int UNIQUE,
isim VARCHAR(50),
bakiye real       
);
COMMIT;

SELECT * FROM hesaplar;


BEGIN;
INSERT INTO hesaplar VALUES(1234,'Harry Potter',5500.3);
INSERT INTO hesaplar VALUES(5678,'Jack Sparrow',8500.5);
savepoint x;--herhangi bir problem olursa geriye dönmek istediğimiz yer
-- bir transaction içerisinde birden fazla savepoint olabilir.
UPDATE hesaplar SET bakiye=bakiye-1000 WHERE hesap_no=1234;
--HATA OLUŞTU!!!!
ROLLBACK TO x;--transfer iptal edildi.

UPDATE hesaplar SET bakiye=bakiye-1000 WHERE hesap_no=1234;
UPDATE hesaplar SET bakiye=bakiye+1000 WHERE hesap_no=5678;

--transfer BAŞARILI

COMMIT;--artık ROLLBACK kullanılmaz.










