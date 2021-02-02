--Write a query that can tell me the names of the artists with the largest tracks
--in the database. For each artist, get their largest track (in Bytes) and have
--the query return the top ten largest tracks sizes and their artist (make the
--artist's name in ALL CAPS). Be sure to use aliases to adjust the column names
--as UPPER_NAME and MEMORY_SIZE.

-- See Chinook Database Schema for details

SELECT UPPER(artist.Name) as UPPER_NAME, track.LargestTrack as MEMORY_SIZE
FROM Album
INNER JOIN (SELECT AlbumId, Name, MAX(Bytes) as LargestTrack
FROM Track
GROUP BY AlbumId) as track
ON Album.AlbumId=track.AlbumId
INNER JOIN(SELECT Name, ArtistId
FROM Artist) as artist
ON Album.ArtistId=artist.ArtistId
GROUP BY UPPER_NAME HAVING MAX(MEMORY_SIZE)
ORDER BY MEMORY_SIZE DESC
LIMIT 10;



--Write a SQL query that returns the name of each artist and the number of seconds
--of tracks that artist has created in the database (called TotalTime). Order by
--the length of time. Please exclude tracks shorter than 120 seconds from the tally,
--and only report on artists with a name begining with the letter "B".

-- See Chinook Database Schema for details

SELECT Name, SUM(TotalTime) as TotalTime
FROM (SELECT artist.Name as Name, track.TotalTime as TotalTime
FROM Album
INNER JOIN (SELECT AlbumId, SUM(CASE WHEN Milliseconds > 120000.0 THEN Milliseconds ELSE 0 END)/1000.0 AS TotalTime
FROM Track
GROUP BY AlbumId) as track
ON Album.AlbumId=track.AlbumId
INNER JOIN(SELECT Name, ArtistId
FROM Artist
WHERE Name LIKE "B%") as artist
ON Album.ArtistId=artist.ArtistId
ORDER BY TotalTime)
GROUP BY Name
ORDER BY TotalTime;



--I want the name of the artist and tracks for the tracks on album that have the same
--name as the artist. Order by track name.

--For instance, there is a track called "Ain't Talkin' 'Bout Love" on an album titled
--"Van Halen" by the artist "Val Halen".

SELECT Artist.Name, Track.Name
FROM Album
INNER JOIN Track
ON Album.AlbumId=Track.AlbumId
INNER JOIN Artist
ON Album.ArtistId=Artist.ArtistId
WHERE Album.Title=Artist.Name
ORDER BY Track.Name;