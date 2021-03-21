SELECT 
(select name from user_info where markets.users_id_account = user_info.id ) as name,
COUNT(users_id_account) as number_of_purchases,
SUM(price)
 FROM ecobank.markets
 group by users_id_account
ORDER BY name