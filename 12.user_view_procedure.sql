-- 사용자 관리
-- 사용자 목록 조회
select * from mysql.user;

-- 사용자 생성
-- %는 원격 포함한 anywhere 접속
create user 'test1'@'localhost' identified by '4321';
create user 'test1'@'%' identified by '4321';

-- 도커 사용자가 원격 접속 실패하면 터미널로 작업 수행(터미널로 접속)
docker exec -it my_mariadb mariadb -u test1 -p 

-- 사용자에게 select 권한 부여
grant select on board.author to 'test1'@'localhost';

-- 권한 조회
show grants for 'test1'@'localhost';

-- test1으로 로그인 후에 select문 실행
select * from board.author;

-- 사용자 권한 회수
revoke select on board.author from 'test1'@'localhost';

-- 환경설정을 변경후 확정(일종의 commit)
flush privileges;

-- 권한 조회
show grants for 'test1'@'localhost';

-- 사용자 계정 삭제
drop user 'test1'@'localhost';



-- view
-- view 생성
create view author_for_marketing_team as
select name, age, role from author;

-- view 조회
select * from author_for_marketing_team;

-- test1 계정 view select 권한 부여
grant select on board.author_for_marketing_team to 'test1'@'localhost'; 

-- test계정 view 사용
select * from board.author_for_marketing_team;

-- view 변경(대체)
create or replace view author_for_marketing_team as 
select name, email, age, role from author;

-- view 삭제
drop view author_for_marketing_team;



-- procedure
-- 프로시저(procedure) 생성 
DELIMITER //
CREATE PROCEDURE test_procedure()
BEGIN
    select 'hello world';
END
// DELIMITER ;

-- 프로시저 호출
call test_procedure();

-- 프로시적 삭제
drop procedure test_procedure;

-- 게시글 목록 조회 프로시저 생성
DELIMITER //
CREATE PROCEDURE 게시글목록조회()
BEGIN
    select * from post;
END
// DELIMITER ;

call 게시글목록조회();

-- 게시글 단건 조회 // 정적이 아닌 동적 호출로 
DELIMITER //
CREATE PROCEDURE 게시글단건조회(in 아이디 int)
BEGIN
    select * from post where id = 아이디;
END
// DELIMITER ;

call 게시글단건조회(3);

-- 응용
DELIMITER //
CREATE PROCEDURE 게시글단건조회2(in 저자id int, in 제목 varchar(255))
BEGIN
    select * from post where author_id = 저자id && title = 제목;
END
// DELIMITER ;

call 게시글단건조회2(1,'hello world');

-- 글쓰기 : title, contents, 저자ID 삽입
DELIMITER //
CREATE PROCEDURE 글쓰기(in 제목 varchar(255), in 컨텐츠 varchar(255), in 저자ID int)
BEGIN
    insert into post(title, contents, author_id) values(제목, 컨텐츠, 저자ID);
END
// DELIMITER ;

call 글쓰기('새로운', '테스트',3);

-- 글쓰기 : title, contents, author_id 삽입 // email을 참조해서 author테이블에 있는 id를 author_id에 삽입
DELIMITER //
CREATE PROCEDURE 글쓰기_이메일(in titleInput varchar(255), in contentsInput varchar(255), in emailInput varchar(255) )
BEGIN
    declare author_Id int;
    select id into author_Id from author where email = emailInput;
    insert into post(title, contents, author_id) values(titleInput, contentsInput, author_Id);
END
// DELIMITER ;

call 글쓰기_이메일('착한', '밀초','milk@google.com');

-- sql에서 문자열 합치는 concat('hello', 'world')
-- 글 상세조회 : input 값이 postId 
-- title, contents, '홍길동' + '님'

DELIMITER //
CREATE PROCEDURE concats(in postId int )
BEGIN
    declare author_name varchar(255);
    select CONCAT( a.name, '님') into author_name
    from post p inner join author a on p.author_id = a.id where p.id = postId;

    select author_name;
END
// DELIMITER ;

call concats(3);

-- 등급조회
-- 글을 100개 이상 쓴 사용자는 고수입니다. 출력
-- 10개이상 100개 미만이면 중수입니다.
-- 그외(else) 초보입니다.
-- input값 : email값.
DELIMITER //
CREATE PROCEDURE 등급조회(in emailInput varchar(255))
BEGIN
    declare authorId int;
    declare count int;
    select id into authorId from author where email = emailInput;
    select count(*) into count from post where author_id = authorId;
    if count >= 100 then
        select '고수입니다';
    elseif count >= 10 and count < 100 then
        select '중수입니다.';
    else
        select '초보입니다.';
    end if;
END
// DELIMITER ;

call 등급조회(3);

-- 반복을 통해 post 대량생성
-- 사용자가 입력한 반복 횟수에 따라 글이 도배되는데, title은 '안녕하세요'
DELIMITER //
CREATE PROCEDURE 글도배(in num int)
BEGIN
    declare i int default 0;
    while i < num do
    insert into post(title) values('안녕하세요');
    set i = i + 1;
    END while;
END
// DELIMITER ;

call 글도배(3);

-- 프로시저 생성문 조회
show create procedure 프로시저명;

-- 프로시저 권한 부여
grant excute on board.글도배 to 'test1'@'localhost'

