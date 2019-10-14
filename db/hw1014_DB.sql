create database product;
use product;

create table pro (
	num varchar(20),
    type varchar(20),
    name varchar(30),
    price integer
);

insert into pro values('1', 'phone', 'iphone6', 500000);
insert into pro values('2', 'phone', 'iphone7', 600000);
insert into pro values('3', 'phone', 'iphone8', 700000);
insert into pro values('4', 'phone', 'iphone11', 900000);
insert into pro values('5', 'phone', 'galaxy8', 950000);
insert into pro values('6', 'phone', 'galaxy10', 990000);
insert into pro values('7', 'TV', 'LCDTV', 50000);
insert into pro values('8', 'TV', 'OLEDTV', 60000);
insert into pro values('9', 'TV', 'LG', 55000);
insert into pro values('10', 'TV', 'Samsung', 95000);

select*from pro;
drop table pro;

use product;
create table members (
    name varchar(20),
   userid varchar(20),
   pwd varchar(20),
   email varchar(20),
   phone varchar(20),
   admin integer
);


insert into members values('정희수', 'ssafy', '1234', 'abcd@ssafy', '010-1111-2222', 10);
insert into members values('정희수', 'junghyun', '1111', 'efgh@ssafy', '010-3333-4444', 11);


select*from members;
drop table members;

