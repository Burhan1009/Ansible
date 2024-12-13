resource "aws_s3_bucket" "my_bucket" {
  bucket = "${var.env}-terraform-ansible-bucket-bk503"
  tags = {
    Name = "${var.env}-terraform-ansible-bucket-bk503"
    Environment = var.env
  }
}