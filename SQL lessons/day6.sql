--------------DAY'6---------------------
--27.GROUP BY clause:sonuçları bir veya birden fazla fielda göre gruplamak için kullanılır.
--GROUP BY dan sonra birden fazla sütun ismi kullanılabilir.


CREATE TABLE manav
(
isim varchar(50),
urun_adi varchar(50),
urun_miktar int
);

INSERT INTO manav VALUES( 'Ali', 'Elma', 5);
INSERT INTO manav VALUES( 'Ayse', 'Armut', 3);
INSERT INTO manav VALUES( 'Veli', 'Elma', 2);  
INSERT INTO manav VALUES( 'Hasan', 'Uzum', 4);  
INSERT INTO manav VALUES( 'Ali', 'Armut', 2);  
INSERT INTO manav VALUES( 'Ayse', 'Elma', 3);  
INSERT INTO manav VALUES( 'Veli', 'Uzum', 5);  
INSERT INTO manav VALUES( 'Ali', 'Armut', 2);  
INSERT INTO manav VALUES( 'Veli', 'Elma', 3);  
INSERT INTO manav VALUES( 'Ayse', 'Uzum', 2);

SELECT * FROM manav;


--Her bir ismi ve her bir isim için alınan toplam ürün miktarını görüntüleyiniz.

SELECT isim, SUM(urun_miktar)
FROM manav
GROUP BY isim;

--Her bir ismi ve her bir isim için alınan toplam ürün miktarını
--alınan toplam ürün miktarına göre azalan görüntüleyiniz.

SELECT isim, SUM(urun_miktar) 
FROM manav
GROUP BY isim
ORDER BY SUM(urun_miktar) DESC;


SELECT isim, SUM(urun_miktar) toplam_urun_mik
FROM manav
GROUP BY isim
ORDER BY toplam_urun_mik  DESC;

--Her bir ismin aldığı her bir ürünün toplam miktarını isme göre sıralayarak görüntüleyiniz.

SELECT isim, urun_adi, SUM(urun_miktar) toplam_urun_mik
FROM manav
GROUP BY isim, urun_adi
ORDER BY isim;


--!!!--SELECT komutundan sonra GROUP BY ifadesinde kullanılan sütun ismi yada aggregate fonk. olabilir.
SELECT isim, urun_adi
FROM manav
GROUP BY isim
ORDER BY isim;

--ürün ismine göre her bir ürünü alan toplam kişi sayısı gösteriniz.

SELECT urun_adi, COUNT(DISTINCT isim)
FROM manav
GROUP BY urun_adi


--Isme gore alinan toplam urun mikarı ve ürün çeşit miktarını bulun

SELECT isim, SUM(urun_miktar), COUNT(DISTINCT urun_adi) urun_cesidi
FROM manav
GROUP BY isim

--Alinan ürün miktarina gore musteri sayisinı görüntüleyiniz.
--musteri sayisina göre artan sıralayınız.

SELECT urun_miktar, COUNT(DISTINCT isim) musteri_sayisi
FROM manav
GROUP BY urun_miktar
ORDER BY musteri_sayisi;


--28.HAVING clause:GROUP BY komutundan sonra koşul eklemek için kullanılır.

CREATE TABLE personel  (
id int,
isim varchar(50),  
sehir varchar(50), 
maas int,  
sirket varchar(20)
);
INSERT INTO personel VALUES(123456789, 'Ali Yilmaz', 'Istanbul', 5500, 'Honda'); 
INSERT INTO personel VALUES(234567890, 'Veli Sahin', 'Istanbul', 4500, 'Toyota'); 
INSERT INTO personel VALUES(345678901, 'Mehmet Ozturk', 'Ankara', 3500, 'Honda');
INSERT INTO personel VALUES(456789012, 'Mehmet Ozturk', 'Izmir', 6000, 'Ford'); 
INSERT INTO personel VALUES(567890123, 'Mehmet Ozturk', 'Ankara', 7000, 'Tofas');
INSERT INTO personel VALUES(456789012, 'Veli Sahin', 'Ankara', 4500, 'Ford');  
INSERT INTO personel VALUES(123456710, 'Hatice Sahin', 'Bursa', 4500, 'Honda');

