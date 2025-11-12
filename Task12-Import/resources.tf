resource "aws_iam_policy" "s3_ec2_policy" {
  name        = "cmtr-959pompn-iam-policy"
  description = "Custom role with limited permissions"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "ec2:*",
          "s3:*"
        ]
        Resource = "*"
      }
    ]
  })
}
#terraform import aws_iam_policy.s3_ec2_policy arn:aws:iam::585008068960:policy/cmtr-959pompn-iam-policy
#aws iam list-policies --query "Policies[?PolicyName=='cmtr-959pompn-iam-policy'].Arn" --output text
