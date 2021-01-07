package rest

import (
	"encoding/json"
	"fmt"
	"github.com/gorilla/mux"
	models "greenrecipe/Models"
	"greenrecipe/Service"
	"log"
	"net/http"
	"strconv"
)

type handler struct{
	Service *service.Service
}

func Initalizer(service service.Service) (*mux.Router){
	handler := handler{&service}
	r := mux.NewRouter()
	r.HandleFunc("/addrecipe",handler.AddRecipeHandler).Methods(http.MethodPost)
	r.HandleFunc("/findrecipeslike/{text}", handler.FindRecipesLikeHandler).Methods(http.MethodGet)
	r.HandleFunc("/findrecipewithid/{id}", handler.FindRecipeWithID).Methods(http.MethodGet)
	r.HandleFunc("/adduser",handler.AddUser).Methods(http.MethodPost)
	r.HandleFunc("/getuserwithappleid/{apple_id}", handler.GetUserWithAppleID).Methods(http.MethodGet)
	r.HandleFunc("/getuserfavorites/{person_id}", handler.GetUserFavorites).Methods(http.MethodGet)
	r.HandleFunc("/addfavorite/{person_id}/{recipe_id}", handler.AddFavorite).Methods(http.MethodPost)
	r.HandleFunc("/removefavorite/{person_id}/{recipe_id}", handler.RemoveFavorite).Methods(http.MethodDelete)
	r.HandleFunc("/submitreview",handler.SubmitReview).Methods(http.MethodPost)
	r.HandleFunc("/fetchreviews/{recipe_id}",handler.FetchReviews).Methods(http.MethodGet)
	r.HandleFunc("/fetchmyrecipes/{person_id}",handler.FetchMyRecipes).Methods(http.MethodGet)
	r.HandleFunc("/updaterecipe",handler.UpdateRecipe).Methods(http.MethodPut)
	r.HandleFunc("/updateuserprofile",handler.UpdateUserProfile).Methods(http.MethodPut)
	r.HandleFunc("/fetchmyreview/{review_id}/{person_id}", handler.FetchMyReview).Methods(http.MethodGet)
	r.HandleFunc("/getusername/{person_id}",handler.GetUserName).Methods(http.MethodGet)
	return r
}

func (h *handler)AddRecipeHandler(w http.ResponseWriter, r *http.Request) {
	log.Println(w,"add recipe")
	decoder := json.NewDecoder(r.Body)
	var recipe models.Recipe
	err := decoder.Decode(&recipe)
	if err!=nil{
		w.WriteHeader(http.StatusInternalServerError)
		w.Write([]byte(fmt.Sprint("Error unmarshalling JSON",err)))
		return
	}
	encoder := json.NewEncoder(w)

	err = encoder.Encode(recipe)
	if (err!=nil){
		w.WriteHeader(http.StatusInternalServerError)
		w.Write([]byte(fmt.Sprint("error encoding",err)))
		return
	}
	fmt.Println("decoded new recipe", recipe)
	fmt.Println("absent parameter nutrients, category",recipe.Nutrition, recipe.Category)

	log.Println("decoded recipe",recipe)
	insertedRecipe, err := h.Service.AddRecipe(recipe)
	if err!=nil {
		w.WriteHeader(http.StatusInternalServerError)
		w.Write([]byte(fmt.Sprint("Error saving model to backend",err)))
		return
	}
	w.Header().Set("Content-Type","application/json")
	w.WriteHeader(http.StatusCreated)
	json.NewEncoder(w).Encode(insertedRecipe)
}

func (h *handler) FindRecipesLikeHandler(w http.ResponseWriter, r *http.Request){
	vars := mux.Vars(r)
	w.WriteHeader(http.StatusOK)
	text := vars["text"]
	fmt.Println("Text is",text)

	//call the service.
	recipes,err := h.Service.FindRecipesLike(text,10)

	if err!=nil{
		//server error
		w.WriteHeader(http.StatusInternalServerError)
		w.Write([]byte(fmt.Sprint("Error querying the database: ", err.Error())))
		return
	}

	data,err := json.Marshal(recipes)

	w.Write(data)
	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(http.StatusOK)
}

func (h *handler) FindRecipeWithID(w http.ResponseWriter, r * http.Request){
	vars := mux.Vars(r)
	id, err := strconv.Atoi(vars["id"])
	if err!=nil{
		w.WriteHeader(http.StatusInternalServerError)
		w.Write([]byte(fmt.Sprint("error getting the id: ",err)))
		return
	}
	if id<0{
		w.WriteHeader(http.StatusBadRequest)
		w.Write([]byte(fmt.Sprint("cannot have negative id ",id)))
		return
	}

	recipe, err := h.Service.FindRecipeWithID(id)
	if err!=nil{
		w.WriteHeader(http.StatusInternalServerError)
		w.Write([]byte(fmt.Sprint("database error: ",err)))
		return
	}

	response,err := json.Marshal(recipe)

	if err!=nil{
		w.Write([]byte(fmt.Sprint("cannot marshal recipe: ",err)))
		w.WriteHeader(http.StatusInternalServerError)
		return
	}

	w.WriteHeader(http.StatusOK)
	w.Write(response)
	w.Header().Set("Content-Type", "application/json")
}

