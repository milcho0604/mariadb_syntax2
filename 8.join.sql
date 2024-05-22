-- inner join
-- 두 테이블 사이에 지정된 조간에 맞는 레코드만 반환. on 조건을 통해 교집합 찾기
select * from postinner join author on author.id=post.author_id;
select * from author a inner join post p on a.id =p.author_id;
-- 글쓴이가 있는 글 목록과 글쓴이의 이메일을 출력하시오.
select p.id, p.title, p.contents, a.email from post p inner join author a on p.author_id = a.id;

-- left outer join
-- 모든 글 목록을 출력하고, 만약에 글쓴이가 있다면 이메일을 출력(침고: outer생략 가능)
select p.id, p.title, p.contents, a.email from post p left outer join author a on p.author_id = a.id;

-- join된 상황에서의 where조건 : on 뒤에 where조건이 나옴
-- 1)글쓴이가 있는 글 중에 글의 title과 저자의 email을 출력, 저자의 나이는 25세 이상
-- 2)모든 글 목록 중에 글의 title과 저자가 있다면 email을 출력, 2024-05-01 이후에 만들어진 글만 출력
select p.title, a.email from post p inner join author a on p.author_id = a.id where 25 <= a.age ;

select p.title, ifnull(a.email,'익명') from post p left join author a on p.author_id = a.id where p.created_time > '2024-05-01' and p.title is not null;

-- 조건에 맞는 도서와 저자 리스트 출력

-- union : 중복제외한 두 테이블의 select를 결합
-- 컬럼의 개수와 타입이 같아야함에 유의
-- union all : 중복포함
select 컬럼1, 컬럼2 from table1 union select 컬럼1, 컬럼2 from table2;

-- author테이블의 name, email 그리고 post테이블의 title, contents union
select name, email from author union select title, contents from post;

-- 서브쿼리 : select문 안에 또 다른 select문을 서브쿼리라 한다.
-- select절 안에 서브쿼리
-- author email과 해당 author가 쓴 글의 개수를 출력
select a.email, (select count(*) from post p where p.author_id = a.id ) as count from author a;

-- from절 안에 서브쿼리
select a.name from (select *from author) as a;

-- where절 안에 서브쿼리
select a.* from author a inner join post p on a.id = p.author_id;
select * from author where id in (select p.author_id from post);

-- 없어진 기록 찾기 문제
-- join으로 풀기
SELECT o.animal_id, o.name 
from animal_ins i right join animal_outs o on i.animal_id = o.animal_id
where i.animal_id is null 
-- 서브쿼리로 풀기
select o.animal_id, o.name from animal_outs o 
where o.animal_id not in (select i.animal_id from animal_ins i)

-- 집계함수
select count(*) from author; = select count(id) from author;
select sum(price) from post;
select round(avg(price),0) from post

-- group by와 집계함수
select author_id from post group by author_id;
select author_id, count(*)as count, sum(price) as sum, round(avg(price),0) as avg, min(price) as mib, max(price) as max
from post group by author_id;

-- 저자 email, 해당저자가 작성한 글 수를 출력
-- inner join? left join?
select a.id, if(p.id is null,0,count(*)) 
from author a left join post p on a.id = p.author_id group by a.id;

-- where와 group by
-- 연도별 post 글 출력, 연도가 null인 데이터는 제외
select date_format(created_time, '%Y') as date, count(*) from post
where created_time is not null group by date;

-- 자동차 종류 별 특정 옵션이 포함된 자동차 수 구하기
select car_type, count(*) as cars from car_rental_company_car
where options like '%통풍시트%' or options like '%열선시트%' or options like '%가죽시트%'
group by car_type 
order by car_type;
-- 정규식 regexp 사용해서 풀어보기
SELECT car_type, count(*) AS cars 
from car_rental_company_car
where options REGEXP '통풍시트|열선시트|가죽시트'
group by car_type 
order by car_type;

-- 입양 시각 구하기(1)
SELECT cast(date_format(datetime, '%H') as unsigned) as hour, count(*) as count
from animal_outs as o
where date_format(datetime, '%H') between '09' and '19' 
-- where date_format(datetime, '%H:%i') between '09:00' AND '19:59'로 하는 것이 더 정확함 --
group by hour
order by hour

-- HAVING : group by를 통해 나온 통계에 대한 조건 
select author_id, count(*)from post group by author_id;
-- 글을 2개이상 쓴 사람에 대한 통계정보
select author_id, count(*)from post group by author_id having count =2;;
-- (실습) post price가 2000원 이상인 글을 대상으로,
-- 작성자별로 몇건인지와 평균 price를 구하되, 
-- 평균 price가 3000원 이상인 데이터를 대상으로만 통계 출력 
select author_id, avg(price) as avg from post p
where 2000 <= p.price
group by author_id
having avg > 3000;
-- 동명 동물 수 찾기
SELECT name, count(*) from animal_ins 
group by name
having 2 <= count(name) 
order by name

-- (실습)2건 이상의 글을 쓴 사람의 id와 email을 구하는데,
-- 나이는 25세 이상인 사람만 통계에 사용하고, 
-- 가장 나이가 많은 사람 1명의 통계만 출력  
select a.id, a.email, count(*) 
from author a inner join post p on a.id = p.author_id
where post_count >= 2
group by a.age
having max(age)
order by age desc

select a.id, a.email, count(a.id) as count
from author a inner join post p on a.id = p.author_id
where a.age >= 25
group by a.id
having count >= 2
order by desc max(a.age)
limit 1;

SELECT a.id, a.email, COUNT(a.id) AS count
FROM author a
INNER JOIN post p ON a.id = p.author_id
GROUP BY a.id, a.email, a.age
HAVING COUNT(a.id) >= 2
ORDER BY a.age DESC;

-- 다중열 group by 
select author_id, title, count(*) from post group by author_id, title\

-- 재구매가 일어난 상품과 회원 리스트 구하기
SELECT user_id, product_id from online_sale
group by user_id, product_id
having count(*) > 1 
order by user_id, product_id desc