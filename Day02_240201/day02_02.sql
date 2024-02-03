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

# G등급이면서 7이상 대여 가능하거나 PG-13등급이면서 3일이내로 대여할 수 있는 영화 목록
select title
from film
where rating = 'G' and rental_duration>=7;

select title, rating, rental_duration
from film
where (rating ='G' and rental_duration>=7) or 
	(rating = 'PG-13' and rental_duration < 4);

# select 컬럼 from 테이블 group by 그룹화할 컬럼;
select c.first_name, c.last_name, count(*)
from customer as c inner join rental as r
	on c.customer_id = r.customer_id 
group by c.first_name, c.last_name 
having count(*) >=40;

# order by (1) 정렬
select c.first_name, c.last_name,
	time(r.rental_date) as rental_time
from customer as c inner join rental as r
	on c.customer_id = r.customer_id 
where date(r.rental_date) = '2005-06-14'
order by c.last_name, c.first_name asc;

# order by (2) 순서를 통한 정렬 (DB는 1부터 시작)
select c.first_name, c.last_name,
	time(r.rental_date) as rental_time
from customer as c
	inner join rental as r
	on c.customer_id = r.customer_id
where date(r.rental_date) = '2005-06-14'
order by 1 desc;

# order by (3)
select actor_id, first_name, last_name
from actor
order by last_name, first_name; #last_name이 동일한 경우 first_name 순으로 정렬.

# 성이 williams <또는> Davis인 모든 배우의 actor_id, first_name, last_name 정보 검색
select actor_id, first_name, last_name
from actor
where last_name = 'WILLIAMS' or last_name = 'DAVIS';


# rental 테이블에서 2005년 7월 5일에 영화를 대여한 고객 ID를 반환하는 쿼리를 작성.
select distinct customer_id
from rental
where date(rental_date) = '2005-07-05';

select c.store_id, c.email, r.rental_date # st
from customer as c inner join rental as r
	on c.customer_id = r.customer_id 
where date(r.rental_date) = '2005-06-14'
order by return_date desc;

#해당 식이 특정 범위 내에 있는지 확인
select customer_id, rental_date
from rental
where rental_date < '2005-05-25';

#해당 날짜만 검색 : date(rental_date) = '2005-05-25'
select customer_id, rental_date
from rental
where rental_date <= '2005-06-16' #2005년 06월 16일 00시 이전이고
	and rental_date >='2005-06-14'; # 2005 6월 14일 00시 이후일 때. (2005년 6월 16일은 시간 때문에 포함되지 않음.)

select customer_id, rental_date
from rental
where date(rental_date) between '2005-06-14' and '2005-06-16'

#숫자 범위 사용
# 하한값과 상한값이 범위에 포함됨.
select customer_id, payment_date, amount
from payment where amount between 10.0 and 11.99;

# 문자열 범위
select last_name, first_name
from customer
where last_name between 'FA' and 'FRB';

#in() 연산
select title, rating
from film
where rating = 'G' or rating = 'PG';

select title, rating
from film
where rating in ('G', 'PG');

# 서브 쿼리 사용 - 값의 집합을 생성할 수 있음.
select title, rating
from film
where rating in(select title, rating from film where title like '%PET%'); #pet을 포함해서 출력.

#where rating in ('G', 'PG');

select title, rating
from film
where rating not in('PG-13', 'R', 'NC-17');

select left('abcdefg', 3);
select mid ('abcdef', 2, 3);
select right('abcdefg',2)

select last_name, first_name
from customer 
where last_like 'Q%' or last_name like #두번쨰 위치에 'A', 네 번째 위치에 'T'를 포함하며 마지막은 'S'로 끝나는 문자열.


#NULL 조건 조합
# 2005년 5월에서 8월 사이에 반납되지 않은 대여 정보 검색
# 반납이 되지 않은 경우, 반납 날짜의 값이 NULL
# 또는 반납 날짜가 2005년 5월 ~ 2005년 8월 사이가 아닌 경우.
select rental_id, customer_id, return_date
from rental r 
where return_date is null 
	or return_date not between '2005-05-01' and '2005-09-01';
	

# 서브셋 조건 설정.

select payment_id, customer_id, amount, date(payment_date) as payment_date
from payment
where (payment_id between 101 and 120);