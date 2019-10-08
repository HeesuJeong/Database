select * from empcp;
commit;
desc empcp;
-- 제약조건 추가는 이렇게!
ALTER TABLE EMPCP ADD primary key (empno);
insert into empcp(empno,ename) values(8000,'뚜');
commit;