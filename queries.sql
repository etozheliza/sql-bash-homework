- Пользователи без заказов
SELECT u.*
FROM Users u
LEFT JOIN Orders o ON u.user_id = o.user_id
WHERE o.user_id IS NULL;

- Пользователи с заказами, но без товаров
SELECT DISTINCT u.*
FROM Users u
JOIN Orders o ON u.user_id = o.user_id
LEFT JOIN Order_Products op ON o.order_id = op.order_id
WHERE op.order_id IS NULL;

- Топ-3 пользователей по сумме заказов
SELECT user_id,
       SUM(amount) AS total_amount
FROM Orders
GROUP BY user_id
ORDER BY total_amount DESC
LIMIT 3;

- Все комбинации Users × Products
SELECT *
FROM Users
CROSS JOIN Products;

- Пользователи с суммой заказов выше средней
SELECT user_id
FROM Orders
GROUP BY user_id
HAVING SUM(amount) >
(
    SELECT AVG(user_total)
    FROM
    (
        SELECT SUM(amount) AS user_total
        FROM Orders
        GROUP BY user_id
    ) t
);

- Пользователи, у которых все заказы больше 1000
SELECT user_id
FROM Orders
GROUP BY user_id
HAVING MIN(amount) > 1000;

- Пользователи из Users, отсутствующие в Orders
SELECT user_id
FROM Users
EXCEPT
SELECT user_id
FROM Orders;

- Объединение без дубликатов
SELECT user_id FROM Users
UNION
SELECT user_id FROM Orders;

- Объединение с дубликатами
SELECT user_id FROM Users
UNION ALL
SELECT user_id FROM Orders;

- Транзакция
BEGIN;

UPDATE accounts
SET balance = balance - 100
WHERE id = 1;

COMMIT;