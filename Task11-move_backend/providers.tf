terraform {
  backend "s3" {
    bucket = "cmtr-959pompn-backend-new-bucket-1762942937"
    key    = "tf_code.tfstate"
    region = "us-east-1"
  }
}