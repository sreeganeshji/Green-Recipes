
/* create tables */

CREATE TABLE recipe(
id SERIAL NOT NULL,
name VARCHAR(50) NOT NULL,
ingredients TEXT[] NOT NULL,
process TEXT[] NOT NULL,
contributor VARCHAR(50),
origin VARCHAR(50),
servings REAL,
equipment TEXT[],
images TEXT[],
added_date DATE,
added_by VARCHAR(50),
nutrition TEXT[],
category VARCHAR(50),
PRIMARY KEY(ID)
);

CREATE TABLE review(
review_id SERIAL,
recipe_id INT,
PRIMARY KEY(review_id),
FOREIGN KEY(recipe_id) REFERENCES recipe(id) ON DELETE CASCADE,
stars INT NOT NULL,
likes INT NOT NULL,
dislikes INT NOT NULL,
images TEXT[]
);

/*
replies for each review (one to many)
 */
CREATE TABLE reply(
reply_id SERIAL,
body TEXT NOT NULL,
likes INT NOT NULL,
dislikes INT NOT NULL,
images TEXT[],
PRIMARY KEY(reply_id),
review_id INT NOT NULL,
FOREIGN KEY(review_id) REFERENCES review(review_id) ON DELETE CASCADE
);

CREATE TABLE user(
user_id SERIAL,
first_name VARCHAR(50) NOT NULL,
last_name VARCHAR(50) NOT NULL,
username VARCHAR(50) NOT NULL UNIQUE,
email VARCHAR(50),
PRIMARY KEY(user_id)
);






