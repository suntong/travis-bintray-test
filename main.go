package main

import (
	"fmt"
	"time"
)

var name string

func main() {
	fmt.Printf("Hello %s ... ", name)
	time.Sleep(time.Second)
	fmt.Println("Goodbye")
}
