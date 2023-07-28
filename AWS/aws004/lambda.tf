# Zip Python Code
data "archive_file" "zip_python_code" {
    type = "zip"
    source_dir = "${path.module}/python/"
    output_path = "${path.module}/python/aws004-lambda.zip"
}

# Define Lambda Function
resource "aws_lambda_function" "aws004_lambda" {
    function_name = format("aws%s%s-lambda-function", var.project, var.environment)
    handler = "index.handler"
    runtime = "python3.8"
    timeout = 300
    memory_size = 128

    filename = "aws004-lambda.zip"
    source_code_hash = filebase64sha256("aws004-lambda.zip")

    role = aws_iam_role.aws004_lambda_role.arn
}