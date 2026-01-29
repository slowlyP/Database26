# 파이썬과 mysql 병합 잡업을 위한 sql 페이지

# 절차 일반적으로 system (root) 계정은 개발용으로 사용하지않는다.
# mysql에 사용할 id와 pw와 권한을 부여하고 db를 생성한다.



#		내주소 	'song'@'192.168.0.160'		'1234'
#				'song'@'192.168.0.%'  <<%는 대역대 라는뜻  >>192.168.0.1~192.168.0.255 사이가됨
#				'song'@'%' <<얘는 전체 ip 외부에서도 접속됨 보안에 안좋음
#				ID	접속PC					암호
CREATE USER 'mbc'@'localhost' IDENTIFIED BY'1234';
# 사용자계정을생성한다
# 사용자 계정은 아이디가 중복되어도된다 > 대신 접속 pc를 다중처리 할 수 있음.
#CREATE USER 'mbc'@'192.168.0.%' IDENTIFIED BY'5678';
#CREATE USER 'mbc'@'%' IDENTIFIED BY'Mbc320!!'; 이런식으로 할수있음

# 사용자를 삭제할때 
drop user 'mbc'@'localhost';

# mbc사용자에게 LMS 권한을 부여
# 1. 데이터베이스 생성
# 2. 계정에 권한을 준다.
CREATE DATABASE lms 
DEFAULT CHARACTER SET utf8mb4 
COLLATE utf8mb4_general_ci;
# lms 데이터 베이스를 생성						한국어지원utf-8
# 													COLLATE : 문자 집합에 포함된 문자들을 어떻게 비교하고 정렬할지 정의하는 키워드
# 데이터 비교시 대소문자 구분 , 문자 간의 정렬 순서, 언어별 특수문자 처리 방식 지원
# utf8mb4 : 문자집합
# general : 비교규칙(간단한 일반비교)
# ci : Case Inensitive < (대소문자 구분하지 않음)
# COLLATE utf8m4_bin < (대소문자 구분함)

# mbc라는 계정에 lms를 사용할수있게 권한 부여해야함
GRANT ALL PRIVILEGES ON LMS.* TO 'mbc'@'localhost';
#						db명.테이블  id    접속pc
#	ALL PRIVILEGES <<는 모든 권한 부여
# GRANT select, insert ON LMS.* TO '일용직'@'%'; << 일용직일경우 이런식으로 줌 
# 		READ	CREATE 


# 권한 즉시 반영
FLUSH PRIVILEGES;

USE MYSQL; # MYSQL 최고 DB에 접속
select * from user; # MYSQL에 사용자의 목록을 볼 수 있다.



 