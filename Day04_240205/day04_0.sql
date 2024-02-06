# cast() 함수
# - date 값과 time 값을 생성.

select cast('2019-09-17' as date) date_field,
		cast('108:17:57' as time) time_field;

# MySQL의 문자열을 이용한 datetime 처리
# mysql은 날짜 구분 기호에 관대
# 2019년 09월 17일 오후 3시 30분에 대한 유효한 표현 방식.
select cast('20190917153000' as datetime);
select cast('2019,09,17,15,30,00' as datetime);

# 날짜 생성 함수 : str_to_date()
# 형식 문자열의 내용에 따라 datetime, date 또는 time값을 반환.
# cast()함수를 사용하기에 적절한 형식이 아닌 경우 사용.
# 'September 17, 2019'
select str_to_date('September 17, 2019', '%M %d, %Y') as return_date;


select current_date(), current_time(), current_timestamp();

select date_add(current_date(), interval 5 day);

use sakila

update rental
set return_date = date_add(return_date, interval '3:27:11' hour_second)
where rental_id = 9999;

#extract() 함수 :
# - date의 구성 요소 중 일부를 추출
# 기간 자료형으로 원하는 날짜 요소를 정의(p.27)
select extract(year from '2019-09-18 22:19:05'); 

#datediff(date1, date2) 함수 
# 두 날짜 사이의 기간(년, 주, 일)을 계산
# 시간 정보는 무시.
select datediff('2019-09-03', '2019-06-21'); 