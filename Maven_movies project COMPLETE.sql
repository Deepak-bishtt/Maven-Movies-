/*CASE STUDY*/
/*The Maven Movies' company insurance policy is up for renewal and the insurance providing company’s 
underwriters need some updated information from it before they will issue a new insurance policy.*/

/*INTRODUCTION*/
/*The "Maven Movies" database represents a comprehensive movie rental system with interconnected tables 
capturing information about actors, films, customers, payments, and more. 
This dataset is designed to facilitate data analysis and retrieval related to a movie rental business.*/

use mavenmovies;
/*1 Pull the list of first_name, last_name and email of each of our customers
*/  
SELECT
	first_name,
    last_name,
    email
FROM customer;

/* 2
Pull the record of the films and see if there are rental duations other then: 3,5 or 7 days
*/ 

-- Solution: 2
SELECT DISTINCT 
	rental_duration
FROM film;

/* 3
Pull the list of all payments from our first 100 customers
*/  
 -- Solution: 3
SELECT
	customer_id,
    rental_id,
    amount,
    payment_date
FROM payment
WHERE customer_id BETWEEN 1 AND 100;

/*4
Pull payments from those specific customers along with payments above $5 from any customer
*/ 

-- Solution: 5
SELECT
	customer_id,
    rental_id,
    amount,
    payment_date
FROM payment
WHERE amount > 5 ;


/*6
Count of all film titles sliced by rental duration
*/ 
-- Solution: 6
SELECT
	rental_duration,
    COUNT(film_id) AS total_films_with_rental_duration
FROM film
GROUP BY rental_duration
ORDER BY 2 DESC;


/* 7
Pull count of films, along with avg, min and max of rental rate grouped by replacement cost
*/ 
-- Solution: 7
SELECT
	replacement_cost,
	COUNT(film_id) as number_of_films,
    MIN(rental_rate) as chepaest_rental,
    MAX(rental_rate) as expensive_rental,
    AVG(rental_rate) as average_rental
FROM film
GROUP BY replacement_cost
ORDER BY 1 DESC;

/*8
Pull list of all film titles along with there length and rental rate and sort from longest to shortes
*/ 
-- Solution:8
SELECT
	title,
    length,
    rental_rate
FROM film
ORDER BY length DESC;

/* 9
Pull list of film title, description, store id along with there inventory id
*/
-- Solution: 9
/*
Assignment: 1
Pull list of film title, description, store id along with there inventory id
*/

-- Solution: 9
SELECT
	inventory.inventory_id,
    inventory.store_id,
	film.title,
    film.description
FROM film
INNER JOIN inventory
	ON film.film_id = inventory.inventory_id;
    
/*
Assignment: 10
Unique titels and description available at store 2 inventory 
*/
-- Solution: 10
SELECT DISTINCT 
	film.title,
    film.description
FROM film
INNER JOIN inventory
	ON film.film_id = inventory.film_id
    AND inventory.store_id = 2;
    
    /*
11. My partner and I would like to get to know your board of advisors and any current investors.
Could you please provide a list of advisor and investor names in one table? 
Could you please note whether they are an investor or an advisor, and for the investors, 
it would be good to include which company they work with. 
*/

-- solution: 11 
SELECT
'investor' AS type, 
    first_name, 
    last_name, 
    company_name
FROM investor
UNION 
SELECT 
	'advisor' AS type, 
    first_name, 
    last_name, 
    Null
FROM advisor;


/*Q12
first_name and last_name of all staff memebers and advisors with there type
*/

-- Solution:12
SELECT
	'advisor' AS type,
	first_name,
    last_name
FROM advisor

UNION

SELECT
	'staff' AS type,
	first_name,
    last_name
FROM staff;

/*Q13
	I would like to get a better understanding of all of the inventory that would come along with the business. 
Please pull together a list of each inventory item you have stocked, including the store_id number, 
the inventory_id, the name of the film, the film’s rating, its rental rate and replacement cost. 
*/

SELECT 
	inventory.store_id, 
    inventory.inventory_id, 
    film.title, 
    film.rating, 
    film.rental_rate, 
    film.replacement_cost
FROM inventory
	LEFT JOIN film
		ON inventory.film_id = film.film_id
;

/* Q14 .	From the same list of films you just pulled, please roll that data up and provide a summary level overview 
of your inventory. We would like to know how many inventory items you have with each rating at each store. 
*/

SELECT 
	inventory.store_id, 
    film.rating, 
    COUNT(inventory_id) AS inventory_items
FROM inventory
	LEFT JOIN film
		ON inventory.film_id = film.film_id
GROUP BY 
	inventory.store_id,
    film.rating
;
