CREATE database SCOTT;

USE SCOTT;

drop table emp;
drop table dept;

-- (1) 테이블생성
CREATE TABLE IF NOT EXISTS `DEPT` (
  `DEPTNO` int(2) NOT NULL,
  `DNAME` varchar(14) DEFAULT NULL,
  `LOC` varchar(13) DEFAULT NULL,
  PRIMARY KEY (`DEPTNO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


INSERT INTO `DEPT` (`DEPTNO`, `DNAME`, `LOC`) VALUES
(10, 'ACCOUNTING', 'NEW YORK'),
(20, 'RESEARCH', 'DALLAS'),
(30, 'SALES', 'CHICAGO'),
(40, 'OPERATIONS', 'BOSTON');


CREATE TABLE IF NOT EXISTS `EMP` (
  `EMPNO` int(4) NOT NULL,
  `ENAME` varchar(10) DEFAULT NULL,
  `JOB` varchar(10) DEFAULT NULL,
  `MGR` int(4) DEFAULT NULL,
  `HIREDATE` datetime DEFAULT NULL,
  `SAL` double DEFAULT NULL,
  `COMM` double DEFAULT NULL,
  `DEPTNO` int(2) DEFAULT NULL,
  PRIMARY KEY (`EMPNO`),
  KEY `PK_EMP` (`DEPTNO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


INSERT INTO `EMP` (`EMPNO`, `ENAME`, `JOB`, `MGR`, `HIREDATE`, `SAL`, `COMM`, `DEPTNO`) VALUES
(7369, 'SMITH', 'CLERK', 7902, '1980-12-17 00:00:00', 800, NULL, 20),
(7499, 'ALLEN', 'SALESMAN', 7698, '1981-02-20 00:00:00', 1600, 300, 30),
(7521, 'WARD', 'SALESMAN', 7698, '1981-02-22 00:00:00', 1250, 500, 30),
(7566, 'JONES', 'MANAGER', 7839, '1981-04-02 00:00:00', 2975, NULL, 20),
(7654, 'MARTIN', 'SALESMAN', 7698, '1981-09-28 00:00:00', 1250, 1400, 30),
(7698, 'BLAKE', 'MANAGER', 7839, '1981-05-01 00:00:00', 2850, NULL, 30),
(7782, 'CLARK', 'MANAGER', 7839, '1981-06-09 00:00:00', 2450, NULL, 10),
(7788, 'SCOTT', 'ANALYST', 7566, '1987-04-19 00:00:00', 3000, NULL, 20),
(7839, 'KING', 'PRESIDENT', NULL, '1981-11-17 00:00:00', 5000, NULL, 10),
(7844, 'TURNER', 'SALESMAN', 7698, '1981-09-08 00:00:00', 1500, 0, 30),
(7876, 'ADAMS', 'CLERK', 7788, '1987-05-23 00:00:00', 1100, NULL, 20),
(7900, 'JAMES', 'CLERK', 7698, '1981-12-03 00:00:00', 950, NULL, 30),
(7902, 'FORD', 'ANALYST', 7566, '1981-12-03 00:00:00', 3000, NULL, 20),
(7934, 'MILLER', 'CLERK', 7782, '1982-01-23 00:00:00', 1300, NULL, 10);

-- (1) 데이터 추가
INSERT INTO DEPT VALUES
(10,'ACCOUNTING','NEW YORK');
INSERT INTO DEPT VALUES
(20,'RESEARCH','DALLAS');
INSERT INTO DEPT VALUES
(30,'SALES','CHICAGO');
INSERT INTO DEPT VALUES
(40,'OPERATIONS','BOSTON');

-- (2) 안 해도 된다.
select * from emp;
select * from dept;
-- (3) emp와 dept Table을 JOIN하여 이름, 급여, 부서명을 검색하세요.
select emp.ename, emp.sal, dept.dname from emp inner join dept where emp.deptno=dept.deptno;
-- (4) 이름이 ‘KING’인 사원의 부서명을 검색하세요.
select dept.DNAME from dept where dept.deptno=(select deptno from emp where ename='KING');
-- (5) dept Table에 있는 모든 부서를 출력하고, emp Table에 있는 DATA와 JOIN하여 모든 사원의 이름, 부서번호, 부서명, 급여를 출력 하라.
-- ***************
select distinct dname from dept;
select emp.ename,emp.deptno,dept.dname,emp.sal from emp join dept where emp.deptno=dept.deptno;
-- (6) emp Table에 있는 empno와 mgr을 이용하여 서로의 관계를 다음과 같이 출력되도록 쿼리를 작성하세요. ‘SCOTT의 매니저는 JONES이다’
select concat(a.ename,'의 매니저는 ',b.ename,'이다.') as sentence from emp as a, emp as b 
where a.mgr=b.empno;
-- (7) 'SCOTT'의 직무와 같은 사람의 이름, 부서명, 급여, 직무를 검색하세요.
select emp.ename,dept.dname,emp.sal,emp.job from emp join dept using (deptno) where emp.job=(select job from emp where ename='SCOTT');
-- (8) 'SCOTT’가 속해 있는 부서의 모든 사람의 사원번호, 이름, 입사일, 급여를 검색하세요.
select empno, ename,hiredate, sal from emp where emp.DEPTNO=(select deptno from emp where ename='SCOTT');
-- (9) 전체 사원의 평균급여보다 급여가 많은 사원의 사원번호, 이름,부서명, 입사일, 지역, 급여를 검색하세요.
select empno,dname,HIREDATE,loc,sal from emp join dept using (deptno) where sal>(select avg(sal) from emp);
-- (10) 30번 부서와 같은 일을 하는 사원의 사원번호, 이름, 부서명,지역, 급여를 급여가 많은 순으로 검색하세요.
select empno,ename,dname,loc,sal from emp join dept using (deptno) where deptno=30 order by sal desc;
-- (11) 10번 부서 중에서 30번 부서에는 없는 업무를 하는 사원의 사원번호, 이름, 부서명, 입사일, 지역을 검색하세요.
select empno,ename,deptno,HIREDATE,loc from emp join dept using (deptno) where emp.job not in (select job from emp where deptno=30) and emp.DEPTNO=10;
-- (12) ‘KING’이나 ‘JAMES'의 급여와 같은 사원의 사원번호, 이름,급여를검색하세요.
select empno,ename,sal from emp where emp.sal in (select sal from emp where ename='KING' or ename='JAMES');
-- (13) 급여가 30번 부서의 최고 급여보다 높은 사원의 사원번호,이름, 급여를 검색하세요.
select empno,ename,sal from emp where emp.sal >all (select sal from emp where deptno=30);
-- (14) 이름 검색을 보다 빠르게 수행하기 위해 emp 테이블 ename에 인덱스를 생성하시오.
create index idx_emp_ename on emp(ename);
-- (15) 이름이 'ALLEN'인 사원의 입사연도가 같은 사원들의 이름과 급여를출력하세요.
select ename,sal from emp where hiredate=(select hiredate from emp where ename='ALLEN');
-- (16) 부서별 급여의 합계를 출력하는 View를 작성하세요.
drop view tmp;
create view TMP as 
select sum(sal) as a from emp group by deptno;
select * from TMP;
-- (17) 16번에서 작성된 View를 이용하여 부서별 급여의 합계가 큰 1~3순위를 출력하세요.
select * from TMP order by a desc;
