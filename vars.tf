# variable "AWS_ACCESS_KEY_ID" {
#   type = string
# }

# variable "AWS_SECRET_ACCESS_KEY" {
#   type = string
# }

variable "Region" {
  type    = string
  default = "us-east-1"
}
variable "main_vpc_cidr" {}
variable "public_subnets" {
  
}
variable "private_subnets" {
  
}
