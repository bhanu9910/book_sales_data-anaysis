

-- Create Tables
DROP TABLE IF EXISTS Books;
CREATE TABLE Books (
    Book_ID SERIAL PRIMARY KEY,
    Title VARCHAR(100),
    Author VARCHAR(100),
    Genre VARCHAR(50),
    Published_Year INT,
    Price NUMERIC(10, 2),
    Stock INT
);
DROP TABLE IF EXISTS customers;
CREATE TABLE Customers (
    Customer_ID SERIAL PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(100),
    Phone VARCHAR(15),
    City VARCHAR(50),
    Country VARCHAR(150)
);
DROP TABLE IF EXISTS orders;
CREATE TABLE Orders (
    Order_ID SERIAL PRIMARY KEY,
    Customer_ID INT REFERENCES Customers(Customer_ID),
    Book_ID INT REFERENCES Books(Book_ID),
    Order_Date DATE,
    Quantity INT,
    Total_Amount NUMERIC(10, 2)
);

SELECT * FROM Books;
SELECT * FROM Customers;
SELECT * FROM Orders;

-- 1) Retrieve all books in the "Fiction" genre:
select *from Books 
where genre='Fiction'

----- 2) Find books published after the year 1950:
select *from Books 
where published_year>1950;


--- 3) List all customers from the Canada:
SELECT * FROM Customers 
WHERE country='Canada';


-- 4) Show orders placed in November 2023:

SELECT * FROM Orders 
WHERE order_date BETWEEN '2023-11-01' AND '2023-11-30';

---

-- 5) Retrieve the total stock of books available:

SELECT SUM(stock) AS Total_Stock
From Books;


-- 6) Find the details of the most expensive book:
SELECT * FROM Books 
ORDER BY Price DESC 
LIMIT 1;


-- 7) Show all customers who ordered more than 1 quantity of a book:
SELECT * FROM Orders 
WHERE quantity>1;



-- 8) Retrieve all orders where the total amount exceeds $20:
SELECT * FROM Orders 
WHERE total_amount>20;



-- 9) List all genres available in the Books table:
SELECT DISTINCT genre FROM Books;


-- 10) Find the book with the lowest stock:
SELECT * FROM Books 
ORDER BY stock 
LIMIT 1;


-- 11) Calculate the total revenue generated from all orders:
SELECT SUM(total_amount) As Revenue 
FROM Orders;


select*from orders
select*from books

----Retrieve the total number of books sold for each genre:
select b.genre,count(o.quantity)
from books b
inner join orders o
on b.book_id=o.book_id
group by b.genre

------ 2) Find the average price of books in the "Fantasy" genre:
select genre,avg(price)
from books
group by genre
having genre='Fantasy'

SELECT AVG(price) AS Average_Price
FROM Books
WHERE Genre = 'Fantasy';

----- 3) List customers who have placed at least 2 orders:
select c.name,count(o.customer_id) as order_count
from customers c
inner join orders o
on c.customer_id=o.customer_id
group by c.name
having count(o.customer_id)>=2

----- 4) Find the most frequently ordered book:
SELECT o.Book_id, b.title, COUNT(o.order_id) AS ORDER_COUNT
FROM orders o
JOIN books b ON o.book_id=b.book_id
GROUP BY o.book_id, b.title
ORDER BY ORDER_COUNT DESC LIMIT 1;

----- 5) Show the top 3 most expensive books of 'Fantasy' Genre :
SELECT title,price
FROM Books
WHERE Genre = 'Fantasy'
order by price desc
limit 3;

---Retrieve the total quantity of books sold by each author:
select*from books

select b.author,count(o.quantity) as book_quantity
from books b
inner join orders o
on b.book_id=o.book_id
group by b.author
order by book_quantity desc

----List the cities where customers who spent over $30 are located:

SELECT DISTINCT c.city, o.total_amount
FROM orders o
JOIN customers c 
ON o.customer_id=c.customer_id
WHERE o.total_amount > 30;

--- Find the customer who spent the most on orders:
select*from orders

SELECT c.name,sum(total_amount) as total_amount
FROM orders o
JOIN customers c 
ON o.customer_id=c.customer_id
group by c.name
order by total_amount desc limit 1

----Calculate the stock remaining after fulfilling all orders:

SELECT b.book_id, b.title, b.stock, COALESCE(SUM(o.quantity),0) AS Order_quantity,  
	b.stock- COALESCE(SUM(o.quantity),0) AS Remaining_Quantity
FROM books b
LEFT JOIN orders o ON b.book_id=o.book_id
GROUP BY b.book_id ORDER BY b.book_id;







