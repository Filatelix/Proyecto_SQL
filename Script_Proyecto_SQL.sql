
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

select
	date("rental"."rental_date") as "Día_Alquiler",
	"payment"."amount"
from "rental"
right join "payment"
on "rental"."rental_id" = "payment"."rental_id"
order by date("rental"."rental_date") desc
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
14. Encuentra el título de todas las películas que tengan una duración mayor a 180 minutos.
 */

select "title", "length"
from "film"
where "length" > 180
order by "length";

/*
15. ¿Cuánto dinero ha generado en total la empresa?.
 */

select sum("amount") as "Ingresos_Totales"
from "payment";

/*
16. Muestra los 10 clientes con mayor valor de id.
 */

select "customer_id", concat("first_name", ' ', "last_name") as "Nombre_Cliente"
from "customer"
order by "customer_id" desc
limit 10;

/*
17. Encuentra el nombre y apellido de los actores que aparecen en la película con título ‘Egg Igbyʼ.
 */

select concat("actor"."first_name", ' ', "actor"."last_name") as "Nombre_Actor"
from film_actor
-- Unir la tabla actor
inner join "actor"
on "film_actor"."actor_id" = "actor"."actor_id"
-- Unir la tabla film
inner join "film"
on "film_actor"."film_id" = "film"."film_id"
-- Que salgan en la película Egg Igby
where "film"."title" in('EGG IGBY');

/*
18. Selecciona todos los nombres de las películas únicos.
 */

select distinct "title"
from "film";

/*
19. Encuentra el título de las películas que son comedias y tienen una duración mayor a 180 minutos en la tabla “filmˮ.
 */

select "film"."title"
from "film_category"
-- Unir la tabla film
inner join "film"
on "film_category"."film_id" = "film"."film_id"
-- Unir la tabla category
inner join "category"
on "film_category"."category_id" = "category"."category_id"
-- Se seleccionan las comedias con una duración mayor a 180 munitos
where "category"."name" in('Comedy')
and "film"."length" > 180;

/*
20. Encuentra las categorías de películas que tienen un promedio de duración superior a 110 minutos y muestra el nombre
de la categoría junto con el promedio de duración.
 */

select
	"category"."name",
	round(avg("film"."length"), 2) as "Duración_Promedio"
from "film_category"
-- Unir la tabla film
inner join "film"
on "film_category"."film_id" = "film"."film_id"
-- Unir la tabla category
inner join "category"
on "film_category"."category_id" = "category"."category_id"
-- Se agrupan por categorías y se seleccionan las que tienen una duración media superior a 110 minutos
group by "category"."name"
having avg("film"."length") > 110;

/*
21. ¿Cuál es la media de duración del alquiler de las películas?.
 */

select avg("return_date" - "rental_date") as "Media_Duración_Alquiler"
from "rental";

/*
22. Crea una columna con el nombre y apellidos de todos los actores y actrices.
 */

select concat("first_name", ' ', "last_name") as "Nombre_Actor"
from "actor";

/*
23. Números de alquiler por día, ordenados por cantidad de alquiler de forma descendente.
 */

select
	date("rental_date") as "Día_ALquiler",
	count(rental_id) as "Número_Alquileres"
from "rental"
group by date("rental_date")
order by "Número_Alquileres" desc;

/*
24. Encuentra las películas con una duración superior al promedio.
 */

select "title"
from "film"
where "length" > (
	select avg("length")
	from "film"
);

/*
25. Averigua el número de alquileres registrados por mes.
 */

select
	extract (month from "rental_date") as "Mes_Alquiler",
	count(rental_id) as "Número_Alquileres"
from "rental"
group by extract (month from "rental_date");

/*
26. Encuentra el promedio, la desviación estándar y varianza del total pagado.
 */

select
	round (avg("amount"), 2) as "Importe_Medio",
	round (variance("amount"), 2) as "Importe_Varianza",
	round (stddev("amount"), 2) as "Importe_Desviación_Std"
from "payment";

/*
27. ¿Qué películas se alquilan por encima del precio medio?.
 */

