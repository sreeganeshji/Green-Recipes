package models

import "time"

type Recipe struct {
	ID          *int       `json:"id,omitempty"`
	Name        *string    `json:"name,omitempty"`
	Description *string `json:"description,omitempty"`
	Ingredients []*string  `json:"ingredients,omitempty"`
	Process     []*string  `json:"process,omitempty"`
	Contributor *string    `json:"contributor,omitempty"`
	Origin      *string    `json:"origin,omitempty"`
	Servings    int   `json:"servings,omitempty"`
	Equipment   []*string  `json:"equipment,omitempty"`
	Images      [] *string `json:"images,omitempty"`
	AddedDate   time.Time    `json:"added_date,omitempty"`
	Addedby     *int    `json:"addedby,omitempty"`
	Nutrition []*string `json:"nutrition,omitempty"`
	Category *string `json:"category,omitempty"`
}

type Review struct{
	Recipefk int `json:"recipefk"`
	Stars int `json:"stars"`
	Body *string `json:"body"`
	Likes int `json:"likes"`
	Dislikes int `json:"dislikes"`
	Images []*string `json:"images"`
}

type Reply struct{
	Body []*string `json:"body"`
	Likes int `json:"likes"`
	Dislikes int `json:"dislikes"`
	Reviewfk int `json:"reviewfk"`
	Recipefk int `json:"recipefk"`
}

type Person struct {

	UserID *int `json:"userid"`
	Appleid *string `json:"appleid"`
	Firstname *string `json:"firstname"`
	Lastname *string `json:"lastname"`
	Username *string `json:"username"`
	Email *string `json:"email"`
}

type Favorite struct {
	UserID *int `json:"userid"`
	RecipeID *int `json:"recipeid"`
}


