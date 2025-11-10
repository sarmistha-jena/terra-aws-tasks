resource "aws_iam_group" "iam_group_name" {
  name = var.iam_group_name
}

resource "aws_iam_policy" "iam_policy_name" {
  name        = var.iam_policy_name
  path        = "/"
  description = "S3 write policy"

  policy = templatefile("${path.module}/policy.json", {
  bucket_name = var.bucket_name })
  tags = {
    Project = var.project_id
  }
}

resource "aws_iam_role_policy_attachment" "attach_policy_to_role" {
  role       = aws_iam_role.iam_role_ec2.name
  policy_arn = aws_iam_policy.iam_policy_name.arn
}

resource "aws_iam_instance_profile" "iam_instance_profile_name" {
  name = var.iam_instance_profile_name
  role = aws_iam_role.iam_role_ec2.name
  tags = {
    Project = var.project_id
  }
}

resource "aws_iam_role" "iam_role_ec2" {
  name = var.iam_role_name
  path = "/"
  tags = {
    Project = var.project_id
  }

  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "sts:AssumeRole",
            "Principal": {
               "Service": "ec2.amazonaws.com"
            },
            "Effect": "Allow",
            "Sid": ""
        }
    ]
}
EOF
}