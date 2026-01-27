
create table doit_dml(
col_1 int,
col_2 varchar(50) 
col_3 datetime,
col_4 int primary key
);

insert into doit_dml (col_1, col_2, col_3) values (1, 'doitsql', '2026-01-27');

select * from doit_dml;

insert into doit_dml(col_1, col_2) values (3, 'col_3 값 생략');

insert into doit_dml(col_1, col_3, col_2) values (4, '2026-01-27', '열순서 변경');

select * from doit_dml;

insert into doit_dml(col_1, col_2, col_3)
values (5, '데이터 입력5', '2023-01-03'), (6, '데이터 입력6', '2023-01-03'),(7, '데이터 입력7', '2023-01-03');

select * from doit_dml;

update doit_dml set col_2 = '데이터 수정'
where col_1 = 4;

set sql_safe_updates=0; 

update doit_dml set col_1 = col_1 + 10; # 모든 열에 +10

delete from doit_dml where col_1 = 13; # doit_dml 테이블에서 col_1 열 에서 13 행 (조건을) 삭제

drop table doit_dml; # 다 배웠으니 이전꺼 삭제함

use sakila;
select first_name, last_name from customer;

show columns from sakila.customer; # customer 테이블의 열 정보 조회

select * from customer where first_name = 'maria'; # where 절로 특정 값 조회

select * from customer where address_id < 200; # address_id열의 데이터가 200인 행을 조회

select * from customer where first_name < 'm'; # first_name 이 maria 미만인 행


select*
from customer
where first_name like 'S%'; # 이렇게 써도 작동됨 like는 비슷한것(패턴이 맞는것)을 찾을때 쓰는 연산자

select *
from payment
where payment_date = '2005-07-09 13:24:07'; # payment_date가 2005-07-09 13:24:07인 행을 조회

select *
from payment
where payment_date < '2005-07-09';  # payment_date가 2005-07-09일 미만인 행을 조회

select *
from payment
where payment_date < '2005-07-09'
order by payment_date asc; # 과거에서 최근 순으로 정렬해서 알려줌 
							# DESC 를쓰면 최근에서 과거 순으로 알려줌
							
select * 				#정해진 범위에 해당하는 데이터 조회
from customer
where address_id
between 5 
and 10;
						

select *				#2005년6월17일~2005년7월19일을 포함한 날짜 조회 + 최근에서부터 과거순으로 정렬
from payment
where payment_date 
between '2005-06-17'
and '2005-07-19'
order by payment_date DESC;

select *				#정확한 날짜를 조회
from payment
where payment_date = '2005-07-08 07:33:56'; 

select *			#forst_name 열에서 m~o 범위의 데이터 조회
from customer
where first_name
between 'm' and 'o';


select *			#first_name 열에서 m~o범위 값을 제외한 데이터 조회
from customer
where first_name
not between 'm' and 'o';


select *			#두 조건을 만족하는 데이터 조회( city 테이블에서 city 열이 sunnyvale이면서 country_id열이 103인 데이터)
from city
where city = 'sunnyvale'
and country_id=103;

select * 			# 두개의 비교 연산식을 만족하는 데이터를 조회(payment테이블에서 지정한 날짜 범위만큼의 데이터조회)
from payment
where payment_date>= '2005-06-01'
and payment_date <='2005-07-05';

select *			# 한조건을 만족한 경우 데이터 조회=OR을씀 (first_name열에서 maria 또는 linda인 데이터를 조회하는 쿼리)
from customer
where first_name = 'maria' or first_name = 'linda';

#or을 중복적으로 사용하면 비효율적 그럴대는 or대신 in을 사용

select *			# in을 활용한 데이터 조회 in사용후 쉼표를 이용해서 조건을 나열함
from customer
where first_name
in ('maria', 'linda', 'nancy');



#city 테이블에서 country_id열이 103또는 86이면서  city 열이 cheju   sunnyvale   dallas 인  데이터 조회
select * 		
from city
where (country_id = 86 
or country_id =103)
and city 
in('cheju', 'sunnyvale', 'dallas');

select * 			# 이렇게 묶어서 사용가능
from city
where country_id 
in (103,86)
and city
in('cheju', 'sunnyvale', 'dallas');

