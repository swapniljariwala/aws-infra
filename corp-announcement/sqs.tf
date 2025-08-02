
resource "aws_sqs_queue" "corporate_announcements" {
  name = var.sqs_name
}

resource "aws_iam_policy" "sqs_corporate_announcements_rw" {
  name        = "sqs_corporate_announcements_rw"
  description = "Allow read/write access to the corporate_announcements SQS queue"
  policy      = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "sqs:SendMessage",
          "sqs:ReceiveMessage",
          "sqs:DeleteMessage",
          "sqs:GetQueueAttributes",
          "sqs:GetQueueUrl"
        ]
        Resource = aws_sqs_queue.corporate_announcements.arn
      }
    ]
  })
}

