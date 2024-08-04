terraform {
  backend "s3" {
    bucket = "myterras"
    key    = "backend/todo-app.tfstate"
    region = "us-east-1"
  }
}