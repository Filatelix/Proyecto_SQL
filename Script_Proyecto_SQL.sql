
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

/*
36. Renombra la columna “first_nameˮ como Nombre y “last_nameˮ como Apellido.
 */

select "first_name" as "Nombre", "last_name" as "Apellido"
from "actor";

/*
37. Encuentra el ID del actor más bajo y más alto en la tabla actor.
 */

select
	min("actor_id") as "id_mínimo",
	max("actor_id") as "id_máximo"
from "actor";

/*
38. Cuenta cuántos actores hay en la tabla “actorˮ.
 */

select count("actor_id") as "Número_Actores"
from "actor";

/*
39. Selecciona todos los actores y ordénalos por apellido en orden ascendente.
 */

select concat("first_name", ' ', "last_name") as "Nombre_Actor"
from "actor"
order by "last_name" asc;

/*
40. Selecciona las primeras 5 películas de la tabla “filmˮ.
 */

select "title"
from "film"
order by "film_id" asc
limit 5;

/*
41. Agrupa los actores por su nombre y cuenta cuántos actores tienen el mismo nombre. ¿Cuál es el nombre más repetido?.
 */

select "first_name", count("first_name") as "Repeticiones"
from "actor"
group by "first_name"
order by "Repeticiones" desc;

/*
42. Encuentra todos los alquileres y los nombres de los clientes que los realizaron.
 */

select
	"rental"."rental_id",
	concat("customer"."first_name", ' ', "customer"."last_name") as "Nombre_Cliente"
from "rental"
-- Unimos la tabla customer para obtener los nombres de quienes realizaron el alquiler
left join "customer"
on "rental"."customer_id" = "customer"."customer_id";

/*
43. Muestra todos los clientes y sus alquileres si existen, incluyendo aquellos que no tienen alquileres.
 */

select
	concat("customer"."first_name", ' ', "customer"."last_name") as "Nombre_Cliente",
	"rental"."rental_id"
from "customer"
-- Unimos la tabla rental para obtener los alquileres que han realizado
left join "rental"
on "customer"."customer_id" = "rental"."customer_id"
order by "Nombre_Cliente";

/*
44. Realiza un CROSS JOIN entre las tablas film y category. ¿Aporta valor esta consulta? ¿Por qué?
Deja después de la consulta la contestación.
 */

select
	"film"."title",
	"category"."name"
from "film"
cross join "category";

/*
Esta consulta no tiene sentido porque crea una fila de cada polícula combinándola con cada categoría. Esto no nos dice nada porque
a una película no le pueden corresponder todas las categorías.
 */

/*
45. Encuentra los actores que han participado en películas de la categoría 'Action'.
 */

select
	concat("actor"."first_name", ' ', "actor"."last_name") as "Nombre_Actor",
	"category"."name"
from "actor"
-- Unimos la tabla film_actor para luego poder unir la tabla film_category
left join "film_actor"
on "actor"."actor_id" = "film_actor"."actor_id"
-- Unimos la tabla film_category para luego poder unir la tabla category
left join "film_category"
on "film_actor"."film_id" = "film_category"."film_id"
-- Unimos la tabla category para obtener el nombre de la categoría
left join "category"
on "film_category"."category_id" = "category"."category_id"
-- Ponemos la condición de que sólo muestre los actores con la categoría 'Action'
where "category"."name" = 'Action';

/*
46. Encuentra todos los actores que no han participado en películas.
 */

select concat("actor"."first_name", ' ', "actor"."last_name") as "Nombre_Actor"
from "actor"
-- Unimos la tabla film_actor para luego poder unir la tabla film
left join "film_actor"
on "actor"."actor_id" = "film_actor"."actor_id"
-- Unimos la tabla film para poder obtener las películas en las que han participado
left join "film"
on "film"."film_id" = "film_actor"."film_id"
-- Ponemos la condición de que sólo muestre los actores sin película
where "film"."film_id" is null;

/*
47. Selecciona el nombre de los actores y la cantidad de películas en las que han participado.
 */

select
	concat("actor"."first_name", ' ', "actor"."last_name") as "Nombre_Actor",
	count("film"."film_id") as "Número_Películas"
