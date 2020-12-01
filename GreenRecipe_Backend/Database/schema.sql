
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
user_id INT,
PRIMARY KEY(review_id),
FOREIGN KEY(recipe_id) REFERENCES recipe(id) ON DELETE CASCADE,
FOREIGN KEY(user_id) REFERENCES user(user_id) ON DELETE CASCADE ,
stars INT NOT NULL DEFAULT 0,
likes INT DEFAULT 0,
dislikes INT DEFAULT 0,
images TEXT[],
created TIMESTAMP DELETE CURRENT_TIMESTAMP
);

/*
replies for each review (one to many)
 */
CREATE TABLE reply(
review_id INT NOT NULL,
body TEXT NOT NULL,
likes INT DEFAULT 0,
dislikes INT DEFAULT 0,
images TEXT[],
user_id INT NOT NULL,
PRIMARY KEY(review_id, user_id),
FOREIGN KEY(review_id) REFERENCES review(review_id),
FOREIGN KEY(user_id) REFERENCES user(user_id)
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


CREATE TABLE favorites(
user_id INT NOT NULL,
recipe_id INT NOT NULL,
PRIMARY KEY(user_id, recipe_id),
FOREIGN KEY(user_id) REFERENCES user(user_id) ON DELETE CASCADE ,
FOREIGN KEY(recipe_id) REFERENCES recipe(id) ON DELETE CASCADE ,
)



