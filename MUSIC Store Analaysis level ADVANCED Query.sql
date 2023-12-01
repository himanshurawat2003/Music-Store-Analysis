-- 1. Find how much amount Spent by each customer on Arists . Write a Query that returns customer name , artist name , total spent .

WITH cte AS (
				SELECT TOP(10) dbo.artist.artist_id AS Artist_ID ,dbo.artist.name AS Artist_Name ,
				SUM(dbo.invoice_line.unit_price * dbo.invoice_line.quantity) AS Total_Sales
				FROM dbo.invoice_line 
				Join dbo.track on dbo.track.track_id = dbo.invoice_line.track_id
				Join dbo.album on dbo.album.album_id = dbo.track.album_id
				Join dbo.artist on dbo.artist.artist_id = dbo.album.artist_id
				GROUP BY dbo.artist.artist_id , dbo.artist.name
				ORDER BY 3 DESC
				
)
SELECT c.first_name as Customer_Name , c.last_name as Surname , cte.Artist_Name ,
SUM (il.unit_price * il.quantity) AS Money_Spent
FROM dbo.customer AS c
JOIN dbo.invoice as i ON i.customer_id = c.customer_id
JOIN dbo.invoice_line as il ON il.invoice_id = i.invoice_id
JOIN dbo.track as t ON t.track_id = il.track_id
JOIN dbo.album as a ON a.album_id = t.album_id
JOIN cte ON cte.Artist_ID = a.artist_id
GROUP BY c.first_name , c.last_name , cte.Artist_Name
ORDER BY 4 DESC


-- 2. Find out the Most popular music genre for each Country determines by the highest amount of purchases .
--    write a query that returns each country along with Top Genre .

WITH cte AS (
				SELECT i.billing_country AS Country , g.name AS Genre , COUNT(il.quantity) AS Purchases 
				,ROW_NUMBER() OVER (PARTITION BY i.billing_country ORDER BY COUNT(il.quantity)DESC) as RN
				FROM dbo.invoice AS i
				JOIN dbo.invoice_line AS il ON il.invoice_id = i.invoice_id
				JOIN dbo.track AS t ON t.track_id = il.track_id
				JOIN dbo.genre AS g ON g.genre_id = t.genre_id
				GROUP BY i.billing_country , g.name
)
SELECT Country , Genre , Purchases FROM cte 
WHERE RN <=1

-- 3. write a query that determines which Customer has spent most on music for each country .
-- WRite a query that returns country along the Top customer and how much they spent .

WITH cte as (
				SELECT c.first_name as Customer , c.last_name as Surname , i.billing_country as Country ,
				SUM(i.total) as Money_Spent ,
				ROW_NUMBER() OVER ( PARTITION BY i.billing_country ORDER BY SUM(i.total) DESC ) AS RN
				FROM dbo.invoice i
				JOIN dbo.customer c ON c.customer_id = i.customer_id
				GROUP BY c.first_name , c.last_name , i.billing_country
)
SELECT Customer , Surname , Country , Money_Spent
FROM cte
WHERE RN <= 1
ORDER BY Money_Spent DESC