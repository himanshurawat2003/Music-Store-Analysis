 SELECT * FROM invoice

-- Who is Most senior employee based on the title ?

SELECT TOP(1) * FROM dbo.employee
ORDER BY levels desc ;
 
-- Which Countries Have the most employees ?

SELECT billing_country ,count(*) as Invoice_Count from dbo.invoice
GROUP BY billing_country
ORDER BY Invoice_Count desc;

-- What are Top 3 Values of total Invoice

SELECT top (3) total from DBO.invoice
ORDER BY total desc;

-- Write a Query that returns one city that returns the highest sum of invoice totals.Return both the City name And sum of all Invoice Totals 

SELECT TOP(1) billing_city as City_name , sum(total) as Total
FROM Dbo.invoice
GROUP BY billing_city
ORDER BY Total desc;


-- Write a Query that returns the person who spents the Most Money

SELECT TOP (1) C.customer_id, C.first_name as First_Name , C.last_name as Last_Name , Sum(I.total) as Money_Spent
FROM dbo.customer as C
JOIN dbo.invoice as I on C.customer_id = I.customer_id
GROUP BY C.first_name , C.last_name , C.customer_id
ORDER BY Money_Spent desc;

SELECT *  from dbo.customer 
WHERE customer_id = 5