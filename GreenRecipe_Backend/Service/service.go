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

func (s *Service) FindRecipesLike(text string, count int) ([]models.Recipe, error){
	return s.Postgres.FindRecipesLike(text, count)
}

func (s *Service) FindRecipeWithID(id int) (models.Recipe, error){
	return s.Postgres.FindRecipeWithID(id)
}
