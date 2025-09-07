
output "ec2_instance_id" {
  description = "ID of the Ubuntu EC2 instance"
  value       = aws_instance.ubuntu_server.id
}

output "ec2_public_ip" {
  description = "Public IP of the Ubuntu EC2 instance"
  value       = aws_instance.ubuntu_server.public_ip
}

output "sqs_queue_url" {
  description = "URL of the SQS queue"
  value       = aws_sqs_queue.corporate_announcements.url
}

output "sqs_queue_arn" {
  description = "ARN of the SQS queue"
  value       = aws_sqs_queue.corporate_announcements.arn
}

output "instance_profile_name" {
  description = "Name of the IAM instance profile attached to EC2"
  value       = aws_iam_instance_profile.lambda_ec2_profile.name
}

output "iam_role_arn" {
  description = "ARN of the IAM role for Lambda/EC2"
  value       = aws_iam_role.lambda_ec2_role.arn
}

output "nameservers" {
  description = "Name servers for the hosted zone"
  value = aws_route53_zone.contentgen
}