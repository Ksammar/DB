-- диапазон дат рождения, где и на какие суммы покупки
SELECT 
ui.name,
birthday,
timestampdiff(year,birthday,NOW()) AS age ,
m.order,
m.price,
c.name as company
 FROM markets m
 join user_info ui on m.users_id_account = ui.id
 join company c on m.company_id = c.id
 WHERE timestampdiff(year,birthday,NOW()) <30 and m.price > 10000 and m.price < 99999
ORDER BY age DESC
