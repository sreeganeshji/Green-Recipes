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

func (s *Service) AddUser(user models.Person) (models.Person, error){
	return s.Postgres.AddUser(user)
}

func (s *Service) GetUserWithAppleID(apple_id string) (models.Person, error){
	return s.Postgres.GetUserWithAppleID(apple_id)
}

func (s *Service) AddFavorite(user_id int, recipe_id int)(error){
	return s.Postgres.AddFavorite(user_id, recipe_id)
}

func (s *Service) RemoveFavorite(user_id int, recipe_id int)(error){
	return s.Postgres.RemoveFavorite(user_id, recipe_id)
}

func (s *Service) GetUserFavorites(user_id int)([]models.Recipe, error){
	return s.Postgres.GetUserFavorites(user_id)
}