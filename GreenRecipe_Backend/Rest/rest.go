package rest

import(
	"encoding/json"
	"fmt"
	models "greenrecipe/Models"
	"greenrecipe/Service"
	"github.com/gorilla/mux"
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