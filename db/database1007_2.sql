select * from dept;

-- 명시적 입력
insert into dept(deptno,dname) values(50,'MIS');
-- 암묵적 입력(모든 colum 모두 입력해야해) null이라도 줘서 컬럼 수 맞춰야해
insert into dept values(60,'MI6',null);

select * from emp;
-- 문자열은 작은 따옴표!
insert into emp(empno,ename,hiredate) values(9999,'홍길동','20191007');

desc dept;
-- 입력할 데이터가 여러건인 경우 values 뒤에 줄줄이 입력 가능하다
-- 표준 아니지만 mySQL에서는 가능하다
-- 하나의 transaction으로 돈다!
insert into emp(empno,ename,hiredate) values(6666,'홍길동','20191007'),
(7777,'홍길동','20191007'),
(8888,'홍길동','20191007'),
(1111,'홍길동','20191007'),
(0000,'홍길동','20191007');

-- 테이블 만들고 값까지 복사
create table emp_copy
as select * from emp;

select * from emp;

delete from emp where ename='홍길동';

insert into emp_copy 
select * from emp;

select * from emp_copy;
desc emp_copy;
alter table emp_copy add(tel varchar(13) not null);
alter table emp_copy drop tel;
-- null 안 된다 했으므로 안 된다.
insert into emp_copy (empno,ename,tel) values(8000,'홍길동',null);

-- 테이블 이름 바꾸기
rename table emp_copy to empcp;
select * from empcp;
-- drop table empcp;
update empcp set sal=sal+1000;
alter table empcp drop tel;
insert into empcp(empno,ename) values (8011,'홍길동'),
(8012,'홍길동'),
(8013,'홍길동');
select * from empcp;
delete from empcp where ename='홍길동';

savepoint aaa;
insert into empcp(empno,ename) values (8014,'홍길동'),
(8015,'홍길동'),
(8016,'홍길동');

rollback;
rollback to aaa;
commit;

insert into empcp(empno,ename) values (9001,'고길동'),
(9002,'둘리'),
(9003,'도우너');
select * from empcp;
 update empcp set sal =10000 where empno in (9001,9002,9003);
 delete from empcp where empno in (8011,8012,8013,8014,8015,8016);
 commit;
 -- 이전 commit 했던 시점까지
 rollback;