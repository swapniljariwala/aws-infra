
data "aws_instance" "content_gen_instance" {
	instance_id = var.instance_id
}

resource "aws_route53_record" "contentgen_record" {
  zone_id = var.zone_id 
  name    = var.domain 
  type    = "A"
  ttl     = "30"
  records = [data.aws_instance.content_gen_instance.public_ip]
}
