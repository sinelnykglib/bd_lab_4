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