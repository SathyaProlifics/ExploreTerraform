resource "aws_iam_role" "lambda_exec" {
  name = "lambda_exec_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_exec_attach" {
  role       = aws_iam_role.lambda_exec.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"

}
resource "aws_lambda_function" "lambda-2" {
  function_name = "lambda-2-function"
  role          = aws_iam_role.lambda_exec.arn
  handler       = "app.lambda_handler"
  runtime       = "python3.12"
  timeout       = 900
  memory_size   = 128
  filename      = "app.zip"
  #Without using filebase64sha256, terraform will always detect changes and re-deploy the lambda function, even if the code hasn't changed. By using filebase64sha256, terraform can compare the hash of the current file with the previous hash and only redeploy if there are actual changes in the code.
  source_code_hash = filebase64sha256("app.zip")

}