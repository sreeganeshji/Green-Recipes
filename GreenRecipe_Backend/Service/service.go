package service

import (
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

func (s *Service) SubmitReview(review models.Review)(int, error){
	return s.Postgres.SubmitReview(review)
}

func (s *Service) FetchReviews(recipe_id int)([]models.Review, error){
	return s.Postgres.FetchReviews(recipe_id)
}

func (s *Service) FetchMyRecipes(person_id int)([]models.Recipe, error){
	return s.Postgres.FetchMyRecipes(person_id)
}

func (s *Service) UpdateRecipe(recipe models.Recipe)(int, error){
	return s.Postgres.UpdateRecipe(recipe)
}

func (s *Service) UpdateUserProfile(user models.Person)(int, error){
	return s.Postgres.UpdateUserProfile(user)
}

func (s *Service) FetchMyReview(person_id int, recipe_id int)(models.Review, error){
	return s.Postgres.FetchMyReview(person_id, recipe_id)
}

func (s *Service) GetUserName(person_id int)(string, error){
	return s.Postgres.GetUserName(person_id)
}

func (s *Service) UpdateMyReview(review models.Review)(int, error){
	return s.Postgres.UpdateMyReview(review)
}

func (s *Service) DeleteMyReview(review_id int)(error){
	return s.Postgres.DeleteMyReview(review_id)
}

func (s *Service) DeleteMyRecipe(recipe_id int)(error){
	return s.Postgres.DeleteMyRecipe(recipe_id)
}

func (s *Service) SubmitReport(report models.Report)(int, error){
	return s.Postgres.SubmitReport(report)
}

func (s *Service) UpdateRecipeRating(recipe_id int, rating float64, rating_count int)(int, error){
	return s.Postgres.UpdateRecipeRating(recipe_id, rating, rating_count)
}

func (s *Service) FetchRecipesOfCategory(category string)([]models.Recipe, error){
	return s.Postgres.FetchRecipesOfCategory(category)
}