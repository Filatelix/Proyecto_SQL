
/*
1. Crea el esquema de la BBDD.
 */

/*
2. Muestra los nombres de todas las películas con una clasificación por edades de ‘Rʼ.
 */

select *
from "film"
where "rating" = 'R';

/*
3. Encuentra los nombres de los actores que tengan un “actor_idˮ entre 30 y 40.
 */

select *
from "actor"
where actor_id between 30 and 40;

/*
4. Obtén las películas cuyo idioma coincide con el idioma original.
 */

select *
from "film"
where "language_id" = "original_language_id";

/*
5. Ordena las películas por duración de forma ascendente.
 */

select *
from "film"
order by "length" asc;

/*
6. Encuentra el nombre y apellido de los actores que tengan ‘Allenʼ en su apellido.
 */

select concat ("first_name", ' ', "last_name") as "Nombre_Actor"
from "actor"
where "last_name" in ('ALLEN');

/*
7. Encuentra la cantidad total de películas en cada clasificación de la tabla “filmˮ y muestra la clasificación junto con el recuento.
 */

select "rating" as "Clasificación", count(*) as "Total_Clasificación"
from "film"
group by "rating";

/*
8. Encuentra el título de todas las películas que son ‘PG-13ʼ o tienen una duración mayor a 3 horas en la tabla film.
 */

select "film_id", "title"
from "film"
where "rating" = 'PG-13' or "length" > 180;

/*
9. Encuentra la variabilidad de lo que costaría reemplazar las películas.
 */

select
	min("replacement_cost") as "Coste_Remplazo_Mínimo",
	max("replacement_cost") as "Coste_Remplazo_Máximo",
	round (avg("replacement_cost"), 2) as "Coste_Remplazo_Medio",
	round (variance("replacement_cost"), 2) as "Coste_Remplazo_Varianza",
	round (stddev("replacement_cost"), 2) as "Coste_Remplazo_Desviación_Std"
from "film";

/*
10. Encuentra la mayor y menor duración de una película de nuestra BBDD.
 */

select
	min("length") as "Menor_Duración",
	max("length") as "Mayor_Duración"
from "film";

/*
11. Encuentra lo que costó el antepenúltimo alquiler ordenado por día.
 */

select "rental"."rental_date", "payment"."amount"
from "rental"
right join "payment"
on "rental"."rental_id" = "payment"."rental_id"
order by "rental_date" desc
limit 1 offset 2;

/*
12. Encuentra el título de las películas en la tabla “filmˮ que no sean ni ‘NC-17ʼ ni ‘Gʼ en cuanto a su clasificación.
 */

select "title", "rating"
from "film"
where "rating" not in('NC-17', 'G');

/*
13. Encuentra el promedio de duración de las películas para cada clasificación de la tabla film y muestra la clasificación
junto con el promedio de duración.
 */

select "rating" as "Clasificación", round(avg("length"), 2) as "Promedio_Duración"
from "film"
group by "rating";

/*
14.  Encuentra el título de todas las películas que tengan una duración mayor a 180 minutos.
 */

select "title", "length"
from "film"
where "length" > 180
order by "length";

/*
15.  ¿Cuánto dinero ha generado en total la empresa?.
 */

select sum("amount") as "Ingresos_Totales"
from "payment";
