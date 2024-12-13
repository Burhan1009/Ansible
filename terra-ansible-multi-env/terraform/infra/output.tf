 output "ec2_public_ips" {
   value = aws_instance.my_ec2[*].public_ip
    description = "Public IP Address of aws EC2 Instance"
 }
  output "ec2_private_ips" {
   value = aws_instance.my_ec2[*].private_ip
    description = "Private IP Address of aws EC2 Instance"
 }
 