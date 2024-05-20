-- inner join
-- 두 테이블 사이에 지정된 조간에 맞는 레코드만 반환. on 조건을 통해 교집합 찾기
select * from postinner join author on author.id=post.author_id;
select * from author a inner join post p on a.id =p.author_id;
-- 글쓴이가 있는 글 목록과 글쓴이의 이메일을 출력하시오.
select p.id, p.title, p.contents, a.email from post p inner join author a on p.author_id = a.id;

-- left outer join
-- 모든 글 목록을 출력하고, 만약에 글쓴이가 있다면 이메일을 출력(침고: outer생략 가능)
select p.id, p.title, p.contents, a.email from post p left outer join author a on p.author_id = a.id;

