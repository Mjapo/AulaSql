SELECT id,first_name,cell_phone 
FROM `ecommerce.customers`; 

SELECT id, first_name, cell_phone
FROM `ecommerce.customers`
ORDER BY first_name ASC;



#apelidos comando AS da o comando para mudar o nome da primeira coluna 
select *
from ecommerce.customers;


select id,first_name as primeiro_nome
from `ecommerce.customers`;

select i.id ,
i.total_price
from ecommerce.items as i;

#usando comando join 
select
p.name as nome_produto,
c.name as nome_categoria
from ecommerce.products as p
join ecommerce.categories as c on p.category_id = c.id;


# USANDO COMANDO WHERE sempre depois do from  
select *
from ecommerce.items
where quantity = 5;

select *
from ecommerce.customers
where state = "Bahia" and email is not null;

#criando uma condicao de duas colunas 
select *
from ecommerce.customers
where (state = "Bahia" or  state= "Rio Grande do sul")and email is not null;



select *
from ecommerce.customers
where (state = "Bahia" or  state= "Goiás")and email is not null;

# Case 
select id,
name ,
 case 
 when name = "Cosméticos e Perfumaria" then  "sim é categoria Cosméticos e Perfumaria" 
 end as case1
from ecommerce.categories;


#comando Case 
select id,
name ,
 case 
 when name = "Cosméticos e Perfumaria" then  "sim é categoria Cosméticos e Perfumaria" 
 when name = "Esporte e Lazer" then "sim é categoria Esporte e Lazer"
 else "Não encontrou as categorias acima"
 end as case1
from ecommerce.categories;



select 
id ,
name ,
 case 
 when id between 0 and 5 then "primeiro verdadeiro"
 when id between 3 and 5 then "segundo verdadeiro"
 when id between 3 and 7 then "terceiro verdadeiro"
 end as case2
from bigquery-public-data.thelook_ecommerce.distribution_centers;



#if  colocando condicoes dentro do if  
select id,
name ,
if (name ="Cosméticos e Perfumaria" ,"sim é categoria Cosméticos e Perfumaria", 
if(name ="Esporte e Lazer", "sim é categoria Esporte e Lazer"
,"Não encontrou as categorias acima")) as if1
from ecommerce.categories;


#coalese parametro1 , parametro2, parametro n retorna o primeiro nao nulo 
select
id , 
first_name,
additionals, 
coalesce(additionals,'Ops o complemento e nulo') as complemento
from ecommerce.customers
limit 20;


#COMANDO ORDER BY 

#group by e order by 
select distinct
status
from bigquery-public-data.thelook_ecommerce.orders; 

# group by sempre depois do from 
select  
status
from bigquery-public-data.thelook_ecommerce.orders
group by status;


#usando group by com order by 


# group by sempre depois do from  asc "de forma crescente" des "de forma decrescente"
select  
count (distinct order_id) as numero_pedidos,
date(created_at) as dia
from bigquery-public-data.thelook_ecommerce.orders
group by dia
order by dia asc;

#join  relacionando duas tabelas 

#comando join 
select 
o.order_id, 
o.user_id,
num_of_item, 
i.order_id,
i.user_id,
round(sum(sale_price), 2) as receita
from bigquery-public-data.thelook_ecommerce.orders as o 
join bigquery-public-data.thelook_ecommerce.order_items as i on  o.order_id = i.order_id
group by 1,2,3,4,5
order by receita desc;



#EXEMPLO DA FUNCAO COUNT E A MIN 

select 
count(*) as qtde_usuarios, 
count(id) as qtde_usuarios_2,
count(distinct(id)) as qtde_usuarios_3  
 from bigquery-public-data.thelook_ecommerce.users;


 
#count da coluna status 
select 
count (distinct status) qtde_status
 from bigquery-public-data.thelook_ecommerce.orders;


 
#count da coluna pedidos 
select 
 count(distinct order_id) qtde_pedidos,
 date(created_at) dia
 from bigquery-public-data.thelook_ecommerce.orders
 group by dia
 order by dia;

 
#usando comando extract 
select 
count(distinct order_id)qtde_pedidos,
extract(year from created_at) ano
from bigquery-public-data.thelook_ecommerce.orders
group by ano 
order by ano asc;


