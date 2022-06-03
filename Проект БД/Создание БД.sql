-- mysql -ur1 -hlocalhost -p

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
  `date` DATE NOT NULL,
  `address` VARCHAR(30) NOT NULL,
  `organizer_id` INT(10) UNSIGNED NOT NULL,

  PRIMARY KEY(`id`),

  FOREIGN KEY (organizer_id) REFERENCES Organizers(id) ON DELETE CASCADE
);

INSERT INTO `Exhibitions` (`name`, `date`, `address`, `organizer_id`) VALUES
('Музей оружия', '4.06.2022', 'Марианская, 11', 1),
('Музей Ruby', '24.06.2022', 'Ленина, 223', 2),
('Несуществующий музей Фокус', '5.06.2022', 'Илюзоная, 37', 1),
('Музей странного исскуства', '1.04.2023', 'Реальная, 44', 3);

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
('Yamaha r1', 1998, 6, 20, 1, 1, 2, 1980000),
('Клавиатура Бога', 2002, 3, 23, 3, 5, NULL, 48000),
('Крест', 1253, 4, 2, 6, 4, 4, 1987500),
('ИС-4', 1944, 10, 19, 1, 2, 1, 299250000),
('Герника', 1937, 8, 3, 2, 1, 3, 5950000),
('Лаврентьевская летопись', 1377, 9, 16, 4, 1, 4, 925000000),
('Сон, вызванный полётом пчелы вокруг граната, за секунду до пробуждения', 2008, 11, 3, 5, 5, 2, 3980000),
('Война и мир', 1958, 5, 6, 3, 3, NULL, 98000);

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
DROP VIEW IF EXISTS total_info;
CREATE VIEW total_info
AS
SELECT i.id, i.name, i.release_year, CONCAT_WS(' ', cr.name, cr.initials) AS creator, t.name AS type, status.name AS status, storage.name AS storage, i.initial_price
FROM `Items` AS i
JOIN `creators` AS cr ON i.id = cr.id
JOIN `types` AS t ON i.id = t.id
JOIN `statuses` AS status ON i.id = status.id
JOIN `storages` AS storage ON i.id = storage.id;

--  Информация о персонале
DROP VIEW IF EXISTS employees_info;
CREATE VIEW employees_info
AS
SELECT CONCAT_WS(' ', e.name, e.`surname`, e.`patronymic`) AS full_name, p.name AS position, e.salary AS salary, e.dbirth AS dbirth
FROM `Employees` AS e
JOIN `Positions` AS p ON e.position_id = p.id;

-- 