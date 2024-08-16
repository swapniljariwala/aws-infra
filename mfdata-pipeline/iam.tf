resource "aws_iam_role" "lambda_role" {
    name = "${local.prefix}-lambda-role"
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
    role = aws_iam_role.lambda_role.name 
    policy_arn =  "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}


resource "aws_iam_role_policy_attachment" "lambda_allow_logs" {
    role = aws_iam_role.lambda_role.name 
    policy_arn = "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess"
}
output "lambda_role_arn" {
  value = aws_iam_role.lambda_role.arn
}

output "lambda_role_name" {
  value = aws_iam_role.lambda_role.name
}
