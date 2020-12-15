package database

import (

	"fmt"
	"greenrecipe/Models"
	"context"
	"time"
	"github.com/jackc/pgx/v4"

)

type Postgres struct{
	db *pgx.Conn
	timeout int
}

func Connect(host string, dbname string, username string, password string, timeout int) (Postgres, error) {
	connStr := fmt.Sprintf("user=%s dbname=%s password=%s  host=%s", username, dbname, password, host)
	db, err := pgx.Connect(context.Background(),connStr)
	if err != nil{
		return Postgres{},err
	}
	return Postgres{db: db, timeout: timeout}, err
}

func (p *Postgres) Close() {
	p.db.Close(context.Background())
}

/*
type Recipe struct {
	ID          int       `json:"id"`
	Name        string    `json:"name"`
	Ingredients []string  `json:"ingredients"`
	Process     []string  `json:"process"`
	Contributor string    `json:"contributor"`
	Origin      string    `json:"origin"`
	Servings    float32   `json:"servings"`
	Equipment   []string  `json:"equipment"`
	Images      [] string `json:"images"`
	AddedDate   string    `json:"added_date"`
	Addedby     string    `json:"addedby"`
	Nutrition []string `json:"nutrition"`
	Category string `json:"category"`
}
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
 */
func (p *Postgres)AddRecipe(recipe models.Recipe) (models.Recipe, error){
context, cancel := context.WithTimeout(context.Background(), time.Second*5)
defer cancel()

sql_statement := `INSERT INTO recipe (name, description, ingredients, process, contributor, origin, servings, equipment, images,
added_date, added_by, nutrition, category) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13) RETURNING id,name, description, ingredients, process, contributor, origin, servings, equipment, images,
added_date, added_by, nutrition, category `

	var insertedrecipe models.Recipe

err := p.db.QueryRow(context,sql_statement,recipe.Name, recipe.Description, recipe.Ingredients, recipe.Process, recipe.Contributor, recipe.Origin, recipe.Servings, recipe.Equipment, recipe.Images, recipe.AddedDate, recipe.Addedby,recipe.Nutrition, recipe.Category).Scan(&insertedrecipe.ID, &insertedrecipe.Name, &insertedrecipe.Description, &insertedrecipe.Ingredients, &insertedrecipe.Process, &insertedrecipe.Contributor, &insertedrecipe.Origin, &insertedrecipe.Servings, &insertedrecipe.Equipment, &insertedrecipe.Images, &insertedrecipe.AddedDate, &insertedrecipe.Addedby, &insertedrecipe.Nutrition, &insertedrecipe.Category)


//fmt.Println("recipe ingridents",recipe.Ingredients)
//	sql_statement := `INSERT INTO recipe (name, description, ingredients, process, contributor) VALUES ($1, $2, $3, $4, $5) RETURNING id,name, description, ingredients, process, contributor, origin, servings, equipment, images,
//added_date, added_by, nutrition, category `
//
//	var insertedrecipe models.Recipe
//
//	err := p.db.QueryRow(context,sql_statement,recipe.Name, recipe.Description, recipe.Ingredients, recipe.Process, recipe.Contributor).Scan(&insertedrecipe.ID, &insertedrecipe.Name, &insertedrecipe.Description, &insertedrecipe.Ingredients, &insertedrecipe.Process, &insertedrecipe.Contributor, &insertedrecipe.Origin, &insertedrecipe.Servings, &insertedrecipe.Equipment, &insertedrecipe.Images, &insertedrecipe.AddedDate, &insertedrecipe.Addedby, &insertedrecipe.Nutrition, &insertedrecipe.Category)


if (err != nil) {
	return models.Recipe{}, err
}
return insertedrecipe, err
}

func (p *Postgres) FindUser(appleString string)(string, error){
	// take the unique user id from apple signin and return the database user id.
}
/*
CREATE TABLE person (
person_id SERIAL,
apple_id VARCHAR (100) NOT NULL,
first_name VARCHAR(50) NOT NULL,
last_name VARCHAR(50) NOT NULL,
username VARCHAR(50) NOT NULL UNIQUE,
email VARCHAR(50),
PRIMARY KEY(person_id)
);
 */
func (p *Postgres) AddUser(user models.Person)(string, error){
	// create a user based on the appleString and return its database id.
	context, cancel := context.WithTimeout(context.Background(),time.Second*3)
	defer cancel()

	sqlstatement := `INSERT INTO people (apple_id, first_name, last_name, username, email) VALUES($1, $2,  
}

func (p *Postgres) GetUserFavs(uuid string)([]models.Recipe,error){
	
}

