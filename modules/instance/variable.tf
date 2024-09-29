variable "ami_id_linux" {
  description = "AMI ID for the Linux ubuntu(22.04) instance"
  type        = string
  default     = "ami-05134c8ef96964280" # Replace with your preferred Amazon Linux AMI ID
}

variable "instance_types" {
  description = "Instance types for the EC2 instances"
  type        = list(string)
  default     = ["t2.micro", "t2.micro", "t2.micro", "t2.micro", "t2.micro"] # Four Linux and one Windows
}

variable "key_name" {
  description = "The name of the key pair"
  type        = string
  default     = "test"  # You can change this default value
}

variable "ami_id_windows" {
  description = "AMI ID for the Windows instance"
  type        = string
  default     = "ami-0845068028e672a07" # Replace with your preferred Windows AMI ID
}

