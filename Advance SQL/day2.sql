
--***********************************************************************
--*****************************  CONSTANT  ******************************
--***********************************************************************

do $$
declare
	vat constant numeric := 0.1;
	net_price numeric = 20.5;
begin
	raise notice 'satis fiyati: %', net_price*(1+vat);
	-- vat = 0.05; -- constant bir degiskeni degistirmeye calisirsak hata aliriz
end $$;


-- constant bir degere RT'de (runtime) deger verilebilir mi?

do $$
declare
	start_at constant time := now();
begin
	raise notice 'blogun calisma zamani : %', start_at;
end $$ ;



-- ////////////////////////  CONTROL STRUCTURES ////////////////////////


--***********************************************************************
--***************************  IF STATEMENT  ****************************
--***********************************************************************

-- Syntax:
/*
	if condition then
		statement;
	end if;
*/


-- Task : 0 id li filmi bulalım eğer yoksa ekrana uyarı yazısı verelim:

do $$
declare
	film1 film%rowtype;
	input_id film.id%type = 0;
begin
	select *
	from film
	into film1
	where id=input_id;
	
	if NOT FOUND then
		raise notice 'film not found with id: %', input_id;
	end if;
end $$;


-- Task: 2 id li filmi bulalim, eger yoksa ekrana uyari yazalim, varsa da ismini ekrana yazalim
do $$
declare
	film1 record;
	input_id film.id%type = 2;
begin
	select title
	from film
	into film1
	where id=input_id;
	
	if NOT FOUND then
		raise notice 'film not found with id: %', input_id;
	else
		raise notice 'film: %', film1.title;
	end if;
end $$;



-- Task :  eger film tablosu bos degilse (count methodu ile)
-- film tablosuna id,title degerlerini ayarliyarak yeni veri girisini yapan kodu yazalim

do $$
declare
	count integer;
begin
	select count(*)
	into count
	from film;
	
	if count>0 then
		insert into film(id,title)
		values (count+1, 'GUL');
		
		raise notice 'yeni film eklendi.';
	else
		raise notice 'film yok.';
	end if;
end $$;



--***********************************************************************
--*************************  IF-THEN-ELSE-IF  ***************************
--***********************************************************************

-- syntax :

/*
	IF condition_1 THEN 
		statement_1;
	ELSE IF condition_2 THEN
		statement_2;
		...
	ELSE IF condition_n THEN
		statment_n;
	ELSE 
		else_statement;
	END IF ;
*/


--	Task : 1 id li film varsa ;
--			süresi 50 dakikanın altında ise Short,
--			50<length<120 ise Medium,
--			length>120 ise Long yazalım

do $$
declare
	v_film film%rowtype; -- 1 id li filmi bu degisken uzerinden tutacagim
	len_description varchar(50); -- film uzunluk bilgisini bu degisken ile takip edecegiz
begin
	select * from film
	into v_film
	where id =1;
	
	if not found then
		raise notice 'Filim bulunamadi';
	else 
		if v_film.length>0 and v_film.length <=50 then
					len_description='Kisa';
				elseif v_film.length>50 and v_film.length<120 then
					len_description='Orta';
				elseif v_film.length>=120 then
					len_description='Uzun';
				else
					len_description='Tanimlanamiyor';
		 end if;
	 raise notice ' % filmin suresi : %', v_film.title, len_description;
	 end if;
end $$ ;



--***********************************************************************
--*************************  CASE STATEMENT  ****************************
--***********************************************************************

--syntax :
/*
        CASE search-expression
            WHEN expression_1 [, expression_2] THEN
                statement;
            [..]
            [else
                else-statement]
        END CASE;
*/

-- Task : Filmin türüne göre çocuklara uygun olup olmadığını ekrana yazalım

do $$
declare
	tur film.type%type;
	uyari varchar(50);
begin 
	select type from film
	into tur
	where id = 4;
	
	if found then
		case tur 
			when 'korku' then
				uyari = 'Cocuklar icin uygun degil';
			when 'macera' then
				uyari = 'Cocuklar icin uygun';
			when 'animasyon' then
				uyari = 'Cocuklar icin tavsiye edilir';
			else
				uyari = 'Tanimlanamadi';
		end case;
		raise notice '%' , uyari;
	end if;
end $$;



--***********************************************************************
--******************************  LOOP  *********************************
--***********************************************************************

-- syntax : 

/*
    <<label>>
    LOOP
        statement;
        
    END LOOP ;
    
    
    --> loop u sonlandirmaK icin if yapisini kullanabiliriz
    
    <<label>>
    LOOP
        statement;
        IF condition THEN
            exit;
        END IF;
     END LOOP ;
     
     --> nested loop 
     
     <<outer>>
     LOOP
        statement;
        <<inner>>
        LOOP
            statement_2;
            exit <<inner>>
        END LOOP;
     END LOOP;
*/


-- Task : Fibonacci Sayilari : 1, 1, 2, 3, 5, 8, .....

do $$
declare
	n integer = 7;
	count integer = 0;
	i integer = 0;
	j integer = 1;
	fib integer;
begin
	loop
		exit when n=count;
		count = count +1;
		select j, j+i into i,j;
	end loop;
	fib = i;
	raise notice '%' , fib;
end $$;









