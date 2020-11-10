
# Lab | Advanced SQL and Pivot tables

use sakila;

# 1. Select the first name, last name, and email address of all the customers who have rented a movie.
select concat(first_name,' ',last_name) as full_name, email, `active` from sakila.customer where `active`= '1';

# 2. What is the average payment made by each customer (display the customer id, customer name (concatenated), and the average payment made).

select a.customer_id, concat(a.first_name,' ',a.last_name) as full_name, round(avg(p.amount),2) as avg_payment 
from sakila.payment as p
left join sakila.customer as a
on a.customer_id = p.customer_id
group by a.customer_id;

# Select the name and email address of all the customers who have rented the "Action" movies.
# 3. Write the query using multiple join statements
# 4. Write the query using sub queries with multiple WHERE clause and IN condition
# 5. Verify if the above two queries produce the same results or not

select concat(c.first_name,' ',c.last_name) as full_name, c.email, cat.name from sakila.customer as c
join sakila.rental as r on c.customer_id = r.customer_id
join sakila.inventory as i on r.inventory_id = i.inventory_id
join sakila.film_category as ca on ca.film_id = i.film_id
join sakila.category as cat on ca.category_id = cat.category_id 
where cat.name='Action' group by c.customer_id;

select concat(first_name,' ',last_name) as full_name, email
from sakila.customer;

select i.inventory_id from sakila.film_category as fc 
inner join sakila.inventory as i
on fc.film_id = i.film_id 
where category_id=1;

select customer_id from sakila.rental where inventory_id in (select i.inventory_id from sakila.film_category as fc 
inner join sakila.inventory as i
on fc.film_id = i.film_id 
where category_id=1);

select concat(first_name,' ',last_name) as full_name, email
from sakila.customer where customer_id in (select customer_id from sakila.rental where inventory_id in (select i.inventory_id from sakila.film_category as fc 
inner join sakila.inventory as i
on fc.film_id = i.film_id 
where category_id=1));

# 6. Use the case statement to create a new column classifying 
#     existing columns as either or high value transactions based on the amount of payment. 
# If the amount is between 0 and 2, label should be low and if the amount is between 2 and 4, 
#     the label should be medium, and if it is more than 4, then it should be high

select amount, 
case 
when amount>=0 and amount<=2 then 'Low' 
when amount>2 and amount<=4 then 'Medium'
else 'High'
end as classification
from sakila.payment;