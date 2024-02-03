# 데이터베이스 만들기
create database shoppingmall;

# 데이터베이스 사용하기
use shoppingmall;

drop table if exists user_table; # 테이블이 이미 존재한다면 삭제.

# 테이블 생성.
create table user_table
	(userID CHAR(8) not null, #고정길이 문자열 
	userName VARCHAR(10) not null, # 가변 길이 문자열
	birthYear INT not null, # 정수
	addr CHAR(2) not null,
	mobile1 CHAR(3),
	mobile2 CHAR(8),
	height smallint,
	mDate DATE,#시간데이터
	primary key(userID)); # userID를 primary key로 지정.# primary key : 기본 키 
	
desc user_table;

# 테이블에 값 입력 하기.
insert into user_table(userID, userName, birthYear, addr, mobile1, mobile2, height, mDate) 
values('KHD', '강호동', 1970, '경북', '011', '22222222', '182', '2007-07-07'),
	('KJD', '김제동', 1974, '경남', NULL, NULL, 173, '2013-03-03'),
	('KKJ', '김국진', 1965, '서울', '019', '33333333', 171, '2009-09-09'),
	('KYM', '김용만', 1967, '서울', '010', '44444444', 177, '2015-05-05'),
	('LHJ', '이휘재', 1972, '경기', '011', '88888888', 180, '2006-04-04'),
	('LKK', '이경규', 1960, '경남', '018', '99999999', 170, '2004-12-12'),
	('NHS', '남희석', 1971, '충남', '016', '66666666', 180, '2017-04-04'),
	('PSH', '박수홍', 1970, '서울', '010', '00000000', 183, '2012-05-05'),
	('SDY', '신동엽', 1971, '경기', NULL, NULL, 176, '2008-10-10'),
	('YJS', '유재석', 1972, '서울', '010', '11111111', 178, '2008-08-08');

# 테이블 생성하기 (2) 
drop table if exists buy_table;
create table buy_table
	(num INT not null,
	userID CHAR(8) not null,
	prodName CHAR(6) not null,
	groupName CHAR(4),
	price INT not null,
	amount smallint not null,
	primary key(num));

set foreign_key_checks = 0; #제약 조건 비활성화

alter table buy_table modify num INT not null auto_increment; # int 타입의 num을 자동증가(auto_increment)로 변경.

set foreign_key_checks=1; #제약 조건 활성화.

# 테이블에 값 입력 하기.
insert into buy_table(num, userID, prodName, groupName, price, amount)
values (1, 'KHD', '운동화', NULL, 30, 2),
		(2, 'KHD', '노트북', '전자', 1000, 1),
		(3, 'KYM', '모니터', '전자', 200, 1),
		(4, 'PSH', '모니터', '전자', 200, 5),
		(5, 'KHD', '청바지', '의류', 50, 3),
		(6, 'PSH', '메모리', '전자', 80, 10),
		(7, 'KJD', '책', '서적', 15, 5),
		(8, 'LHJ', '책', '서적', 15, 2),
		(9, 'LHJ', '청바지', '의류', 50, 1),
		(10, 'PSH', '운동화', NULL, 30, 2),
		(11, 'LHJ', '책', '서적', 15, 1),
		(12, 'PSH', '운동화', NULL, 30, 2);
#2-1		
select ut.userName, bt.prodName, ut.addr, concat(ut.mobile1, ut.mobile2) as phone
from user_table as ut inner join buy_table as bt
on ut.userID = bt.userID; # join 조건 : ut.userID와 bt.userID

#2-2
select distinct ut.userID, ut.userName, bt.prodName, ut.addr, concat(ut.mobile1, ut.mobile2) as phone # 중복 없이 출력.
from user_table as ut inner join buy_table as bt
on ut.userID = bt.userID
where ut.userID = 'KYM'; #조건 userID가 KYM일 때 

#2-3 전체 회원이 구매한 목록을 회원 아이디 순으로 정렬
select ut.userID, ut.userName, bt.prodName, ut.addr, concat(ut.mobile1, ut.mobile2) as '연락'
from user_table as ut inner join buy_table as bt
on ut.userID = bt.userID
order by ut.userID; #userID로 정렬.

#2-4 쇼핑몰에서 한 번이라도 구매한 기록이 있는 회원 정보를 회원 아이디 순으로 출력.
select distinct ut.userID, ut.userName, ut.addr
from user_table as ut inner join buy_table as bt
on ut.userID = bt.userID
order by ut.userID;

#2-5 쇼핑몰 회원 중에 주소가 경북과 경남인 회원 정보를 회원 아이디 순으로 출력
select distinct ut.userID, ut.userName, ut.addr, concat(ut.mobile1, ut.mobile2) as '연락'
from user_table as ut inner join buy_table as bt
on ut.userID = bt.userID
where addr = '경북' or addr = '경남'
order by ut.userID;