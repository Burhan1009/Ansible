#developer-infra
module "dev-infra" {
  source         = "./infra"
  env            = "dev"
  instance_count = 2
  instance_type  = "t2.micro"
  ami            = "ami-055e3d4f0bbeb5878"  # Add double quotes around the AMI ID
  volume_size    = 10
}

#stg-infra 


#prd-infra  