1-) Utilize o dataset público “thelook_ecommerce”, que está presente no projeto 
“bigquery-public-data” para trazer o identificador único dos usuários, o primeiro 
nome, email e idade, ordernados pela data de criação do cadastro. 

# resolvendo execicios exibindo as colunas de forma crescente 
select 
first_name, 
email, 
age,
created_at
from bigquery-public-data.thelook_ecommerce.users
order by created_at asc;




2) No mesmo dataset do exercício anterior, extraia os pedidos que tenham status 
“Shipped” ou “Processing”. 

#processando por comando shipped e processing
select 
status
from bigquery-public-data.thelook_ecommerce.order_items
where (status = "Shipped" or  status= "Processing")and status is not null;


3) Considerando o mesmo exercício anterior, traga os pedidos que sejam foram 
criados no dia “2022-04-05” e, ao mesmo tempo, tenham status “Cancelled”. 

#processando status canceled 
select 
status
from bigquery-public-data.thelook_ecommerce.order_items
where (status = "Cancelled")and status is not null;


4) O time de marketing deseja fazer uma campanha em um país específico, com o 
mesmo dataset dos itens anteriores. Para isso, eles te pedem os e-mails de todos 
os clientes que moram no Brasil. 

#usuarios do brasil 
select 
country,
last_name,
age,
email
from bigquery-public-data.thelook_ecommerce.users
where (country ="Brasil") and country is not null;


5) No mesmo dataset anterior, traga o nome dos usuários e o id de seus pedidos. 

select 
usuario_id.id,
usuario_id.first_name, 
produto_id.product_id,
produto_id.status
from bigquery-public-data.thelook_ecommerce.order_items as produto_id
join bigquery-public-data.thelook_ecommerce.users as usuario_id on produto_id.product_id = usuario_id.id
group by 1,2,3,4
order by id asc;






6) Vá ao dataset público “baseball” e na tabela “schedules” traga os identificadores 
únicos, o nome do time da casa e o nome do time de fora de casa dos jogos em 
que a duração foi maior ou igual a 250 minutos e menos de 25 mil espectadores. 


# selecionando partidas acima de 250 minutos com os times da casa 
SELECT
  homeTeamName,
  gameId,
  duration_minutes,
  attendance,
FROM bigquery-public-data.baseball.schedules
WHERE duration_minutes > 250
GROUP BY 1, 2, 3, 4
order by homeTeamName asc;







7) No mesmo dataset e tabela, retorne os jogos que começaram entre maio e junho 
de 2016. 


SELECT
  homeTeamName,
  gameId,
  duration_minutes,
  attendance,
  startTime
FROM bigquery-public-data.baseball.schedules
WHERE EXTRACT(MONTH FROM startTime) IN (05 , 06)
order by startTime asc;



8) DESAFIO: No mesmo dataset anterior, descubra o nome dos times que tenham 
somente 6 caracteres, usando o like. Retorne de forma única. 

SELECT
  homeTeamName
FROM bigquery-public-data.baseball.schedules
WHERE homeTeamName LIKE '______';


