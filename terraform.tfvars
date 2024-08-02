vpc_cidr_block = "10.0.0.0/16"

instance_tenancy = "default"

region = "us-east-1"

tags = {
      "Name" = "EffulgenceNetwork"
      "Env" = "dev"

}

pub_subnet_cidr_block = "10.0.0.0/19"

priv_subnet_cidr_block = "10.0.32.0/19"
