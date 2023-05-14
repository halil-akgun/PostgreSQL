---------------DAY1---------------
--1:DB oluşturma
CREATE DATABASE techproed;

--2:DB silme
DROP DATABASE techproed2;
--3:Sıfırdan Tablo oluşturma
CREATE TABLE students(
id char(4),
full_name varchar(50),
grade real,
register_date date	
);
----------------------
create table sirinler(
id int,
isim varchar(30),
mantarsayisi int,
dogumyili date
);
--4:Var olan bir tablodan yeni tablo oluşturma
CREATE TABLE grades 
AS SELECT full_name, grade 
FROM students;
--5:Tüm fieldlara data ekleme

INSERT INTO students VALUES('1001','Erdem Beyazıt',99.0,'2023-02-15');
INSERT INTO students VALUES('1002','Sezai Karakoç',99.5,now());

--6:Bazı fieldlara data ekleme
INSERT INTO students(id,full_name) VALUES('1003','A.Nihat Asya');

--7:tablodan tüm fieldlarla verileri getirme
SELECT * FROM students;
--tablodan belirli fieldlarla verileri getirme
SELECT full_name FROM students;
SELECT full_name,grade FROM students;