select "film"."title", "payment"."amount" 
from "payment"
-- Unir la tabla rental para obtener el inventory_id
left join "rental"
on "payment"."rental_id" = "rental"."rental_id"
-- Unir la tabla inventory para obtener el film_id
left join "inventory"
on "rental"."inventory_id" = "inventory"."inventory_id"
-- Unir la film inventory para obtener el title
left join "film"
on "inventory"."film_id" = "film"."film_id"
-- Ponemos la condición del alquiler por encima de la media
where "payment"."amount" > (
	select avg("payment"."amount")
	from "payment"
);

/*
28. Muestra el id de los actores que hayan participado en más de 40 películas.
 */

select "actor_id", "Total_Películas"
-- Hacemos el cálculo del número de películas en las que han participado los actores
from (
	select "actor_id", count("film_id") as "Total_Películas"
	from "film_actor"
	group by "actor_id"
	) as "Actores_Agrupados"
-- Añadimos la condición de más de 40 películas
where "Total_Películas" > 40;

/*
29. Obtener todas las películas y, si están disponibles en el inventario, mostrar la cantidad disponible.
 */

select
	"film"."title",
	count("inventory"."inventory_id") as "Total_Inventario"
from "film"
- Unimos la tabla inventory para obtener el inventario de las películas
left join "inventory"
on "film"."film_id" = "inventory"."film_id"
group by "film"."title";

/*
30. Obtener los actores y el número de películas en las que ha actuado.
 */

select
	concat("actor"."first_name", ' ', "actor"."last_name") as "Nombre_Actor",
	"Total_Películas"
-- Calculamos el número de películas en las que han actuado
from (
	select "film_actor"."actor_id", count("film_actor"."film_id") as "Total_Películas"
	from "film_actor"
	group by "actor_id"
	) as "Actores_Agrupados"
-- Unimos la tabla actor para tener los nombres de los actores
join "actor"
on "Actores_Agrupados"."actor_id" = "actor"."actor_id";

/*
31. Obtener todas las películas y mostrar los actores que han actuado en ellas, incluso si algunas películas
no tienen actores asociados.
 */

select
	"film"."title",
	concat("actor"."first_name", ' ', "actor"."last_name") as "Nombre_Actor"
from "film"
-- Unimos la tabla film_actor para luego poder unir la tabla actor. Con left join para que salgan todas las películas.
left join "film_actor"
on "film"."film_id" = "film_actor"."film_id"
-- Unimos la tabla actor para tener los datos de los actores. Con left join para que salgan todas las películas.
left join "actor"
on "film_actor"."actor_id" = "actor"."actor_id"
order by "title";

/*
32. Obtener todos los actores y mostrar las películas en las que han actuado, incluso si algunos actores no han
actuado en ninguna película.
 */

select
	concat("actor"."first_name", ' ', "actor"."last_name") as "Nombre_Actor",
	"film"."title"
from "actor"
-- Unimos la tabla film_actor para luego poder unir la tabla film. Con left join para que salgan todos los actores.
left join "film_actor"
on "actor"."actor_id" = "film_actor"."actor_id"
-- Unimos la tabla film para tener las palículas en las que han actuado. Con left join para que salgan todos los actores.
left join "film"
on "film_actor"."film_id" = "film"."film_id"
order by "Nombre_Actor";

/*
33. Obtener todas las películas que tenemos y todos los registros de alquiler.
 */

select *
from "film"
-- Hacemos un full join de la tabla inventory para unir todas la líneas y luego poder unir la tabla rental
full join "inventory"
on "film"."film_id" = "inventory"."film_id"
-- Hacemos full join de la tabla rental para obtener todos los registros de alquiler
full join "rental"
on "inventory"."inventory_id" = "rental"."inventory_id";

/*
34. Encuentra los 5 clientes que más dinero se hayan gastado con nosotros.
 */

select
	concat("customer"."first_name", ' ', "customer"."last_name"),
	sum("payment"."amount") as "Total_Gastado"
from "payment"
-- Unimos la tabla rental para luego poder unir la tabla customer
left join "rental"
on "payment"."rental_id" = "rental"."rental_id"
-- Unimos la tabla customer para poder obtener el nombre de los clientes
left join "customer"
on "rental"."customer_id" = "customer"."customer_id"
group by "customer"."customer_id"
order by "Total_Gastado" desc
limit 5;

/*
35. Selecciona todos los actores cuyo primer nombre es 'Johnny'.
 */

select concat("first_name", ' ', "last_name") as "Nombre_Actor"
from "actor"
where "first_name" in('JOHNNY');
