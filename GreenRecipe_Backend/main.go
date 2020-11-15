package main

import (
	"fmt"
	"github.com/gorilla/mux"
	"github.com/lib/pq"
	"io/ioutil"
	"log"
	"net/http"
	//"encoding/json"
)

func AddRecipe(w http.ResponseWriter, r * http.Request) {
	message := "adding recipe"
	vars := mux.Vars(r)
	fmt.Fprint(w,vars)
	return
	body, err := ioutil.ReadAll(r.Body)
	if err != nil {
		fmt.Fprint(w,err.Error())
		return
	}
	message += string(body)
	fmt.Fprint(w,message)
}

func HomeHandler(w http.ResponseWriter, r * http.Request) {
	fmt.Fprint(w,"Welcome page")
}


func main() {
	r := mux.NewRouter()
	r.HandleFunc("/hello",HomeHandler)
	r.HandleFunc("/addRecipe/{abc}/{d}",AddRecipe)
	http.Handle("/",r)

	connStr := "user=postgres dbname=postgres password=postgres sslmode=disable host=database-1.cbhzbc7blcip.us-west-1.rds.amazonaws.com"

	db,err := pq.Open(connStr)
	fmt.Println(db)
	fmt.Println(err)
	//http.HandleFunc("/hello", handleHello)

if err := http.ListenAndServe(":5000", nil); err != nil {
	log.Fatalln(err)
	}
}

func handleHello(w http.ResponseWriter, r *http.Request) {
	log.Println(r.Method, r.RequestURI)

	fmt.Fprintln(w, "Howdy horsey!")
}

