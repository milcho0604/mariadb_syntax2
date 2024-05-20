-- not null 조건 추가
alter table 테이블명 modify column 컬럼명 타입 not null;

-- auto_increment
alter table author modify column id bigint auto_increment; 
alter table post modify column id bigint auto_increment; 

-- author id에 제약조건 추가시 fk로 인해 문제 발생시
--fk 먼저 제거 이후에 author.id에 제약조건 추가
select * from information_schema.key_column_usage where table_name = 'post';
-- 삭제
alter table post drop foreign key post_ibfk_1;
-- 삭제된 제약조건 다시 추가(foreign key 추가)
alter table post add CONSTRAINT post_author_fk
foreign key (author_id) references author(id); 

-- uuid
alter table post add column user_id char(36) default(UUID());

-- unique 제약조건
alter table author modify column email varchar(255) unique;

-- on delete cascade 테스트 -> 부모 테이블의 id를 수정하면? 수정안됨(디폴트 조건 : RESTRICT)
-- 삭제
select * from information_schema.key_column_usage where table_name = 'post';
alter table post drop foreign key post_author_fk;
-- cascade옵션을 delete에 주고 다시 제약조건을 추가
alter table post add CONSTRAINT post_author_fk
foreign key (author_id) references author(id) 
on delete cascade; 
-- cascade옵션을 update에 주고 다시 제약조건을 추가
alter table post add CONSTRAINT post_author_fk
foreign key (author_id) references author(id) 
on update cascade; 
-- author를 삭제하면 post의 author_id가 포함된 row도 함께 삭제
delete from author where id = 3;

-- (실습) delete는 set null, update cascade
alter table post drop foreign key post_author_fk;
alter table post add CONSTRAINT post_author_fk
foreign key (author_id) references author(id)
on delete set null on update cascade;