from "actor"
-- Unimos la tabla film_actor para luego poder unir la tabla film
left join "film_actor"
on "actor"."actor_id" = "film_actor"."actor_id"
-- Unimos la tabla film para poder obtener las películas en las que han participado
left join "film"
on "film"."film_id" = "film_actor"."film_id"
-- Agrupamos por el actor_is para contar las películas en las que ha participado
group by "actor"."actor_id"
order by "Número_Películas" desc;

/*
48. Crea una vista llamada “actor_num_peliculasˮ que muestre los nombres de los actores y el número de películas
en las que han participado.
 */

create view actor_num_peliculas as
select
	concat("actor"."first_name", ' ', "actor"."last_name") as "Nombre_Actor",
	count("film"."film_id") as "Número_Películas"
from "actor"
-- Unimos la tabla film_actor para luego poder unir la tabla film
left join "film_actor"
on "actor"."actor_id" = "film_actor"."actor_id"
-- Unimos la tabla film para poder obtener las películas en las que han participado
left join "film"
on "film"."film_id" = "film_actor"."film_id"
-- Agrupamos por el actor_is para contar las películas en las que ha participado
group by "actor"."actor_id";

/*
49. Calcula el número total de alquileres realizados por cada cliente.
 */

select
	concat("customer"."first_name", ' ', "customer"."last_name") as "Nombre_Cliente",
	count("rental"."rental_id") as "Número_Alquileres"
from "customer"
-- Unimos la tabla rental para obtener los datos de los alquileres
left join "rental"
on "customer"."customer_id" = "rental"."customer_id"
-- Agrupamos por customer_id para contar los alquileres que han realizado
group by "customer"."customer_id"
order by "Número_Alquileres" desc;

/*
50. Calcula la duración total de las películas en la categoría 'Action'.
 */

select sum("film"."length") as "Duración_Total"
from "film"
-- Unimos la tabla film_category para obtener el category_id
inner join "film_category"
on "film"."film_id" = "film_category"."film_id"
-- Unimos la tabla category para obtener el nombre de las categorías
inner join "category"
on "film_category"."category_id" = "category"."category_id"
-- Ponemos la condición de que sólo cuente las películas con la categoría 'Action'
where "category"."name" = 'Action';

/*
51. Crea una tabla temporal llamada “cliente_rentas_temporalˮ para almacenar el total de alquileres por cliente.
 */

create temporary table cliente_rentas_temporal as
select
	concat("customer"."first_name", ' ', "customer"."last_name") as "Nombre_Cliente",
	count("rental"."rental_id") as "Número_Alquileres"
from "customer"
-- Unimos la tabla rental para obtener los datos de los alquileres
left join "rental"
on "customer"."customer_id" = "rental"."customer_id"
-- Agrupamos por customer_id para contar los alquileres que han realizado
group by "customer"."customer_id";

/*
52. Crea una tabla temporal llamada “peliculas_alquiladasˮ que almacene las películas que han sido alquiladas al menos 10 veces.
 */

create temporary table películas_alquiladas as
select
	"film"."title",
	count("rental"."rental_id") as "Número_Alquileres"
from "film"
-- Unimos la tabla inventory para obtener el inventory_id
inner join "inventory"
on "film"."film_id" = "inventory"."film_id"
-- Unimos la tabla rental para obtener los datos de alquileres
inner join "rental"
on "rental"."inventory_id" = "inventory"."inventory_id"
-- Agrupamos por title y filtramos por los que tienen al menos 10 alquileres
group by "film"."title"
having count("rental"."rental_id") > 9;

/*
53. Encuentra el título de las películas que han sido alquiladas por el cliente con el nombre ‘Tammy Sandersʼ y
que aún no se han devuelto. Ordena los resultados alfabéticamente por título de película.
 */

