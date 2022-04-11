-- 1. List all customers who live in Texas (use JOINs)
select customer.first_name, customer.last_name, address.district
from customer 
full join address 
on customer.address_id = address.address_id 
where district = 'Texas';
-- Answer - Kim Cruz, Jennifer Davis, Bryan Hardison, Ian Still, Richard Mccrary

-- 2. Get all payments above $6.99 with the Customer's Full Name
select customer.first_name, customer.last_name, payment.amount 
from customer
full join payment 
on customer.customer_id = payment.customer_id 
where amount > '6.99';


-- 3. Show all customers names who have made payments over $175(use subqueries)
select first_name, last_name
from customer
where customer_id in (
	select customer_id 
	from payment 
	group by customer_id, amount 
	having amount > 175
	order by amount desc
	);
-- Answer - Jennifer Davis, Mildred Bailey, Harold Martino

-- 4. List all customers that live in Nepal (use the city table)
select customer.first_name, customer.last_name, country
from customer 
full join address 
on customer.address_id = address.address_id
full join city 
on address.city_id = city.city_id 
full join country 
on city.country_id = country.country_id
where country = 'Nepal';
-- Answer - Kevin Schuler

-- 5. Which staff member had the most transactions?
select staff.first_name, staff.last_name, count(payment.staff_id)
from staff 
inner join payment 
on staff.staff_id = payment.staff_id
group by staff.first_name, staff.last_name
order by count desc;
-- Answer - Jon Stephens, 7304 transactions.

-- 6. How many movies of each rating are there?
select rating, count(title)
from film
group by rating
order by count desc;

-- 7.Show all customers who have made a single payment above $6.99 (Use Subqueries)
select first_name, last_name, amount
from customer 
inner join payment 
on customer.customer_id = payment.customer_id
where amount in (
	select amount 
	from payment 
	group by amount
	having amount > 6.99
	order by amount desc)
group by first_name, last_name, amount;

-- 8. How many free rentals did our stores give away?
select amount, count(amount) 
from payment 
where amount = 0
group by amount 
-- Answer - 23 times
