locals {
  hdfc_downloader_file = "hdfc_downloader.zip"
}


resource "aws_lambda_function" "hdfc_mfdata_download" {
  function_name = "${local.prefix}-hdfc-mfdata-download"
  description = "Download portfolio from HDFC mutual fund website, covert to a standard format and put it in the queue"
  role = aws_iam_role.lambda_role.arn
  runtime = "python3.10"
  s3_bucket = aws_s3_bucket.lambda_code.bucket
  s3_key = aws_s3_object.lambda_handler.id 
  handler = "main.main"
  environment {
    variables = {
      OUTPUT_BUCKET = aws_s3_bucket.stock_data.bucket 
    }
  }
  timeout = 900
}
data "archive_file" "lambda" {
  type        = "zip"
  source_file = "main.py"
  output_path = "code.zip"
}

resource "aws_s3_object" "lambda_handler" {
  bucket = aws_s3_bucket.lambda_code.bucket
  key = local.hdfc_downloader_file
  source = data.archive_file.lambda.output_path
  lifecycle {
    ignore_changes = all
  }
}

