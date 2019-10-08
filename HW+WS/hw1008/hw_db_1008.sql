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

ALTER TABLE `EMP`
  ADD CONSTRAINT `PK_EMP` FOREIGN KEY (`DEPTNO`) REFERENCES `DEPT` (`DEPTNO`) ON DELETE SET NULL ON UPDATE CASCADE;

select * from emp;
select * from dept;
-- (1)  부서위치가CHICAGO인모든사원에대해이름,업무,급여출력하는SQL을작성하세요.
select ename,job,sal from emp join dept using (deptno) where loc='CHICAGO';

-- (2) 부하직원이없는사원의사원번호,이름,업무,부서번호출력하는SQL을작성하세요.
select empno,ename,job,deptno from emp where empno not in (select distinct mgr from emp where mgr is not null); 

-- (3) BLAKE와같은상사를가진사원의이름,업무,상사번호출력하는SQL을작성하세요.
select ename,job,mgr from emp where emp.mgr=(select mgr from emp where ename='BLAKE');

-- (4) 입사일이가장오래된사람5명을검색하세요.
select * from emp order by HIREDATE limit 5;

-- (5) 
select ename,job,dname from emp join dept using(deptno) where mgr=(select empno from emp where ename='JONES');