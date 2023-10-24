/* FOREIGN KEY */

CREATE TABLE IF NOT EXISTS exams(
id SERIAL PRIMARY KEY,
subject VARCHAR(255) NOT NULL,
score DECIMAL NOT NULL,
student_id INT NOT NULL,
CONSTRAINT FK_student_id FOREIGN KEY (student_id) REFERENCES students(id))

/* CREATE TABLE WITH VALUES */
CREATE TABLE IF NOT EXISTS people(
    id SERIAL PRIMARY KEY,
    name VARCHAR(50),
    surname VARCHAR(50),
    birthdate VARCHAR(50),
    number_of_children INT
);

INSERT INTO people(name,surname,birthdate,number_of_children)
VALUES
('Paul','Motchkovich','1990-08-13',0),
('Charlotte','Dupuis','1986-11-05',2),
('Clara','Milaux','1976-02-12',3);

SELECT * FROM people


/* ALTER TABLE TO ADD A FOREIGN KEY */

ALTER TABLE public.reviews ADD CONSTRAINT
FK_restaurant_id FOREIGN KEY (restaurant_id) REFERENCES restaurants(id)

/* LEFT JOIN */
/*Crear un conjunto de datos que une la información de dos (o más) tablas a través de una condición. Une lo que puede de la TABLA ORIGINAL con todo lo que se encuentra en la TABLA OBJETIVO, por la IZQUIERDA. Cumpliendo una condición.
ej. Unir siempre que la ID de un estudiante sea igual a la student_id en la otra tabla: */

SELECT * FROM public.students
LEFT JOIN public.exams
ON public.students.id=public.exams.students_id

/* Puedo filtrar usando WHERE: */
SELECT * FROM public.students
LEFT JOIN public.exams
ON public.students.id = public.exams.student_id
WHERE public.students.age<32

/* Puedo Llamar de una manera sencilla una tabla para no tener que estar escribiendo "public....."
ej. */
SELECT * FROM public.students s
LEFT JOIN public.exams e
ON s.id = e.student_id
WHERE s.age<32

/* Puedo especificar qué columnas quiero traerme de una tabla antes de hacer el left JOIN y ordenarlas a mi gusto: */
SELECT id,age,name FROM public.students s ............
/* o también abreviando cada columna: */
SELECT s.id as id,s.name as name, s.age as age,
e.subject as subject, e.score as score
FROM publics.students s
LEFT JOIN public.exams e
ON s.id=e.student_id

/* Puedo hacer varios JOINS seguidos uno luego del otro, en la misma query. */

/* INNER JOIN */

/* Cuando queremos cruzar varias tablas relacionadas entre sí, pero sólo los datos que cumplan una condición...
Las tablas se van a unir, y solo voy a tener lo que coinciden en ambas tablas. Para buscar algo puntual y rápido, es mejor.
Left join da un pool de información, muestra todo. Inner join filtra, quita lo que no coincide entre ambas tablas. */

SELECT * FROM public.students s
INNER JOIN public.exams e
ON s.id=e.student_id
WHERE e.subject ILIKE ('%SQL')

/* ALTER TABLE */

ALTER TABLE public.students
ADD COLUMN surname VARCHAR(255)

UPDATE public.students
SET surname='undefined'
WHERE surname IS NULL

ALTER TABLE public.students s
ALTER COLUMN surname SET NOT NULL

/* CHANGE COLUMN TYPE: */

ALTER TABLE public.students
ALTER COLUMN name TYPE VARCHAR(250)

/* DELETE A COLUMN */

ALTER TABLE public.students
DROP COLUMN

/* ADD A CONSTRAINT, for exmaple PRIMARY KEY */

ALTER TABLE tablename ADD CONSTRAINT
ADD PRIMARY KEY (id)

/* CRUD (create, read, update and delete) */

CREATE TABLE Usuarios (id INT,nombre VARCHAR(50),edad INT)

INSERT INTO nombre_de_tabla (columna1, columna2, columna3, ...)
VALUES (valor1, valor2, valor3, ...);

DELETE FROM nombre_de_tabla
WHERE condicion;

SELECT * FROM tablename
SELECT columna1,columna2 FROM tablename
SELECT * FROM personas WHERE edad < 30

UPDATE courses
SET published_date = '2020-08-01' 
WHERE course_id = 3

/* Al final del code se puede poner RETURNING * para ver la fila que se cambiaron los datos. */

/* ORDER FUNCTION (DESC OR ASC) */

SELECT *
FROM restaurants
ORDER BY rating DESC

/* COUNT FUNCTION : how many elements I have ? */

SELECT COUNT(*) FROM restaurants 

/* GROUP AND COUNT */

/*Example: count all restaurants per city: */

SELECT city,COUNT(*) FROM restaurants
GROUP BY city 

SELECT name AS "Nombre",COUNT(*) AS "Counter" FROM restaurants
GROUP BY name
ORDER BY Counter DESC

SELECT name AS "Nombre",COUNT(*) AS "Counter" FROM restaurants
GROUP BY name
ORDER BY COUNT(*) DESC

/* JOIN FUNCTION. For example: "Give all the reviews for restaurant 'Ichiran' */

SELECT name,
FROM restaurants
JOIN reviews ON restaurants.id = reviews.restaurant_id
WHERE restaurants.name = 'Ichiran'

/* Another example: How many reviews for Ichiran restaurant? */

SELECT COUNT(*)
FROM restaurants
INNER JOIN reviews ON restaurants.id = reviews.restaurant_id
WHERE restaurants.name = 'Ichiran'

/* SELECT FUNCTION WITH 2 CONDITIONS (AND or OR) */
SELECT *
FROM restaurants
WHERE name LIKE '%Cafe%'
AND city='Paris'

SELECT * FROM people
WHERE name = 'Clara' OR number_of_children = 0

/*Count all restaurants per city and then sort them by counter (ORDER) */
SELECT city, COUNT(*) AS counter
FROM restaurants
GROUP by city
ORDER by counter DESC

/* USE OF LIKE with % :
C% : starts with 'C'
%C : finishes with 'C'
%C% : contains 'C' 
_C% : 'C' as second letter */

/* SELECT + rename column */
SELECT 'column name' AS 'new name' FROM 'table name'

/* ORDER by 2 columns */
SELECT name,birthdate FROM people
ORDER BY birthdate DESC, name ASC
