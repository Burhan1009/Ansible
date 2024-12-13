resource "aws_key_pair" "deployer" {
  key_name   = "${var.env}-terraform-ansible-bk503-key"           # The key name
  public_key = file("terraform-ansible-bk503-key.pub") # Specifies the public key file
}

resource "aws_default_vpc" "default" {}

resource "aws_security_group" "allow_user_to_connect" {
  name        = "${var.env}terraform-ansible-sg"
  description = "This is an SG created using Terraform"
    vpc_id      = aws_default_vpc.default.id

  # Ingress rules for incoming traffic
  ingress {
    description = "Allow access to SSH port 22"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow access to HTTP port 80"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

# Egress rules for outgoing traffic
  egress {
    description = "Allow all outgoing traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "port 443 allow"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.env}terraform-ansible-sg"
    Environment = var.env
  }
}

resource "aws_instance" "my_ec2" {
  count                       = var.instance_count
  ami                         = var.ami # Replace with a valid AMI ID for your region
  instance_type               = var.instance_type
  security_groups             = [aws_security_group.allow_user_to_connect.name] # Use .name for security group name
  key_name                    = aws_key_pair.deployer.key_name
  associate_public_ip_address = true

  root_block_device {
    volume_size = var.volume_size
    volume_type = "gp2"
  }

  tags = {
    Name        = "${var.env}-terraform-ansible-bk503"
    Environment = var.env
  }
}
