--------------DAY'7---------------------
--JOINS:ilişkili tablolarda ortak bir sütun baz alınarak
--bir veya daha fazla sütunu birleştirir.


CREATE TABLE sirketler  (
sirket_id int,  
sirket_isim varchar(20)
);

INSERT INTO sirketler VALUES(100, 'IBM');
INSERT INTO sirketler VALUES(101, 'GOOGLE');
INSERT INTO sirketler VALUES(102, 'MICROSOFT');
INSERT INTO sirketler VALUES(103, 'APPLE');


CREATE TABLE siparis (
siparis_id int,
sirket_id int,
siparis_tarihi date
);

INSERT INTO siparis VALUES(11, 101, '2023-02-17');  
INSERT INTO siparis VALUES(22, 102, ' 2023-02-18');  
INSERT INTO siparis VALUES(33, 103, ' 2023-01-19');  
INSERT INTO siparis VALUES(44, 104, ' 2023-01-20');  
INSERT INTO siparis VALUES(55, 105, ' 2022-12-21');



--32.INNER JOIN:baz alınan sütundaki ortak dataları birleştirir.

--iki tablodaki şirket id'si aynı olanların şirket id,şirket ismi,sipariş tarihini,sipariş idsini  listeleyiniz.

SELECT sir.sirket_id,sir.sirket_isim,sip.siparis_tarihi,sip.siparis_id
FROM siparis sip 
INNER JOIN sirketler sir
ON sir.sirket_id=sip.sirket_id;


--33.-LEFT JOIN:soldaki tablodaki tüm kayıtları getirir, sağdaki tabloda olmayan kayıtlar için null gösterir .
    --RIGHT JOIN:sağdaki tablodaki tüm kayıtları getirir, soldaki tabloda olmayan kayıtlar için null gösterir .
	
--Şirketler tablosundaki tüm şirket idlerini,şirket ismi,sipariş tarihini,sipariş idsini  listeleyiniz.
	
SELECT sir.sirket_id,sir.sirket_isim,sip.siparis_tarihi,sip.siparis_id
FROM sirketler sir LEFT JOIN siparis sip
ON sir.sirket_id=sip.sirket_id;


--Siparişler tablosundaki tüm şirket idlerini,şirket ismi,sipariş tarihini,sipariş idsini  listeleyiniz.

SELECT sip.sirket_id,sir.sirket_isim,sip.siparis_tarihi,sip.siparis_id
FROM sirketler sir RIGHT JOIN siparis sip
ON sir.sirket_id=sip.sirket_id;

SELECT sip.sirket_id,sir.sirket_isim,sip.siparis_tarihi,sip.siparis_id
FROM siparis sip LEFT JOIN sirketler sir
ON sir.sirket_id=sip.sirket_id;

	
--34.-FULL JOIN:her iki tablodaki tüm kayıtları getirir.	

--iki tablodaki tüm kayıtların şirket id,şirket ismi,sipariş tarihini,sipariş idsini  listeleyiniz.

SELECT sir.sirket_id,sip.sirket_id,sir.sirket_isim,sip.siparis_tarihi,sip.siparis_id
FROM siparis sip
FULL JOIN sirketler sir
ON sir.sirket_id=sip.sirket_id;


SELECT *
FROM siparis sip
FULL JOIN sirketler sir
ON sir.sirket_id=sip.sirket_id;


SELECT * FROM siparis;
SELECT * FROM sirketler;

--35.-SELF JOIN:tablonun kendi içerisindeki bir sütun üzerinde INNER JOIN yapılmasıdır.
DROP TABLE personel;

CREATE TABLE personel  (
id int,
isim varchar(20),  
title varchar(60),  
yonetici_id int
);
INSERT INTO personel VALUES(1, 'Ali Can', 'SDET', 2);
INSERT INTO personel VALUES(2, 'Veli Cem', 'QA', 3);
INSERT INTO personel VALUES(3, 'Ayse Gul', 'QA Lead', 4);  
INSERT INTO personel VALUES(4, 'Fatma Can', 'CEO', 5);


SELECT * FROM personel;

--Her personelin yanina yonetici ismini yazdiran bir tablo olusturun

SELECT p2.isim personel,p1.isim yöneticisi
FROM personel p1 
INNER JOIN personel p2
ON p1.id=p2.yonetici_id

--developers tablosu-contact_info tablosunu
--tüm developerların isim,email ve iletişim adresindeki şehirleri görüntüleyiniz.ÖDEVV
--iletişim adresi olan tüm developerların isim,email ve iletişim adresindeki şehirleri görüntüleyiniz.ÖDEVV

--36.LIKE Cond.: WHERE komutundan sonra sorgulama yaparken pattern(desen-kalıp ifadeler)
--kullanmamızı sağlar.

--ILIKE : LIKE ile aynı ancak case insensitive: küçük/büyük harf duyarsız 
INSERT INTO developers(name,email,salary,prog_lang,city,age) VALUES('A','tk@mail.com',4000,'Java','Ankara',28);
SELECT * FROM developers;

--LIKE op. aradığımız kelimenin tamamı ile kullandığımızda = ile aynı çalışır.
SELECT * FROM developers WHERE name='Gülsüm';

SELECT * FROM developers WHERE name ILIKE 'gülsüm';

-- % wildcard(joker): 0 veya daha fazla karakter

