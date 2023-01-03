variable "ami" {
  description = "ami to use"
  type        = string
  default     = "ami-0fe0b2cf0e1f25c8a"
}

variable "instance_type" {
  description = "instance type to use in conjunction to aws ami"
  type        = string
  default     = "t2.micro"
}