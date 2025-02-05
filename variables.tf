variable "hash_key" {
  description = "Hash key of database"
  type        = string
  default     = "ISBN"
}

variable "sort_key" {
  description = "Sort key of database"
  type        = string
  default     = "Genre"
}

variable "vpc" {
  description = "VPC ID to use"
  type        = string
  default     = "vpc-012814271f30b4442"
}

variable "subnet" {
  description = "Subnet ID to use"
  type        = string
  default     = "subnet-079049edc56a73fc3"
}

variable "instance_type" {
  description = "Instance type to use"
  type = string
  default = "t2.micro"
}

variable "keypair" {
  description = "Keypair name to use"
  type        = string
  default     = "ky_keypair"
}