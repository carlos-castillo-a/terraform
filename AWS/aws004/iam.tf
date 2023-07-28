# Lambda Role
resource "aws_iam_role" "aws004_lambda_role" {
    name = format("aws%s%s-lambda-iam-role", var.project, var.environment)
    assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

# Lambda IAM Policy
resource "aws_iam_policy" "aws004_lambda_policy" {
  name = format("aws%s%s-lambda-iam-policy-%03d", var.project, var.environment, count.index + 1)
  path = "/"
  description = format("AWS IAM Policy for %s", aws_iam_role.aws004_lambda_role.name)
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "s3:GetObjectVersion",
        "s3:ListBucket",
        "s3:DeleteObjectVersion"
      ],
      "Resource": [
        "arn:aws:s3:::*castillo-a.com/*"
      ]
    },
    {
        "Effect": "Allow",
        "Action": [
            "logs:CreateLogGroup",
            "logs:CreateLogStream",
            "logs:PutLogEvents"
        ],
        Resource": "arn:aws:logs:*:*:*"
    }
  ]
}
EOF
}

# Attachment
resource "aws_iam_role_policy_attachment" "aws004_policy_attachment" {
  policy_arn = aws_iam_policy.aws004_lambda_policy.arn
  role       = aws_iam_role.aws004_lambda_role.name
}