SELECT 
    EMPNO, ENAME,sal,sal*12 as 연봉,deptno -- 12곱했으니 연봉
FROM
    emp
where sal between 2000 and 3000 
and deptno in(20,30)
-- and deptno=20 or deptno=30 -- or 기준으로 조건 2개
order by sal desc; -- desc는 내림차순, 디폴트는 오름차순 asc

select ename,empno,sal,'제직' -- 재직이라는 col이 생겨
from emp;

-- 이름(사번), 급여 .. 이런식으로 출력하고 싶다.
select concat(ename,'(',empno,')') as name,sal   -- ename과 empno을 묶는다.
from emp;

-- 이름의 급여는 얼마입니다.
select concat(ename,'의 급여는',sal,'입니다.') as name
from emp;

desc emp;

-- 사원의 총 연봉을 구하세요(sal*12)+comm
select ename,sal*12+ifnull(comm,0) from emp;
-- where comm is not null; 
-- 다르다 표현 != <>
-- commision이 없는 사람은 null값이 나온다. null과는 사칙연산,비교 안 돼=>null이 돼

-- 중복제거 하는 distinct
select distinct deptno,ename from emp;

select ename,deptno,job,sal from emp where sal!=2000;

select ename,deptno,job from emp
where sal between 1000 and 3000;

select ename,deptno,job from emp
where deptno in(10,20);

select ename,deptno,job from emp
where ename not in('SMITH','KING');

-- 다중리스트
-- 부서번호 업무가 10번 'manager' 이거나 20번 'clerk'
select * from emp
where (deptno,job) in ((10,'manager'),(20,'clerk'));

select ename from emp
where ename like 's%';   -- s로 시작하는 얘 찾기

select ename from emp
where ename like '%s';   -- s로 끝나는 얘 찾기

select ename from emp
where ename like '%s%';   -- s 포함되는 얘 찾기

-- 언더바(_)는 남은 자리의 수를 일치 시켜야 한다,
select ename from emp
where ename like 'smi__';

-- and가 or보다 우선순위가 높다alter
-- 부서번호가 10과 20 이거나 sal이 2000넘어
-- 헷갈리면 괄호 사용!
select ename,sal,deptno from emp
where sal>2000 or deptno=20 and deptno=10;

select ename,sal,deptno
from emp
order by sal desc, ename; -- sal같은 경우 이름차순

-- rollup 그룹의 합계
select job,sum(sal),avg(sal) from emp 
where 1 group by job with rollup;

-- 부서별 업무별 급여합 구하기
select deptno,job,sum(sal) from emp
group by deptno,job;

-- 행:부서 열:업무
-- 부서 별 업무의 sal 합
select deptno,
	sum(case when job='president' then sal end) as president,
    sum(case when job='clerk' then sal end) as clerk,
    sum(case when job='manager' then sal end) as manager,
    sum(case when job='analyst' then sal end) as analyst,
    sum(case when job='salesman' then sal end) as salesman
from emp group by deptno;
    
select ifnull(deptno,'합계'),
	ifnull(sum(case when job='president' then sal end),0) as president,
    ifnull(sum(case when job='clerk' then sal end),0) as clerk,
    sum(case when job='manager' then sal end) as manager,
    ifnull(sum(case when job='analyst' then sal end),0) as analyst,
    ifnull(sum(case when job='salesman' then sal end),0) as salesman,
    sum(sal) as deptsum
from emp group by deptno with rollup;
