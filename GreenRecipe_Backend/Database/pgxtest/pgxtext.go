package main

import (
	"context"
	_ "context"
	"fmt"
	_ "fmt"
	"github.com/jackc/pgx/v4"
	_ "os"
)

func main(){
	//config ,err := pgx.ParseConfig("postgres://postgres:postgres@database-1.cbhzbc7blcip.us-west-1.rds.amazonaws.com/postgres")
	//if err != nil{
	//	print(err.Error())
	//}

	connStr := "user=postgres dbname=postgres password=postgres host=database-1.cbhzbc7blcip.us-west-1.rds.amazonaws.com"
	conn,err:= pgx.Connect(context.Background(),connStr)
	if err!= nil{
		fmt.Println("couldn't connect")
	} else{
		fmt.Println(conn)
	}

	//connection,err:= pgx.ConnectConfig(context.Background(),config)
	//if err != nil {
	//	print(err.Error())
	//	fmt.Println("connection error")
	//}
	//print(connection)


}
