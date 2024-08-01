resource "aws_instance" "jt-ec2-instance" {
  ami           = data.aws_ami.amazon-linux-2.id # us-east-1
  instance_type = "t2.micro"
  associate_public_ip_address = true
  vpc_security_group_ids = [var.sg_id]
  subnet_id = var.subnets[count.index]
  count = length(var.ecs_names)
  availability_zone = data.aws_availability_zones.available.names[count.index]
  user_data = "Hello everyone"
  
tags = {
  Name = var.ecs_names[count.index]
}
  
}