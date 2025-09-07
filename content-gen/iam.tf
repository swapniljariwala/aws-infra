resource "aws_iam_instance_profile" "lambda_ec2_profile" {
  name = "${var.project_prefix}-lambda-ec2-profile"
  role = aws_iam_role.lambda_ec2_role.name
}

resource "aws_iam_role" "lambda_ec2_role" {
  name = "${var.project_prefix}-lambda-ec2-role"
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
  name       = "${var.project_prefix}-lambda-ec2-sqs-policy-attachment"
  roles      = [aws_iam_role.lambda_ec2_role.name]
  policy_arn = aws_iam_policy.sqs_corporate_announcements_rw.arn
}

resource "aws_iam_policy" "ec2_start_stop_policy" {
  name        = "${var.project_prefix}-ec2_start_stop_policy"
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
  name       = "${var.project_prefix}-lambda-ec2-start-stop-policy-attachment"
  roles      = [aws_iam_role.lambda_ec2_role.name]
  policy_arn = aws_iam_policy.ec2_start_stop_policy.arn
}

resource "aws_iam_policy" "s3_rw_policy" {
  name        = "${var.project_prefix}-s3-rw-policy"
  description = "Policy to allow all S3 actions for the bucket and its objects"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = "s3:*",
        Resource = [
          "arn:aws:s3:::${local.contentgen_bucket}",
          "arn:aws:s3:::${local.contentgen_bucket}/*"
        ]
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "s3_rw_policy_attachment" {
  role       = aws_iam_role.lambda_ec2_role.name
  policy_arn = aws_iam_policy.s3_rw_policy.arn
}

resource "aws_iam_policy" "route53_rw_policy" {
  name        = "${var.project_prefix}-route53-rw-policy"
  description = "Policy to allow listing, adding, and deleting records in the Route 53 DNS zone"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "route53:ListResourceRecordSets",
          "route53:ChangeResourceRecordSets"
        ],
        Resource = "arn:aws:route53:::hostedzone/${aws_route53_zone.contentgen.zone_id}"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "route53_rw_policy_attachment" {
  role       = aws_iam_role.lambda_ec2_role.name
  policy_arn = aws_iam_policy.route53_rw_policy.arn
}
