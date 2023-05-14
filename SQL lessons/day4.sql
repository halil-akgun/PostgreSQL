------------------DAY'4----------------
--22.a-SUBQUERIES: WHERE ile kullanımı-NESTED QUERY
--bir SQL sorgusu içerisinde sonucundan yararlandığımız diğer sorguya
--ALT SORGU(subquery) denir.

--calisanlar3 tablosu ve markalar


--marka id si 100 olan markada çalışanları listeleyiniz.

SELECT marka_isim 
FROM markalar
WHERE marka_id=100;

SELECT * 
FROM calisanlar3
WHERE isyeri='Vakko';

--2.yol

SELECT * 
FROM calisanlar3
WHERE isyeri=(	SELECT marka_isim 
				FROM markalar
				WHERE marka_id=100 );
				


--Interview Question:calisanlar3 tablosunda max maaşı alan çalışanın tüm fieldlarını gösteriniz.
SELECT *
FROM calisanlar3
WHERE maas=( SELECT max(maas) FROM calisanlar3 ) ;

--Interview Question:calisanlar3 tablosunda ikinci en yüksek maaşı gösteriniz.ÖDEV

--Interview Question:calisanlar3 tablosunda max veya min maaşı alan çalışanların tüm fieldlarını gösteriniz.

SELECT *
FROM calisanlar3
WHERE maas=( SELECT max(maas) FROM calisanlar3 ) OR maas=( SELECT min(maas) FROM calisanlar3 );

SELECT *
FROM calisanlar3
WHERE maas IN ( (SELECT max(maas) FROM calisanlar3 ),( SELECT min(maas) FROM calisanlar3 ));

-- Çalisan sayisi 15.000’den cok olan markalarin isimlerini ve bu markada calisanlarin isimlerini ve maaşlarini listeleyin.

SELECT isim,maas,isyeri
FROM calisanlar3
WHERE isyeri IN ( SELECT marka_isim 
				  FROM markalar 
				  WHERE  calisan_sayisi>15000 ); 
				  

-- Ankara’da calisani olan markalarin marka id'lerini ve calisan sayilarini listeleyiniz.

SELECT marka_id,calisan_sayisi 
FROM markalar
WHERE marka_isim IN ( SELECT isyeri  
                      FROM calisanlar3
                      WHERE sehir='Ankara' )


-- marka_id’si 101’den büyük olan marka çalişanlarinin isim, maaş ve şehirlerini listeleyiniz.

SELECT isim,maas,sehir
FROM calisanlar3
WHERE isyeri IN ( SELECT marka_isim
				 FROM markalar
				 WHERE marka_id>101 ) 

--22.b-SUBQUERIES:aggregate fonk. kullanımı

-- Her markanin id’sini, ismini ve toplam kaç şehirde bulunduğunu listeleyen bir SORGU yaziniz.

SELECT marka_id,marka_isim, (SELECT count(sehir)
							 FROM calisanlar3
							 WHERE isyeri=marka_isim)
FROM markalar;
--ilişkili subquery(corralated sq)

--DISTINCT komutu:tekrarlı datalardan sadece birini alır. 
SELECT COUNT(DISTINCT sehir)
FROM calisanlar3

--  Her markanin ismini, calisan sayisini ve o markaya ait calisanlarin maksimum ve minumum maaşini listeleyen bir Sorgu yaziniz.

SELECT marka_isim, calisan_sayisi, (SELECT max(maas)
								   FROM calisanlar3
								   WHERE isyeri=marka_isim) max_maas,
								   
								   (SELECT min(maas)
								   FROM calisanlar3
								   WHERE isyeri=marka_isim) min_maas

FROM markalar;

--23.EXISTS Condition
--Bir SQL sorgusunda alt sorgunun sonucunun boş olup olmadığını kontrol etmek için kullanılır.
--Eğer alt sorgu sonucu boş değilse, koşul sağlanmış sayılır ve sorgunun geri kalanı işletilir.
--Alt sorgu en az bir satır döndürürse sonucu EXISTS doğrudur.
--Alt sorgunun satır döndürmemesi durumunda, sonuç EXISTS yanlıştır.

CREATE TABLE mart
(	
urun_id int,	
musteri_isim varchar(50),
urun_isim varchar(50)
);

INSERT INTO mart VALUES (10, 'Mark', 'Honda');
INSERT INTO mart VALUES (20, 'John', 'Toyota');
INSERT INTO mart VALUES (30, 'Amy', 'Ford');
INSERT INTO mart VALUES (20, 'Mark', 'Toyota');
INSERT INTO mart VALUES (10, 'Adam', 'Honda');
INSERT INTO mart VALUES (40, 'John', 'Hyundai');
INSERT INTO mart VALUES (20, 'Eddie', 'Toyota');

CREATE TABLE nisan 
(	
urun_id int ,
musteri_isim varchar(50),
urun_isim varchar(50)
);

INSERT INTO nisan VALUES (10, 'Hasan', 'Honda');
INSERT INTO nisan VALUES (10, 'Kemal', 'Honda');
INSERT INTO nisan VALUES (20, 'Ayse', 'Toyota');
INSERT INTO nisan VALUES (50, 'Yasar', 'Volvo');
INSERT INTO nisan VALUES (20, 'Mine', 'Toyota');

select * from mart;
select * from nisan;

--Mart ayında 'Toyota' satışı yapılmışsa Nisan ayındaki tüm ürünlerin bilgilerini listeleyiniz.

SELECT *
FROM nisan
WHERE EXISTS ( SELECT urun_isim
			   FROM mart
			   WHERE urun_isim='Toyota' )
--EXISTS False dönerse

--Mart ayında 'Volvo' satışı yapılmışsa Nisan ayındaki tüm ürünlerin bilgilerini listeleyiniz.

			   
SELECT *
FROM nisan
WHERE EXISTS ( SELECT *
			   FROM mart
			   WHERE urun_isim='Volvo' )

--Mart ayında satılan ürünün urun_id ve musteri_isim'lerini, eğer Nisan ayında da satılmışsa, listeleyen bir sorgu yazınız. 

SELECT urun_id,musteri_isim
FROM mart m
WHERE EXISTS (SELECT urun_id
			  FROM nisan n
			  WHERE n.urun_id=m.urun_id)--ilişkili
			
---Her iki ayda birden satılan ürünlerin URUN_ISIM'lerini ve bu ürünleri
--NİSAN ayında satın alan MUSTERI_ISIM'lerini listeleyen bir sorgu yazınız.

SELECT urun_isim,musteri_isim
FROM nisan 
WHERE EXISTS (SELECT urun_isim
			  FROM mart
			  WHERE mart.urun_isim=nisan.urun_isim)


--Martta satılıp Nisanda satilmayan ürünlerin URUN_ISIM'lerini ve bu ürünleri
--MART ayında satın alan MUSTERI_ISIM'lerini listeleyen bir sorgu yazınız.

SELECT urun_isim,musteri_isim
FROM mart m
WHERE NOT EXISTS (SELECT urun_isim
			      FROM nisan n
			      WHERE n.urun_isim=m.urun_isim)












