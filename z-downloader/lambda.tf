
data "aws_ssm_parameter" "z_username" {
  name = "Z_USERNAME"
}

data "aws_ssm_parameter" "z_password" {
  name = "Z_PASSWORD"
}

data "aws_ssm_parameter" "z_secret" {
  name = "Z_SECRET"
}


resource "aws_lambda_function" "zdownloader" {
  function_name = "${local.prefix}"
  role = aws_iam_role.z_downloader_lambda_role.arn
  runtime = "python3.12"
  s3_bucket = aws_s3_bucket.lambda_code.bucket
  s3_key =  aws_s3_object.lambda_handler.id
  handler = "main.download_handler"
  environment {
    variables = {
      OUTPUT_BUCKET = aws_s3_bucket.stock_data.bucket 
      Z_USERNAME = data.aws_ssm_parameter.z_username.value
      Z_PASSWORD = data.aws_ssm_parameter.z_password.value
      Z_SECRET = data.aws_ssm_parameter.z_secret.value
    }
  }
  timeout = 900
}

data "archive_file" "lambda" {
  type        = "zip"
  source_file = "main.py"
  output_path = "lambda_function_payload.zip"
}

resource "aws_s3_object" "lambda_handler" {
  bucket = aws_s3_bucket.lambda_code.bucket
  key = "code.zip"
  source = data.archive_file.lambda.output_path
  lifecycle {
    ignore_changes = all
  }
}