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
	ID *int `json:"id,omitempty"`
	Personfk *int `json:"personfk,omitempty"`
	Recipefk *int `json:"recipefk,omitempty"`
	Stars int `json:"stars,omitempty"`
	Body *string `json:"body,omitempty"`
	Title *string `json:"title,omitempty"`
	Likes int `json:"likes,omitempty"`
	Dislikes int `json:"dislikes,omitempty"`
	Images []*string `json:"images,omitempty"`
	Created time.Time `json:"created,omitempty"`
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


