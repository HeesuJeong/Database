use scott;
select * from emp;
delete from emp where ename='홍길동';
select * from dept;

select count(*) from dept;
select count(*) from emp;
-- 이름 급여 부서번호
-- 부서이름은 dept 테이블에서
-- 어느 테이블의 속성을 가져오는지 명시해야해(deptno의 모호성이 발생해, 두 개의 테이블 모두에 존재하니깐)
select * 
-- e.ename as 이름,e.sal as 급여,e.deptno as 부서번호, d.dname as 부서이름 
from emp as e,dept as d;
-- 4*14=56건 뽑힌다(두 테이블을 붙여버린다)   cross product 발생

-- filtering => 직원의 deptno에 매칭되는 dept의 deptno만 출력 (14건 출력) 
-- 동등비교 이므로  equijoin
-- 같은 얘들만 비교하였으므로 inner join
-- 두 개의 테이블을 ,로 연결하고 where절로 필터링 했다 => 전통적 방식
select e.ename as 이름,e.sal as 급여,e.deptno as 부서번호, d.dname as 부서이름 from emp as e,dept as d where e.deptno=d.deptno;
-- ansi 형식
select e.ename as 이름,e.sal as 급여,e.deptno as 부서번호, d.dname as 부서이름 from emp e inner join dept d on e.deptno=d.deptno;
-- column명 같은 경우 using 절 사용(연결할 column명이 같을 때만 사용 가능)
select e.ename as 이름,e.sal as 급여,e.deptno as 부서번호, d.dname as 부서이름 from emp e inner join dept d using(deptno);

-- 이름 급여 급여등급(70건=>사원수 14명 건수만 나와야했는데~)
select ename, sal,grade
from emp,salgrade;
select * from salgrade;

-- emp와 salgrade의 froeign key가 없다!
-- non-equi join이다!
select ename, sal,grade
from emp,salgrade where emp.sal>=losal and emp.sal<=hisal; -- 14건 나온다!alter
-- between 사용
select ename, sal,grade
from emp,salgrade where emp.sal between losal and hisal;

update emp set deptno=null where ename='king';
select * from emp where ename='king';
-- 모든 사원의 이름 부서명 급여를 구하시오
select ename,dname,sal from emp inner join dept on emp.deptno=dept.deptno;  -- king 부서가 null이라 하나 빠진 13건이 나와버린다!
-- 참조 무결성이 깨진 예시이다.

-- ------------outer join
-- master와 slave 테이블로 나뉜다.
-- master의 데이터는 slave의 데이터와 연결되지 않아도 다 나와야한다!
-- 모든 사원의 이름 부서명 급여를 구하시오
select ename,dname,sal from emp left outer join dept on emp.deptno=dept.deptno;
select ename,dname,sal from emp right outer join dept on emp.deptno=dept.deptno;

-- -------self join
-- 자기 자신끼리 연결하는 것(의미가 다른 두 개의 테이블을 join하는거야) => a와 b테이블의 의미를 파악하는 것이 중요!
-- 사원명, 급여, 관리자번호, '관리자명'
select b.empno,b.ename,b.sal,b.mgr,a.ename from emp as a,emp as b where a.empno=b.mgr;
-- b테이블의 의미: 사원! => a가 관리자 테이블,b가 사원 테이블이 된다.

-- ansi 표현식 (using사용 불가, 연결하는 column다르니깐)
select b.empno,b.ename,b.sal,b.mgr,a.ename from emp a join emp b on a.empno=b.mgr;

-- 사원의 이름 급여 관리자명 관리자급여등급
-- b가 관리자 a가 사원
select a.ename,a.sal,b.ename from emp a, emp b, salgrade c where a.mgr=b.empno and b.sal between c.losal and c.hisal;
-- 위와 같지만 ansi 표현방식
select a.ename,a.sal,b.ename from emp a join emp b on a.mgr=b.empno
join salgrade c on b.sal between c.losal and c.hisal;

-- -----natural join
-- 사번 이름 급여 부서명
select dmpno,ename,sal,dname
from emp natural join dept;

-- cross join
select empno,ename,sal,dname from emp join dept;

select * from emp;
select * from dept;
select * from salgrade;
-- 사번 이름 급여 부서명 관리자이름 관리자급여등급 구하기
-- 단 관리자 없는 사원도 같이 나오게 하세요(king)
-- 관리자 없는 경우 '관리자없음'으로 표시
select a.empno,a.ename,a.sal,d.dname,ifnull(b.ename,"관리자 없어")as mgr,c.grade
from emp a left outer join emp b on a.mgr=b.empno   -- mgr이 null인 king을 뽑기 위해 left outer join
left outer join dept as d on a.deptno=d.deptno
left outer join salgrade c on b.sal between c.losal and c.hisal;
-- b가 관리자 a가 사원 

