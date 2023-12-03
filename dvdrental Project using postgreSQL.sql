--customer segment--
select customer.customer_id,customer.first_name,customer.last_name,
payment.payment_date ,count(distinct rental.rental_id)as total_rental
,SUM(payment.amount)as total_revenue
FROM rental 
INNER JOIN  payment ON rental.rental_id=payment.rental_id
INNER JOIN customer ON rental.customer_id=customer.customer_id
GROUP BY rental.rental_id,payment.payment_date,customer.customer_id,
customer.first_name,customer.last_name

--Film Performance--
SELECT film_id,title,length, release_year,ROUND(AVG(rental_rate),2)AS AVG_rental,
COUNT(film_id)AS total_ 
FROM film
GROUP BY film_id

SELECT rental.rental_id,rental.rental_date,COUNT(rental.rental_id)AS total_rental
,SUM(payment.amount)AS total_revenue
FROM rental
inner JOIN payment ON 
rental.customer_id=payment.customer_id
GROUP BY rental.rental_id,rental.rental_date,payment.payment_date
 
 --Store Comparison--
 
SELECT  store.store_id,payment.payment_date,rental.last_update,
SUM(payment.amount)AS total_revenue ,COUNT(rental.rental_id)as total_rental
FROM payment
INNER JOIN store ON payment.staff_id= store.manager_staff_id
INNER JOIN rental ON payment.customer_id=rental.customer_id
GROUP BY store.store_id,payment.payment_date,rental.last_update
 
 --**Seasonal Trends--
 SELECT customer.first_name||' '||customer.last_name AS full_name,
 Count(customer.customer_id) AS total_customer,COUNT(rental.rental_id)AS total_rental,
 EXTRACT(QUARTER FROM rental.rental_date)AS quarter, 
 EXTRACT(MONTH FROM rental.rental_date)AS month
 FROM rental
 INNER JOIN payment ON rental.customer_id=payment.customer_id
 INNER JOIN customer ON payment.customer_id=customer.customer_id
 GROUP BY customer.customer_id,EXTRACT(QUARTER FROM rental.rental_date)
 , EXTRACT(MONTH FROM rental.rental_date)
 
 --Late Returns Analysis--
 SELECT customer.first_name||' '||customer.last_name AS full_name,
 EXTRACT(MONTH FROM rental.return_date)AS quarter,
 EXTRACT(MONTH FROM rental.return_date)AS month,
COUNT(DISTINCT rental.return_date) AS total_return,
COUNT(rental.rental_id)AS total_rental,
rental.return_date
 FROM rental
 INNER JOIN payment ON rental.customer_id=payment.customer_id
 INNER JOIN customer ON payment.customer_id=customer.customer_id
 GROUP BY customer.first_name||' '||customer.last_name,
  EXTRACT(MONTH FROM rental.return_date),
  EXTRACT(MONTH FROM rental.return_date),rental.return_date
 
 









