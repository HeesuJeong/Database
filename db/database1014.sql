-- 분석함수
use scott;

-- 스칼라 서브쿼리
select ename,sal,(select sum(sal) from emp) 
from emp;
-- 상호연관 서브쿼리(자기가 속한 부서별 급여 합,최대,최소,평균)
update emp set deptno=10 where ename='king';
select ename,sal
,(select sum(sal) from emp b where a.deptno=b.deptno) a
,(select max(sal) from emp b where a.deptno=b.deptno) b
,(select min(sal) from emp b where a.deptno=b.deptno) c
,(select round(avg(sal)) from emp b where a.deptno=b.deptno) d -- 소수 첫째자리에서 반올림 round
,(select sum(sal) from emp b) e -- 모든 부서 합
from emp a;

-- 그냥 sum이 아니라 분석함수 sum으로 바뀐다
-- 분석함수명 over(|partition by| |order by| 옵션 줄 수 있다) 
-- 전통적 쿼리문 다 돌아고 분석함수 돌려서 둘이 붙인다.
select ename,sal,sum(sal) over() from emp;

-- 분석함수 종류 2가지 : 기존 다중 집계 함수의 overload형 및 분석함수 전용함수 
-- 집계함수: sum,avg,max,min,count
-- partition by => 자기가 속한 부서별 급여 합으로 바뀐다
select ename,sal
,sum(sal) over(partition by deptno)
,avg(sal) over(partition by deptno)
,max(sal) over(partition by job)
,min(sal) over(partition by job) 
from emp;

-- 분석함수 전용함수(deptno 기준으로)
select ename,sal,deptno
				,rank() over(partition by deptno order by sal desc) r1       -- 등수메기기=> 2등2등 => 4등(해당 부서 안에서의 랭킹)
				,dense_rank() over(order by sal desc) r2 -- 등수메기기=>2등2등 =>3등
                ,cume_dist() over(order by sal desc)*100 r3 -- 내 급여가 전체에서 상위 몇% 차지하는지
                ,ntile(4) over(order by sal desc) r4 -- 급여의 역순으로 grouping한다.
                ,row_number() over (order by sal desc,hiredate asc) r5 -- 순서 메기기, 두번째 인자는 동일한 sal일때 다음 기준
from emp
order by r5 desc;
-- 정렬은 하나만 기준을 줄 수 있다
-- main함수 => 분석함수가 각 그룹에서 각각 실행돼 => 각 그룹내 순서 정하는 옵션 order by
-- 정말 정렬하려면 명시적으로 order by deptno이나 order by r5 해줘야해.

-- 응용) 랭크 4 뽑기
select * from
(select ename,sal,rank() over(order by sal asc) r1       -- 2등2등 => 4등
				,dense_rank() over(order by sal desc) r2 -- 2등2등 =>3등
from emp
) a
where a.r2=4;

-- 범위누적 집계(집계함수가 누적이 된다.)
select empno,ename
,sal
,sum(sal) over() r1 -- 전체집계의 합
,sum(sal) over(order by sal    -- 정렬한 얘에서 내 하나 앞에 있는 얘를 sum해라
				rows 1 preceding ) r2 
from emp;

 -- 앞에거 몇 개인지 정하지 않고 다 더해 unbounded
select empno,ename
,sal
,sum(sal) over() r1 -- 전체집계의 합
,sum(sal) over(order by sal    -- 정렬한 얘에서 내 하나 앞에 있는 얘를 sum해라
				rows unbounded preceding ) r2  -- 앞에거 몇 개인지 정하지 않고 다 더해 unbounded
from emp;

 -- 뒤에꺼 더하는 following 자식은 미리 알 수 없으므로 preceding이랑 꼭 같이 써야해
 select empno,ename
,sal
,sum(sal) over() r1 -- 전체집계의 합
,sum(sal) over(order by sal    -- 정렬한 얘에서 내 하나 앞에 있는 얘를 sum해라
				rows unbounded preceding) r2
,sum(sal) over(order by sal rows between current row and 1 following) r3 -- 현재 내 줄과 뒤에 하나 해서 뽑아주세요
,sum(sal) over(order by sal rows between unbounded preceding and unbounded following)-- 전체 통합
from emp;

