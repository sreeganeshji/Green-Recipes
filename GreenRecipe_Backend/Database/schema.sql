
/* create tables */

CREATE TABLE person (
person_id SERIAL,
apple_id VARCHAR (100) NOT NULL,
firstname VARCHAR(50) NOT NULL,
lastname VARCHAR(50) NOT NULL,
username VARCHAR(50) NOT NULL UNIQUE,
profilepic VARCHAR(100),
email VARCHAR(50),
PRIMARY KEY(user_id)
);

CREATE TABLE recipe(
id SERIAL NOT NULL,
name VARCHAR(50) NOT NULL,
ingredients TEXT[] NOT NULL,
description VARCHAR(1000),
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
rating REAL,
rating_count INT,
estimated_time VARCHAR (50),
PRIMARY KEY(ID),
FOREIGN KEY(added_by) REFERENCES person(user_id)
);

CREATE TABLE review(
review_id SERIAL,
recipe_id INT,
person_id INT,
PRIMARY KEY(review_id),
FOREIGN KEY(recipe_id) REFERENCES recipe(id) ON DELETE CASCADE,
FOREIGN KEY(person_id) REFERENCES person(user_id) ON DELETE CASCADE ,
stars INT NOT NULL DEFAULT 0,
likes INT DEFAULT 0,
dislikes INT DEFAULT 0,
body VARCHAR (1000),
title VARCHAR (200) NOT NULL,
images TEXT[],
created DATE DEFAULT CURRENT_DATE
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
person_id INT NOT NULL,
PRIMARY KEY(review_id, person_id),
FOREIGN KEY(review_id) REFERENCES review(review_id),
FOREIGN KEY(person_id) REFERENCES person(user_id),
created TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE favorites(
person_id INT NOT NULL,
recipe_id INT NOT NULL,
PRIMARY KEY(person_id, recipe_id),
FOREIGN KEY(person_id) REFERENCES person(user_id) ON DELETE CASCADE ,
FOREIGN KEY(recipe_id) REFERENCES recipe(id) ON DELETE CASCADE
);

CREATE TABLE report(
report_id SERIAL NOT NULL,
person_id INT NOT NULL,
recipe_id INT NOT NULL,
PRIMARY KEY (report_id),
FOREIGN KEY(person_id) REFERENCES person(user_id) ON DELETE CASCADE,
FOREIGN KEY(recipe_id) REFERENCES recipe(id) ON DELETE  CASCADE,
title VARCHAR (200) NOT NULL,
body VARCHAR(1000),
created DATE DEFAULT CURRENT_DATE
);
