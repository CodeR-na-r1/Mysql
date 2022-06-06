-- ------------------ Изменение таблиц ------------------

-- Просмотр таблицы с экспонатами
SELECT * FROM `items`;

-- Удаление экспоната по id
DELETE FROM `items` AS i WHERE i.id = 2 LIMIT 1;

-- Изменение цены экспоната по id
UPDATE `items` AS i SET initial_price = 2495000 WHERE i.id = 1 LIMIT 1;

-- Удаление прошедших выставок у экспонатов
UPDATE `items` AS i SET exhibition_id = 1
WHERE i.id IN (
(SELECT id
FROM
(SELECT i.id, e.date FROM `items` AS i JOIN `exhibitions` AS e ON e.id = i.exhibition_id) AS inner_t
WHERE date < NOW())
);

-- Удаление сотрудника по id
DELETE FROM `Employees` AS e WHERE e.id = 1 LIMIT 1;

-- Изменение зарплаты сотрудника по id
UPDATE `Employees` AS e SET salary = 108000.8 WHERE e.id = 2 LIMIT 1;

-- Удаление автора экспоната по id
DELETE FROM `creators` AS с WHERE с.id = 1 LIMIT 1;

-- Изменение имени автора экспоната по id
UPDATE `creators` AS с SET name = 'Матроскин' WHERE с.id = 2 LIMIT 1;

-- ------------------ Удаление таблиц ------------------

-- Удаление основной таблицы
DROP TABLE IF EXISTS `items`;

-- Удаление связанных с основной таблицей таблиц
DROP TABLE IF EXISTS `creators`;
DROP TABLE IF EXISTS `types`;
DROP TABLE IF EXISTS `statuses`;
DROP TABLE IF EXISTS `storages`;
DROP TABLE IF EXISTS `exhibitions`;

-- Удаление основной таблицы с персоналом
DROP TABLE IF EXISTS `employees`;

-- Удаление связанных с основной таблицей персонала таблиц
DROP TABLE IF EXISTS `positions`;

-- Удаление таблицы с организаторами выставок
DROP TABLE IF EXISTS `organizers`;

-- Удаление представлений
DROP VIEW IF EXISTS view_total_info;
DROP VIEW IF EXISTS view_employees_info;
DROP VIEW IF EXISTS view_exhibitions_info;
DROP VIEW IF EXISTS view_items_with_exhibition;
DROP VIEW IF EXISTS view_items_without_exhibition;

-- Удаление базы данных
drop database IF EXISTS `auction_of_items`;
