DROP TABLE IF EXISTS tracks CASCADE;
DROP TABLE IF EXISTS albums;

--Create the albums table
CREATE TABLE albums (
  album_id SERIAL PRIMARY KEY,
  title text NOT NULL
);

-- Create the tracks table and drop album_id column if it exists
CREATE TABLE tracks (
  track_id SERIAL PRIMARY KEY,
  title text NOT NULL,
  length INT NOT NULL
);

-- Drop album_id column if it exists
ALTER TABLE tracks DROP COLUMN IF EXISTS album_id;

-- Add the album_id column to the tracks table
ALTER TABLE tracks ADD COLUMN album_id INT;

-- Create the relationship between the albums and tracks tables
ALTER TABLE tracks
ADD CONSTRAINT fk_album_id
FOREIGN KEY (album_id)
REFERENCES albums(album_id);

-- Insert ten rows into the albums table
INSERT INTO albums (title) VALUES
('Album 1'),
('Album 2'),
('Album 3'),
('Album 4'),
('Album 5'),
('Album 6'),
('Album 7'),
('Album 8'),
('Album 9'),
('Album 10');

-- Insert ten rows into the tracks table
INSERT INTO tracks (album_id, title, length) VALUES
(1, 'Track 1', 3),
(1, 'Track 2', 4),
(1, 'Track 3', 5),
(2, 'Track 4', 2),
(2, 'Track 5', 6),
(2, 'Track 6', 4),
(3, 'Track 7', 3),
(3, 'Track 8', 4),
(3, 'Track 9', 5),
(4, 'Track 10', 3);

SELECT tracks.title AS track_title, albums.title AS album_title
FROM tracks
JOIN albums ON tracks.album_id = albums.album_id;

SELECT a.title, t.title
FROM albums a
JOIN tracks t ON a.album_id = t.album_id
ORDER BY a.title;

SELECT albums.title AS album_title, COUNT(tracks.track_id) AS number_of_songs
FROM albums
JOIN tracks ON albums.album_id = tracks.album_id
GROUP BY albums.album_id;

SELECT tracks.title AS track_title, COUNT(albums.album_id) AS number_of_albums
FROM tracks
JOIN albums ON tracks.album_id = albums.album_id
WHERE tracks.title = 'Track 2'
GROUP BY tracks.track_id;