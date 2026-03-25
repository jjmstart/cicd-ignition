package main

import (
	"fmt"
	"net/http"
)

func main() {
	// 定义一个简单的路由，返回一段标识信息
	http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
		fmt.Fprintf(w, "Hello CI/CD! The pipeline is working. Version: 1.0.0")
	})
	
	// 监听 8080 端口
	fmt.Println("Server is starting on port 8080...")
	err := http.ListenAndServe(":8080", nil)
	if err != nil {
		panic(err)
	}
}