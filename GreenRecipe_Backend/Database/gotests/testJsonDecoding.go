package main
import (
	"fmt"
	"encoding/json"
)


type Person struct {
UserID *int `json:"userid"`
Appleid *string `json:"appleid"`
Firstname *string `json:"firstname"`
Lastname *string `json:"lastname"`
Username *string `json:"username"`
Email *string `json:"email"`
}


func main(){
	var jsonData = `{"userId":23,"firstName":"def","profilePic":"sdf","username":"abc","email":"wer","appleId":"sdf","lastName":"fhi"}`

	var person Person
	json.Unmarshal([]byte(jsonData),&person)
	fmt.Println("Decoding",jsonData)
	data,_ := json.Marshal(person)
	fmt.Println(string(data))

}