#funcao max 
select
max(retail_price) as preco_maximo_produto
from bigquery-public-data.thelook_ecommerce.products


#funcao min 
select
min(retail_price) as preco_minimo_produto
from bigquery-public-data.thelook_ecommerce.products




 #agrupamento #revisar 
 #Criando Agrupamentos 
select
  ROUND(MAX(retail_price), 2) AS preco_maximo_produto,
  ROUND(MIN(retail_price), 2) AS preco_minimo_produto,
  c.name
FROM `bigquery-public-data.thelook_ecommerce.products` p
JOIN `bigquery-public-data.thelook_ecommerce.distribution.centers` c ON p.distribution_center_id = c.id
GROUP BY c.name
ORDER BY 2;


# imprimindo datas 

#Criando Agrupamentos 
select 
max(created_at) as data_de_cadastro_mais_recente,
min(created_at) as data_de_cadastro_mais_antiga
from bigquery-public-data.thelook_ecommerce.users;



# funcoes soma sum , avg - media 

select
round(sum(sale_price),2) as receita  
from bigquery-public-data.thelook_ecommerce.order_items
where status = "Complete";



#agrupamentos com a fucao sum 

select
round(sum(sale_price),2) as receita,  
 format_date("%Y-%m", created_at) as mes 
from bigquery-public-data.thelook_ecommerce.order_items
where status = "Complete"
group by mes 
order by mes;

#usando condicao 
select 
sum(if(country='Brasil',1,0)) as cadastro_Brasil,
count(case when country='Brasil'then id end ) as cadastro_Brasil 
from bigquery-public-data.thelook_ecommerce.users


#AVG 
select
round(avg(sale_price),2) as receita,  
 format_date("%Y-%m", created_at) as mes 
from bigquery-public-data.thelook_ecommerce.order_items
where status = "Complete"
group by mes 
order by mes;
# vai moostrar o ticket medio 


#Pratica  

#absoluto 
#usado para calculo de distancia , posicoes = para calcular percursos
select
100,
-23,
abs(100) as teste1,
abs(-23) as teste2



#funcao rand 
select
rand() as teste1,
 10*rand() as teste2,
 10000*rand()as teste3



#funcao rand  na pratica 
select
id,
email,
rand() as valor_aleatorio
from bigquery-public-data.thelook_ecommerce.users
where email is not null
order by valor_aleatorio asc
limit 20


#funcao sqr 
select
sqrt(16),
sqrt(81)


#pow
select 
pow(3,2),
pow(100,0),
pow(10,-2)


#log base maior que 0 e diferente  de 1 
select
log(49,7),
log(81,9),
log(3,0)# erro de operacao 



#round
select 
round(1.64,1) as teste1,
round(1.65,2) as teste2,
round(25.364,1) as teste3,
round(numeric"25.364",1)as teste4,
round(numeric"1.65",1)as teste5

#round
select
avg(retail_price) as media_preco,
round(avg(retail_price),0)as teste1,
round(avg(retail_price),2)as teste2,
from bigquery-public-data.thelook_ecommerce.products


#round
select
avg(retail_price) as media_preco,
round(avg(retail_price),0)as teste1,
round(avg(retail_price),2)as teste2,
round(cast(avg(retail_price)as numeric),8)as teste3
from bigquery-public-data.thelook_ecommerce.products


#mod
select
mod(4,2)as test1,
mod(50,4)as test2,
mod(35,2) as test3




#FUNCOES DE TEXTO 
#concat 
select
 "ola",
 "mundo",

concat("ola","  " ,"mundo")

#concat
select
id,
first_name,
last_name,
concat(first_name, "  " ,last_name) as nome_completo
from bigquery-public-data.thelook_ecommerce.users



#concat revisar formula 
select
 o.order_id,
 concat('quantidade total de ordens do pedido: ',avg(o.num_of_item), ' - ',' - ' , 'Receita total do pedido: ',  
sum(sale_price) as detalhe )
from bigquery-public-data.thelook_ecommerce.orders o 
from  ol on o.orders = ol.orders
group by 1
order by 1;  


#starts_with 
select
starts_with("ciencias de dados", "c") as teste1, 
starts_with("ciencias de dados" ,"C")as teste2,
starts_with("ciencias", "ciencias")as teste3;

