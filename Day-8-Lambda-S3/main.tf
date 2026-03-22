#Create S3 bucket and lambda function to read the data from S3 bucket and print the data in lambda console.

resource "aws_s3_bucket" "mybucket" {
  bucket = "myuniquebucketname1234567822"

}

resource "aws_iam_role" "lambda_exec2" {
  name = "lambda_exec_role2"

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
  role       = aws_iam_role.lambda_exec2.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"

}
resource "aws_lambda_function" "lambda-3" {
  function_name    = "lambda-3-function"
  role             = aws_iam_role.lambda_exec2.arn
  handler          = "app.lambda_handler"
  runtime          = "python3.12"
  timeout          = 900
  memory_size      = 128
  filename         = "app.zip"
    #Without using filebase64sha256, terraform will always detect changes and re-deploy the lambda function, even if the code hasn't changed. By using filebase64sha256, terraform can compare the hash of the current file with the previous hash and only redeploy if there are actual changes in the code.
    source_code_hash = filebase64sha256("app.zip")
    environment {
    variables = {
      bucket_name = aws_s3_bucket.mybucket.bucket
    }
  }
}

