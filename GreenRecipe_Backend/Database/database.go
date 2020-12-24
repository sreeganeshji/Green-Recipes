package database

import (
	"context"
	"fmt"
	"github.com/jackc/pgx/v4"
	"greenrecipe/Models"
	"time"
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
	c, cancel := context.WithTimeout(context.Background(), time.Second*5)
	defer cancel()

	sql_statement := `INSERT INTO recipe (name, description, ingredients, process, contributor, origin, servings, equipment, images,
added_date, added_by, nutrition, category) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13) RETURNING id,name, description, ingredients, process, contributor, origin, servings, equipment, images,
added_date, added_by, nutrition, category`

	var insertedrecipe models.Recipe

	err := p.db.QueryRow(c,sql_statement,recipe.Name, recipe.Description, recipe.Ingredients, recipe.Process, recipe.Contributor, recipe.Origin, recipe.Servings, recipe.Equipment, recipe.Images, recipe.AddedDate, recipe.Addedby,recipe.Nutrition, recipe.Category).Scan(&insertedrecipe.ID, &insertedrecipe.Name, &insertedrecipe.Description, &insertedrecipe.Ingredients, &insertedrecipe.Process, &insertedrecipe.Contributor, &insertedrecipe.Origin, &insertedrecipe.Servings, &insertedrecipe.Equipment, &insertedrecipe.Images, &insertedrecipe.AddedDate, &insertedrecipe.Addedby, &insertedrecipe.Nutrition, &insertedrecipe.Category)

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

//func (p *Postgres) FindUser(appleString string)(string, error){
//	// take the unique user id from apple signin and return the database user id.
//}
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
func (p *Postgres) AddUser(user models.Person) (models.Person, error){
	// create a user based on the appleString and return its database id.
	c, cancel := context.WithTimeout(context.Background(),time.Second*3)
	defer cancel()
	sql := `INSERT INTO person (apple_id, firstname, lastname, username, email) VALUES($1, $2, $3, $4, $5) RETURNING user_id, apple_id, firstname, lastname, username, email  `

	var user_rec models.Person

	err := p.db.QueryRow(c, sql, user.Appleid, user.Firstname, user.Lastname, user.Username, user.Email).Scan(&user_rec.UserID, &user_rec.Appleid, &user_rec.Firstname, &user_rec.Lastname, &user_rec.Username, &user_rec.Email)

	if err!=nil{
		return user_rec, err
	}

	return user_rec, nil
}

func (p *Postgres) GetUserWithAppleID(apple_id string)(models.Person, error){
	c, cancel := context.WithTimeout(context.Background(), 5 * time.Second)
	defer cancel()

	sql := `select user_id, apple_id, firstname, lastname, username, email from person where apple_id=$1`

	var user models.Person
	err := p.db.QueryRow(c, sql, apple_id).Scan(&user.UserID, &user.Appleid, &user.Firstname, &user.Lastname, &user.Username, &user.Email)
	if err!=nil{
		return user, err
	}

	return user,nil
}

//func (p *Postgres) GetUserFavs(uuid string)([]models.Recipe,error){
//
//}


func (p *Postgres) FindRecipesLike(recipe string, count int)([]models.Recipe, error){
	c, cancel  := context.WithTimeout(context.Background(), 5*time.Second)
	defer cancel()

	sql := `select id, name, category from recipe where name ilike '%' || $1 || '%' limit $2`

	recipe_rec := make([]models.Recipe, count)

	rows, err := p.db.Query(c, sql, recipe, count)

	if err != nil{
		return nil, err
	}

	i := 0
	for rows.Next(){
		var recipeRow models.Recipe
		err := rows.Scan(&recipeRow.ID, &recipeRow.Name, &recipeRow.Category)
		if err!=nil{
			return []models.Recipe{}, err
		}
		recipe_rec[i] = recipeRow
		i += 1
	}
	//fmt.Println("Retrived ",i," rows of recipes")

	//if (err != nil){
	//	return recipe_rec, err
	//}
	return recipe_rec[:i], nil
}

func (p *Postgres) FindRecipeWithID(id int) (models.Recipe, error) {
	c, cancel := context.WithTimeout(context.Background(), 5 * time.Second)
	defer cancel()

	sql := `select id, name, description, ingredients, process, contributor, origin, servings, equipment, images,
added_date, added_by, nutrition, category from recipe where id=$1`

	var recipe models.Recipe
	err := p.db.QueryRow(c, sql, id).Scan(&recipe.ID, &recipe.Name, &recipe.Description, &recipe.Ingredients, &recipe.Process, &recipe.Contributor, &recipe.Origin, &recipe.Servings, &recipe.Equipment, &recipe.Images, &recipe.AddedDate, &recipe.Addedby, &recipe.Nutrition, &recipe.Category)

	if err!=nil{
		return recipe, err
	}

	return recipe, nil
}

func (p *Postgres) AddFavorite(userid int, recipeid int)(error){
	c, cancel := context.WithTimeout(context.Background(), 5 * time.Second)
	defer cancel()

	sql := `insert into favorites (person_id, recipe_id) values($1, $2)`

	err := p.db.QueryRow(c, sql, userid, recipeid).Scan()
	if err!= nil && err!=pgx.ErrNoRows {
		return err
	}
	return nil
}

func (p *Postgres) RemoveFavorite(userid int, recipeid int)(error){
	c, cancel := context.WithTimeout(context.Background(), 5 * time.Second)
	defer cancel()

	sql := `delete from favorites where person_id=$1 and recipe_id=$2`

	err := p.db.QueryRow(c, sql, userid, recipeid).Scan()
	if err!=nil && err!=pgx.ErrNoRows{
		return err
	}

	return err
}

func (p *Postgres) GetUserFavorites(userid int)([]models.Recipe, error){
	c, cancel := context.WithTimeout(context.Background(), 5 * time.Second)
	defer cancel()

	sql := `select id, name, category from recipe inner join favorites on id=recipe_id where person_id=$1`

	var recipes []models.Recipe
	row, err := p.db.Query(c, sql, userid)
	if err!=nil && err!=pgx.ErrNoRows{
		return []models.Recipe{}, err
	}

	for row.Next(){
		var recipe models.Recipe
		err := row.Scan(&recipe.ID, &recipe.Name, &recipe.Category)
		if err!=nil{
			return []models.Recipe{}, err
		}

		recipes = append(recipes, recipe)
	}
	return recipes, nil
}