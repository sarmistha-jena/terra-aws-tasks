resource "aws_s3_bucket" "bucket" {
  bucket = "cmtr-959pompn-bucket-1762523245"
  region = "us-east-1"
  tags = {
    Project = "cmtr-959pompn"
    Name    = "cmtr-959pompn-bucket-1762523245"
  }
}