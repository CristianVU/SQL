/* Select the first n number of rows of a database */
SELECT * FROM database
LIMIT n;

/*Select a row as of a given date */
SELECT * FROM database
WHERE date > '01/01/2000'
order by namecolumn DESC
LIMIT 1

/* Which director made the most movies? */
SELECT directors.name,COUNT(movies.id)
FROM movies INNER JOIN directors ON movies.director_id = directors.id
GROUP BY directors.name
ORDER BY COUNT DESC
LIMIT 1;

/* Which director is the most bankable? The one with more revenues (sum) */
SELECT d.name, SUM(m.revenue)
FROM movies m
JOIN directors d ON d.id = m.director_id
GROUP BY d.name
ORDER BY SUM DESC
LIMIT 1;

/* SQL queries */
sql
SELECT columns
FROM table
JOIN table ON condition
WHERE condition
AND condition
OR condition
GROUP BY column
ORDER BY column
LIMIT integer

/* Aggregative functions */

SELECT COUNT(*), column 
FROM table
GROUP BY column

SELECT SUM(column1), column2
FROM table
GROUP BY column2

/* JOIN OF THREE TABLES */
SELECT COUNT(movies.id), genres.name AS genre_name
FROM movies
JOIN movie_genres ON movie_genres.movie_id = movies.id
JOIN genres ON genres.id = movie_genres.genre_id
WHERE genres.name = 'Zombie'
GROUP BY genre_name

/* 

SQL documentation: https://www.sqlservertutorial.net/sql-server-basics/ 

Different kind of `JOIN` http://www.sql-join.com/sql-join-types


/* Advanced SQL query */
SELECT ROUND(EXTRACT(epoch FROM age(_camp_start_at,birthday)) / (3600*24*365)) as age,
COUNT (distinct_id)
FROM alumni
GROUP BY 1
HAVING ROUND(EXTRACT(epoch FROM age(_camp_start_at,birthday)) / (3600*24*365)) > 15
AND ROUND(EXTRACT(epoch FROM age(_camp_start_at,birthday)) / (3600*24*365)) < 90
ORDER BY 1


