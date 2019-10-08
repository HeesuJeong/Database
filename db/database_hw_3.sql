use ssafydb;

-- 16)
select avg(sal),max(sal),min(sal),count(empno) from emp
where deptno=10;
-- 17)
select deptno,job,count(empno) from emp
group by DEPTNO,Job order by deptno;
-- 18)
select job,count(empno) from emp
group by job having count(empno)>=4;

-- -----------------------------------------------
use testdb;
-- 1)
create table wsTB(isbn char(8) primary key, title varchar(50) not null, author varchar(10) not null,
publisher varchar(15) not null,price int not null, description varchar(200));
-- 2)
insert into wsTB values('123-1-14','Java와 coffee','diana','자바닷컴',8000,'삶의 즐거움');
insert into wsTB values('555-23-2','AI와 미래','김현주','미래닷컴',20000,null);
insert into wsTB values('123-2-15','Java와 놀기','김태희','자바닷컴',22000,'Java 정복');
insert into wsTB values('123-6-24','Java와 알고리즘','서민규','자바닷컴',20000,'성능 업!!');
insert into wsTB values('423-5-36','IoT세상','이세준','미래닷컴',25000,null);
select * from wsTB;
-- 3)
update wsTB set price=price*0.9;
select * from wsTB;
-- 4)
update wsTB set price=price*0.8 where title like '%java%';
select * from wsTB;
-- 5)
delete from wsTB where (title like '%java%' and price<10000);
select * from wsTB;
-- 6)
select publisher, count(isbn), sum(price), avg(price) from wsTB 
group by publisher; 