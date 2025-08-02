resource "aws_iam_instance_profile" "lambda_ec2_profile" {
  name = "lambda-ec2-profile"
  role = aws_iam_role.lambda_ec2_role.name
}

resource "aws_iam_role" "lambda_ec2_role" {
  name = "lambda-ec2-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = ["lambda.amazonaws.com", "ec2.amazonaws.com"]
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_policy_attachment" "lambda_ec2_sqs_policy" {
  name       = "lambda-ec2-sqs-policy-attachment"
  roles      = [aws_iam_role.lambda_ec2_role.name]
  policy_arn = aws_iam_policy.sqs_corporate_announcements_rw.arn
}

resource "aws_iam_policy" "ec2_start_stop_policy" {
  name        = "ec2_start_stop_policy"
  description = "Allow start/stop any EC2 instance"
  policy      = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "ec2:StartInstances",
          "ec2:StopInstances"
        ]
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_policy_attachment" "lambda_ec2_start_stop_policy" {
  name       = "lambda-ec2-start-stop-policy-attachment"
  roles      = [aws_iam_role.lambda_ec2_role.name]
  policy_arn = aws_iam_policy.ec2_start_stop_policy.arn
}
