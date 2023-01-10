CREATE TABLE dubs (
	film_id int NOT NULL,
	film_name varchar(200) NOT NULL,
	film_lang varchar(30)
);

CREATE TABLE maturity_rate (
	film_name varchar(200) NOT NULL,
	age_rate varchar (10)
);

CREATE TABLE movie (
	film_name varchar (200) NOT NULL,
	run_time varchar (15),
	years int NOT NULL,
	rate decimal(3,1)
);

alter table dubs add constraint PK_dubs PRIMARY KEY (film_id);
alter table maturity_rate add constraint PK_maturity_rate PRIMARY KEY (film_name);
alter table movie add constraint PK_movie PRIMARY KEY (film_name);

ALTER table movie add constraint FK_movie_maturity_rate FOREIGN KEY (film_name) REFERENCES maturity_rate (film_name);
alter table dubs add CONSTRAINT FK_movie_dubs FOREIGN KEY (film_name) REFERENCES movie (film_name);


INSERT into maturity_rate
VALUES ('Flight 192', '16+'),
    ('SkyBound','16+'),
    ('A Case of You', '18+'),
    ('300', '18+'),
    ('10,000 B.C.', '13+');

insert into movie
VALUES ('10,000 B.C.', '1 h 48 min', 2008, 5.1),
    ('300', '1 h 56 min', 2007, 7.6),
    ('A Case of You', '1 h 31 min', 2014, 5.6),
    ('SkyBound', '1 h 21 min', 2017, 4.7),
    ('Flight 192', '1 h 25 min', 2016, 5);
	
insert into dubs
VALUES (1, '10,000 B.C.', 'English'),
    (2, '10,000 B.C.', 'Hindi'),
    (3, '10,000 B.C.', 'Telugu'),
    (4, '10,000 B.C.', 'Tamil'),
    (5, '300', 'English'),
    (6, '300', 'Tamil'),
    (7, '300', 'Telugu'),
    (8, '300', 'Hindi'),
    (9, 'A Case of You', 'English'),
    (10, 'SkyBound', 'Bengali'),
    (11, 'SkyBound', ' English'),
    (12, 'Flight 192', 'English'),
    (13, 'Flight 192', 'Malayalam');	


DROP FUNCTION IF EXISTS get_movie(varchar); 

CREATE OR REPLACE FUNCTION get_movie(film_arg varchar) RETURNS TABLE (name_film varchar, lang varchar)
    LANGUAGE 'plpgsql'
AS $$
BEGIN
    RETURN QUERY
        SELECT film_name::varchar, film_lang::varchar
		FROM dubs
		WHERE film_lang = film_arg;
END;
$$
SELECT * FROM get_movie('English');


--Процедура insert_movie(varchar, varchar, integer, decimal) додає в таблицю movie новий рядок із вказаними аргументами
DROP PROCEDURE IF EXISTS insert_movie(varchar, varchar, integer, decimal);
CREATE OR REPLACE PROCEDURE insert_movie(name_films varchar, time_run varchar, years_c integer, rate_c decimal)
LANGUAGE 'plpgsql'
AS $$
BEGIN
    INSERT INTO movie(film_name, run_time, years, rate) VALUES (name_film, time_run, years_c, rate_c);
END;
$$;

SELECT * FROM channel
-- ТЕСТИ
CALL insert_movie('Bemovie', '1 h 30 min', 2007, 5.7);


DROP TRIGGER IF EXISTS updaten_rating ON movie;

--Тригерна функція
CREATE OR REPLACE FUNCTION update_rating() RETURNS trigger 
LANGUAGE plpgsql
AS
$$
     BEGIN
          UPDATE movie
		  SET rate = rate + 0.1 
 		  WHERE movie.rate = NEW.rate; 
		  RETURN NULL;
     END;
$$;


CREATE TRIGGER updaten_rating
AFTER INSERT ON movie
FOR EACH ROW EXECUTE FUNCTION update_rating();

--ТЕСТ

INSERT INTO movie(film_name, run_time, years, rate) VALUES ('Avarat', '2 h 07 min', 2009, 7.8);

select * from  movie