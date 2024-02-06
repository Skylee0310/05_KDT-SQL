# 그룹화 개념 - 가장 많이 대여한 회원 찾기.
use sakila;

select customer_id, count(*)
from rental
group by customer_id 
order by 2 desc;

#잘못된 필터링 사용
select customer_id, count(*)
from rental
#where count(*)>40 #count(*)는 그룹화 이후 실행해야 하기 때문에 where문을 사용할 수 없음.
group by customer_id
having count(*)>40 # 그룹화 이후 필터링에는 having 사용
order by count(*) desc;


# payment 테이블의 amount 열에 집계 함수 계산
# 암시적 그룹 결과
# group by 절을 사용하지 않음 : 집계 함수에 의해 생성된 값.
# 쿼리가 반환한 값은 모두 집계함수를 사용.
select max(amount) as max_amt,
		min(amount) as min_amt,
		avg(amount) as avg_amt,
		sum(amount) as tot_amt,
		count(*) as num_payments
from payment;

# 명시적 그룹
# 집계 함수를 적용하기 위해 group by 절에 그룹화할 열의 이름 지정
# customer_id 값이 동일한 행들을 그룹화한 다음, 5개의 집계 함수 적용.

-- select customer_id,
-- 	max(amount) as max_amt,
-- 	min(amount) as min_amt, 
-- 	avg(amount) as avg_amt,
-- 	sum(amount) as tot_amt,
-- 	count(*) as num_payments
-- from payment;

select customer_id,
	max(amount) as max_amt,
	min(amount) as min_amt, 
	avg(amount) as avg_amt,
	sum(amount) as tot_amt,
	count(*) as num_payments
from payment
group by customer_id;

# count() : 그룹의 모든 customer_id 수 산 : 중복포함
select count(customer_id) as num_rows,
	count(distinct customer_id) as num_customers
from payment;

#8.2.4 Null 처리 방법.
# 함수들이 null 값을 만나면 무시.

# 단일 열 그룹화
use sakila;

# 각 배우가 출연한 영화 수 계산.
select actor_id, count(*) # actor_id로 그룹화된 배우들이 출연한 영화 수
from film_actor
group by actor_id;

# 다중 열 그룹화
select fa.actor_id, f.rating, count(*)
from film_actor as fa
	inner join film as f
	on fa.film_id = f.film_id
group by fa.actor_id, f.rating
order by 1, 2;

# 표현식으로 생성한 값을 기반으로 그룹 생성 가능.
# extract() 함수를 사용하여 rental 테이블의 그룹화

select extract(year from rental_date) as year, count(*) as how_many
from rental
group by extract(year from rental_date);

# with rollup 옵션 
# group by 결과로 출력된 항목들의 합계를 나타내는 방법

select fa.actor_id, f.rating, count(*)
from film_actor as fa
	inner join film as f
	on fa.film_id = f.film_id 
group by fa.actor_id, f.rating with rollup
order by 1, 2;


#where 절 : G 또는 PG 등급 영화 선택, where 절에는 집계함수 포함할 수 없음.
#having 절 : 10개 이상의 영화에 출연한 배우만 선택
select fa.actor_id, f.rating, count(*)
from film_actor fa
	inner join film as f
	on fa.film_id = f.film_id 
where f.rating in ('G', 'PG')
group by fa.actor_id, f.rating
having count(*) >9;
