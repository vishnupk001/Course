variable "aws_region" {
  description = "aws region name"
  type        = string
  default     = "ap-south-1"
}

variable "aws_access_key" {
  description = "aws access key"
  type        = string
  default     = "AKIAYFYJGMJ4CEB3C3H4"
}

variable "aws_secret_key" {
  description = "aws secret key"
  type        = string
  default     = "lOd141OTC+AXTQyLKZab9rtoYcZluFp9ZVxao3zp"
}

variable "project_name" {
  description = "project name"
  type        = string
  default     = "zomato"
}

variable "project_environment" {
  description = "project environment"
  type        = string
  default     = "production"
}