resource "aws_route53_zone" "contentgen" {
  name = "${var.project_prefix}.${var.marketsetup_domain}"
}


