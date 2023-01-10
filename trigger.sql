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