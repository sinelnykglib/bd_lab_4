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