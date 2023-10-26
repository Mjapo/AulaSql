#aritmedico 
select
7/7 as divisao,
12*4 as mutiplicacao ,
5+6 as soma,
10-6 as subtracao; 

#comparacao 
select
5=5 , 
1>10, 
100>3,
17!=17,
60<=3;  

#between( entre )
select
10 between  8 and 15 ,
-13 between 0 and 100,


#usando comando select
select * 
from `ecommerce.products`
where price between 30 and 80;

#comando like 
select * 
from `ecommerce.customers`
where first_name like 'J%'

#comando distinct 
select distinct
category_id
from `ecommerce.products`;


# comando count com distintic 
select
 count(distinct first_name) as nomes_distintos
from `ecommerce.customers`;

#comando like 
select * 
from `ecommerce.customers`
where first_name like 'J%r';

#comando distinct 
select distinct
category_id
from `ecommerce.products`;

#comando distinct 
select distinct
first_name
from `ecommerce.customers`;

select
 count(distinct first_name) as nomes_distintos
from `ecommerce.customers`;


#COMANDO ORDER BY 
SELECT first_name AS nome , email AS email
FROM ecommerce.customers
ORDER BY nome;

select * 
from `ecommerce.products`
where price between 30 and 80;

#comando like 
select * 
from `ecommerce.customers`
where first_name like 'J%r';


