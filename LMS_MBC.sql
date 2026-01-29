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
