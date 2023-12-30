resource "aws_iam_role" "z_downloader_lambda_role" {
    name = "${local.prefix}_lambda_role"
    assume_role_policy = jsonencode({
                "Version" = "2012-10-17"
                "Statement" = [
                    {
                    "Effect" = "Allow"
                    "Principal" = {
                        "Service" = "lambda.amazonaws.com"
                    }
                    "Action" = "sts:AssumeRole"
                    }
                ]
                })
}

resource "aws_iam_role_policy_attachment" "lambda_role_allow_s3" {
    role = aws_iam_role.z_downloader_lambda_role.name 
    policy_arn =  "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

resource "aws_iam_role_policy_attachment" "lambda_role_allow_screts_access" {
    role = aws_iam_role.z_downloader_lambda_role.name 
    policy_arn =  "arn:aws:iam::aws:policy/SecretsManagerReadWrite"
}

output "z_downloader_lambda_role_arn" {
  value = aws_iam_role.z_downloader_lambda_role.arn
}

output "z_downloader_lambda_role_name" {
  value = aws_iam_role.z_downloader_lambda_role.name
}