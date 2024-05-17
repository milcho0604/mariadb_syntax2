-- 데이터 베이스 접속
mariadb -u root -p

docker exec -it my_mariadb mariadb -u root -p -- 도커로 실행하는 법(MAC에서 아주 편함)

-- 스키마(database) 목록조회
show databases;

-- (스키마)데이터베이스 생성
CREATE DATABASE board;

-- 데이터 베이스 선택
use board;

-- 테이블 조회
show tables;

-- author 테이블 생성
create table author(id INT PRIMARY KEY, name VARCHAR(255), email VARCHAR(255), password VARCHAR(255));

-- 테이블 컬럼 조회
describe author; 
-- 컬럼 상세 조회
show full columns from author;

-- 테이블 생성문 조회
show create table author;

-- post 테이블 신규 생성(id, title, content, author_id)
create table posts(id INT PRIMARY KEY, title VARCHAR(255), content VARCHAR(255), author_id INT, foreign key(author_id) references author(id));

-- 테이블 index 조회
show index from author;
show index from posts;

-- ALTER문 : 테이블 또는 테이블의 구조를 변경하는 작업
-- 테이블 이름 변경
alter table posts rename post;
-- 테이블 컬럼 추가
alter table author add column test1 VARCHAR(50);
-- 테이블 컬럼 삭제
alter table author drop column test1;
-- 테이블 컬럼명 변경
alter table post change column content contents VARCHAR(255);
-- 테이블 컬럼 타입과 제약조건 변경 
alter table author modify column email VARCHAR(255) not null;
-- 실습 : author테이블에 address 칼럼을 추가. varchar(255)
alter table author add column address varchar(255);
-- 실습 : post테이블에 title은 not null 제약조건 추가, contents는 3000자로 변경
alter table post modify column title varchar(255) not null;
alter table post modify column contents varchar(3000);

-- DROP문 : 테이블 삭제
drop table 테이블명;


CREATE TABLE `post` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `contents` varchar(3000) DEFAULT NULL,
  `author_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `author_id` (`author_id`),
  CONSTRAINT `post_ibfk_1` FOREIGN KEY (`author_id`) REFERENCES `author` (`id`)
)