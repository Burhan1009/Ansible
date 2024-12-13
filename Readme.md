![image](https://github.com/user-attachments/assets/4a62ec3a-9c07-4d32-98fa-56b830364fa0)

# Terraform-Ansible Infrastructure Setup

This project automates the provisioning of AWS infrastructure using Terraform. It includes EC2 instances, VPC, security groups, key pairs, and other essential resources for a development environment. The setup also supports scalable infrastructure by leveraging Terraform modules.

---

## Features

1. **EC2 Instances:**
   - Creates EC2 instances with specified AMI, instance type, and storage.
   - Automatically assigns public IPs to instances.

2. **Key Pair:**
   - Generates an SSH key pair for secure access to EC2 instances.

3. **VPC and Networking:**
   - Sets up a default VPC for networking.
   - Creates security groups with ingress and egress rules for SSH, HTTP, and HTTPS traffic.

4. **Reusability:**
   - Utilizes modules for defining reusable and scalable infrastructure components.

---

## Prerequisites

- **AWS CLI**: Installed and configured with appropriate permissions.
- **Terraform**: Installed on your local machine.
- **Public Key**: Ensure the public key file (`terraform-ansible-bk503-key.pub`) exists.

---

## Variables

### Input Variables:

| Variable         | Type    | Description                              |
|------------------|---------|------------------------------------------|
| `env`            | String  | Environment name (e.g., `dev`, `stg`).   |
| `instance_type`  | String  | EC2 instance type (e.g., `t2.micro`).    |
| `instance_count` | Number  | Number of EC2 instances to create.       |
| `ami`            | String  | AMI ID for the EC2 instances.            |
| `volume_size`    | Number  | Storage size in GB for each instance.    |

### Outputs:

| Output Name        | Description                                  |
|--------------------|----------------------------------------------|
| `ec2_public_ips`   | Public IP addresses of the EC2 instances.    |
| `ec2_private_ips`  | Private IP addresses of the EC2 instances.   |

---

## Modules

### dev-infra

The `dev-infra` module defines reusable infrastructure configurations. Example usage:

```hcl
module "dev-infra" {
  source = "./infra"
  env = "dev"
  instance_count = 2
  instance_type = "t2.micro"
  ami = "ami-055e3d4f0bbeb5878"
  volume_size = 10
}
```

---

## Resources

1. **Key Pair**
   - Name: `${var.env}-terraform-ansible-bk503-key`
   - Reads public key from `terraform-ansible-bk503-key.pub`.

2. **VPC**
   - Creates a default VPC for networking.

3. **Security Group**
   - Allows traffic for SSH (port 22), HTTP (port 80), and HTTPS (port 443).

4. **EC2 Instances**
   - Configured with the specified AMI, instance type, and attached storage.

---

## Example Security Group Configuration

```hcl
resource "aws_security_group" "allow_user_to_connect" {
  name        = "${var.env}terraform-ansible-sg"
  description = "This is an SG created using Terraform"
  vpc_id      = aws_default_vpc.default.id

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

  ingress {
    description = "Allow access to HTTPS port 443"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outgoing traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.env}terraform-ansible-sg"
    Environment = var.env
  }
}
```

---

## Steps to Deploy

1. Initialize Terraform:
   ```bash
   terraform init
   ```

2. Validate the configuration:
   ```bash
   terraform validate
   ```

3. Apply the configuration:
   ```bash
   terraform apply
   ```

4. Confirm resources are created successfully.

---

## Tags

- Environment: Dynamically tagged based on `env` variable.
- Name: Each resource includes descriptive tags for easy identification.

---

## Troubleshooting

1. **Incorrect Attribute Type**:
   - Ensure `security_groups` references the name of the security group.
   - Use `vpc_security_group_ids` for security group IDs.

2. **Missing Public Key**:
   - Ensure `terraform-ansible-bk503-key.pub` exists in the working directory.

3. **Invalid AMI ID**:
   - Replace `ami` with a valid AMI ID for your region.

---

## Author
This project was developed for setting up scalable and reusable AWS infrastructure using Terraform and Ansible.

