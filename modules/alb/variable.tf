variable "sg_id" {
  description = "SG for ALB"
  type = string
}

variable "subnets" {
    description = "subnet for alb"
    type = list(string)
  
}
variable "vpc_id" {
    description = "subnet for alb"
    type = string
  
}

variable "instance" {
    description = "Instance id for target group attachment"
    type = list(string)
  
}