-- mysql -ur1 -hlocalhost -p

--  drop database `auction_of_items`;

create database `auction_of_items`;

use `auction_of_items`;

--- Создание таблиц и заполнение их данными ---

CREATE TABLE `Creators` (
	`id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
	`name` VARCHAR(50) NOT NULL,
	`initials` VARCHAR(30) DEFAULT NULL,

	PRIMARY KEY(`id`)
);

INSERT INTO `Creators` (`name`, `initials`) VALUES
('Ушаков', 'А.А.'),
('Дмитриев', 'А.Г.'),
('Иванов', 'Д.А.'),
('Достоевский', 'Ф.М.'),
('Толстой', 'Л.Н.'),
('Yamaha motors', NULL),
('Крылов', 'И.А.'),
('Пабло Пикассо', NULL),
('Монарх Лаврентий', NULL),
('Челябинский Кировский завод', NULL),
('Сальвадор Дали', NULL),
('Цой', 'В.Р.');

CREATE TABLE `Types` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(30) NOT NULL,
  PRIMARY KEY(`id`)
);

INSERT INTO `Types` (`name`) VALUES
('Бюст'),
('Статуэтка'),
('Живопись'),
('Фотография'),
('Комикс'),
('Книга'),
('Кино'),
('Брелок'),
('Письмо'),
('Монета'),
('Музыка'),
('Пленка'),
('Негатив на стекле'),
('Диапозитив на стекле'),
('Документ'),
('Летопись'),
('Хроника'),
('Автомобиль'),
('Танк'),
('Мотоцикл'),
('Восковая фигура'),
('Прибор'),
('Механизм'),
('Миниатюра'),
('Мозаика'),
('Магнитная лента'),
('Винил'),
('Граффити');

CREATE TABLE `Statuses` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(30) NOT NULL,
  PRIMARY KEY(`id`)
);

INSERT INTO `Statuses` (`name`) VALUES
('Прямо с завода'),
('Потёртости на упаковке'),
('Небольшие потёртости'),
('Потёртости, трещины'),
('Нуждается в реставрации'),
('Не подлежит восстановлению');

CREATE TABLE `Storages` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(30) NOT NULL,
  `address` VARCHAR(30) NOT NULL,
  PRIMARY KEY(`id`)
);

INSERT INTO `Storages` (`name`, `address`) VALUES
('Главный склад', 'Марианская, 153'),
('Запасной склад', 'Чернобыльская АЭС, блок 4'),
('Удалённый склад', 'Ленина, 33'),
('Центральный склад', 'Советская, 298'),
('Тяжёлый склад', 'Июльская, 87');

CREATE TABLE `Items` (
	`id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
	`name` VARCHAR(80) NOT NULL,
	`release_year` INT(4) DEFAULT NULL,
	`creator_id` INT(10) UNSIGNED NOT NULL,
	`type_id` INT(10) UNSIGNED NOT NULL,
	`status_id` INT(10) UNSIGNED NOT NULL,
	`storage_id` INT(10) UNSIGNED NOT NULL,
	`initial_price` DECIMAL(12,3) NOT NULL,

	PRIMARY KEY(`id`),

	FOREIGN KEY (creator_id) REFERENCES Creators(id) ON DELETE CASCADE,
	FOREIGN KEY (type_id) REFERENCES Types(id) ON DELETE CASCADE,
	FOREIGN KEY (status_id) REFERENCES Statuses(id) ON DELETE CASCADE,
	FOREIGN KEY (storage_id) REFERENCES Storages(id) ON DELETE CASCADE
);

INSERT INTO `Items` (`name`, `release_year`, `creator_id`, `type_id`, `status_id`, `storage_id`, `initial_price`) VALUES
('Yamaha r1', 1998, 6, 20, 1, 1, 1980000),
('Клавиатура Бога', 2002, 3, 23, 3, 5, 48000),
('Крест', 1253, 4, 2, 6, 4, 1987500),
('ИС-4', 1944, 10, 19, 1, 2, 299250000),
('Герника', 1937, 8, 3, 2, 1, 5950000),
('Лаврентьевская летопись', 1377, 9, 16, 4, 1, 925000000),
('Сон, вызванный полётом пчелы вокруг граната, за секунду до пробуждения', 2008, 11, 3, 5, 5, 3980000),
('Война и мир', 1958, 5, 6, 3, 3, 98000);



DROP VIEW IF EXISTS total_info;
CREATE VIEW total_info
AS
SELECT i.id, i.name, i.release_year, CONCAT_WS(' ', cr.name, cr.initials) AS creator, t.name AS type, status.name AS status, storage.name AS storage, i.initial_price
FROM `Items` AS i
JOIN `creators` AS cr ON i.id = cr.id
JOIN `types` AS t ON i.id = t.id
JOIN `statuses` AS status ON i.id = status.id
JOIN `storages` AS storage ON i.id = storage.id;
