package main

import (
	"fmt"
	"log"
	"net/http"
	"os"
)

func handler(w http.ResponseWriter, r *http.Request) {
	fmt.Fprintf(w, "<h1>Hi there!</h1>")
	fmt.Fprintf(w, "<div>I am working on <b>%s</b> cluster</div>", os.Getenv("CLUSTER_NAME"))
	fmt.Fprintf(w, "<div>in <b>%s</b> region</div>", os.Getenv("REGION"))
	fmt.Fprintf(w, "<div>at <b>%s</b> environment</div>", os.Getenv("ENVIRONMENT"))
	fmt.Fprintf(w, "<div>getting data from <b>%s</b> database</div>", os.Getenv("DATABASE_URL"))
}

func main() {
	http.HandleFunc("/", handler)
	log.Fatal(http.ListenAndServe(":"+os.Getenv("PORT"), nil))
}
