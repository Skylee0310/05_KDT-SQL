use sqlclass_db;

desc nobel;


# 1. 1960년에 노벨 물리학상 또는 노벨 평화상을 수상한 사람의 정보
select year, category, fullname from nobel
where year = 1960 and (category = 'Physics' or category = 'Peace');

# 2. 아인슈타인이 수상한 연도와 수상분야, 출생대륙, 출생국가 출력.
select year, category, birth_continent, birth_country from nobel n 
where fullname = 'Albert Einstein';

# 3. 1910년부터 2010년까지 노벨 평화상 수상자 명단 출력
select year, fullname, birth_country from nobel
where year between 1910 and 2010
order by year desc;

# 4. 전체 테이블에서 수상자 이름이 'John'으로 시작하는 수상자 모두 출력.
select category, fullname from nobel n 
where fullname like 'John%'

# 5. 1964년 수상자 중에서 노벨 화학상과 의학상을 제외한 수상자의 모든 정보를 수상자 이름을 기준으로 오름차순으로 정렬 후 출력.
select * from nobel
where year = 1964 and (category !='Chemistry' and category != 'Physiology or Medicine')
order by fullname;

# 6) 2000년부터 2019년까지 노벨 문학상 수상자 명단 출력
select year, fullname, gender, birth_country from nobel
where category = 'Literature' and  year between 2000 and 2019; 

# 7) 각 분야별 역대 수상자의 수를 내림차순으로 정렬 후 출력(group by, order by)
select category, count(*) from nobel as n
group by n.category # 그룹화
order by count(*) desc; # 수상자 수별 내림차순 정렬.

#8) 노벨 의학상이 있었던 연도를 모두 출력
select distinct year from nobel
where year in (select year from nobel where category in ('Physiology or Medicine'));

#9) 노벨 의학상이 없었던 연도의 총 횟수를 출력
# 연도의 총 횟수를 출력 
select count(distinct year) 
from nobel
where year in (select distinct year from nobel
	where year not in (select year from nobel where category in ('Physiology or Medicine')));

#10) 여성 노벨상 수상자의 명단 출력.
select fullname, category, birth_country from nobel
where gender = 'female'

#11) 수상자들의 출생 국가별 횟수 출력.
select birth_country, count(*) from nobel as n
group by n.birth_country;

#12) 수상자의 출생 국가가 'Korea'인 정보 모두 출력
select * from nobel
where birth_country ='Korea';

#13) 수상자 출신 대륙이 'Europe', 'North America', 공백이 아닌 모든 정보 출력.
select * from nobel
where birth_continent != 'Europe' and (birth_continent != 'North America') and (birth_continent != '');

#14) 수상자 출신 국가별로 그룹화를 해서 수상횟수가 10회 이상인 국가의 모든 정보를 출력하고 국가별 수상횟수의 역순으로 출력.
select birth_country, count(*) from nobel
	group by birth_country
	having count(*)>=10
	order by count(*) desc


#15)2회 이상 수상자 중에서 fullname이 공백이 아닌 경우를 출력하는데, fullname의 오름차순으로 출력
select fullname, count(*) from nobel
	group by fullname
	having count(*)>=2 and fullname != ''
	order by fullname;
	

select distinct year, category from nobel;