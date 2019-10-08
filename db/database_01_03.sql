desc emp;

-- emp 테이블에 hobby 속성 추가합니다!
alter table emp add(hobby char(5));

select * from emp;

-- ------------------------ 문자형 함수

-- ecase는 lower, ucase는 upper랑 같다
select ename,lower(ename), upper(ename),reverse(ename),lcase(ename),ucase(ename)
from emp where lower(ename)='smith';

-- ||비트연산이 되어버린다
-- 두 문자 붙이려면 무조건 concat
select 'squl'||'plus' from dual;

select concat('squl','plus') from dual;

-- 문자 자르고 싶을 때 substr()
select substr('i love you',3,4) from dual; 
-- 시작은 1부터
-- 3번째부터 4개 가져오겟다

select substr(ename,1,3) from emp
where substr(ename,1,1)='s'; -- s로 시작하는 이름들

-- dual은 데이터베이스의 가상테이블이야  => 굳이 안 써줘도 되는데 syntax를 맞추기 위해 
select instr('i love you','you') from dual;

-- admin@naver.com
select substr('admin@naver.com',1,instr('admin@naver.com','@')-1) from dual;
select substr('admin@naver.com',instr('admin@naver.com','@')+1) from dual;


-- 자리수 채우기
select lpad('홍길동',10,'*'),rpad('홍길동',10,'*') from dual;

-- 양쪽 공백 제거
select trim(' i love you  ') from dual;
-- 정말 공백 제거 되었는지 확인하기
select length('i love you'), length(trim('  i love you   ')) from dual;

-- 한글은 3byte, 영어는 1byte
select length('공유'), length('abc') from dual;

select replace('i love you','you','us');

-- ------------------------ 숫자형 함수
select abs(2),abs(-2) from dual;

-- 음수인지 양수인지 알기 위해
select sign(2),sign(-2),sign(0) from dual;

-- 올림
select round(123.1234567,-2) from dual;
-- 버림
select truncate(123.123456,3) from dual;

-- 같거나 큰 정수 ceil() == 올림, 같거나 작은 정수 floor() == 내림
select ceil(123.1234567),floor(123.12345) from dual;

select mod(5,3) from dual; 
select mod(60,0) from dual; -- 0으로 나누엇으니 원래 error이지만 그냥 null을 반환한다.

select power(3,2);

-- ------------------------ 날짜형 함수
select now(),curdate() from dual;

select year('20190812'),month('20190812');

select hiredate,year(hiredate),year(now()) from emp;

-- 2019녀의 몇번째 주일까?
select week(now());
select date_add(now(),interval 100 month);

select(to_days(now())-to_days('19960922'));

select extract(year from now());
select year(now());


select date_format(now(),'%Y:%M:%p');

-- 변환함수
select format(123456789,'#,###,###.###') from dual;
select cast(now() as char);
select cast(1234 as char);

-- 일반함수
-- 표현식이 비교1이면 결과1로 변경
/*case 표현식 when 비교1 then 결과1
			when 비교2 then 결과2
            else 기본값
            end;*/
            
select case job when 'manager' then upper('manager')
				when 'clerk' then '클럭이구나'
				else '몰라몰라' 
                end as a
	from emp;

select sal, case sal when 3000 then '많이 버네요'
				when 2000 then '보통이네요'
                else '그저그래요'
                end as aa
		from emp;
        
-- 범위 지정은 when안에 속성 두기
select sal, case when sal>3000 then '많이 버네요'
				when sal>2000 then '보통이네요'
                else '그저그래요'
                end as aa
		from emp order by sal;
        
select case substr('100812-3235423',8,1) when 3 then '여자'
									when 4 then '남자'
		end as a from dual;