select "film"."title"
from "customer"
-- Unimos la tabla rental para obtener la información de alquileres
inner join "rental"
on "customer"."customer_id" = "rental"."customer_id"
-- Unimos la tabla invenotry para después poder unir la tabla film
inner join "inventory"
on "rental"."inventory_id" = "inventory"."inventory_id"
-- Unimos la tabla film para obtener la información sobre los títulos de las películas
inner join "film"
on "inventory"."film_id" = "film"."film_id"
-- Ponemos las condiciones del nombre y la fecha de devolución, y ordenamos por título
where "customer"."first_name" = 'TAMMY'
and "customer"."last_name" = 'SANDERS'
and "rental"."return_date" is null
order by "film"."title" asc;

/*
54. Encuentra los nombres de los actores que han actuado en al menos una película que pertenece a la categoría ‘Sci-Fiʼ.
Ordena los resultados alfabéticamente por apellido.
 */

select distinct(concat("actor"."first_name", ' ', "actor"."last_name")) as "Nombre_Actor"
from "actor"
-- Unimos la tabla film_actor para obtener el film_id
inner join "film_actor"
on "actor"."actor_id" = "film_actor"."actor_id"
-- Unimos la tabla film_category para obtener el category_id
inner join "film_category"
on "film_actor"."film_id" = "film_category"."film_id"
-- Unimos la tabla category para obtener el dato del nombre de la categoría
inner join "category"
on "film_category"."category_id" = "category"."category_id"
-- Ponemos el filtro de la categoría 'Sci-Fi'
where "category"."name" = 'Sci-Fi'
order by "Nombre_Actor" asc;

/*
55. Encuentra el nombre y apellido de los actores que han actuado en películas que se alquilaron después de que
la película ‘Spartacus Cheaperʼ se alquilara por primera vez. Ordena los resultados alfabéticamente por apellido.
 */

select distinct
	"actor"."first_name",
	"actor"."last_name"
from "actor"
-- Unimos la tabla film_actor para obtener el film_id
inner join "film_actor"
on "actor"."actor_id" = "film_actor"."actor_id"
-- Unimos la tabla inventory para obtener el inventory_id
inner join "inventory"
on "film_actor"."film_id" = "inventory"."film_id"
-- unimos la tabla rental para obtener la información sobre alquileres
inner join "rental"
on "inventory"."inventory_id" = "rental"."inventory_id"
-- Añadimos una subconsulta para hacer el filtro de la fecha de alquiler basada en el primer alquiler de 'Spartacus Cheaper'
where "rental"."rental_date" > (
	-- Seleccionamos la fecha mínima, es decir, la primera fecha
	select min("rental"."rental_date")
	from "film"
	-- Unimos la tabla inventory para obtener el inventory_id
	inner join "inventory"
	on "film"."film_id" = "inventory"."film_id"
	-- Unimos la table rental para obtener la información sobre los alquileres
	inner join "rental"
	on "inventory"."inventory_id" = "rental"."inventory_id"
	-- Añadimos la condicion de el título sea 'Spartacus Cheaper'
	where "film"."title" = 'SPARTACUS CHEAPER')
-- Ordenamos por el apellido del actor
order by "actor"."last_name" asc;

/*
56. Encuentra el nombre y apellido de los actores que no han actuado en ninguna película de la categoría ‘Musicʼ.
 */

select distinct
	"actor"."first_name",
	"actor"."last_name"
from "actor"
-- Unimos la tabla film_actor para obtener el film_id
left join "film_actor"
on "actor"."actor_id" = "film_actor"."actor_id"
-- Unimos la tabla film_category para obtener el category_id
left join "film_category"
on "film_actor"."film_id" = "film_category"."film_id"
-- Unimos la tabla category para obtener la categoría 'Music'
left join "category"
on "film_category"."category_id" = "category"."category_id"
-- Ponemos la condición que no hayan actuado en ninguna película 'Music'
and "category"."name" = 'Music'
where "category"."name" is null;

/*
57. Encuentra el título de todas las películas que fueron alquiladas por más de 8 días.
 */

select distinct "film"."title"
from "film"
-- Unimos la tabla inventory para obtener el inventory_id
left join "inventory"
on "film"."film_id" = "inventory"."film_id"
-- Unimos la tabla rental para obtener las fechas del alquiler
left join "rental"
on "inventory"."inventory_id" = "rental"."inventory_id"
-- Ponemos la condición de la duración del alquiler superior a 8 días
where ("rental"."return_date" - "rental"."rental_date") > interval '8 days';

