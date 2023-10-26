#comandos Mysql 
#usando o comando where 
select * from sakila.actor;
select * from sakila.actor
where actor_id =10;

#order comando para ordenar a ordem de processo de consulta 
select * 
from sakila.film
order by title;

#comando order by sendo usado para criar ordem de registros 
select * from sakila.city
order by last_update;


# comando count e group by 
SELECT * FROM sakila.film;
SELECT *, COUNT(*) FROM film
GROUP BY rental_rate
ORDER BY special_features;

#consulta com o metodo count 
select * from sakila.address;
select *, count(*) from address
group by location
order by city_id;

#usando comando where  ( select , from , where)
select * from sakila.payment
where rental_id = 1725;
#comando da especificacao do uso do comando where  
select * from sakila.customer
where first_name like "%mari%";

select * from sakila.customer
where email like "%m%";
#selecionando pelo id 
select * from sakila.customer
where store_id in (1,2);

select * from sakila.customer
where store_id =2;
select * from sakila.customer
where first_name like "%JOYCE%";

#listar todos os filmes de ordem alfabetica 

select * from sakila.film
order by title
limit 50;
# correcao do execiio 
select * from sakila.film
order by description asc; 

select * from sakila.film
order by description desc; 


# trabalhando com tabelas metodo join 
select * from sakila.payment;
select *from sakila.customer;

#correlacionando tabela tem que similar e especificar as colunas 
#payment_id chave primaria 
#customer_id chave estrangeira 
select * from sakila.payment a ,customer b 
where a.customer_id = b.customer_id;



#selecionando colunas especificas 
SELECT b.first_name, b.last_name, SUM(a.amount) as total_amount
FROM sakila.payment a
INNER JOIN sakila.customer b
ON a.customer_id = b.customer_id
GROUP BY b.first_name, b.last_name
ORDER BY total_amount;



# atividade  localizar os filmes que tem genero de acao da locadora  relatorio com esses registros 
# film , categoria , film categoria 
select * from sakila.film; # description , title, film_id 
select * from sakila.category; # name , category_id 
select * from sakila.film_category; #film_id , category_id 

#selecionamos os filmes de acao 
SELECT a.title, a.description, a.film_id
FROM sakila.film a
INNER JOIN sakila.film_category c
ON a.film_id = c.film_id
INNER JOIN sakila.category b
ON c.category_id = b.category_id
WHERE b.name = 'Action';


#ultima data de alugel da tabela alugel 
#ultimo filme  da locadora alugado 
select * from sakila.payment;
select * from sakila.inventory; # invetory_id , film_id,store_id 
select * from sakila.film; # description

SELECT c.store_id
FROM sakila.payment a, sakila.inventory b, sakila.film c
WHERE a.payment_id = b.inventory_id
AND b.film_id = c.film_id
ORDER BY c.last_update DESC;


#comandos avancados de sql sum 
select * from sakila.film; 
#fazendo comando de soma 
select sum(replacement_cost)
from sakila.film;


#comando para soma 
SELECT c.store_id, SUM(c.replacement_cost) AS total_replacement_cost
FROM sakila.payment a
JOIN sakila.inventory b ON a.payment_id = b.inventory_id
JOIN sakila.film c ON b.film_id = c.film_id
GROUP BY c.store_id
ORDER BY MAX(c.last_update) DESC;


# tirando media 
select * from sakila.film;
#tirando media de uma coluna 
select avg(rental_rate,replace_cost)
from sakila.film;
#tirando media de duas colunas 
SELECT AVG(rental_rate) AS avg_rental_rate, AVG(replacement_cost) AS avg_replacement_cost
FROM sakila.film;


#usando comando distint 
SELECT DISTINCT s.store_id
FROM sakila.payment a
JOIN sakila.rental r ON a.rental_id = r.rental_id
JOIN sakila.inventory i ON r.inventory_id = i.inventory_id
JOIN sakila.store s ON i.store_id = s.store_id
ORDER BY r.last_update DESC
LIMIT 0, 1000;


#retirar s colunas em duplicidades retira as duplicidades 
select * from sakila.film;
SELECT title, description, film_id
FROM sakila.film
GROUP BY title, description, film_id;
#usando metodo distinct 
SELECT DISTINCT title, description, film_id
FROM sakila.film;




#comando inner join 
select distinct
a.user_id as user_id_a,
c.user_id as user_id_c,
a.name
from cursos-401615.relacionamentos.acessos a 
inner join cursos-401615.relacionamentos.compras c on a.user_id = c.user_id

#somento o join 
#inner join 
select distinct
a.user_id as user_id_a,
c.user_id as user_id_c,
a.name
from cursos-401615.relacionamentos.acessos a 
join cursos-401615.relacionamentos.compras c on a.user_id = c.user_id

#left join 
select distinct
a.user_id as user_id_a,
c.user_id as user_id_c,
a.name,
c.revenue
from cursos-401615.relacionamentos.acessos a 
left join cursos-401615.relacionamentos.compras c on a.user_id = c.user_id


#left join 
select distinct
a.user_id as user_id_a,
c.user_id as user_id_c,
a.name,
c.revenue
from cursos-401615.relacionamentos.acessos a 
left join cursos-401615.relacionamentos.compras c on a.user_id = c.user_id
where c.user_id is not null


