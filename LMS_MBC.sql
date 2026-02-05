# LMS에 대한 테이블을 생성하고 더미데이터 입력(CRUD)

SHOW databases; #LMS만 보인다.

USE LMS; #LMS 데이터베이스를 사용하겠다.

CREATE TABLE members(		# members 테이블 생성
#   필드명 타입 옵션 
	id  INT AUTO_INCREMENT PRIMARY KEY,
#	    정수	자동번호생성        기본키(다른테이블과 연결용)
    uid  VARCHAR(50) NOT NULL UNIQUE,
#		가변문자(50자)  공백비허용  유일한값
    password  VARCHAR(255) NOT NULL,
    name VARCHAR(50) NOT NULL,
    role ENUM('admin','manager','user')DEFAULT 'user',
#			 열거타입(괄호안에글자만 허용)          기본값 은  user
    active  BOOLEAN DEFAULT TRUE,
#			불린타입			기본값
    created_at  DATETIME DEFAULT CURRENT_TIMESTAMP
#	생성일		날짜시간타입		 기본값은 시스템시간
);


# 더미데이터 입력
INSERT IGNORE INTO members(uid, password, name, role, active)
VALUES ('kkw','1234','김기원','admin',True), ('lhj','2345','임효정','manager',True),
('kdg','3456','김도균','user',True),('ksb','4567','김수빈','user',True),
('kjy','5678','김지영','user',True),('song','1234','송명근','admin',True);

#계정 활성화
UPDATE members
SET active = 1
WHERE uid = 'song';



select * from members; # 더미데이터 확인

# 더미데이터를 수정
UPDATE members set password = '1111' where uid = 'kkw';

select * from members where uid='kkw' and password='1234' and active=true;


# 회원 삭제
DELETE FROM members WHERE uid = 'kkw';
UPDATE members set active = false WHERE uid = 'kkw'; # 회원 비활성화
# 회원 비활성화 했을때 active 에 0이면 false 1이면 true

#성적 테이블 생성
drop table scores;

create table scores (
	id	int auto_increment primary key,
	member_id int not null,
	korean int not null,
	english int not null,
	math int not null,
	total int not null,
	average float not null,
	grade char(1) not null,
	created_at datetime default current_timestamp,

	foreign key (member_id) references members(id)
    # 외래키 생성	내가 갖은 필드와 연결 		테이블 필드
);

# 후보키 = 공백이 없고, 유일해야되는 필드들 (학번, 주민번호, ID EMAIL)
# PRIMARY KEY 는 기본키로 공백이 없고 유일해야 되고, 인뎃싱이 되어 있는 옵션
# 인덱싱 =  DB에서 빠른 찾기를 위한 옵션
# 외래키 = 다른테이블과 연결이 되는키(foreign key
# 외래키는 자식이고 기본키는 부모
# members가 부모임으로 kkw 계정이 있어야 scores 테이블에 kkw 점수를 넣을수있다
# members 테이블에 id와 scores 테이블에 member_id는 타입이 일치해야함

INSERT INTO scores (member_id,korean, english, math, total, average, grade)
VALUES
(4,99,99,99,297,99,'A'),
(9,88,88,88,264,88,'B'),
(10,77,77,77,231,77,'C'),
(11,66,66,66,198,66,'F'),
(12,80,80,80,240,80,'B'),
(14,97,78,85,260,86,'B');

select *
FROM scores;

# 기본 정보 조회(INNER JOIN) <<많이 씀
# 성적 데이터가 존재하는 회원만 조회합니다. 이름, 과목점수,평균, 등급을 가져오는 쿼리.
SELECT
	m.name AS 이름,
    m.uid AS 아이디,
    s.korean AS 국어,
    s.english AS 영어,
    s.math AS 수학,
    s.total AS 총점,
    s.average AS 평균,
    s.grade AS 등급
From members m

join scores s on m.id = s.member_id;
# on 조건 : m.id = s.member_id와
# 같이 두 테이블을 연결하는 핵심 키(PK-PK)를 정확히 지정


Delete from scores where member_id = 2;
# 성적 없는 회원도 포함 조회(LEFT JOIN)
# 성적표가 아직 작성되지 않은 회원까지 모두 포함하여 명단을 만들때 사용.
# 성적이 없으면 NULL로 표시
    
select
	m.name AS 이름,
    m.role AS 역할,
    s.average AS 평균,
    s.grade as 등급,
    ifnull(s.grade,'미산출') as 상태 # 성적 없으면 '미산출' 표시
from members m
left join scores s on m.id = s.member_id;


# boards 테이블 
drop table boards;
create table boards(
	id int auto_increment primary key,
    member_id int not null,
    title varchar(200) not null,
    content text not null,
    created_at datetime default current_timestamp,
    
    foreign key (member_id) references members(id)
);

insert into boards (member_id, title, content)
values 
(4,'제목1','내용'),
(9,'제목1','내용'),
(10,'제목1','내용'),
(11,'제목1','내용'),
(12,'제목1','내용'),
(14,'제목1','내용');

select *
from boards;

# 게시글 목록 조회(inner join)

select
	b.id as 글번호,
    b.title as 제목,
    m.name as 작성자, # members 테이블에서 가져옴
	b.created_at as 작성일
from boards b
inner join members m on b. member_id = m.id
order by b.created_at desc; # 최신글 순으로 정렬

# 특정 사용자의 글만 조회( where 절 조합)

select
	b.title,
    b.content,
    m.name as 작성자, # members 테이블에서 가져옴
    b.created_at
from boards b
join members m on b.member_id = m.id
where m.uid = 'lhj'; # 특정 아이디를 가진 유저의 글만 필터링

# 관리자용 : 통계 조회(group by 조합)
select
	m.name,
    m.uid,
    count(b.id) as 작성글수 # group by와 셋트
from members m
left join boards b on m.id = b.member_id
group by m.id;

# 작성자 이름으로 검색하기 (like 활용)
select
	b.id as 글번호,
    b.title as 제목,
    m.name as 작성자,
    b.created_at as 작성일
from boards b
inner join members m on b.member_id = m.id
where m.name like '%효정%'
order by b.created_at desc;
#like = 문자열추출
# where m.name like '%검색어%' or b.title like '%검색어%'

ALTER TABLE boards
add active TINYINT(1) NOT NULL DEFAULT 1;

SELECT id, title
FROM boards
WHERE title LIKE '%오늘%';

CREATE TABLE items (
    id INT AUTO_INCREMENT PRIMARY KEY,
    code VARCHAR(50) UNIQUE NOT NULL,
    name VARCHAR(100) NOT NULL,
    category VARCHAR(50),
    price INT NOT NULL,
    stock INT DEFAULT 0,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE orders (
    id INT AUTO_INCREMENT PRIMARY KEY,
    member_id INT NOT NULL,
    total_price INT NOT NULL,
    status VARCHAR(20) DEFAULT 'paid',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (member_id) REFERENCES members(id)
);

CREATE TABLE order_items (
    id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    item_id INT NOT NULL,
    qty INT NOT NULL,
    price INT NOT NULL,

    FOREIGN KEY (order_id) REFERENCES orders(id),
    FOREIGN KEY (item_id) REFERENCES items(id)
);

INSERT INTO items (code, name, category, price, stock)
VALUES
('I001','키보드','IT',30000,10),
('I002','마우스','IT',15000,20),
('D001','콜라','음료',2000,50),
('B001','파이썬책','도서',25000,5);