/*
58. Encuentra el título de todas las películas que son de la misma categoría que ‘Animationʼ.
 */

select "film"."title"
from "film"
-- Unimos la tabla film_category para obtener el category_id
inner join "film_category"
on "film"."film_id" = "film_category"."film_id"
-- Unimos la tabla category para obtener la categoría 'Animation'
inner join "category"
on "film_category"."category_id" = "category"."category_id"
-- Ponemos la condición de que sean de la categoría 'Animation'
where "category"."name" = 'Animation';

/*
59. Encuentra los nombres de las películas que tienen la misma duración que la película con el título ‘Dancing Feverʼ.
Ordena los resultados alfabéticamente por título de película.
 */

select "title"
from "film"
-- Hacemos el filtro de las películas que duren lo mismo que 'Dancing Fever'
where "length" = (
	select "length"
	from "film"
	where "title" = 'DANCING FEVER')
order by "title";

/*
60. Encuentra los nombres de los clientes que han alquilado al menos 7 películas distintas. Ordena los resultados alfabéticamente
por apellido.
 */

select
	"customer"."first_name",
	"customer"."last_name"
from "customer"
-- Unimos la tabla rental para obtener el inventory_id
inner join "rental"
on "customer"."customer_id" = "rental"."customer_id"
-- Unimos la tabla inventory para obtener el film_id
inner join "inventory"
on "rental"."inventory_id" = "inventory"."inventory_id"
-- Unimos la tabla film para obtener los títulos de las películas
inner join "film"
on "inventory"."film_id" = "film"."film_id"
-- Agrupamos por customer_id y añadimos el filtro
group by "customer"."customer_id"
having count(distinct "film"."film_id") > 6
order by "customer"."last_name";

/*
61. Encuentra la cantidad total de películas alquiladas por categoría y muestra el nombre de la categoría junto con el
recuento de alquileres.
 */

select
	"category"."name",
	count(*) as "Número_ALquileres"
from "rental"
-- Unimos la tabla inventory para obtener el film_id
inner join "inventory"
on "rental"."inventory_id" = "inventory"."inventory_id"
-- Unimos la tabla film_category para obtener el category_id
inner join "film_category"
on "inventory"."film_id" = "film_category"."film_id"
-- Unimos la tabla category para obtener el nombre de las categorías
inner join "category"
on "film_category"."category_id" = "category"."category_id"
-- Agrupamos por la categoría y ordenamos
group by "category"."name"
order by count(*) desc;

/*
62. Encuentra el número de películas por categoría estrenadas en 2006.
 */

select
	"category"."name",
	count("film"."film_id") as "Número_Estrenos"
from "film"
-- Unimos la tabla film_category para obtener el category_id
inner join "film_category"
on "film"."film_id" = "film_category"."film_id"
-- Unimos la tabla category para obtener el nombre de las categorías
inner join "category"
on "film_category"."category_id" = "category"."category_id"
-- Filtramos por las películas que se han estrenado en 2006, agrupamos por categoría y ordenamos
where "film"."release_year" = '2006'
group by "category"."name"
order by count("film"."film_id") desc;

/*
63. Obtén todas las combinaciones posibles de trabajadores con las tiendas que tenemos.
 */

select
	concat("staff"."last_name", ', ', "staff"."first_name") as "Nombre_Empleado",
	"store"."store_id"
from "staff"
cross join "store";

/*
64. Encuentra la cantidad total de películas alquiladas por cada cliente y muestra el ID del cliente,
su nombre y apellido junto con la cantidad de películas alquiladas.
 */

select
	"customer"."customer_id",
	"customer"."first_name",
	"customer"."last_name",
	count("rental"."rental_id") as "Número_Alquileres"
from "customer"
-- Unimos la tabla rentals para obtener la información sobre alquileres
inner join "rental"
on "customer"."customer_id" = "rental"."customer_id"
-- Agrupamos por customer_id, contamos y ordenamos
group by "customer"."customer_id"
order by count("rental"."rental_id") desc;
