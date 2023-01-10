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