select 
id,
first_name
from bigquery-public-data.thelook_ecommerce.users
where starts_with(first_name, "Michelle")


#comando lower 
select distinct
repo_name,
lower(repo_name) as lower_repo_name
from bigquery-public-data.github_repos.sample_repos
where lower(repo_name) like "%python%";


#comando upper
select distinct
repo_name,
upper(repo_name) as upper_repo_name
from bigquery-public-data.github_repos.sample_repos
where upper(repo_name) like "%PYTHON%";



#init cap 

SELECT
  id,
  first_name,
  last_name,
  CONCAT(first_name, ' ', last_name) AS nome_completo,
  LOWER(CONCAT(first_name, ' ', last_name)) AS nome_completo1,
  UPPER(CONCAT(first_name, ' ', last_name)) AS nome_completo2,
  INITCAP(CONCAT('cliente','   ',first_name, ' ', last_name)) AS nome_completo3
FROM
  bigquery-public-data.thelook_ecommerce.users;



#split

SELECT
  SPLIT('Por favor parem de atribuir a mim , frases que nunca pronuciei - Albert Einstein ', ' ')[ORDINAL(1)] AS Palavras,
  SPLIT('Por favor parem de atribuir a mim , frases que nunca pronunciei - Albert Einstein ', ' ')[ORDINAL(2)] AS segunda,
  SPLIT('Por favor parem de atribuir a mim , frases que nunca pronunciei - Albert Einstein ', ' ')[ORDINAL(3)] AS terceira,
  SPLIT('Por favor parem de atribuir a mim , frases que nunca pronunciei - Albert Einstein ', ' ')[ORDINAL(4)] AS quarta,
  SPLIT('Por favor parem de atribuir a mim , frases que nunca pronunciei - Albert Einstein ', ' ')[ORDINAL(5)] AS quinta,
  
  #usado para segmentar textos conforme tabelas 




#trim 
select 
trim('CPF: 123.456.789-0', 'CPF:'),
ltrim('CPF: 123.456.789-0', 'CPF:'),
rtrim('CPF: 123.456.789-0', 'CPF:'),
trim('***(11)9 7286-8850***', '*') as telefone,
trim('          Rio de Janeiro        ','   ')as cidade



#comando Replace 
SELECT
  *,
  REPLACE(name, "/New Jersey NY/NJ", "NJ") AS name_replaced,
  REPLACE(REPLACE(name, "/New Jersey NY/NJ", "NJ"), "Authority", "") AS name_replaced_without_authority
FROM bigquery-public-data.thelook_ecommerce.distribution_centers;





# quando colocamos vazios ele sempre vai referenciar de forma UTC   
select
current_date() as ex1, 
current_timestamp() as ex2, 
current_datetime() as ex3;

# no current date tudo depende do join que no caso e localizacao de onde a pessoa esta fazendo a consulta 
select
current_datetime("America/Sao_Paulo") as ex4,
current_date("America/Sao_Paulo") as ex6,
current_datetime("America/Los_Angeles") as ex5,
current_date("Asia/Tokyo")as ex6,
current_datetime("Asia/Tokyo")as ex7




#current_date
select 
*
from bigquery-public-data.thelook_ecommerce.users
where date(created_at) = current_date() - interval 5 day;


#date_sub 
select 
*
from bigquery-public-data.thelook_ecommerce.users
where date(created_at) = date_sub(current_date(), interval 5 day);


#date,datetime, timstamp

select
date(2023,02,01)as ex1,
date"2023-02-01" as ex2;


select
datetime(2023,7,20,12,34,47) as ex1,
datetime"2023-7-20 12:34:47"as ex2,
datetime"2022-07-20T12:34:47"as ex3, 
current_timestamp()as ex4,
datetime(current_timestamp())as ex5,
datetime(current_timestamp,"America/Sao_Paulo")as ex6,
datetime(current_timestamp, "Asia/Tokyo")as ex7;

# ele transforma em horario de utc
select
timestamp("2023-10-20 13:05:52 America/Sao_Paulo")as ex1,
timestamp("2023-10-20 13:05:52", "America/Sao_Paulo")as ex2,
timestamp(current_datetime())as ex3,
timestamp(current_date())as ex4