#right join 
select distinct
a.user_id as user_id_a,
c.user_id as user_id_c,
c.name,
c.revenue
from cursos-401615.relacionamentos.acessos a 
right join cursos-401615.relacionamentos.compras c on a.user_id = c.user_id
where a.user_id is not null


#full join 
select distinct
a.user_id as user_id_a,
a.name as name_a,
c.user_id as user_id_c,
c.name as name_c,
c.revenue
from cursos-401615.relacionamentos.acessos a 
full join cursos-401615.relacionamentos.compras c on a.user_id = c.user_id


#full join pega os dados das 2 tabelas 

#sempre temos que correlacionar a chave id e outros itens da coluna 
#full join duplo 
select distinct
 a.user_id as user_id_A,
 a.name as name_a, 
 b.user_id as user_id_b,
 b.name as name_b,
 a.revenue ,
 u.id as user_id_u,
 u.name as name_u
from cursos-401615.relacionamentos.compras a 
full join cursos-401615.relacionamentos.acessos b on a.user_id = b.user_id
full join cursos-401615.relacionamentos.usuarios u on u.id = coalesce(a.user_id, b.user_id)
where coalesce(a.user_id,b.user_id) is null



#full join duplo 
select distinct
 a.user_id as user_id_A,
 a.name as name_a, 
 b.user_id as user_id_b,
 b.name as name_b,
 a.revenue ,
 u.id as user_id_u,
 u.name as name_u
from cursos-401615.relacionamentos.compras a 
full join cursos-401615.relacionamentos.acessos b on a.user_id = b.user_id
full join cursos-401615.relacionamentos.usuarios u on u.id = coalesce(a.user_id, b.user_id)


#SUB QUERYS 
#sub query como coluna select dentro de select 
select 
 u.id ,
 u.name,
 ( select
    count(c.id) as numero_compras
  from cursos-401615.relacionamentos.compras c
  where c.user_id = u.id
 )
from cursos-401615.relacionamentos.usuarios u


#tirando media 
select 
avg((
 select 
 count(id)
 from cursos-401615.relacionamentos.acessos a
 where a.user_id  = u.id
)) as media_acessos
from cursos-401615.relacionamentos.usuarios u



#relacionamento de tabelas 

#tirando media de  acessos 
select
avg(acessos)as media_acessos
from (
select
count(a.id) acessos,
a.user_id 
from cursos-401615.relacionamentos.usuarios u 
left join cursos-401615.relacionamentos.acessos a on u.id = a.user_id
group by 2)


#exemplo com base de dados the look ecommerce 
select
user_id ,
avg(receita) as ticket_medio
from(
 select 
  order_id,
  user_id,
  sum(sale_price) as receita
from bigquery-public-data.thelook_ecommerce.order_items
group by order_id ,user_id
)
group by 1


#sub query com filtro  da para fazer acesso dentro de acesso ou seja select dentro de select 
select 
u.id, 
u.name,
(
  select 
  count(c.id)as numero_de_compras
  from cursos-401615.relacionamentos.compras c
  where c.user_id  = u.id
) as num_compras ,acessos as num_acessos
from cursos-401615.relacionamentos.usuarios u
left join 
(
  select 
   count(a.id) as acessos,
   user_id
   from cursos-401615.relacionamentos.acessos a
   group by 2
) as T on T.user_id = u.id
where
(
  select 
  count(c.id)as numero_compras
  from cursos-401615.relacionamentos.compras c
  where c.user_id = u.id
)>0

#FUNCOES DE JANELA  AULA PRATICA 

#last_value
select 
o.user_id ,
order_id, 
o.created_at ,
last_value(created_at) over(partition by user_id order by created_at rows between current row and unbounded following )as data_ultimo_pedido
from bigquery-public-data.thelook_ecommerce.orders o
order by user_id , created_at;


#fist_value 
select 
o.user_id ,
order_id, 
o.created_at ,
first_value(created_at) over(partition by user_id order by created_at)as data_primeiro_pedido
from bigquery-public-data.thelook_ecommerce.orders o
order by user_id , created_at;


#lag
SELECT
  o.user_id,
  order_id,
  o.created_at,
  LAG(o.created_at) OVER (PARTITION BY user_id ORDER BY created_at) AS data_ultimo_pedido,
  TIMESTAMP_DIFF(
    o.created_at,
    LAG(o.created_at) OVER (PARTITION BY user_id ORDER BY created_at),
    DAY
  ) AS diff_dias
FROM
  bigquery-public-data.thelook_ecommerce.orders o
ORDER BY
  user_id, created_at;




#lead
SELECT
  o.user_id,
  order_id,
  o.created_at,
  lead(o.created_at) OVER (PARTITION BY user_id ORDER BY created_at) AS data_proximo_pedido,
  TIMESTAMP_DIFF(
    o.created_at,
    LAG(o.created_at) OVER (PARTITION BY user_id ORDER BY created_at),
    DAY
  ) AS diff_dias
FROM
  bigquery-public-data.thelook_ecommerce.orders o
ORDER BY
  user_id, created_at;


  #rank e row number
select 
distribution_center_id,
rank() over(order by distribution_center_id)as rank ,
row_number() over(order by distribution_center_id)as numero_1inha
from bigquery-public-data.thelook_ecommerce.products
order by 1,3;


