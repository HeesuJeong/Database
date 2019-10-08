use workshop;
drop table product;
-- (1)
create table product(
product_no int(10) not null,
product_name varchar(20),
product_price int(10),
primary key(product_no)
);
-- (2)
insert into product(product_no, product_name, product_price) values(1111,'TV',1000),
(2222,'laptop',2000),
(3333,'LG TV',3000),
(4444,'LG laptop',4000),
(5555,'samsung TV',5000);
select * from product;

-- (3)
update product set product_price=1.5*(product_price);
select * from product;

-- (4)
update product set product_price=0.8*(product_price) where product_name like '%TV%';
select * from product;

-- (5)
select sum(product_price) as total from product;