--Ismi A harfi ile baslayan devlerin tum bilgilerini yazdiran QUERY yazin

SELECT * FROM developers WHERE name LIKE 'A%';

--A harfi ile biten şehirde çalışan dev isimlerini ve şehirlerini yazdiran QUERY yazin

SELECT name,city FROM developers WHERE city ILIKE '%A';

--Ismi A ile başlayıp t harfi ile biten dev isimlerini ve maaşlarını yazdiran QUERY yazin

SELECT name,salary FROM developers WHERE name ILIKE 'A%t';

--Ismi içinde 'il' olan dev isimlerini ve maaşlarını yazdiran QUERY yazin

SELECT name,salary FROM developers WHERE name ILIKE '%il%';
SELECT name,salary FROM developers WHERE name ~~* '%il%';

--LIKE: ~~
--ILIKE: ~~*

--Ismi içinde i ve a olan devlerin tüm bilgilerini yazdiran QUERY yazin

SELECT * FROM developers WHERE name ILIKE '%i%a%' OR name ILIKE '%a%i%';--ALİ ,Faik
SELECT * FROM developers WHERE name ILIKE '%i%' AND name ILIKE '%a%';

--underscore _:bir karakteri temsil eder

--Isminin ikinci harfi ü olan devlerin tum bilgilerini yazdiran QUERY yazin

SELECT * FROM developers WHERE name ILIKE '_ü%'; 

--Kullandığı prog. dili 4 harfli ve üçüncü harfi v olan devlerin tum bilgilerini yazdiran QUERY yazin

SELECT * FROM developers WHERE prog_lang ILIKE '__v_'; --'_%v_':javvvvvvva

--Kullandığı prog. dili en az 5 harfli ve ilk harfi J olan devlerin tum bilgilerini yazdiran QUERY yazin

SELECT * FROM developers WHERE prog_lang ILIKE 'J____%';

--Isminin 2. harfi i,4. harfi a olan devlerin tum bilgilerini yazdiran QUERY yazin

SELECT * FROM developers WHERE name ILIKE '_i_a%';

--ismi boşluk içeren devlerin tum bilgilerini yazdiran QUERY yazin:ÖDEVVVV

--REGEXP_LIKE:(~) regular expression kullanarak karşılaştırma yapmamızı sağlar.
--: ~*:case insensitive

CREATE TABLE words
( 
  word_id int UNIQUE,
  word varchar(50) NOT NULL,
  number_of_letters int
);

INSERT INTO words VALUES (1001, 'hot', 3);
INSERT INTO words VALUES (1002, 'hat', 3);
INSERT INTO words VALUES (1003, 'Hit', 3);
INSERT INTO words VALUES (1004, 'hbt', 3);
INSERT INTO words VALUES (1008, 'hct', 3);
INSERT INTO words VALUES (1005, 'adem', 4);
INSERT INTO words VALUES (1006, 'selim', 6);
INSERT INTO words VALUES (1007, 'yusuf', 5);
INSERT INTO words VALUES (1009, 'hAt', 3);
INSERT INTO words VALUES (1010, 'yaf', 5);

SELECT * FROM words


--[] içerisinde bulunan harflerden en az birini içeren kayıtlar

 --Ilk harfi h,son harfi t olup 2.harfi a veya i olan 3 harfli kelimelerin tum bilgilerini yazdırınız.
 
 SELECT * FROM words WHERE word ~ '^h[ai]t$';

 SELECT * FROM words WHERE word ~* '^h[ai]t$';
 
--[-] içerisinde bulunan iki harf arasındaki tüm harflerden en az birini içeren kayıtlar
 

--h harfinden sonra a ile k arasinda olan bir harf daha sonra t harfi olan kelimelerin  tum bilgilerini  yazdiran QUERY yazin

 SELECT * FROM words WHERE word ~* 'h[a-k]t';

-- Icinde m veya i olan kelimelerin tum bilgilerini yazdiran QUERY yazin

 SELECT * FROM words WHERE word ~* '[mi]';

-- ^:başlangıcı ifade eder

--a veya s ile baslayan kelimelerin tum bilgilerini yazdiran QUERY yazin

 SELECT * FROM words WHERE word ~* '^[as]';

-- $:bitişi belirtir.

-- m veya f ile biten kelimelerin tum bilgilerini yazdiran QUERY yazin

 SELECT * FROM words WHERE word ~* '[mf]$';
 

--  y ile başlayıp f ile biten kelimelerin tum bilgilerini yazdiran QUERY yazin

SELECT * FROM words WHERE word ~* '^y(.*)f$';--'^y.*f$'

--.* => 0 veya çok karakter
-- . => tek karakter

SELECT * FROM words WHERE word ~* '^y(.)f$';

-- NOT LIKE: verilen desen şeklinde olmayanları getirir.(!~~)
-- !~ : verilen desen şeklinde olmayanları getirir.


-- ilk harfi h olmayan kelimelerin tum bilgilerini yazdiran QUERY yazin

SELECT * FROM words WHERE word !~* '^h';

SELECT * FROM words WHERE word NOT ILIKE 'h%';

--[] içerisinde ^ değil anlamı içerir.


--2. harfi e,i ve o olmayan kelimelerin tum bilgilerini yazdiran QUERY yazin. ÖDEVVV3:)




-37-UPPER,LOWER,INITCAP