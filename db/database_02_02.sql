-- DDL: data definition language
Create database testdb; 
drop database testdb;

use testdb;

-- primary key는 튜플을 구별할 수 있기 위해 unique해야하고, null이면 안 된다.
Create table testTB(id int primary key,title varchar(100),content varchar(2000),regdate datetime);
alter table testTB add(cnt int); -- 속성 추가
alter table testTB drop cnt;     -- cnt 속성 지우기
drop table testTb;               -- 테이블 삭제

-- 들어가 있는 테이블의 사이즈를 제로화 (데이터 아무것도 없는거랑 같아)
truncate table testTB;
-- 테이블 이름을 a to b (a에서 b로 변경)
rename table ssafyTB to testTB;
select * from testTB;


-- DML
-- 명시적 추가
insert into testTB(id,title,content,regdate) values(1,'title1','content1','20190813');
insert into testTB(id,title,content,regdate) values(2,'title2','content2','19960922');
insert into testTB(id,title,content,regdate) values(3,'title3','content3','19960922');
insert into testTB(id,title,content,regdate) values(4,'title4','content4','19960922');
-- id가 primary key이므로 null이면 안 된다.
insert into testTB(id,content) values(5,'test');

-- 추가 두번째 방식
insert into testTB values(6,null,'content6',null);

-- query
select * from testTB;

-- id가 2인 row가 삭제된다.
Update testTb set title='aaa' where id=2;

-- 삭제는 col 단위 안 돼
-- 삭제는 row 단위로!
delete from testTb where id=2;

-- view
create view vEmp
as select id,title,content,regdate as reg1,regdate as reg2 from testTB;

select * from vEmp;