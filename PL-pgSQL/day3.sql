
-- Task 1 : Film tablosundaki film sayısı 10 dan az ise "Film sayısı az" yazdırın,
-- 10 dan çok ise "Film sayısı yeterli" yazdıralım


do $$
declare
	sayi integer = 0;

begin
	select count(*)
	from film
	into sayi;
	
	if sayi<10 then
		raise notice 'film sayisi az';
	else
		raise notice 'film sayisi yeterli';
	end if;
end $$;


-- Task 2: user_age isminde integer data türünde bir değişken tanımlayıp default olarak bir değer verelim,
-- If yapısı ile girilen değer 18 den büyük ise Access Granted, küçük ise Access Denied yazdıralım

do $$
declare
	user_age integer = 15;
begin
	if user_age<18 then
		raise notice 'Access Denied';
	else
		raise notice 'Access Granted';
	end if;
end $$;


-- Task : 1 dan 4 e kadar counter değerlerini ekrana basalım

do $$
declare
	n integer := 4;
	counter integer := 0;
begin
	loop
		exit when counter = n ;
		counter := counter + 1 ;
		raise notice '%',counter;
	end loop;
end $$ ;


--2. yol : 
do $$
declare 
	n integer := 4;
	counter integer :=0;
begin
	while counter <n loop  -- if ile sonsuz donguden kurtulmak yerine while da kullanilabilir
		counter := counter +1 ;
		raise notice 'Counter %', counter;	
	end loop;
end $$ ;


-- 3.yol :
do $$
declare
	counter integer :=1;	
begin
	while counter < 5 loop
		raise notice 'counter %', counter;
		counter := counter +1;
	end loop ;
end $$;



-- Task 5 : sayac isminde bir degisken olusturun ve dongu icinde sayaci birer artirin,
-- her dongude sayacin degerini ekrana basin ve sayac degeri 5 e esit olunca donguden cikin

do $$
declare
	counter integer := 0;
begin
	loop
		raise notice '%', counter;
		counter := counter +1 ;
		exit when counter = 5;
	end loop;
end $$ ;



--***********************************************************************
--*****************************  FOR LOOP  ******************************
--***********************************************************************

-- syntax :

/* 
	FOR loop_counter IN [reverse] FROM..TO [By step] LOOP
		statement;
	END LOOP;
	
*/


-- Ornek ( IN )
do $$
begin
	for counter in 1..5 loop
		raise notice '%', counter;
	end loop;
end $$;


-- Ornek ( reverse )
do $$
begin
	for counter in reverse 5..1 loop
		raise notice '%', counter;
	end loop;
end $$;


-- Ornek ( by )
do $$
begin
	for counter in 1..15 by 2 loop
		raise notice '%', counter;
	end loop;
end $$;


-- Task : 10 dan 20 ye kadar 2 ser 2 ser ekrana sayilari basalim :

do $$
begin
	for counter in 10..20 by 2 loop
		raise notice '%', counter;
	end loop;
end $$;



--***********************************************************************
--****************************  DB'de LOOP  *****************************
--***********************************************************************

-- syntax :

/*
	FOR target IN query loop
		statement;
	END LOOP;
*/


-- Task : Filmleri süresine göre sıraladığımızda en uzun 2 filmi gösterelim
do $$
declare
	f record;
begin
	for f in select title,length 
				from film
				order by length desc
				limit 2
	loop
		raise notice '% %', f.title, f.length;
	end loop;
end $$;


CREATE TABLE employees (
  employee_id serial PRIMARY KEY,  
  full_name VARCHAR NOT NULL,
  manager_id INT
);
INSERT INTO employees (
  employee_id,
  full_name,
  manager_id
)
VALUES
  (1, 'M.S Dhoni', NULL),
  (2, 'Sachin Tendulkar', 1),
  (3, 'R. Sharma', 1),
  (4, 'S. Raina', 1),
  (5, 'B. Kumar', 1),
  (6, 'Y. Singh', 2),
  (7, 'Virender Sehwag ', 2),
  (8, 'Ajinkya Rahane', 2),
  (9, 'Shikhar Dhawan', 2),
  (10, 'Mohammed Shami', 3),
  (11, 'Shreyas Iyer', 3),
  (12, 'Mayank Agarwal', 3),
  (13, 'K. L. Rahul', 3),
  (14, 'Hardik Pandya', 4),
  (15, 'Dinesh Karthik', 4),
  (16, 'Jasprit Bumrah', 7),
  (17, 'Kuldeep Yadav', 7),
  (18, 'Yuzvendra Chahal', 8),
  (19, 'Rishabh Pant', 8),
  (20, 'Sanju Samson', 8);


-- Task :  manager ID si en buyuk ilk 10 kisiyi ekrana yazalim
do $$
declare
	e record;
begin
	for e in select full_name,manager_id 
				from employees
				order by manager_id desc
				limit 10
	loop
		raise notice '% %', e.full_name,e.manager_id;
	end loop;
end $$;



--***********************************************************************
--*******************************  EXIT  ********************************
--***********************************************************************

exit when counter > 10 ;


-- yukardaki ile asagidaki ayni isi yapiyor, ust tarafdakini tercih edelim


if counter > 10 then 
	exit ;
end if ;



--***********************************************************************
--*****************************  CONTINUE  ******************************
--***********************************************************************


-- mevcut iterasyonu  atlamak icin kullanilir

-- syntax :
 
-- continue [loop_label] [when condition] 

-- Task : continue yapisi kullanarak 1 dahil 10 a kadar olan tek sayilari ekrana basalim
do $$
declare
	counter integer := 0;
begin 
	loop 
		counter := counter +1 ;
		exit when counter > 10 ;
		continue when mod(counter, 2)=0; -- counter degerim cift sayi ise bu iterasyonu atla
		raise notice '%',counter;
	end loop ;
end $$ ;




--***********************************************************************
--*****************************  FUNCTION  ******************************
--***********************************************************************

-- syntax :

    create [or replace] function function_name(param_list)-- fonksiyon ismi ve parametrelerini setliyorum
        returns return_type -- donen data turunu belirtiyorum
        language plpgsql -- PL-JAVA / PL-Python
        as
    $$
    declare
        -- degisken tanimlama
    begin
        -- logic
    end $$;


-- Film tablomuzdaki filmlerin sayisini getiren bir fonsiyon yazalim

CREATE FUNCTION get_film_count(len_from int, len_to int)
	returns integer
	language plpgsql
as
$$
declare
	film_count integer;
begin
	select count(*)
	into film_count
	from film
	where length between len_from and len_to;
	
	return film_count;
end $$;


select get_film_count(40,150);




