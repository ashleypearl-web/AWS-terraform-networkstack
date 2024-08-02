variable "vpc_cidr_block" {
    description = "cidr block of effulgence vpc"
    type = string
}

variable "instance_tenancy" {
    description = "instance tenancy of vpc"
    type = string
}

variable "region" {
    description = "region in which vpc should"
    type = string
}

variable "tags" {
    description = "tags"
    type = map(string)
}

variable "pub_subnet_cidr_block" {
    description = "public subnet cidr block"
    type = string
  
}

variable "priv_subnet_cidr_block" {
    description = "private subnet cidr block"
    type = string
  
}
