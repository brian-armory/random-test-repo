
terraform {
  backend "s3" {
    bucket  = "brian-terraform-state"
    key     = "workspace-dev.tfstate"
    region  = "us-west-2"
    encrypt = false
    profile = "dev"
  }
}

provider "aws" {
  profile = "dev"
  region  = "us-west-2"
}

variable "tag" {
  default = "defaultTag"
}
resource "aws_s3_bucket" "b" {
  bucket = "brian-terraform-bucket"
  acl    = "private"

  tags = {
    Name = "Brian Terraform Bucket"
    Overridden = "${var.tag}"
  }
}

output "bucket_name" {
  value = "${aws_s3_bucket.b.bucket}"
}