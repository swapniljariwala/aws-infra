variable "volume_type" {
  description = "Type of EBS volume for the VM"
  type        = string
  default     = "gp3"
}

variable "volume_size" {
  description = "Size of the EBS volume in GB"
  type        = number
  default     = 15
}

variable "region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "ap-south-1"
}
variable "sqs_name" {
  description = "Name of the SQS queue"
  type        = string
  default     = "corporate-announcements"
}

variable "vm_name" {
  description = "Name of the Ubuntu VM instance"
  type        = string
  default     = "announcement-processor"
}

variable "ami"{
    default = "ami-0f918f7e67a3323f0"
}

variable "instance_type" {
    default = "t3a.large"
}
