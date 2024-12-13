variable "env" {
  description = "this is the env name eg. dev/stg/prm"
  type        = string
}
variable "instance_type" {
  description = "this is the instance Variable"
  type        = string
}
variable "instance_count" {
  description = "This is the count of the number of instance"
  type        = number
}
variable "ami" {
  description = "This is the AMI ID for EC2 instance"
  type        = string
}

variable "volume_size" {
  description = "This is the size of Root EBS for Ec2"
  type = number
}
