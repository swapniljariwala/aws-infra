resource "aws_lambda_function" "zdownloader" {
  function_name = "${local.prefix}"
  role = aws_iam_role.z_downloader_lambda_role.arn
  runtime = "python3.12"
  s3_bucket = aws_s3_bucket.lambda_code.bucket
  s3_key =  aws_s3_object.lambda_handler.id
  handler = "main.downlaod_handler"
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