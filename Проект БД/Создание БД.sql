-- Файл с командами для создания БД, таблиц, представлений.

drop database IF EXISTS `auction_of_items`;

create database `auction_of_items`;

use `auction_of_items`;

-- Создание таблиц и заполнение их данными ---

CREATE TABLE IF NOT EXISTS `Creators` (
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

CREATE TABLE IF NOT EXISTS `Types` (
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

CREATE TABLE IF NOT EXISTS `Statuses` (
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

CREATE TABLE IF NOT EXISTS `Storages` (
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

CREATE TABLE IF NOT EXISTS `Organizers` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(30) NOT NULL,
  `email` VARCHAR(25) NOT NULL,
  `phone` VARCHAR(11) NOT NULL,
  `main_address` VARCHAR(45) NOT NULL,

  PRIMARY KEY(`id`)
);

INSERT INTO `Organizers` (`name`, `email`, `phone`, `main_address`) VALUES
('Петрович', 'petrov_em@gmail.com', '89145552355', 'Севастопольская, 13'),
('Шишкин П.Н.', 'shishka_em@gmail.com', '89145436355', 'Ильинская, 13'),
('ООО РУС-ВЫСТАВКА', 'rus_view@gmail.com', '332-126', 'Зимняя, 13');

CREATE TABLE IF NOT EXISTS `Exhibitions` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(30) NOT NULL,
  `date` DATE,
  `address` VARCHAR(30),
  `organizer_id` INT(10) UNSIGNED,

  PRIMARY KEY(`id`),

  FOREIGN KEY (organizer_id) REFERENCES Organizers(id) ON DELETE CASCADE
);

INSERT INTO `Exhibitions` (`name`, `date`, `address`, `organizer_id`) VALUES
('нет', NULL, NULL, NULL),
('Музей оружия', '2022-06-04', 'Марианская, 11', 1),
('Музей Ruby', '2022-06-24', 'Ленина, 223', 2),
('Несуществующий музей Фокус', '2022-06-05', 'Илюзоная, 37', 1),
('Музей странного исскуства', '2023-04-01', 'Реальная, 44', 3);

CREATE TABLE IF NOT EXISTS `Items` (
	`id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
	`name` VARCHAR(80) NOT NULL,
	`release_year` INT(4) DEFAULT NULL,
	`creator_id` INT(10) UNSIGNED NOT NULL,
	`type_id` INT(10) UNSIGNED NOT NULL,
	`status_id` INT(10) UNSIGNED NOT NULL,
	`storage_id` INT(10) UNSIGNED NOT NULL,
	`exhibition_id` INT(10) UNSIGNED DEFAULT NULL,
	`initial_price` DECIMAL(12,3) NOT NULL,

	PRIMARY KEY(`id`),

	FOREIGN KEY (creator_id) REFERENCES Creators(id) ON DELETE CASCADE,
	FOREIGN KEY (type_id) REFERENCES Types(id) ON DELETE CASCADE,
	FOREIGN KEY (status_id) REFERENCES Statuses(id) ON DELETE CASCADE,
	FOREIGN KEY (storage_id) REFERENCES Storages(id) ON DELETE CASCADE,
	FOREIGN KEY (exhibition_id) REFERENCES Exhibitions(id) ON DELETE CASCADE
);

INSERT INTO `Items` (`name`, `release_year`, `creator_id`, `type_id`, `status_id`, `storage_id`, `exhibition_id`, `initial_price`) VALUES
('Yamaha r1', 1998, 6, 20, 1, 1, 3, 1980000),
('Клавиатура Бога', 2002, 3, 23, 3, 5, 1, 48000),
('Крест', 1253, 4, 2, 6, 4, 5, 1987500),
('ИС-4', 1944, 10, 19, 1, 2, 2, 299250000),
('Герника', 1937, 8, 3, 2, 1, 4, 5950000),
('Лаврентьевская летопись', 1377, 9, 16, 4, 1, 5, 925000000),
('Сон, вызванный полётом пчелы вокруг граната, за секунду до пробуждения', 2008, 11, 3, 5, 5, 3, 3980000),
('Война и мир', 1958, 5, 6, 3, 3, 1, 98000);

CREATE  TABLE IF NOT EXISTS `Positions` (
	`id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
	`name` VARCHAR(40) NOT NULL,

	PRIMARY KEY(`id`)
);

INSERT INTO `Positions` (`name`) VALUES
('Генеральный директор'),
('Заместитель генерального директора'),
('Водитель'),
('Секретарь'),
('Повар'),
('Слесарь'),
('Менеджер по закупкам'),
('Секретарь'),
('Менеджер по продажам'),
('Маркетолог'),
('Дежурный по складу'),
('Охранник'),
('Стажёр');

CREATE  TABLE IF NOT EXISTS `Employees` (
	`id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
	`name` VARCHAR(30) NOT NULL,
	`surname` VARCHAR(30) NOT NULL,
	`patronymic` VARCHAR(30) NOT NULL,
	`position_id` INT(10) UNSIGNED NOT NULL,
	`salary` DECIMAL(8, 2) NOT NULL,
	`dbirth` DATE,

	PRIMARY KEY(`id`),

	FOREIGN KEY (position_id) REFERENCES Positions(id) ON DELETE CASCADE
);

INSERT INTO `Employees` (`name`, `surname`, `Patronymic`, `position_id`, `salary`, `dbirth`) VALUES
('Стас', 'Михайло', 'Николаевич', 1, 190000, '1972-11-29'),
('Марина', 'Лебедева', 'Сергеевна', 2, 110000, '1976-06-09'),
('Валерий', 'Зайцев', 'Николаевич', 3, 90000, '2002-01-26'),
('Аркадий', 'Морозов', 'Иванович', 4, 48000, '1981-03-22'),
('Гарри', 'Поттер', 'Владимирович', 5, 73000, '1991-11-29'),
('Глеб', 'Соловьёв', 'Ильич', 6, 34000, '2000-08-17'),
('Илья', 'Попов', 'Гавриилович', 7, 98000, '1999-09-08'),
('Клара', 'Козлова', 'Петровна', 8, 22800, '1995-08-12'),
('Кристина', 'Васильева', 'Васильевна', 9, 65000, '2001-11-12'),
('Михаил', 'Волков', 'Андреевич', 10, 88000, '1983-12-20'),
('Лариса', 'Семёновна', 'Михайловна', 11, 65000, '1986-04-06'),
('Патрик', 'Иванов', 'Сергеевич', 12, 55000, '1990-05-16');

-- Создание представлений ---

-- Информация о товаре
DROP VIEW IF EXISTS view_total_info;
CREATE VIEW view_total_info
AS
SELECT i.id, i.name, i.release_year, CONCAT_WS(' ', cr.name, cr.initials) AS creator, t.name AS type, status.name AS status, storage.name AS storage, exhibition.name AS exhibition, i.initial_price
FROM `Items` AS i
JOIN `creators` AS cr ON i.creator_id = cr.id
JOIN `types` AS t ON i.type_id = t.id
JOIN `statuses` AS status ON i.status_id = status.id
JOIN `storages` AS storage ON i.storage_id = storage.id
JOIN `Exhibitions` AS exhibition ON i.exhibition_id = exhibition.id
ORDER BY i.id;

--  Информация о персонале
DROP VIEW IF EXISTS view_employees_info;
CREATE VIEW view_employees_info
AS
SELECT e.id as id, CONCAT_WS(' ', e.name, e.`surname`, e.`patronymic`) AS full_name, p.name AS position, e.salary AS salary, e.dbirth AS dbirth
FROM `Employees` AS e
JOIN `Positions` AS p ON e.position_id = p.id;

--  Информация о выставках
DROP VIEW IF EXISTS view_exhibitions_info;
CREATE VIEW view_exhibitions_info
AS
SELECT ex.name as name, ex.address AS address, date_format(ex.date, '%d %M %Y') AS date, org.name AS organizer
FROM `Exhibitions` AS ex
JOIN `Organizers` AS org ON ex.organizer_id = org.id;

--  Информация о товаре, который будет на выставках
DROP VIEW IF EXISTS view_items_with_exhibition;
CREATE VIEW view_items_with_exhibition
AS
SELECT i.id, i.name, CONCAT_WS(' ', cr.name, cr.initials) AS creator, t.name AS type, storage.name AS storage, exhibition.name AS exhibition, i.initial_price
FROM `Items` AS i
JOIN `creators` AS cr ON i.creator_id = cr.id
JOIN `types` AS t ON i.type_id = t.id
JOIN `storages` AS storage ON i.storage_id = storage.id
JOIN `Exhibitions` AS exhibition ON i.exhibition_id = exhibition.id
WHERE i.exhibition_id > 1;

--  Информация о товаре, который не будет на выставках
DROP VIEW IF EXISTS view_items_without_exhibition;
CREATE VIEW view_items_without_exhibition
AS
SELECT i.id, i.name, CONCAT_WS(' ', cr.name, cr.initials) AS creator, t.name AS type, storage.name AS storage, exhibition.name AS exhibition, i.initial_price
FROM `Items` AS i
JOIN `creators` AS cr ON i.creator_id = cr.id
JOIN `types` AS t ON i.type_id = t.id
JOIN `storages` AS storage ON i.storage_id = storage.id
JOIN `Exhibitions` AS exhibition ON i.exhibition_id = exhibition.id
WHERE i.exhibition_id = 1;

--  Информация о товарах, у которых выставки уже прошли
DROP VIEW IF EXISTS view_items_exhibition_completed;
CREATE VIEW view_items_exhibition_completed
AS
SELECT i.id, i.name AS item, e.name AS exhibition, e.date
FROM items AS i
JOIN exhibitions AS e ON e.id = i.exhibition_id
WHERE e.date < NOW();
