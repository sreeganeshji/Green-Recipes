package rest

import(
	"encoding/json"
	"fmt"
	models "greenrecipe/Models"
	"greenrecipe/Service"
	"github.com/gorilla/mux"
	"net/http"
)

type handler struct{
	Service *service.Service
}

func Initalizer(service service.Service) (*mux.Router){
	handler := handler{&service}
	r := mux.NewRouter()
	r.HandleFunc("/addrecipe",handler.AddRecipeHandler).Methods(http.MethodPost)

	return r
}

func (h *handler)AddRecipeHandler(w http.ResponseWriter, r *http.Request) {
	decoder := json.NewDecoder(r.Body)
	var recipe models.Recipe
	err := decoder.Decode(&recipe)
	if err!=nil{
		w.WriteHeader(http.StatusInternalServerError)
		w.Write([]byte(fmt.Sprint("Error unmarshalling JSON",err)))
		return
	}

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
