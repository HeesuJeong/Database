use scott;

select ename,empno,sal,ifnull(comm,0) from emp
where sal>2000 and comm is null and empno>7700 or deptno=30;

desc emp;
-- 다중행 함수(집계함수)
-- sum,avg,count,max,min
-- 나오는 데이터의 카운터 숫자를 변경하지 않아(단일행함수) 즉, row의 숫자 바뀌지 않는다.
select sum(sal),count(*),max(sal),min(sal) from emp;

-- 집계함수의 데이터는 하나!이므로 단일행함수와 함께 사용하면 matrix가 깨져서 단일행함수의 값이 쓰레기값이 된다!
select sal,sum(sal),count(*),max(sal),min(sal) from emp;

-- null은 카운트하지 않는다. =>avg에서 심각한 문제를 초래한다!=>null인 사람을 전체 수에 제외한다
select count(comm),avg(comm),sum(comm),sum(comm)/count(sal) from emp;
select avg(ifnull(comm,0)) from emp;

-- group by
select count(distinct deptno) from emp;

-- 집계함수를 사용할 때 group by의 기준이 되는 col은 의미있는 값이다.
-- 그 외의 col은 의미 없는 값이다.
select deptno,sum(sal),max(sal) from emp
group by deptno;

-- 없무별 급여 합,평균,최고,최소
-- sal이 1500이상인 얘들로만 그룹을 짓는다!!!!!!!!!
select job,sum(sal) as sum,round(avg(sal),1),max(sal),min(sal) from emp where sal>=1500
group by job order by sum desc;

-- 동일입사월별 사원의 사원수,급여합,급여평균
select month(hiredate) as mon,count(empno),sum(sal),avg(sal) from emp
group by mon order by mon;

-- 부서별 급여합,평균을 구하는데 부서별 급여합이 10000이상인 부서만 출력
select deptno,sum(sal) as sum,avg(sal) from emp
group by deptno having sum>=10000;

