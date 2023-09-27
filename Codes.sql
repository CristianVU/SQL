/* FOREIGN KEY */
CREATE TABLE IF NOT EXISTS exams(
id SERIAL PRIMARY KEY,
subject VARCHAR(255) NOT NULL,
score DECIMAL NOT NULL,
student_id INT NOT NULL,
CONSTRAINT FK_student_id FOREIGN KEY (student_id) REFERENCES students(id))
/* student_id de la tabla exams va a tener que ser un número de id de la tabla students */
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
