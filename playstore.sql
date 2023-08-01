use playstore

CREATE TABLE reviews (
    App VARCHAR (500),
    Translated_Review VARCHAR(500),
    Sentiment VARCHAR(500)
    );
   
   CREATE TABLE app (
    app_id INT AUTO_INCREMENT PRIMARY KEY,
    App VARCHAR(255),
    Category VARCHAR(255),
    Rating FLOAT,
    Reviews INT,
    Size VARCHAR(255),
    Installs VARCHAR(255),
    Price_type VARCHAR(255),
    Price VARCHAR(255),
    Content_Rating VARCHAR(255),
    Genres VARCHAR(255),
    Last_Updated VARCHAR(255),
    Current_Ver VARCHAR(255),
    Android_Ver VARCHAR(255),
    category_id INT,
    FOREIGN KEY (category_id) REFERENCES app(app_id)
);

CREATE TABLE app (
    app_id INT AUTO_INCREMENT PRIMARY KEY,
    App VARCHAR(255),
    Category VARCHAR(255),
    Rating FLOAT,
    Reviews INT,
    Size VARCHAR(255),
    Installs VARCHAR(255),
    Type VARCHAR(255),
    Price_type VARCHAR(255),
    Content_Rating VARCHAR(255),
    Genres VARCHAR(255),
    Last_Updated VARCHAR(255),
    Current_Ver VARCHAR(255),
    Android_Ver VARCHAR(255)
);

CREATE TABLE categories (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(255)
);




ALTER TABLE app
ADD COLUMN category_id INT;

ALTER TABLE app
ADD CONSTRAINT FK_app_category
FOREIGN KEY (category_id) REFERENCES categories(category_id);








ALTER TABLE app
RENAME COLUMN Type TO Price_type;

select category 
from app
GROUP BY category

"to find categories with the most highly rated apps"
SELECT Category, COUNT(Rating)
FROM app
WHERE rating > 4.5
GROUP BY category
ORDER BY count(Rating) DESC

"to find categories with the most low rated apps"
SELECT Category, COUNT(Rating)
FROM app
WHERE rating <= 2.5
GROUP BY category
ORDER BY count(Rating) DESC

SELECT * FROM APP

"to find average of category ratings"
SELECT category, AVG(rating) AS rating_avg
FROM app
GROUP BY category
ORDER BY avg(rating) DESC 

"to return apps with higher than average ratings"
SELECT app, category, installs, rating, AVG(rating) OVER (PARTITION BY category) AS category_avg, price_type
FROM app
WHERE rating >= (
  SELECT AVG(rating)
  FROM app
  WHERE category = app.category
)
ORDER BY category, rating DESC, installs DESC

"from this query, return the total number of apps with higher than average ratings per category"
SELECT category, COUNT(*) AS total_apps_with_higher_rating
FROM (
  SELECT app, category, installs, rating, AVG(rating) OVER (PARTITION BY category) AS category_avg
  FROM app
  WHERE rating >= (
    SELECT AVG(rating)
    FROM app
    WHERE category = app.category
  )
  ORDER BY category, rating DESC, installs DESC
) AS t1
GROUP BY category
ORDER BY total_apps_with_higher_rating DESC

"from this query, return prices"
SELECT t1.category, t1.total_apps_with_higher_rating, app, price
FROM (
  SELECT category, COUNT(*) AS total_apps_with_higher_rating
  FROM (
    SELECT app, category, installs, rating, AVG(rating) OVER (PARTITION BY category) AS category_avg
    FROM app
    WHERE rating >= (
      SELECT AVG(rating)
      FROM app
      WHERE category = app.category
    )
  ) AS t
  GROUP BY category
  ORDER BY total_apps_with_higher_rating DESC
) AS t1
JOIN app AS t2 ON t1.category = t2.category
ORDER BY t1.total_apps_with_higher_rating DESC;

"with this query, find total paid apps per category with average rating"
SELECT category, COUNT(app) AS total_paid_apps, AVG(rating)
FROM app
WHERE price_type = 'Paid'
GROUP BY category
ORDER BY COUNT(app) DESC

"return results for avg rating of paid vs free apps"		
SELECT t1.category, t1.total_paid_apps, t1.avg_rating, t2.total_free_apps, t2.avg_rating
FROM (
	SELECT category, COUNT(app) AS total_paid_apps, AVG(rating) AS avg_rating
	FROM app
	WHERE price_type = 'Paid'
	GROUP BY category
	ORDER BY COUNT(app) DESC
) AS t1
JOIN (
	SELECT category, COUNT(app) AS total_free_apps, AVG(rating) AS avg_rating
	FROM app
	WHERE price_type = 'Free'
	GROUP BY category
	ORDER BY COUNT(app) DESC
) AS t2
ON t1.category = t2.category;

"to find common prices for paid apps"
SELECT price, COUNT(price) AS price_count
FROM app
WHERE price_type = 'Paid'
GROUP BY price
ORDER BY price_count DESC














