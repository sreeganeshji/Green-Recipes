package models

type Recipe struct {
	ID          *int       `json:"id"`
	Name        *string    `json:"name"`
	Description *string `json:"description"`
	Ingredients []*string  `json:"ingredients"`
	Process     []*string  `json:"process"`
	Contributor *string    `json:"contributor"`
	Origin      *string    `json:"origin"`
	Servings    int   `json:"servings"`
	Equipment   []*string  `json:"equipment"`
	Images      [] *string `json:"images"`
	AddedDate   *string    `json:"added_date"`
	Addedby     *string    `json:"addedby"`
	Nutrition []*string `json:"nutrition"`
	Category *string `json:"category"`
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




