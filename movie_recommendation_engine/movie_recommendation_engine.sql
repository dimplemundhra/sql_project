-- create user table
CREATE TABLE Users (
    user_id SERIAL PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    gender CHAR(1),
    age INT
);

-- create movies table
CREATE TABLE Movies(
    movie_id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    genre VARCHAR(100),
    release_year INT
);

-- create ratings table
CREATE TABLE Ratings (
    rating_id SERIAL PRIMARY KEY,
    user_id INT REFERENCES Users(user_id),
    movie_id INT REFERENCES Movies(movie_id),
    rating DECIMAL(2,1) CHECK (rating >= 0 AND rating <= 10),
    rated_on DATE DEFAULT CURRENT_DATE
);


-- create reviews table
CREATE TABLE Reviews (
    review_id SERIAL PRIMARY KEY,
    user_id INT REFERENCES Users(user_id),
    movie_id INT REFERENCES Movies(movie_id),
    review TEXT,
    review_date DATE DEFAULT CURRENT_DATE
);

-- Insert values to user's table
INSERT INTO Users (username, gender, age) 
VALUES
('alice', 'F', 23),
('bob', 'M', 30),
('charlie', 'M', 28),
('diana', 'F', 35),
('emily','F', 22),
('conrad','M',24);

-- Insert values to movies table
INSERT INTO Movies (title, genre, release_year)
VALUES
('Inception', 'Sci-Fi', 2010),
('The Dark Knight', 'Action', 2008),
('Titanic', 'Romance', 1997),
('The Matrix', 'Sci-Fi', 1999),
('Forrest Gump', 'Drama', 1994),
('Ironman','Sci-Fi',2004);

-- Insert values to ratings table
INSERT INTO Ratings (user_id, movie_id, rating) 
VALUES
(1, 1, 9.0), (2, 1, 8.5), (3, 1, 9.5), (4, 1, 8.0), -- Inception
(1, 2, 9.5), (2, 2, 9.0), (3, 2, 9.2), -- The Dark Knight
(1, 3, 7.0), (2, 3, 6.5), (4, 3, 7.2), -- Titanic
(2, 4, 8.0), (3, 4, 8.5), (4, 4, 7.8), -- The Matrix
(1, 5, 8.2), (2, 5, 8.5), (3, 5, 8.0), -- Forrest Gump
(6,6,9.8),   (3, 6, 9.0), (4, 6, 7.8); --Ironman

INSERT INTO Reviews (user_id, movie_id, review) VALUES
(1, 1, 'Mind-blowing!'), (2, 2, 'Great performance!'),
(3, 3, 'Classic love story'), (4, 4, 'Action-packed!'),
(2, 5, 'Inspiring and emotional');

-- Average rating per Movie:-
SELECT
 m.title,
 ROUND(AVG(r.rating),2) AS avg_rating,
 COUNT(r.rating) AS total_ratings
FROM Movies m
JOIN Ratings r ON m.movie_id=r.movie_id
GROUP BY m.title
ORDER BY avg_rating DESC;

-- Top 3 Highest rated movie
SELECT 
 m.title,
 ROUND(AVG(r.rating),2) AS avg_rating
FROM Movies m JOIN Ratings r ON M.movie_id=r.movie_id
GROUP BY m.title 
HAVING COUNT(r.rating)>=3
ORDER BY avg_rating DESC
LIMIT 3;

-- Create Views for (recommend movies to all users (avg rating >= 8))
CREATE VIEW Recommended_Movies AS 
SELECT
  m.movie_id,
  m.title,
  m.genre,
  ROUND(avg(r.rating),2) AS Avg_Rating,
  COUNT (r.rating) AS Total_Ratings
FROM Movies m
JOIN Ratings r ON m.movie_id = r.movie_id
GROUP BY m.movie_id,m.title,m.genre
HAVING AVG(r.rating) >=8
ORDER BY Avg_Rating DESC;


-- Rank Movies using Dense_Rank WINDOW FUNCTIONS:-
SELECT 
 title,
 genre,
 release_year,
 ROUND(AVG(rating),2) AS Avg_Rating,
 DENSE_RANK() OVER (ORDER BY AVG(rating) DESC)
 AS movie_rank
FROM Movies m
JOIN Ratings r ON m.movie_id = r.movie_id
GROUP BY m.movie_id, m.title,m.genre,m.release_year;


-- Add Rating and Auto-update Review using Stored Procedure
CREATE OR REPLACE FUNCTION add_rating_review(
    p_user_id INT,
    p_movie_id INT,
    p_rating DECIMAL(2,1),
    p_review TEXT DEFAULT NULL
)
RETURNS VOID AS $$
BEGIN
    INSERT INTO Ratings(user_id, movie_id, rating)
    VALUES (p_user_id, p_movie_id, p_rating);

    IF p_review IS NOT NULL THEN
        INSERT INTO Reviews(user_id, movie_id, review)
        VALUES (p_user_id, p_movie_id, p_review);
    END IF;
END;
$$ LANGUAGE plpgsql;


SELECT add_rating_review(2, 4, 9.0, 'Absolutely brilliant!');


-- Most Active Users :-
SELECT
    u.username,
    COUNT(r.rating_id) AS total_ratings,
    COUNT(rv.review_id) AS total_reviews
FROM Users u
LEFT JOIN Ratings r ON u.user_id = r.user_id
LEFT JOIN Reviews rv ON u.user_id = rv.user_id
GROUP BY u.username
ORDER BY total_ratings DESC
LIMIT 4 ;


-- Rating Distribution Per Movie:-
SELECT
    m.title,
    r.rating,
    COUNT(*) AS frequency
FROM Ratings r
JOIN Movies m ON r.movie_id = m.movie_id
GROUP BY m.title, r.rating
ORDER BY m.title, r.rating DESC;


-- Movies liked by similar users (e.g., who liked the same movies as user_id 1)
SELECT DISTINCT m2.title
FROM Ratings r1
JOIN Ratings r2 ON r1.movie_id = r2.movie_id
JOIN Movies m2 ON m2.movie_id = r2.movie_id
WHERE r1.user_id = 1 AND r2.user_id != 1
AND r1.rating >= 8 AND r2.rating >= 8;


-- Genre-wise Top rated movies
SELECT genre, title, ROUND(AVG(rating),2) AS avg_rating
FROM Movies m
JOIN Ratings r ON m.movie_id = r.movie_id
GROUP BY genre, title
HAVING COUNT(rating) >= 2
ORDER BY genre, avg_rating DESC;


-- Recent reviews(Time-based)
SELECT u.username, m.title, rv.review, rv.review_date
FROM Reviews rv
JOIN Users u ON u.user_id = rv.user_id
JOIN Movies m ON m.movie_id = rv.movie_id
ORDER BY rv.review_date DESC
LIMIT 3;


SELECT * FROM Recommended_Movies;




