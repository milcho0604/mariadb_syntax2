-- insert into : 데이터 삽입
insert into 테이블명(컬럼1, 컬럼2, 컬럼3) values(데이터1, 데이터2, 데이터3);
-- id, name, email -> author 1건 추가
insert into author(id, name, email) values(1, 'milcho', 'milcho0604@gmail.com');

-- select : 데이터 조회, * : 모든 컬럼 조회
select * from author;

-- id, title, content, author_id -> post에 1건 추가
insert into posts(id, title, content, author_id) values(1, 'milcho', 'new_line', 1);

-- 테이블 제약조건 조회
select * from information_schema.key_column_usage where table_name = 'posts';

-- insert문을 통해 author데이터 4개 정도 추가, post 데이터 5개 추가(1개 정도는 익명 = author_id를 받아오지 않는다.)
insert into author(id,name, email) values(2, '홍길동', 'aka@test.com');
insert into post(id, title, contents, author_id) values(2, '구렁이', 'solt',2);

-- update 테이블명 set 컬럼명1 = 데이터1, 컬럼명2 = 데이터2 where id = 1;
-- where문을 빠뜨리게 될 경우, 모든 데이터에 update문이 실행됨에 유의.
update author set email = 'okay@naver.com' where id = 2;

-- delete from 테이블명 where 조건
-- where 조건이 생략될 경우 모든 데이터가 삭제됨에 유의.
delete from author where id =5;
-- delete와 truncate, drop
-- drop은 테이블 구조까지 전체 삭제, delete와 truncate는 데이터만 삭제
-- 단, delete는 복구 가능, truncate는 복구 불가능

-- SELECT의 다양한 조화방법;
select * from author;
select * from author where id =1;
select * from author where id > 2;
select * from author where id > 2 && name ='KS빌';



-- 특정 컬럼만을 조회할때
select name, email from author where id = 3;

-- 중복 제거하고 조회
select email from author;
select distinct email from author;

-- 주석은 #과 --로~!!

-- 정렬 : order by, 데이터의 출력결과를 특정 기준으로 정렬
-- 아무런 정렬조건없이 조회할 경우에는 pk기준으로 오름차순 정렬
-- asc : 오름차순, desc : 내림차순
select * from author order by name asc;

-- 멀티컬럼 order by : 여러 컬럼으로 정렬, 먼저 쓴 컬럼 우선 정렬. 중복시, 그다음 정렬옵션 적용
select * from author order by email; -- asc/desc 생략시 오름차순 디폴트
select * from author order by email, id desc; -- 만약 email이 중복이면 id기준으로 정렬하겠다

-- limit number : 특정숫자로 결과값 개수 제한
select * from author order by id desc limit 1;

-- alias(별칭)을 이용한 select : as 키워드 사용
select name as n, email as e from author; 
select a.name as 이름, a.email as 이메일 from author as a;

-- null을 조회조건으로
select * from post where author_id is null;
select * from post where author_id is not null;