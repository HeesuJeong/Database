use ssafydb;
-- 1)
desc emp;
-- 2)
select EMPNO,ENAME,HIREDATE,SAL from emp
where ename like 'K%';
-- 3)
select * from emp
where extract(year from hiredate)=2000;
-- 4)
select * from emp
where comm is not null;
-- 5)
select ENAME,DEPTNO,SAL from emp
where DEPTNO=30 and sal>=1500;
-- 6)
select * from emp
where DEPTNO=30 order by empno;
-- 7)
select * from emp
order by sal desc;
-- 8)
select * from emp
order by deptno, sal desc;
-- 9)
select * from emp
order by deptno desc, ename asc, sal desc;
-- 10)
select ename,sal,comm,sal+comm as total from emp
where comm is not null
order by total desc;
-- 11)
select ename,sal,sal*0.13 as bonus,deptno from emp
where deptno=10;
-- 12)
select ename,sal,round(sal/60,1) as daymoney from emp
where deptno=20;
-- 13)
select ename,sal,round(sal*0.15,2) as fee from emp
where sal between 1500 and 3000;
-- 14)
select ename,sal,sal*0.9 as pay from emp
order by sal desc;
-- 15)
select lower(substr(ename,1,3)) as lower from emp
where length(ename)>=6;
-- 16)
select avg(sal),max(sal),min(sal),count(empno) from emp
where deptno=10;
-- 17)
select deptno,job,count(empno) from emp
group by DEPTNO,Job order by deptno;
-- 18)
select job,count(empno) from emp
group by job having count(empno)>=4;
-- 19) 
select ename,HIREDATE,(to_days(now())-to_days(hiredate)) as totalday from emp;
-- 20)
select ename,(extract(year from now())-extract(year from hiredate)) as totalyear from emp;
