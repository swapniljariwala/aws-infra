locals{
    contentgen_bucket = "${var.project_prefix}-data"
}

resource "aws_s3_bucket" "example" {
  bucket = local.contentgen_bucket

  tags = {
    Name        = local.contentgen_bucket
    Environment = "production"
  }
}