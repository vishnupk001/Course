terraform {
  backend "s3" {
    bucket         = "terraform-statefile.vpkdevops.online"
    key            = "terraform.tfstate"
    region         = "ap-south-1"                       
  }
}
