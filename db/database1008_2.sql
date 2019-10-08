-- subQuery
-- 이름이 smith인 사람과 같은 부서의 직원정보를 조회하세요

-- query 두번 일어나야해
-- 조건절 서브쿼리의 예시이다.
-- 단일 컬럼, 단일 로우 리턴
select * from emp
where deptno = (select deptno from emp where ename='smith');

-- EXISTS
-- 각각의 데이터에 대해서 있으면 돌리고 없으면 안 돌린다
select * from emp where empno in (select distinct mgr from emp where mgr is not null);

-- 같은게 존재한다면 1이 튀어나오고 => exists가 작동하게 된다.
-- 관리자의 경우
select * from emp B where exists (select 1 from emp A where A.empno=B.mgr and a.mgr is not null);
-- 관리자 아닌 경우
select * from emp B where not exists (select 1 from emp A where A.empno=B.mgr and a.mgr is not null);
-- 하나만 찾아라(속도 튜닝) => 한건 찾으면 더 이상 스캔 안 해
select * from emp B where not exists (select 1 from emp A where A.empno=B.mgr and a.mgr is not null limit 1);


-- 이름이 smith 사람보다 급여를 많이 받는 직원의 정보
select * from emp
where sal > (select sal from emp where ename ='martin');

select distinct mgr from emp;
-- 단일컬럼, 다중로우
-- 관리자인 직원 조회
-- 다중로우인 경우 = 계산이 안 되고 in을 사용해야 한다.
select * from emp where empno in (select distinct mgr from emp);

-- 관리자가 아닌 직원
select * from emp where empno not in (select distinct mgr from emp where mgr is not null); -- in안에 null 들어가면 비교 안 되기 때문에 

-- 업무가 slaesman의 최저급여보다 많은 급여를 받는 직원조회
-- 단일컬럼,다중로우 서브쿼리와 비교
-- >any <any >all <all .. 다 해보쟈
select * from emp where sal > any (select sal from emp where job='salesman') order by sal;

-- 다중컬럼 서브쿼리
-- 부서별 최저급여를 받는 직원정보를 구하세요
-- 그룹의 기준이 되지 않는 컬럼에는 집계함수를 써야한다
-- 다중컬럼,다중로우 서브커리
select * from emp where (deptno,sal) in (select deptno,min(sal) from emp group by deptno); -- 다른 부서의 최소 금액과 일치하면 다른 부서인데도 선택될 수 있어

-- 부서별 최소금액이다. 
select min(sal) from emp group by deptno;

-- inline view
-- 평균급여보다 많이 받고 최고급여보다 적게 받는 직원정보를 구하시오
select EMP.*,MAX,AVG from (select deptno,max(sal) MAX,avg(sal) AVG from emp group by deptno) A,
emp where A.deptno=emp.deptno and emp.sal>A.AVG and emp.sal<=max;
-- A가 단일 로우이므로(1)*emp(14) =>  cross join =>(14그대로)

-- column 절의 서브쿼리
-- 사번 이름 급여 전체급여합 구하시오
-- 서브쿼리가 매 줄마다 돌기 때문에 14번 돈다...> 사실상 한번 돌고 캐싱해두고 데이터 쭉 찍는 것이다!
select empno,ename,sal,(select sum(sal) from emp) from emp;


-- 아래는 시험에 안 나오는 부분이야
-- 상호연관서브커리: 한건씩 나오는데, 모든 emp 하나씩 비교해서 .... 다시보기
-- inline view보다 빠르다! 왜냐? scalar는 캐싱을 하기 때문에!
-- 상호연관서브쿼리 ; 여러개 row도 return 가능
-- 부서별 사번, 이름, 급여, 전체급여의 합을 구하세요
select empno, ename, sal, (select sum(sal) from emp a where a.deptno = b.deptno) from emp b;
select empno, ename, sal
    , (select sum(sal) from emp a where a.deptno = b.deptno) sum
    , (select avg(sal) from emp a where a.deptno = b.deptno) avg
    , (select max(sal) from emp a where a.deptno = b.deptno) max
    , (select min(sal) from emp a where a.deptno = b.deptno) min
from emp b
-- 아까 inline과 비교해서 보면, 값을 캐싱하기 때문에 이게 훨씬 빠르다.
-- group by와 비교하면, 같은 것 끼리 묶어서 한꺼번에 묶고, 심지어 같은 집합의 데이터를 캐싱하고 있으므로 빠르다는 소리

