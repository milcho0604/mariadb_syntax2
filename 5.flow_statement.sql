-- 흐름제어 : case문 사용법
select 컬럼1, 컬럼2, 컬럼3, 
case 컬럼4
    when [비교값1] then 결과값1
    when [비교값2] then 결과값2
    else 결과값3
end
from 테이블명
-- 실습 : post테이블에서 1번 user는 first author, 2번 users는 second author
select id, title, contents,
case author_id
    when 1 then 'first_author'
    when 2 then 'second_author'
    when 3 then 'third_author'
    else 'others'
end as 'author_id'
from post;
-- author_id가 있으면 그대로 출력 else author_id, 없으면 '익명사용자'로 출력되도록 post테이블 조회
select id, title,
case
    when author_id is not null then author_id
    else 'anonymous'
end as author_name
from post;
-- 또는 
select id, title,
case
    when author_id is null then 'anonymous'
    else author_id
end as author_name
from post;
-- 위 case문을 ifnull구문으로 변환
select id, title, 
    ifnull(post.author_id, 'anonymous') 
from post;
-- 위 case문을 if구문으로 변환
select id, title, 
    if(author_id is null, 'anonymous', author_id )
from post;

 