-- Her sirketin MIN maaslarini eger 4000’den buyukse gosteriniz
SELECT sirket, MIN(maas) min_maas
FROM personel
GROUP BY sirket
HAVING MIN(maas)>4000;

--Her bir ismin aldigi toplam gelir 10000 liradan fazla ise ismi ve toplam maasi gosteren sorgu yaziniz
SELECT isim, SUM(maas) 
FROM personel
GROUP BY isim
HAVING SUM(maas)>10000;


--Eger bir sehirde calisan personel sayisi 1’den coksa sehir ismini ve personel sayisini veren sorgu yaziniz

SELECT sehir, COUNT(DISTINCT id)
FROM personel
GROUP BY sehir
HAVING COUNT(DISTINCT id)>1;

--Eger bir sehirde alinan MAX maas 5000’den dusukse sehir ismini ve MAX maasi veren sorgu yaziniz

SELECT sehir, MAX(maas)
FROM personel
GROUP BY sehir
HAVING MAX(maas)<5000;

--29.UNION/UNION ALL OPERATOR:
--UNION:iki farklı sorgunun sonuçlarını birleştirir, tekrarlı sonuçları bir kere gösterir.
--UNION ALL: UNION ile aynı işlemi yapar, ancak tekrarlı olanları da gösterir. 


CREATE TABLE developers(
id SERIAL PRIMARY KEY,
name varchar(50),
email varchar(50) UNIQUE,
salary real,
prog_lang varchar(20),
city varchar(50),
age int	
);

INSERT INTO developers(name,email,salary,prog_lang,city,age) VALUES('Akın Toprak','toprak@mail.com',4000,'Java','Ankara',28);
INSERT INTO developers(name,email,salary,prog_lang,city,age) VALUES('Ebubekir','ebubekir@mail.com',5000,'JavaScript','Istanbul',35);
INSERT INTO developers(name,email,salary,prog_lang,city,age) VALUES('Bilal Güney ','guney@mail.com',5000,'Java','Izmır',38);
INSERT INTO developers(name,email,salary,prog_lang,city,age) VALUES('Gülsüm','gulsum@mail.com',4000,'JavaScript','Istanbul',32);
INSERT INTO developers(name,email,salary,prog_lang,city,age) VALUES('Fatih Deniz','deniz@mail.com',6000,'Java','Izmır',25);
INSERT INTO developers(name,email,salary,prog_lang,city,age) VALUES('Cemil','cemil@mail.com',6000,'Html','Istanbul',28);
INSERT INTO developers(name,email,salary,prog_lang,city,age) VALUES('Adam Born','adam@mail.com',5500,'Css','Ankara',28);
INSERT INTO developers(name,email,salary,prog_lang,city,age) VALUES('Zişan','zisan@mail.com',5000,'Java','Bursa',32);
INSERT INTO developers(name,email,salary,prog_lang,city,age) VALUES('Mürsel Aygün','aygun@mail.com',4500,'Html','Izmır',33);
INSERT INTO developers(name,email,salary,prog_lang,city,age) VALUES('Ahmet Saat','saat@mail.com',4500,'Css','Bursa',32);
INSERT INTO developers(name,email,salary,prog_lang,city,age) VALUES('İrfan','irfan@mail.com',7000,'C++','Konya',38);
INSERT INTO developers(name,email,salary,prog_lang,city,age) VALUES('Gülsüm','dev@mail.com',4000,'C#','Istanbul',30);
INSERT INTO developers(name,email,salary,prog_lang,city,age) VALUES('Zişan','developer@mail.com',4000,'C#','Bursa',29);

CREATE TABLE contact_info(
address_id int,
street varchar(30),
number int,	
city varchar(30),
FOREIGN KEY(address_id) REFERENCES developers(id)	
);

