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
('kjy','5678','김지영','user',True);



select * from members; # 더미데이터 확인

# 더미데이터를 수정
UPDATE members set password = '1111' where uid = 'kkw';


# 회원 삭제
DELETE FROM members WHERE uid = 'kkw';
UPDATE members set active = false WHERE uid = 'kkw'; # 회원 비활성화
# 회원 비활성화 했을때 active 에 0이면 false 1이면 true
