-- not null 조건 추가
alter table 테이블명 modify column 컬럼명 타입 not null;

-- auto_increment
alter table author modify column id bigint auto_increment; 

select * from information_schema.key_column_usage where table_name = 'post';