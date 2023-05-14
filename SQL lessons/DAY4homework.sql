*********ÖDEV***********

ÖDEVVVV-1: 1- Mart
--1.developers tablosundaki kayıtların maaşını %50 artırınız.
--2.calisanlar3 tablosunda Pierre Cardinde çalışan Ayse Gul'un maaşını
--tablodaki max maaş ile güncelleyiniz.
--3.calisanlar3 tablosunda Ali Seker'in maaşını tablodaki min maaşın 2 katı kadar artırın.
--4.calisanlar3 tablosunda maaşı ortalama maaşdan az olanların maaşını tablodaki ort. maaş olarak güncelleyin.



ÖDEVVVV-2:
-----------------------------------------------------------------------------

CREATE TABLE ogrenciler 
(  
  id int, 
  isim varchar(50), 
  sehir varchar(50), 
  puan int,
  bolum varchar(20)
);

INSERT INTO ogrenciler VALUES(100, 'Ahmet Ümit', 'İstanbul', 546, 'Bilgisayar Müh.');
INSERT INTO ogrenciler VALUES(101, 'R.Nuri Güntekin', 'Antalya', 486, 'İşletme');
INSERT INTO ogrenciler VALUES(102, 'S.Faik Abasıyanık', 'Bursa', 554, 'Bilgisayar Müh.');
INSERT INTO ogrenciler VALUES(103, 'Yaşar Kemal', 'İstanbul', 501, 'Matematik');
INSERT INTO ogrenciler VALUES(104, 'Halide E. Adıvar', 'İzmir', 473, 'Psikoloji');
INSERT INTO ogrenciler VALUES(105, 'Nazan Bekiroğlu', 'İzmir', 432, 'Edebiyat');
INSERT INTO ogrenciler VALUES(106, 'Peyami Safa', 'Antalya', 535, 'Bilgisayar Müh.');
INSERT INTO ogrenciler VALUES(107, 'Sabahattin Ali', 'İstanbul', 492, 'Matematik');

CREATE TABLE bolumler 
(  
  bolum_id int, 
  bolum varchar(20),
  taban_puanı int,
  kampus varchar(20)
);
INSERT INTO bolumler VALUES(5001, 'Bilgisayar Müh.', 521,'Kuzey');
INSERT INTO bolumler VALUES(5002, 'Matematik', 455,'Güney');
INSERT INTO bolumler VALUES(5003, 'Psikoloji', 440,'Hisar');
INSERT INTO bolumler VALUES(5004, 'İşletme', 465,'Hisar');
INSERT INTO bolumler VALUES(5005, 'Edebiyat', 420,'Kuzey');


-----------------------------------------------------------------------------
--Q1)Puanı, taban puanı en yüksek olan bölümün puanından yüksek olan öğrencilerin isim ve sehirlerini 
--listeleyiniz.
SELECT isim, sehir
FROM ogrenciler
WHERE puan>(SELECT MAX(taban_puanı)
			FROM bolumler);



--Q2)Taban puanı 460 dan az olan bölümlerdeki öğrencilerin isimlerini 
--ve bölümlerini listeleyiniz.
SELECT isim,bolum
FROM ogrenciler
WHERE bolum IN (SELECT bolum
		   FROM bolumler
		   WHERE taban_puanı<460);



--Q3)İstanbulda yaşayan öğrencilerin bölümlerini ve 
--taban puanlarını listeleyiniz.
SELECT bolum, taban_puanı
FROM bolumler
WHERE bolum IN (SELECT bolum
			   FROM ogrenciler
			   WHERE sehir='İstanbul');


--Q4)Bölüm isimlerini, kampüslerini ve 
--her bölümde okuyan öğrencilerin en yüksek puanlarını listeleyiniz.
SELECT bolum, kampus, (SELECT MAX(puan)
					 FROM ogrenciler O
					 WHERE O.bolum=B.bolum)
FROM bolumler B



ÖDEVVVV-3:
---------------------------------------------------------------------------------

CREATE TABLE musteriler2
(
  id int, 
  isim varchar(50), 
  sehir varchar(50), 
  yas int
);
INSERT INTO musteriler2 VALUES(100, 'Ahmet Ümit', 'İstanbul', 54);
INSERT INTO musteriler2 VALUES(101, 'R.Nuri Güntekin', 'Antalya', 18);
INSERT INTO musteriler2 VALUES(102, 'S.Faik Abasıyanık', 'Bursa', 14);
INSERT INTO musteriler2 VALUES(103, 'Yaşar Kemal', 'İstanbul', 26);
INSERT INTO musteriler2 VALUES(104, 'Halide E. Adıvar', 'İzmir', 35);
INSERT INTO musteriler2 VALUES(105, 'Nazan Bekiroğlu', 'İzmir', 42);
INSERT INTO musteriler2 VALUES(106, 'Peyami Safa', 'Antalya', 33);
INSERT INTO musteriler2 VALUES(107, 'Sabahattin Ali', 'İstanbul', 41);
INSERT INTO musteriler2 VALUES(108, 'Oğuz Atay', 'İstanbul', 28);
INSERT INTO musteriler2 VALUES(109, 'Orhan Pamuk', 'Ankara', 30);

CREATE TABLE siparisler
(
  id int, 
  musteri_id int, 
  urun_adi varchar(20), 
  tutar int
);
INSERT INTO siparisler VALUES(3001,109, 'kitap',100);
INSERT INTO siparisler VALUES(3002,101, 'kitap',230);
INSERT INTO siparisler VALUES(3003,109, 'defter',100);
INSERT INTO siparisler VALUES(3004,102, 'kalem',80);
INSERT INTO siparisler VALUES(3005,101, 'çanta',550);
INSERT INTO siparisler VALUES(3006,109, 'çanta',440);
INSERT INTO siparisler VALUES(3007,103, 'kitap',160);
INSERT INTO siparisler VALUES(3008,103, 'kalem',75);
INSERT INTO siparisler VALUES(3009,105, 'defter',250);
INSERT INTO siparisler VALUES(3010,108, 'kitap',300);
INSERT INTO siparisler VALUES(3011,106, 'kitap',175);
INSERT INTO siparisler VALUES(3012,109, 'kalem',105);
INSERT INTO siparisler VALUES(3013,107, 'defter',145);
------------------------------------------------------------------------

--Q1)Siparişlerde defter varsa müşterilerin isim ve şehirlerini listeleyiniz.
SELECT isim, sehir
FROM musteriler2
WHERE EXISTS (SELECT *
			  FROM siparisler
			  WHERE urun_adi='defter');


--Q2)Siparişi olan müşterileri listeleyiniz.

-- in daha yavas - butun satirlara bakar
SELECT *
FROM musteriler2
WHERE id IN (SELECT musteri_id FROM siparisler);

-- exists daha hizli - ilk eslesmede true dondurur
SELECT * FROM musteriler2 M
WHERE EXISTS (SELECT musteri_id
			 FROM siparisler S
			 WHERE S.musteri_id=M.id);


--Q3)Müşterilerden yaşı 18 den küçük varsa siparişini sil.
DELETE FROM siparisler S
WHERE EXISTS (SELECT *
			 FROM musteriler2 M
			 WHERE yas<18 AND M.id=S.musteri_id);




--Interview Question:calisanlar3 tablosunda ikinci en yüksek maasi gösteriniz.

SELECT * FROM calisanlar3;

SELECT MAX(maas)
FROM calisanlar3
WHERE maas<(SELECT MAX(maas) FROM calisanlar3);











