
/* create tables */

CREATE TABLE recipe(
id SERIAL NOT NULL,
name VARCHAR(50) NOT NULL,
ingredients TEXT[] NOT NULL,
document VARCHAR(1000),
process TEXT[] NOT NULL,
contributor VARCHAR(50),
origin VARCHAR(50),
servings INT DEFAULT 1,
equipment TEXT[],
images TEXT[],
added_date DATE DEFAULT CURRENT_DATE,
added_by INT,
nutrition TEXT[],
category VARCHAR(50),
PRIMARY KEY(ID),
FOREIGN KEY(added_by) REFERENCES user(user_id)
);

CREATE TABLE review(
review_id SERIAL,
recipe_id INT,
PRIMARY KEY(review_id),
FOREIGN KEY(recipe_id) REFERENCES recipe(id) ON DELETE CASCADE,
stars INT NOT NULL DEFAULT 0,
likes INT DEFAULT 0,
dislikes INT DEFAULT 0,
images TEXT[]
);

/*
replies for each review (one to many)
 */
CREATE TABLE reply(
reply_id SERIAL,
body TEXT NOT NULL,
likes INT DEFAULT 0,
dislikes INT DEFAULT 0,
images TEXT[],
PRIMARY KEY(reply_id),
review_id INT NOT NULL,
FOREIGN KEY(review_id) REFERENCES review(review_id) ON DELETE CASCADE
);

CREATE TABLE user(
user_id SERIAL,
apple_id VARCHAR (100) NOT NULL,
first_name VARCHAR(50) NOT NULL,
last_name VARCHAR(50) NOT NULL,
username VARCHAR(50) NOT NULL UNIQUE,
email VARCHAR(50),
PRIMARY KEY(user_id)
);






