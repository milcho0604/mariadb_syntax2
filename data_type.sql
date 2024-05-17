-- tinyint는 -128~127까지 표현
-- author테이블에 age 컬럼 추가
alter table author add column age tinyint;


-- insert시에 age : 200 ->125 넣어보기
insert into author(id, name, email, age) values(1,'사슴', 'dddd@naver.com',200); -- 여기서는 에러 발생 range
insert into author(id, name, email, age) values(1,'사슴', 'dddd@naver.com',120);

-- unsinged시에 255까지 표현범위 확대
alter table author modify column age tinyint unsigned;
insert into author(id, name, email, age) values(1,'사슴', 'dddd@naver.com',200); -- 표현범위 확대로 정상 실행

-- decimal 실습
alter table post add column price decimal(10, 3); 
describe post;

-- decimal 소수점 초과 값 입력 후 짤림 확인
insert into post(id, title, price) values(7, 'hello java', 3.123123);

-- update: price를 1234.1 
update post set price = 1234.1 where id = 7;

-- blob 바이너리데이터 실습
-- athuor테이블에 profile_image 컬럼을 blob형식으로 추가
alter table author add column profile_image blob;
alter table author add column profile_image longblob;

INSERT INTO author (id, email, profile_image) 
VALUES (7, 'milk@google.com', LOAD_FILE('/Users/milcho/mimo2.png'));

-- enum : 삽입될 수 있는 데이터의 종류를 한정하는 데이터 타입
-- role 컬럼 : user와 admin만 데이터 목록에 들어갈 수 있음
alter table author add column role enum('user', 'admin') not null; 
alter table author modify column role enum('user', 'admin') not null default 'user'; -- default를 넣으면 굳이 not null을 안 넣어도 괜찮음.


-- enum컬럼 실습
-- user1을 insert => 에러
insert into author(id, name, email, age, role) values(8,'cake','cake@navr.com',140,'user1'); 
-- user 또는 admin insert => 정상
insert into author(id, name, email, age, role) values(8,'cake','cake@navr.com',140,'admin');

-- DATE 타입
-- author테이블에 birth_day 컬럼을 date로 추가
-- 날짜 타입의 insert는 문자열 형식으로 insert
alter table author add column birth_day date;
insert into author(id, email, birth_day)
values (9, 'okay@naver.com', '1999-05-01');

-- DATETIME 타입
-- author, post 둘다 datetime으로 created_time 컬럼추가
alter table  author add column created_time datetime;
alter table  post add column created_time datetime;

insert into author(id, email, birth_day, created_time)
values (10, 'okay@naver.com', '1999-05-01','1999-05-01 12:01:00');

insert into post(id, title, created_time)
values (8, 'good','1999-05-01 12:01:00');
-- default옵션을 추가
alter table  author modify column created_time datetime default current_timestamp;
alter table  post modify column created_time datetime default current_timestamp;

insert into author(id, email)
values (11, 'okay@naver.com');
insert into post(id, title)
values (9, 'good');

-- 비교연산자
-- and 또는 &&
select * from post where 2<=id and id<=4;
select * from post where id between 2 and 4;
-- or 또는 ||
-- NOT 또는 !
select * from post where 2<id or id<4;
select * from post where not(id <2 or id >4);
select * from post where !(id <2 or id >4);
-- NULL인지 아닌지
select * from post where contents is null;
select * from post where contents is not null;
-- in(리스트형태), not in(리스트형태)
select * from post where id in(1,2,3,4);
select * from post where id not in(1,2,3,4);

-- like : 특정 문자를 포함하는 데이터를 조회하기 위해 사용하는 키워드
select * from post where title like '%2'; -- 2로 끝나는 title 검색
select * from post where title like 't%'; -- t로 시작하는 title 검색

select * from post where title like '%t%'; -- 중간에 t가 들어간 title 검색
select * from post where title not like '%t'; -- t로 끝나지 않는 title 검색

-- ifnull(a,b) : 만약 a가 null이면 b반환, null이 아니면 a반환
select title, contents, ifnull(author_id, '익명') from post;
-- 경기도에 위차한 식품창고 목록 출력하기

-- REGEXP : 정규표현식을 활용한 조회
select * from author where name regexp'[a-z]';
select * from author where name regexp'[가-힣]';

-- 날짜 변환 : 숫자 -> 날짜, 문자 -> 날짜
-- CAST와 CONVERT
select CAST(20200101 as date);
select CAST('20200101' as date);
select CONVERT(20200101, date);
select CONVERT('20200101'. date);
-- datetime 조회방법
select * from post where created_time like '2024-05%';