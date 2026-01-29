
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

use sakila;
select *
from address 
where address2 is null; # address2 열에서 null인 데이터 조회

select *
from address
where address2 is not null; # address2 열애서 null인 데이터 조회

select *
from address
where address2 =''; # address2 열에서 null이 아닌 데이터 조회

select * 
from customer
order by first_name; # first_name 열을 기준으로 정렬  

select*
from customer
order by store_id, first_name; # store_id ,first_name 순으로 데이터 정렬

select *
from customer
order by store_id desc , first_name asc; # ASC와 DESC를 조합하여 데이터 정렬


select * 
from customer
order by customer_id asc limit 100, 10; # limit 으로 101 번째부터 10개의 데이터 조회


select * 
from customer 
order by customer_id asc limit 10 offset 100; # 데이터 100개를 건너뛰고 101번째부터 데이터 10개 조회

# A% = A로 시작하는 모든 문자열
# %A = A로 끝나는 모든 문자열
# %A% = A가 포함된 모든 문자열

select *
from customer
where first_name like 'a%'; # 첫번째 글자가 a로 시작하는 데이터 조회

SELECT * 
FROM customer
where first_name like '%a';# a로 끝나는 모든 데이터 조회

select *
from customer
where first_name 
not like 'a%';  # 첫번째 글자가 a로 시작하지 않는 데이터만 조회 not를사용하면됨




with cte (col_1) as(
select 'a%bc' union all
select 'a_bc' union all
select 'abc'
)
select * from cte; 			# 특수문자를 포함한 임의의 테이블 생성

with cte (col_1) as(
select 'a%bc' union all
select 'a_bc' union all
select 'abc'
)
select * from cte where col_1 like '%' ;
 # 특수문자 %를 포함한 데이터 조회를 했는데 제대로 안나옴 이럴때는 아래방법으로해야함

with cte (col_1) as (
select 'a%bc' union all
select 'a_bc' union all
select 'abc'
)
select * from cte where col_1 like '%#%%' escape '#';



select * 
from customer 
where first_name
like 'a_'; # a로 시작하면서 문자열 길이가 2인데이터조회


select * 
from customer 
where first_name
like 'a__'; # a로 시작하면서 문자열 길이가 3인데이터 조회
				# 추가로 문자열 길이로만 조회하려면 a와같은 것 입력 없이'___' 이런식으로 입력하면됨 언더바의 갯수
                

select * 
from customer
where first_name
like 'a_r%';    # a와 r로 시작하는 문자열 조회



#===========regexp========= 정규표현식

# . 줄바꿈 문자(\n)을 제외한 임의의 한 문자를 의미.
# * 해당 문자 패턴이 0번 이상 반복한다.
# + 해당 문자 패턴이 1번이상 반복한다.
# ^ 문자열의 처음을 의미한다.
# $ 문자열의 끝을 의미한다.
# | or을 의미한다.
# [...] 대괄호 ([]) 안에 있는 어떠한 문자를 의미한다.
# [^...] 대괄호 ([]) 안에 있지 않은 어떠한 문자를 의미한다.
# {n} 반복되는 횟수를 지정한다.
# {m,n} 반복되는 횟수의 최솟값과 최댓값을 지정한다.



select *
from customer where first_name regexp '^k|n$'; # ^,|,$ 를 사용한 데이터 조회 ( k로 시작하거나 n으로 끝나는 데이터 조회)


select * 
from customer 
where first_name 
regexp 'k[l-n]';				# first_name 열의 문자열 데이터에서 k뒤에 l과n사이의 글자가 포함되어 있는 데이터

select * 
from customer
where first_name
regexp 'k[^l-n]';# [^...] 대괄호 ([]) 안에 있지 않은 어떠한 문자를 의미한다. //<< k와 함께 l과 n사이의 글자를 포함하지 않는 데이터를 조회한것

select *
from customer
where first_name like '_______'
and first_name regexp 'a[l-n]'
and first_name regexp 'o$';    # 와일드카드 조합으로 데이터 조회 (first_name 열에서 총7글자이고 a뒤에 l과 n사이의 글자가 있고 마지막 글자는 o인 문자열 데이터를 조회



select special_features
from film group by special_features; # special_features 열의 데이터를 그룹화

select rating 	
from film
group by rating;  # rating 열의 데이터를 그룹화(special_features 열에서 deleted scenes,trailers 등으로 데이터가 그룹화
				  # rating 열에서는 pg,g 등으로 데이터가 그룹화



# COUNT로 그룹화한 열의 데이터 개수 세기

SELECT special_features, COUNT(*) 
AS CNT FROM FILM
GROUP BY SPECIAL_FEATURES;    # COUNT 함수로 그룹에 속한 데이터 개수 세기


SELECT special_features, rating, COUNT(*)
AS CNT FROM FILM
GROUP BY SPECIAL_FEATURES, RATING
ORDER BY SPECIAL_FEATURES, RATING, CNT desc; # 두 열의 데이터 그룹에 속한 데이터 개수 세기
												# select 문에 사용한 열을 반드시 groupby 절에도 사용해야함
									
