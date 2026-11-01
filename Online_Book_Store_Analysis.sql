Online BOOK Store Analysis

CREATE TABLE Books (
	Book_ID SERIAL PRIMARY KEY,
	Title VARCHAR(100),
	Author VARCHAR(100),
	Genre VARCHAR(50),
	Published_Year INT,
	Price NUMERIC (10,2),
	Stock INT
);

CREATE TABLE Customers (
	Customer_ID SERIAL PRIMARY KEY,
	Name VARCHAR(100),
	Email VARCHAR(100),
	Phone VARCHAR(15),
	City  VARCHAR(50),
	Country VARCHAR(150)
);

CREATE TABLE Orders (
	Order_ID SERIAL PRIMARY KEY,
	Customer_ID INT REFERENCES Customers(Customer_ID),
	Book_ID INT  REFERENCES Books (Book_ID),
	Order_Date Date,
	Quantity INT,
	Total_Amount NUMERIC (10,2)
);

select * from Books,
select * from Customers,
select * from Orders

					#BASIC QUESTIONS:

--Q1: Retrieve all books in the "Fiction" genre

select * from books
where genre = 'Fiction';


--Q2: Find books published after the year 1950

select * from books
where published_year > 1950;


--Q3: List all the customers from canada

select * from customers
where country = 'Canada';

--Q4: show orders placed in november 2023

select * from orders
where order_date BETWEEN '2023-11-01' and '2023-11-30';

--Q5: Retrieve the total stock of books available 

select 
sum (stock) as total_stock ;

--Q6: Find the details of the most expensive book

select * from books
order by price desc
limit 1;

--Q7: Show all customers who ordered more than 1 quantity of a book

select * from orders
where quantity > 1;


--Q8: Retrieve all orders where the total amount exceeds $20

select * from orders
where total_amount > 20;

--Q9: List all the genres available in the books table

select distinct genre from books;


--Q10: Find the book with the lowest stock

select * from books
order by stock asc;

--Q11: Calculate the total revenue generated from all orders

select sum (total_amount) from orders;


					#ADVANCE QUERIES:

--Q1: Retrieve the total number of books sold for each genre

select b.genre, sum (o.quantity) as total_number from books b
join orders o
on b.book_id = o.book_id
group by b.genre;


--Q2: Find the average price of books in the 'Fantasy' genre

select avg(price) as avg_price from books
where genre = 'Fantasy';


--Q3: List customers who have placed atleast 2 orders


select c.customer_id, c.name, count (o.order_id) as order_count
from orders o
join customers c
on o.customer_id = c.customer_id
group by c.customer_id,c.name
having count(o.order_id) >=2;

--Q4: Find the most frequently ordere book

select o.book_id, b.title, count(o.order_id) as order_count
from orders o
join books b
on o.book_id = b.book_id
group by o.book_id, b.title
order by order_count desc 
limit 1;

--Q5: show the top 3 most expensive books of 'Fantasy' genre

select title, genre, price from books
where genre = 'Fantasy'
order by price desc
limit 3;

--Q6: Retrieve the total quantity of books sold by each author

select b.author, sum (o.quantity) as total_books from books b
join orders o 
on b.book_id= o.book_id
group by b.author;


--Q7: List the cities where customers who spent over $30 dollar are located

select distinct (c.city), o.total_amount
from customers c
join orders o
on c.customer_id = o.customer_id
where o.total_amount >30;

--Q8: Find the customers who spent most on the orders 

select c.customer_id, c.name, sum(o.total_amount) as total_spent from customers c
join orders o
on c.customer_id = o.customer_id
group by c.customer_id, c.name
order by total_spent desc;


--Q9: Calculate the stock reamaining after fulfilling all orders

select b.book_id, b.title,b.stock, coalesce (sum(o.quantity),0) as order_quantity,
b.stock - coalesce (sum(o.quantity),0) as remaining_quantity 
from books b
left join orders o
on b.book_id= o.book_id
group by b.book_id;