func (h *handler) AddUser(w http.ResponseWriter, r *http.Request){

	decoder := json.NewDecoder(r.Body)
	var user models.Person
	err := decoder.Decode(&user)
	if err!=nil{
		w.WriteHeader(http.StatusInternalServerError)
		w.Write([]byte(fmt.Sprint("Error decoding request: ",err)))
		return
	}

	user_rec,err := h.Service.AddUser(user)
	if err!=nil{
		w.WriteHeader(http.StatusInternalServerError)
		w.Write([]byte(fmt.Sprint("Database error: ", err)))
		return
	}

	response,err := json.Marshal(user_rec)
	if err!=nil {
		w.WriteHeader(http.StatusInternalServerError)
		w.Write([]byte(fmt.Sprint("Error marshalling data: ",err)))
		return
	}

	w.WriteHeader(http.StatusOK)
	w.Write(response)
	w.Header().Set("Content-Type","application/json")
}

func (h *handler) GetUserWithAppleID(w http.ResponseWriter, r *http.Request){
	vars := mux.Vars(r)
	apple_id := vars["apple_id"]

	user, err := h.Service.GetUserWithAppleID(apple_id)
	if err!=nil{
		w.WriteHeader(http.StatusInternalServerError)
		w.Write([]byte(fmt.Sprint("database error: ",err)))
		return
	}

	response,err := json.Marshal(user)
	if err!=nil{
		w.WriteHeader(http.StatusInternalServerError)
		w.Write([]byte(fmt.Sprint("Error marshalling json: ",err)))
		return
	}

	w.WriteHeader(http.StatusOK)
	w.Write(response)
}

func (h *handler) AddFavorite(w http.ResponseWriter, r *http.Request){
	vars := mux.Vars(r)
	person_id, err := strconv.Atoi(vars["person_id"])
	if err!=nil{
		w.WriteHeader(http.StatusInternalServerError)
		w.Write([]byte(fmt.Sprint("Error getting person_id: ",err)))
		return
	}
	recipe_id, err := strconv.Atoi(vars["recipe_id"])
	if err!=nil{
		w.WriteHeader(http.StatusInternalServerError)
		w.Write([]byte(fmt.Sprint("Error getting recipe_id: ",err)))
		return
	}

	err = h.Service.AddFavorite(person_id, recipe_id)
	if err!=nil{
		w.WriteHeader(http.StatusInternalServerError)
		w.Write([]byte(fmt.Sprint("Error getting recipe_id: ",err)))
		return
	}

}

func (h *handler) RemoveFavorite(w http.ResponseWriter, r *http.Request){
	vars := mux.Vars(r)
	person_id, err := strconv.Atoi(vars["person_id"])
	if err!=nil{
		w.WriteHeader(http.StatusInternalServerError)
		w.Write([]byte(fmt.Sprint("Error getting person_id: ",err)))
		return
	}
	recipe_id, err := strconv.Atoi(vars["recipe_id"])
	if err!=nil{
		w.WriteHeader(http.StatusInternalServerError)
		w.Write([]byte(fmt.Sprint("Error getting recipe_id: ",err)))
		return
	}

	err = h.Service.RemoveFavorite(person_id, recipe_id)
	if err!=nil{
		w.WriteHeader(http.StatusInternalServerError)
		w.Write([]byte(fmt.Sprint("Error getting recipe_id: ",err)))
		return
	}
}

func (h *handler) GetUserFavorites(w http.ResponseWriter, r *http.Request){
	fmt.Println("Getting user favorites")
	vars := mux.Vars(r)
	person_id, err := strconv.Atoi(vars["person_id"])
	if err!=nil{
		w.WriteHeader(http.StatusInternalServerError)
		w.Write([]byte(fmt.Sprint("unable to get the person_id: ", err)))
		return
	}
	var favorites []models.Recipe

	favorites, err = h.Service.GetUserFavorites(person_id)
	if err!=nil{
		w.WriteHeader(http.StatusInternalServerError)
		w.Write([]byte(fmt.Sprint("Error getting favorites: ",err)))
		return
	}
	data,err := json.Marshal(favorites)

	w.Write(data)
	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(http.StatusOK)
}

func (h *handler) SubmitReview(w http.ResponseWriter, r *http.Request){
	fmt.Println("Submitting review")
	decoder := json.NewDecoder(r.Body)
	var review models.Review
	err := decoder.Decode(&review)
	if err!=nil{
		w.WriteHeader(http.StatusInternalServerError)
		w.Write([]byte(fmt.Sprint("Error unmarshalling JSON",err)))
		return
	}

	review_id, err := h.Service.SubmitReview(review)
	if err!=nil {
		w.WriteHeader(http.StatusInternalServerError)
		w.Write([]byte(fmt.Sprint("Error saving review to database:",err)))
		return
	}
	data, err := json.Marshal(review_id)
	w.Write(data)
	w.WriteHeader(http.StatusCreated)
}

