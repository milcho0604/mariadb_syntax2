-- 트랜잭션 : 어떤 상황에서 2가지의 쿼리 모두가 실행되거나 모두 실행하지 않는 것. 즉, 1개만 실행될 수는 없음
-- 확정 짓는 행위 : commit
-- 둘중하나라도 실패내서 취소 : rollback

-- author테이블에 post_count라고 컬럼(int) 추가
alter table author add column post_count int;
alter table author modify column post_count int default 0;

-- post에 글 쓴 후에, author테이블에 post_count값에 +1 => 트랜잭션 
start transaction;
update author set post_count = post_count+1 where id = 1;
insert into post(title, author_id) values('hello wirld java', 1);
insert into post(title, author_id) values('hello wirld java', 2);
commit;
-- 위 쿼리들이 정상실행 
-- 또는
rollback;


-- stored 프로시저를 활용한 트랜잭션 테스트
DELIMITER //
CREATE PROCEDURE InsertPostAndUpdateAuthor()
BEGIN
    DECLARE exit handler for SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;
    -- 트랜잭션 시작
    START TRANSACTION;
    -- UPDATE 구문
    UPDATE author SET post_count = post_count + 1 where id = 1;
    -- INSERT 구문
    insert into post(title, author_id) values('hello world java', 2);
    -- 모든 작업이 성공했을 때 커밋
    COMMIT;
END //
DELIMITER ;
-- 프로시저 호출
CALL InsertPostAndUpdateAuthor();
