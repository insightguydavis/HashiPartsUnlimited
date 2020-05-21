terraform {
  required_providers {
    aws = "~> 2.0"
  }
  # backend "remote" {
  #   hostname = "app.terraform.io"
  #   organization = "cardinalsolutions"

  #   workspaces {
  #     prefix = "parts-unlimited-"
  #   }
  # }
}