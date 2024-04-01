-- Top 10 Movies by IMDB Score:

SELECT title, 
       type, 
       imdb_score
FROM shows_movies.titles
WHERE type = 'MOVIE'
ORDER BY imdb_score DESC
LIMIT 10;

-- Bottom 10 Movies by IMDB Score:

SELECT title, 
       type, 
       imdb_score
FROM shows_movies.titles
WHERE type = 'MOVIE'
ORDER BY imdb_score ASC
LIMIT 10;

-- Average IMDB and TMDB Scores for Shows and Movies:
SELECT type, 
       ROUND(AVG(imdb_score), 2) AS avg_imdb_score,
       ROUND(AVG(tmdb_score), 2) AS avg_tmdb_score
FROM shows_movies.titles
GROUP BY type;

-- Count of Movies and Shows in Each Decade:
SELECT CONCAT(FLOOR(release_year / 10) * 10, 's') AS decade,
       COUNT(*) AS movies_shows_count
FROM shows_movies.titles
WHERE release_year >= 1940
GROUP BY decade
ORDER BY decade;


--Average IMDB and TMDB Scores by Production Country:

SELECT production_countries, 
       ROUND(AVG(imdb_score), 2) AS avg_imdb_score,
       ROUND(AVG(tmdb_score), 2) AS avg_tmdb_score
FROM shows_movies.titles
GROUP BY production_countries
ORDER BY avg_imdb_score DESC;


-- Average IMDB and TMDB Scores by Age Certification:
SELECT age_certification, 
       ROUND(AVG(imdb_score), 2) AS avg_imdb_score,
       ROUND(AVG(tmdb_score), 2) AS avg_tmdb_score
FROM shows_movies.titles
WHERE age_certification != 'N/A'
GROUP BY age_certification
ORDER BY avg_imdb_score DESC;


--Top 20 Actors by Number of Appearances:

SELECT name AS actor, 
       COUNT(*) AS number_of_appearances 
FROM shows_movies.credits
WHERE role = 'actor'
GROUP BY actor
ORDER BY number_of_appearances DESC
LIMIT 20;

-- Top 20 Directors by Number of Movies/Shows:
SELECT name AS director, 
       COUNT(*) AS number_of_movies_shows
FROM shows_movies.credits
WHERE role = 'director'
GROUP BY director
ORDER BY number_of_movies_shows DESC
LIMIT 20;


-- Titles and Directors of Movies Released on or After 2015:

SELECT t.title, 
       c.name AS director, 
       t.release_year
FROM shows_movies.titles AS t
JOIN shows_movies.credits AS c 
ON t.id = c.id
WHERE t.type = 'Movie' 
      AND t.release_year >= 2010 
      AND c.role = 'director'
ORDER BY t.release_year DESC;

-- Genres with the Most Shows:
SELECT genres, 
       COUNT(*) AS title_count
FROM shows_movies.titles 
WHERE type = 'Show'
GROUP BY genres
ORDER BY title_count DESC
LIMIT 10;

-- Titles and Directors of High-Scoring Movies:

SELECT t.title, 
       c.name AS director
FROM shows_movies.titles AS t
JOIN shows_movies.credits AS c 
ON t.id = c.id
WHERE t.type = 'Movie' 
      AND t.imdb_score > 7.5 
      AND t.tmdb_popularity > 80 
      AND c.role = 'director';

-- Top 3 Most Common Genres:

SELECT genres, 
       COUNT(*) AS genre_count
FROM shows_movies.titles AS t
WHERE t.type = 'Movie'
GROUP BY genres
ORDER BY genre_count DESC
LIMIT 3;

