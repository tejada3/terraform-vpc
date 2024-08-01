variable "sg_id" {
  description = "SG ID for ec2"
  type = string
}

variable "subnets" {
    description = "subnets for ec2"
    type = list(string)
  
}

variable "ecs_names" {
    description = "Ec2 name"
    type = list(string)
    default = [ "Webserver1", "Webserver2" ]
  
}