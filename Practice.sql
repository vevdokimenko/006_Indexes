# Для созданной ранее базы данных Издательства реализовать следующие запросы:
USE Publishing;

# 1.Создайте кластеризованный индекс по имени автора для таблицы Authors.
CREATE INDEX FirstName ON Authors (FirstName);

# 2.Создайте кластеризованный составной индекс, содержащий цену и название каждой книги.
CREATE INDEX PriceNameBook ON Books (Price, NameBook);

# 3.Создайте представление, в котором выберите из таблицы продажи все книг, стоимостью больше 55 грн.
CREATE VIEW SalesOver55 AS
SELECT NameBook, B.Price
FROM Sales
         JOIN Books B ON B.ID_BOOK = Sales.ID_BOOK
WHERE B.Price > 55;

SELECT *
FROM SalesOver55;

# 4.Для таблицы «Авторы» отключить кластеризированный индекс. Проверить возможность выбора данных из таблицы.
# Подключить обратно индекс.
DROP INDEX FirstName ON Authors;

EXPLAIN
SELECT *
FROM Authors;

CREATE INDEX FirstName ON Authors (FirstName);

# 5.Написать представление, которое будет отображать информацию о книгах, которые имели тираж более 10 экземпляров.
CREATE VIEW BooksWithDrawing10 AS
SELECT NameBook, DrawingOfBook
FROM Books
WHERE DrawingOfBook > 10;

SELECT *
FROM BooksWithDrawing10;

# 6. Написать представление, которое содержит информацию о суммах, на которые были проданы книги каждым магазином за последний месяц.
CREATE VIEW SalesByShops AS
SELECT SUM(Price * Quantity), NameShop
FROM Sales
         JOIN Shops S ON S.ID_SHOP = Sales.ID_SHOP
GROUP BY NameShop;

SELECT *
FROM SalesByShops;

# 7. Показать на экран среднее количество страниц по каждой из тематик,
# при этом показать только тематики, в которых среднее количество более 400.
CREATE VIEW AvgPagesInThemes AS
SELECT AVG(Pages), NameTheme
FROM Books
         JOIN Themes T ON T.ID_THEME = Books.ID_THEME
GROUP BY NameTheme;

SELECT *
FROM AvgPagesInThemes;