CREATE DATABASE moviedb;

USE moviedb;
CREATE TABLE movietbl
	(movie_id		INT,
	movie_title	VARCHAR(30),
	movie_director	VARCHAR(20),
	movie_star	VARCHAR(20),
	movie_script	LONGTEXT,
	movie_film	LONGBLOB
	) DEFAULT CHARSET=utf8mb4;

INSERT INTO movietbl VALUES (1, '쉰들러 리스트','스필버그','리암 니슨', LOAD_FILE('C:/movies/Scindler.txt'), 
LOAD_FILE('C:/movies/Mohican.mp4')
);
select LOAD_FILE('C:/movies/Scindler.txt');
select 'this is a testing sql by 장동민' into outfile'C:/movies/test.txt';