func (h *handler) FetchReviews(w http.ResponseWriter, r *http.Request){

	vars := mux.Vars(r)
	recipe_id, err := strconv.Atoi(vars["recipe_id"])
	if err!=nil{
		w.WriteHeader(http.StatusInternalServerError)
		w.Write([]byte(fmt.Sprint("unable to get the recipe_id: ", err)))
		return
	}
	var reviews []models.Review

	reviews, err = h.Service.FetchReviews(recipe_id)
	if err!=nil{
		w.WriteHeader(http.StatusInternalServerError)
		w.Write([]byte(fmt.Sprint("Error getting favorites: ",err)))
		return
	}
	data,err := json.Marshal(reviews)

	w.Write(data)
	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(http.StatusOK)
}

func (h *handler) FetchMyRecipes(w http.ResponseWriter, r *http.Request){
	fmt.Println("Getting my recipes")
	vars := mux.Vars(r)

	person_id, err := strconv.Atoi(vars["user_id"])
	if err!=nil{
		w.WriteHeader(http.StatusInternalServerError)
		w.Write([]byte(fmt.Sprint("unable to get the user_id: ", err)))
		return
	}
	var recipe []models.Recipe

	recipe, err = h.Service.FetchMyRecipes(person_id)
	if err!=nil{
		w.WriteHeader(http.StatusInternalServerError)
		w.Write([]byte(fmt.Sprint("Error getting favorites: ",err)))
		return
	}
	data,err := json.Marshal(recipe)

	w.Write(data)
	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(http.StatusOK)
}

func (h *handler) UpdateRecipe(w http.ResponseWriter, r *http.Request){
	decoder := json.NewDecoder(r.Body)
	var recipe models.Recipe
	err := decoder.Decode(&recipe)
	if err!=nil{
		w.WriteHeader(http.StatusInternalServerError)
		w.Write([]byte(fmt.Sprint("Error unmarshalling JSON",err)))
		return
	}

	err = h.Service.UpdateRecipe(recipe)
	if err!=nil {
		w.WriteHeader(http.StatusInternalServerError)
		w.Write([]byte(fmt.Sprint("Error saving review to database:",err)))
		return
	}

	w.WriteHeader(http.StatusAccepted)
}

func (h *handler) UpdateUserProfile(w http.ResponseWriter, r *http.Request){
	decoder := json.NewDecoder(r.Body)
	var person models.Person
	err := decoder.Decode(&person)
	if err!=nil{
		w.WriteHeader(http.StatusInternalServerError)
		w.Write([]byte(fmt.Sprint("Error unmarshalling JSON",err)))
		return
	}

	err = h.Service.UpdateUserProfile(person)
	if err!=nil {
		w.WriteHeader(http.StatusInternalServerError)
		w.Write([]byte(fmt.Sprint("Error saving review to database:",err)))
		return
	}

	w.WriteHeader(http.StatusAccepted)
}

func (h *handler) FetchMyReview(w http.ResponseWriter, r* http.Request){
	fmt.Println("Getting my review")
	vars := mux.Vars(r)

	person_id, err := strconv.Atoi(vars["user_id"])
	if err!=nil{
		w.WriteHeader(http.StatusInternalServerError)
		w.Write([]byte(fmt.Sprint("unable to get the user_id: ", err)))
		return
	}

	recipe_id, err := strconv.Atoi(vars["recipe_id"])
	if err!=nil{
		w.WriteHeader(http.StatusInternalServerError)
		w.Write([]byte(fmt.Sprint("unable to get the user_id: ", err)))
		return
	}
	var review models.Review

	review, err = h.Service.FetchMyReview(person_id, recipe_id)
	if err!=nil{
		w.WriteHeader(http.StatusInternalServerError)
		w.Write([]byte(fmt.Sprint("Error getting favorites: ",err)))
		return
	}
	data,err := json.Marshal(review)

	w.Write(data)
	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(http.StatusOK)
}

func (h *handler) GetUserName(w http.ResponseWriter, r *http.Request){
	vars := mux.Vars(r)

	person_id, err := strconv.Atoi(vars["person_id"])
	if err!=nil{
		w.WriteHeader(http.StatusInternalServerError)
		w.Write([]byte(fmt.Sprint("unable to get the person_id: ", err)))
		return
	}

	username, err := h.Service.GetUserName(person_id)
	if err!=nil{
		w.WriteHeader(http.StatusInternalServerError)
		w.Write([]byte(fmt.Sprint("Error getting username: ",err)))
		return
	}
	data,err := json.Marshal(username)

	w.Write(data)
	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(http.StatusOK)
}