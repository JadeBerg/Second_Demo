variable "environment" {}

variable "az_count" {}

variable "vpc" {}

variable "public_cidr" {
  type = list(string)
  default = [
    "172.17.1.0/24",
    "172.17.2.0/24"
  ]
}

variable "private_cidr" {
  type = list(string)
  default = [
    "172.17.10.0/24",
    "172.17.20.0/24"
  ]
}