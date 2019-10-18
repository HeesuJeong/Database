create database homework;
use homework;

create table if not exists product(
id varchar(10) not null,
name varchar(10) not null,
price int(10) not null,
descrip varchar(10) not null
);

insert into product (id,name,price,descrip) values 
('1','ddu',100,'first'),
('2','ddfadifh',100,'second');
select * from product;

select * from product where id=1;
select * from product;
update product set id='0',name='change',price=0,descrip='changed' where id='1';
delete from product where id=0;