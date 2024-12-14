#developer-infra
module "dev-infra" {
  source         = "./infra"
  env            = "dev"
  instance_count = 2
  instance_type  = "t2.micro"
  ami            = "ami-055e3d4f0bbeb5878"  # Add double quotes around the AMI ID
  volume_size    = 10
}

#Stg-infra 
module "stg-infra" {
  source         = "./infra"
  env            = "stg"
  instance_count = 2
  instance_type  = "t2.micro"
  ami            = "ami-055e3d4f0bbeb5878"  # Add double quotes around the AMI ID
  volume_size    = 10
}

#Production-infra 
module "prd-infra" {
  source         = "./infra"
  env            = "prd"
  instance_count = 2
  instance_type  = "t2.micro"
  ami            = "ami-055e3d4f0bbeb5878"  # Add double quotes around the AMI ID
  volume_size    = 10
}

output "dev_infra_ec2_public_ips" {
  value = module.dev-infra.ec2_public_ips
}

output "dev_infra_ec2_private_ips" {
  value = module.dev-infra.ec2_private_ips
}

output "stg_infra_ec2_public_ips" {
  value = module.stg-infra.ec2_public_ips
}

output "stg_infra_ec2_private_ips" {
  value = module.stg-infra.ec2_private_ips
}

output "prd_infra_ec2_public_ips" {
  value = module.prd-infra.ec2_public_ips
}

output "prd_infra_ec2_private_ips" {
  value = module.prd-infra.ec2_private_ips
}