INSERT INTO contact_info VALUES(1,'Kaya Sok.',5,'Bursa');
INSERT INTO contact_info VALUES(2,'Kaya Sok.',3,'Ankara');
INSERT INTO contact_info VALUES(3,'Can Sok.',10,'Bursa');
INSERT INTO contact_info VALUES(4,'Gül Sok.',12,'Ankara');
INSERT INTO contact_info VALUES(5,'Can Sok.',4,'Afyon');
INSERT INTO contact_info VALUES(6,'Taş Sok.',6,'Bolu');
INSERT INTO contact_info VALUES(7,'Dev Sok.',6,'Sivas');
INSERT INTO contact_info VALUES(8,'Dev Sok.',8,'Van');


/*Yaşı 25’den büyük olan developer isimlerini ve 
yaşı 30'dan küçük developerların kullandığı prog. dillerini
tekrarsız gösteren sorguyu yaziniz*/

SELECT name isim_progdili FROM developers WHERE age>25
UNION
SELECT prog_lang isim_progdili FROM developers WHERE age<30

--aynı sorguda tekrarlı veriler de gösterilsin.

SELECT name isim_progdili FROM developers WHERE age>25
UNION ALL
SELECT prog_lang isim_progdili FROM developers WHERE age<30


--!!!-- sorgularda SELECT ten sonra çağırdığımız sütun sayısı ve data type aynı olmalı 

/* Java kullananların maaşını ve prog. dilini
ve 
JavaScript kullananların yaşını ve prog. dilini
tekrarsız gösteren sorguyu yaziniz*/

SELECT salary maas_yas,prog_lang FROM developers WHERE prog_lang='Java'
UNION
SELECT age maas_yas,prog_lang FROM developers WHERE prog_lang='JavaScript'

/* Java kullananların bulunduğu şehir ve maaşını
ve 
maaşı 5000 den fazla olanların isim ve yaşını
tekrarsız gösteren sorguyu yaziniz*/

(SELECT city sehir_isim ,salary yas_maas FROM developers WHERE prog_lang='Java' )
UNION
(SELECT name sehir_isim ,age yas_maas FROM developers WHERE salary>5000 )
ORDER BY yas_maas;

--id si 8 olan developerın çalıştığı şehir ve maaşını
--iletişim adresindeki şehir ve kapı nosunu görüntüleyiniz.

SELECT city, salary maas_kapino FROM developers WHERE id=8
UNION
SELECT city, number maas_kapino FROM contact_info WHERE address_id=8


--developers tablosundaki şehirler ve
--calisanlar3 tablosunda sehirlerin
--tümünü listeleyiniz

SELECT city FROM developers
UNION
SELECT sehir FROM calisanlar3

--30.INTERSECT OPERATOR:iki sorgunun ortak sonuçlarını tekrarsız getirir

--developers tablosundaki şehirler ve
--calisanlar3 tablosundaki sehirlerden 
--ortak olanlarını listeleyiniz.

SELECT city FROM developers
INTERSECT
SELECT sehir FROM calisanlar3;


--developers tablosunda Java kullananların çalıştıkları şehirler ve
--calisanlar3 tablosunda maaşı 1000 den fazla olanların sehirlerinden 
--ortak olanlarını listeleyiniz.

SELECT city FROM developers WHERE prog_lang='Java'
INTERSECT
SELECT sehir FROM calisanlar3 WHERE maas>1000 ;

--31.EXCEPT OPERATOR:bir sorgunun sonucunu listelerken başka bir sorgunun
--sonuçlarını hariç tutmak için kullanılır.

----developers tablosundaki şehirlerden
--calisanlar3 tablosunda olmayanları listeleyiniz.


SELECT city FROM developers
EXCEPT
SELECT sehir FROM calisanlar3;


----developers tablosundaki maaşı 4000 den büyük olanların idlerinden
--contact_info tablosunda olmayanları listeleyiniz.

SELECT id FROM developers WHERE salary>4000
EXCEPT
SELECT address_id FROM contact_info ;


 --ÖDEV:mart ve nisan tablolarındaki tüm ürünlerin isimlerini tekrarsız listeleyiniz.  
 --ÖDEV:mart ve nisan tablolarındaki ortak ürünlerin isimlerini listeleyiniz.
 --ÖDEV:mart ayında satılıp nisan ayında satılmayan ürünlerin isimlerini listeleyiniz.  







