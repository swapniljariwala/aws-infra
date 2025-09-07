

locals {
  vm_name = "${var.project_prefix}-vm"
}

resource "aws_instance" "ubuntu_server" {
  ami           = var.ami 
  instance_type = var.instance_type
  key_name      = "work-key"
  
  vpc_security_group_ids = ["sg-019c4eb82f6ceadc8"]
  iam_instance_profile = aws_iam_instance_profile.lambda_ec2_profile.name
  tags = {
    Name = local.vm_name
  }
  root_block_device {
    volume_type = var.volume_type
    volume_size = var.volume_size
  }
}


