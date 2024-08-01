output "instances" {
    value = aws_instance.jt-ec2-instance.*.id
  
}