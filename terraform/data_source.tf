data "aws_ami" "main" {
  most_recent = true
  name_regex  = "^example"
  owners      = ["self"]
}

data "aws_vpc" "main" {
  id = var.vpc_id
}
