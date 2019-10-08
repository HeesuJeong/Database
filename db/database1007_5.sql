select * from emp where ename='smith';

-- emp테이블에 ename 속성에 인덱스 만들겠다
create index idx_emp_ename on emp(ename);
drop index idx_emp_ename on emp;

select * from emp;
create index idx_emp_sal on emp(sal);
select * from emp where sal=800; -- look up
select * from emp where sal !=800; -- (크다, 작다, 같지 않다) 있는 경우 full scan해
select * from emp where sal =800 and deptno=20; -- 인덱스 걸친 것과 걸치지 않는 경우 => look up이다! 800은 look up으로 한다 그리고 걸러져서 메모리에 올라온 것을 full scan한다.
-- or 거는 순간 인덱스 물넘어간다.
select * from emp where sal =800 or deptno=20; 

select * from emp where 1 and lower(ename)='smith'; -- full scan
select * from emp where 1 and ename=lower('smith'); -- look up(인덱스 이용하느냐 마냐의 차이!)

select * from emp; -- where empno=7521; -- primary key이면 not null과 unique, index가 자동으로 걸린다!
insert into emp(empno,ename,sal) values(7657,'홍길동',8000);  -- 중간에 삽입된 것을 확인할 수 있다.

create index idx_emp_sal_name on emp(ename desc, sal asc); -- 복합 column index

select * from emp where sal=800; --  and ename='smith'; 