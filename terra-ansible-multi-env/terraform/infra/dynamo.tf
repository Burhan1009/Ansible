resource "aws_dynamodb_table" "my_table" {
  name = "${var.env}-terraform-ansible-app-bk503-table"
  billing_mode = "PAY_PER_REQUEST"
  hash_key = "userID"
  attribute {
    name = "userID"
    type = "S"
  }
  tags = {
    Name = "${var.env}-terraform-ansible-app-bk503-table"
    Environment = var.env
  }
}