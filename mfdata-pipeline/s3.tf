resource "aws_s3_bucket" "stock_data" {
  bucket = "${local.prefix}-stock-data"

  tags = {
    Name        = "${local.prefix}-stock-data"

  }
}

resource "aws_s3_bucket" "lambda_code" {
  bucket = "${local.prefix}-lambda-code"

  tags = {
    Name        = "${local.prefix}-lambda-code"

  }
}
resource "aws_s3_bucket" "athena_results" {
  bucket = "${local.prefix}-athena-results"

  tags = {
    Name        = "${local.prefix}-athena-results"

  }
}


output "z_downloader_stock_data_bucket" {
  value = aws_s3_bucket.stock_data.bucket
}

output "z_downloader_code_bucket" {
    value = aws_s3_bucket.lambda_code.bucket
}

output "z_downloader_athena_results_bucket" {
    value = aws_s3_bucket.athena_results.bucket
}


