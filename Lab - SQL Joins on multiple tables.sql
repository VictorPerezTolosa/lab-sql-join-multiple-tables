use sakila;

-- Instructions

-- 1. Write a query to display for each store its store ID, city, and country.

select * from store; -- store_id, address_id
select * from address; -- address_id, address, city_id
select * from city; -- city_id, city, country_id
select * from country; -- country_id, country

select store_id, address, city, country
from store s
left join address a using(address_id)
join city c using(city_id)
join country co using(country_id);

-- 2. Write a query to display how much business, in dollars, each store brought in.

select * from store; -- store_id, manager_staff_id
select * from payment; -- amount, staff_id
select * from staff; -- staff_id

select s.store_id as "store", sum(p.amount) as "total_amount_$"
from store s
left join staff st on s.manager_staff_id = st.staff_id
join payment p using(staff_id)
group by s.store_id;

-- 3. What is the average running time of films by category?

select * from film; -- length, film_id
select * from category; -- category_id, name
select * from film_category; -- film_id, category_id

select c.name, round(avg(f.length),2) as "average_length"
from category c
left join film_category fc using(category_id)
join film f using(film_id)
group by c.name;

-- 4. Which film categories are longest?

select c.name, round(avg(f.length),2) as "average_length"
from category c
left join film_category fc using(category_id)
join film f using(film_id)
group by c.name
order by round(avg(f.length),2) desc
limit 5; -- I put 5 but I could put 3 or 1... They didn't ask for a number

-- 5. Display the most frequently rented movies in descending order.

select * from rental; -- inventory_id
select * from film; -- film_id, title
select * from inventory; -- inventory_id, film_id

select f.title, count(r.inventory_id) as "times_rented"
from rental r
left join inventory i using(inventory_id)
left join film f using(film_id)
group by title
order by count(r.inventory_id) desc;

-- 6. List the top five genres in gross revenue in descending order.

select * from category; -- name, category_id
select * from payment; -- rental_id, amount
select * from film_category; -- film_id, category_id
select * from inventory; -- film_id, inventory_id
select * from rental; -- rental_id, inventory_id

select c.name, sum(p.amount) as "gross_revenue"
from category c
join film_category fc using(category_id)
join inventory i using(film_id)
join rental r using(inventory_id)
join payment p using(rental_id)
group by name
order by sum(p.amount) desc
limit 5;

-- 7. Is "Academy Dinosaur" available for rent from Store 1?

select * from inventory; -- film_id, store_id
select * from film; -- film_id, title

select title, sum(film_id) as "available_copies"
from film f
join inventory i using(film_id)
where i.store_id = 1 and f.title = "Academy Dinosaur";
















