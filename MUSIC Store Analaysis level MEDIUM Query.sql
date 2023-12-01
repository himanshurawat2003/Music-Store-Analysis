-- 1. Write the query to return the Email , First Name ,Last Name and Genre of all Rock Music Listeners . Order  of list Alphabetically by Email .

SELECT DISTINCT C.first_name , C.last_name , C.email
FROM dbo.customer As C
JOIN dbo.invoice As I On C.customer_id = I.customer_id
JOIN dbo.invoice_line As IL On IL.invoice_id = I.invoice_id
WHERE IL.track_id In 
(
SELECT T.track_id
FROM dbo.genre as G
JOIN dbo.track as T ON G.genre_id = T.genre_id
WHERE g.name Like 'Rock' )
ORDER BY email

-- 2. Write a query that returns The Artist Name  and Total Count of the Top 10 Rock Bands

SELECT TOP (10) Count(A.name) as Number_Of_Tracks , A.name as Artit_Name
FROM dbo.artist as A
JOIN dbo.album as AL on A.artist_id = AL.artist_id 
JOIN dbo.track as T on T.album_id = AL.album_id
JOIN dbo.genre as G on G.genre_id = T.genre_id
WHERE G.name like 'Rock'
GROUP BY A.name
Order By Number_Of_Tracks DESC

-- 3. Return all the tracks name that have a song longer than the Average Song lenght . Return the Name and Milliseconds .

SELECT name as Song_Name , milliseconds as Track_Length_in_Milliseconds
FROM dbo.track
WHERE milliseconds > (
					  SELECT AVG(milliseconds) as AVG_TRACK_LENGTH
					  FROM dbo.track
					  )
ORDER BY milliseconds DESC

