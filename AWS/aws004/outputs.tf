output "aws004_lambda_role_name" {
  value = aws_iam_role.aws004_lambda_role.name
}

output "aws004_lambda_role_arn" {
  value = aws_iam_role.aws004_lambda_role.arn
}

output "aws004_lambda_policy_arn" {
  value = aws_iam_policy.aws004_lambda_policy.arn
}