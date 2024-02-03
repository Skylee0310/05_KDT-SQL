use sakila

#내부 조인
select c.first_name, c.last_name, a.address
from customer as c inner join address as a
on c.address_id = a.address_id;


select count(*)
from customer as c inner join address as a 
on c.address_id = a.address_id;

#ANSI 조인 문법
select c.first_name, c.last_name, a.address
from customer as c join address as a
	on c.address_id = a.address_id 
where a.postal_code = 52137;

# 세 개 이상의 테이블 조인.
# from 절에서 테이블 순서는 중요하지 않음.
# 데이터 내부에서 결정.
select c.first_name, c.last_name, ct.city, a.address, a.district, a.postal_code
from customer as c
inner join address as a on c.address_id = a.address_id
inner join city as ct on a.city_id = ct.city_id;

# 서브 쿼리 사용
select c.first_name, c.last_name, addr.address, addr.city, addr.district
from customer as c
	inner join
	(select a.address_id, a.address, ct.city, a.district
	from address as a
		inner join city as ct
		on a.city_id = ct.city_id
	where a.district = 'California'
	) as addr 
on c.address_id = addr.address_id;

#테이블 재사용
select f.title, a.first_name, last_name
from film as f
	inner join film_actor as fa
	on f.film_id = fa.film_id 
	inner join actor a
	on fa.actor_id = a.actor_id 
where ((a.first_name = 'CATE' and a.last_name = 'MCQUEEN')
		or (a.first_name = 'CUBA' and a.last_name = 'BIRCH'));

#Mcqueen만 검색
select f.title,f.film_id, a1.first_name, a1.last_name
from film as f
	inner join film_actor as fa1
	on f.film_id = fa1.film_id
	inner join actor as a1 # film, film_actor, actor 내부 조인 #1
	on fa1.actor_id = a1.actor_id 
where (a1.first_name = 'CATE' and a1.last_name = 'MCQUEEN');

# cuba birch만 검색.
select f.title, f.film_id, a2.first_name, a2.last_name
from film as f
	inner join film_actor as fa2
	on f.film_id = fa2.film_id
	inner join actor as a2
	on fa2.actor_id = a2.actor_id
where (a2.first_name = 'CUBA' and a2.last_name = 'BIRCH')

#데이터베이스	
use sqlclass_db;

#테이블 생성
create table customer
	(customer_id smallint unsigned,
	first_name varchar(20),
	last_name varchar(20),
	birth_date date,
	spouse_id smallint unsigned,
	constraint primary key (customer_id));

# 데이터 입력	
insert into customer (customer_id, first_name, last_name, birth_date, spouse_id)
values
(1, 'John', 'Mayer', '1983-05-12', 2),
(2, 'Mary', 'Mayer', '1990-07-30', 1),
(3, 'Lisa', 'Ross', '1989-04-15', 5),
(4, 'Anna', 'Timothy', '1988-12-26', 6),
(5, 'Tim', 'Ross', '1957-08-15', 3),
(6, 'Steve', 'Donell', '1967-07-09', 4);

#데이터 입력 2
insert into customer (customer_id, first_name, last_name, birth_date)
values (7, 'Donna', 'Trapp', '1978-06-23');

# 전체 데이터 출력
select * from customer

# 셀프 join 예제.
select
	cust.customer_id,
	cust.first_name,
	cust.last_name,
	cust.birth_date,
	cust.spouse_id,
	spouse.first_name as spouse_firstname,
	spouse.last_name as spouse_lastname
from customer as cust
	join customer as spouse
	on cust.spouse_id = spouse.customer_id; # 배우자가 없는 7, Donna Trapp은 출력되지 않음.(spouse.customer_id가 없으므로.)

select f.title
from film as f
	inner join film_actor as fa 
	on f.film_id = fa.film_id
	inner join actor as a
	on fa.actor_id = a.actor_id 
where a.first_name = 'JOHN';
	
use sakila;

select a1.address as addr1, a2.address as addr2, a1.city_id, a2.district
from address as a1
	inner join address as a2
where (a1.city_id = a2.city_id)
	and (a1.address_id !=a2.address_id);

# 집합 연산자

# union all : 중복 항목 제거 안함.
select c. first_name, c.last_name
from customer c
where c.first_name like 'J%' and last_name like 'D%'
union all
select a.first_name, a.last_name
from actor a
where a.first_name like 'J%' and a.last_name like 'D%';

# union : 중복 데이터 제거
select c. first_name, c.last_name
from customer c
where c.first_name like 'J%' and last_name like 'D%'
union
select a.first_name, a.last_name
from actor a
where a.first_name like 'J%' and a.last_name like 'D%';

# intersect(교집합)
select c.first_name, c.last_name
from customer c
where c.first_name like 'J%' and c.last_name like 'D%'
intersect 
select a.first_name, a.last_name
from actor a
where a.first_name like 'J%' and a.last_name like 'D%';

# inner join으로 같은 결과 출력.
select c.first_name, c.last_name
from customer as c
	inner join actor as a
	on (c.first_name = a.first_name) and (c.last_name = a.last_name)
where a.first_name like 'J%' and a.last_name like 'D%';

# 복합 쿼리의 결과 정렬.
# -> 위에서 아래의 순서대로 진행. intersect 연산자가 다른 집합 연산자보다 우선 순위가 높음.

#last_name 열을 기준으로 오름차순 정렬.
select first_name, last_name
from actor
where last_name like 'L%'
union 
select first_name, last_name
from customer
where last_name like 'L%'
order by last_name;