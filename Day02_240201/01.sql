use sakila;

select*from language;

select name from language;

select language_id, name, last_update from language;

select name from language;

select language_id,
	'Common' language_usage,
	language_id *3.14 lan_pi_value,
	upper(name) language_name
from language;

select actor_id from film_actor order by actor_id;
select distinct actor_id from film_actor order by actor_id; #데이터 정렬이 먼저 이루어짐.

select concat(cust.last_name, ', ', cust.first_name) as full_name, cust.email
from
	(select first_name, last_name, email
	from customer where first_name = 'JESSIE')
	as cust;
	
create temporary table actors_j
	(actor_id smallint(5),
	first_name varchar(45),
	last_name varchar(45));

desc actors_j;

insert into actors_j
	select actor_id, first_name, last_name
	from actor where last_name like 'J%';
	
select * from actors_j;

# 가상 테이블 (view)
create view cust_vw as 
	select customer_id, first_name, last_name, active
	from customer;
select * from cust_vw;

select first_name, last_name from cust_vw where active=0;

#테이블 연결(customer, rental)
select customer.first_name, customer.last_name,
	time(rental.rental_date) as rental_time #변수 rental_time에 시간 정보만 추출.
from customer inner join rental
	on customer.customer_id = rental.customer_id
where date(rental.rental_date) = '2005-06-14';

# 테이블 별칭 정의
select c.first_name, c.last_name,
	time(r.rental_date) as rental_time
from customer as c inner join rental as r
	on c.customer_id = r.customer_id 
where date(r.rental_date) = '2005-06-14';

select title
from film
where rating = 'G' and rental_duration>=7;

select title, rating, rental_duration
from film
where (rating ='G' and rental_duration>=7) or 
	(rating = 'PG-13' and rental_duration < 4);


