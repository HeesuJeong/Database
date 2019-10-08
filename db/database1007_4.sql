select * from bonus;
desc bonus;
-- 존재하면 테이블 지워라 / 없다면 에러 발생하지말고 넘어가라
drop table if exists bonus;

select deptno from dept;
select distinct deptno from emp;

select * from emp;
delete from emp where ename='홍길동';
commit;

delete from emp where empno=9001;
insert into emp(empno,ename,deptno) values(9001,'홍길동',10);

-- foreignkey 적용되어있기 때문에 dept에 없는 deptno을 emp에 적용할 수 없다
-- 아래 코드 에러뜬다
insert into emp(empno,ename,deptno) values(9005,'홍길동',70); 
-- 아래 명령어로 dept테이블에 deptno=70을 넣어줘야지 위의 코드가 가능하다!
insert into dept(deptno,dname,loc) values (70,'ssafy','광주');

select * from dept;
delete from dept where deptno=50;
delete from dept where deptno=70;
select * from emp;

delete from dept where deptno=10;
update dept set deptno=90 where deptno=30;