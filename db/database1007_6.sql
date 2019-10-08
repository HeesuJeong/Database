-- 실제 테이블이 아니라 가상이다!
-- emp에 있는 데이터 바뀌면 vemp도 바뀐다
-- view는 실제로 데이터를 가지고 있는게 아니라 매번 emp에서 조회를 한다
-- 객체이므로  drop view 할 때까지 살아남는다
create view VEMP as
select ename,sal,deptno,job from emp where sal>=1000 and job is not null;

select * from vemp;
select ename,sal from vemp where deptno =20 order by sal desc; -- vemp가 서브쿼리 같은 것이다!!
-- 위와 아래와 같다
select A.ename,A.sal from (select ename,sal,deptno,job from emp where sal>=1000 and job is not null) A 
where deptno =20 order by sal desc;

insert into vemp(ename,sal) values('홍길동',1000); -- 뷰에는 insert 안 돼(실제 테이블 아니므로 데이터 입력 안 된다)

drop view vemp;
create view VEMP as
select ename as 이름,sal as 급여,deptno as 부서번호,job as 업무 from emp where sal>=1000 and job is not null;
select 이름,급여 from vemp where 부서번호=20;