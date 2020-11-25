package service

import(
	"greenrecipe/Database"
    "greenrecipe/Models"
)

type Service struct{
 Postgres database.Postgres
}

func (s *Service) AddRecipe(recipe models.Recipe) (models.Recipe, error){
	return s.Postgres.AddRecipe(recipe)
}
