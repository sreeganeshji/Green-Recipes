
/* create tables */

create table person(
username varchar(30) not null,
first_name varchar(30) not null,
last_name varchar(30) not null,
enabled boolean default true
);

create table recipe(
id serial not null,
author varchar(50),
description varchar(300),
primary key(id)
);

create table step(
recipe_id int not null,
step_no int not null unique,
description varchar(200),
primary key (recipe_id, step_no) ,
foreign key (recipe_id) references recipe(id) on delete cascade
);



