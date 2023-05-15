--  tek satir aciklama

/*
	cok satirli aciklama
*/

-- sutun isimlarinde buyuk harf kullanma (ROW TYPE'da sorun oluyor / baska methodlarda da olabilir)


--***********************************************************************
--************************  DEĞİŞKEN TANIMLAMA **************************
--***********************************************************************

do $$  	-- anonim bir blok oldugunu gosterir
		-- $ $ isaretleri bitisik olarak yorum satirinda kullanilirsa hata verir

declare
	counter integer := 1;
	firstName varchar(50) := 'Ali';
	lastName varchar(50) := 'Can';
	payment numeric(4,2) := 20.5; -- 4: toplam 4 basamak(ust sinir 38), 2: virgulden sonra 2 basamak
begin
	raise notice '% % % has been paid % USD', --  sout gibi  - % : yer tutucu
		counter,
		firstName,
		lastName,
		payment;
end $$ ;



-- Task 1 : değişkenler oluşturarak ekrana  Ahmet ve Mehmet beyler 120 tl ye bilet aldılar. 
-- cümlesini ekrana basınız

do $$  -- anonim bir blok oldugunu gosterir

declare
	name1 varchar(50) := 'Ahmet';
	name2 varchar(50) := 'Mehmet';
	payment numeric(4) := 120;
begin
	raise notice '% ve % beyler % tl ye bilet aldılar.',
		name1,
		name2,
		payment;
end $$ ;



--***********************************************************************
--**************************  BEKLEME KOMUTU  ***************************
--***********************************************************************

do $$
declare
    create_at time := now();
begin
    raise notice '%', create_at;
    perform pg_sleep(5);  -- 5 saniye kodu bekletiyorum
    raise notice '%', create_at;
    
end $$;


--***********************************************************************
--******************  TABLODAN DATA TIPINI KOPYALAMA  *******************
--***********************************************************************

do $$
declare
    film_title film.title%type;    -- data tipi tablodan otomatik olarak setleniyor
begin
    -- 1 id'li filmin ismini getir
    select title
	from film
	into film_title   -- bu satirda atama yapar
	where id=1;
	
	raise notice 'film title with id 1: %', film_title;
end $$;


-- Task : 1 id li filmin turunu ekrana basalim :
do $$
declare
	film_type film.type%type; --film_title --> text
begin
	select type
	from film
	into film_type -- select ve into'daki isimler ayni olamaz (mesela select type.. into type..)
	where id=1;
	
	raise notice 'Film type with id 1 : %',film_type;
end $$;


-- Task : 1 id li filmin ismini ve turunu ekrana basalim :
-- 1. yol
do $$
declare
	film_type film.type%type;
	film_title film.title%type;
begin
	select title,type
	from film
	into film_title,film_type
	where id=1;
	
	raise notice 'Film title and type with id 1 : % - %',film_title,film_type;
end $$;

-- 2. yol
do $$
declare
	film_type film.type%type;
	film_title film.title%type;
begin
	select title
	from film
	into film_title
	where id=1;
	
	select type
	from film
	into film_type
	where id=1;
	
	raise notice 'Film title and type with id 1 : % - %',film_title,film_type;
end $$;


--***********************************************************************
--*****************************  ROW TYPE  ******************************
--***********************************************************************

do $$
declare
	selected_film film%rowtype ;
begin
	-- 1 id li film getirelim
	select *
	from film
	into selected_film
	where id=1;
	
	raise notice 'The film is : % % % %',
			selected_film.id,
			selected_film.title,
			selected_film.type,
			selected_film.length;
end $$ ;



--***********************************************************************
--****************************  RECORD TYPE  ****************************
--***********************************************************************

do $$
declare
	rec record;
begin 
	select id, title, type
	into rec
	from film
	where id=2;
	
	raise notice '% % %',
				rec.id,
				rec.title,
				rec.type;
end $$;


--***********************************************************************
--****************************  İç İÇE BLOK  ****************************
--***********************************************************************

do $$
<<outer_block>>
declare -- outer block

	counter integer := 0;

begin
	
	counter := counter +1 ;
	raise notice 'counter degerim : %', counter;
	
	declare -- inner block
		counter integer := 0;
	begin
		counter := counter + 10;
		raise notice 'ic blokdaki counter degerim : %', counter;
		raise notice 'dis blokdaki counter degerim : %', outer_block.counter;
	
	end; -- inner block sonu
	
		raise notice 'dis blokdaki counter degerim : %', counter ;

end $$; -- outer block sonu