#funcao extract 
select
current_date()as ex1,
extract(month from current_date)as mes,
extract(dayofyear from current_date)as day,
extract(hour from current_timestamp)as h;


#exemplo pratico 
select
count(order_id)as pedido,
extract(quarter from created_at)as trimestre
from bigquery-public-data.thelook_ecommerce.orders
where date(created_at) between "2022-01-01" and "2022-12-31"
group by 2
order by 2;

#date_add, datetime, timestanp_ add
select
current_date as t1,
date_add(current_date, interval 10 day) as t2,
date_add(current_date,interval 1 month)as t3,
current_timestamp() as t4 ,
timestamp_sub(current_timestamp, interval 2 hour)as t5;

#exemmplo pratico 
select 
sum(num_of_item) as qtde_items,
from bigquery-public-data.thelook_ecommerce.orders
where date(created_at) >= date_sub(current_date, interval 5 day);


select 
sum(num_of_item) as qtde_items,
from bigquery-public-data.thelook_ecommerce.orders
where date(created_at) between date_sub(current_date, interval 5 day) and current_date();

#date_diff
SELECT
    date_diff('2022-10-05', '2022-10-01', day) AS ex1,
    date_diff('2022-10-05T21:00:00', '2022-10-05T14:00:00', HOUR) AS ex2,
    date_diff('2022-10-05 21:30:00', '2022-10-05 21:00:00', minute) AS ex3;


# time stanp 
select
u.id,
min(timestamp_diff(o.created_at ,u.created_at,day)) as dias_ate_primeira_compra
from bigquery-public-data.thelook_ecommerce.orders o 
join bigquery-public-data.thelook_ecommerce.users u on u.id  = o.user_id
group by 1
order by 2 desc;


#encadeamento de media de dias 

with dias as (
  # time stanp 
select
u.id,
min(timestamp_diff(o.created_at ,u.created_at,day)) as dias_ate_primeira_compra
from bigquery-public-data.thelook_ecommerce.orders o 
join bigquery-public-data.thelook_ecommerce.users u on u.id  = o.user_id
group by 1
order by 2 desc
)
select
avg(dias.dias_ate_primeira_compra) as media_dias_ate_primeira_compra
from dias;


#format_date 
select 
format_date("%Y-%n",current_date)as month,
format_date("%R",current_timestamp)as horario,


SELECT
    COUNT(id) AS usuarios,
    FORMAT_TIMESTAMP("%Y-%m", created_at) AS mes_cadastro
FROM bigquery-public-data.thelook_ecommerce.users
GROUP BY mes_cadastro
ORDER BY mes_cadastro ASC;



#MODULO EXTRA 

#union all 
select  
id,
first_name,
last_name
from cursos-401615.ecommerce.customers
where id between 1 and 5

union all
select
id, 
first_name,
last_name
from ecommerce.customers
where id between 4 and 6
order by id


#union distinct 
select  
id,
first_name,
last_name
from cursos-401615.ecommerce.customers
where id between 1 and 5

union distinct
select
id, 
first_name,
last_name


#usando comando with 

WITH tabela1 AS (
  SELECT 
    COUNT(DISTINCT customer_id) AS compradores,
    DATE(created_at) AS dias 
  FROM ecommerce.orders
  GROUP BY 2
),

tabela2 AS (
  SELECT
    COUNT(DISTINCT customer_id) AS compras,
    DATE(created_at) AS dias
  FROM ecommerce.orders
  GROUP BY 2
)

SELECT 
  a.compradores,
  b.compras,
  a.dias
FROM tabela1 a
JOIN tabela2 b ON a.dias = b.dias
WHERE a.dias BETWEEN "2020-01-01" AND "2020-01-31"
ORDER BY a.dias ASC;


#comando de DDL 
#create table  comando replace subtistue a tabela atual 

create table ecommerce.teste(
  id integer ,
  idade integer,
  nome string
);

create or replace table ecommerce.teste(
  id integer ,
  idade integer,
  nome string
);

#comando drop exclui tabela 
drop table ecommerce.teste;


#create table com consulta para criar tabela 
create table ecommerce.teste as (
  select
  count(distinct id)as pedidos,
  date(created_at)as dia,
  from ecommerce.orders
  group by 2
  order by 1 asc
);

