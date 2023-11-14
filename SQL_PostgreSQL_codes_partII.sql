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

SELECT COUNT(*), column /* it counts allso NULL rows */
FROM table
GROUP BY column

/* to not count NULL rows: */
SELECT COUNT(column) FROM tablename

/*COUNT IF */
SELECT COUNTIF(column > number) FROM tablename /* We can use also AND/OR */

SELECT SUM(column1), column2, etc.
FROM table
GROUP BY column2

/* MAX and MIN */
SELECT MAX(column) FROM table

SELECT MIN(column) FROM table

SELECT MAX(column1), MIN(column2) FROM table

/* AVERAGE */
SELECT AVG(column) FROM table

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

/* WHERE + IN */
SELECT * FROM tablename
WHERE name IN ('Paul','Harris','Victor')

/* BETWEEN */
SELECT * FROM tablename
WHERE age BETWEEN 10 AND 50   /* also: WHERE age >= 10 AND <= 50 */

/* ORDER with numbers */
SELECT name, surname, birth_date, number_of_children 
FROM People
ORDER BY 4 DESC, 2 ASC

/* SELECT DISCTINCT : The SELECT DISTINCT statement is used to return only distinct (different) values. */
/* Example: Select all the different countries from the "Customers" table: */
SELECT DISTINCT Country FROM Customers;

/* Inside a table, a column often contains many duplicate values; and sometimes you only want to list the different (distinct) values. */
SELECT DISTINCT column1, column2, ...
FROM table_name;

/* COUNT DISTINCT */
SELECT COUNT(DISTINCT Country) FROM Customers; /* return the number of different countries */

SELECT Count(*) AS DistinctCountries
FROM (SELECT DISTINCT Country FROM Customers);

/* NULL VALUES */
SELECT column_names
FROM table_name
WHERE column_name IS NULL;

SELECT column_names
FROM table_name
WHERE column_name IS NOT NULL;

/* SELECT DISTINCT + NULL VALUES (rows with null values for a column) */
SELECT DISTINCT node_id
FROM shapr.node_human
WHERE industry IS NULL

/* Aggregation functions per group (a priori filter) */
SELECT buyer, SUM(spend) FROM purchases
GROUP BY buyer /* We can see how much spend each buyer */

/* a posteriori filter (filter by a codition) */
SELECT buyer, SUM(spend) AS totalspend FROM purchases
GROUP BY buyer
HAVING totalspend > 10

/* DATE_PARSE. The date function used to parse a date or datetime value, according to a given format string: */
SELECT DATE_PARSE("2018/01/02", "yyyy/MM/dd")

/* EXTRACT: */
SELECT EXTRACT(MONTH from date) AS month, SUM(spend) AS totalspend   /* Can be YEAR, WEEK, DAYOFWEEK, etc. Can use also the function DATE() */
FROM purchases
GROUP BY 1

/* WITH: */
WITH buyer_quantities_over_10 AS (
    SELECT buyer, SUM(quantity) AS totalquantity FROM purchases
    GROUP BY buyer
    HAVING totalquantity > 10 
)

SELECT COUNT(buyer)
FROM buyer_quantities_over_10

/* JOINS: */
LEFT JOIN
INNER JOIN
RIGHT JOIN
OUTER JOIN /* can see everything from both tables */

/* MORE THAN ONE JOIN: */
SELECT bu.name,pr.name, SUM(pu.quantity) AS totalquantity FROM purchases AS pu
INNER JOIN buyers AS bu ON pu.buyer_id = bu.id
INNER JOIN products AS pr ON pu.product_id = pr.id
GROUP BY 1,2
ORDER BY 1,2
