resource "aws_lb" "jt-alb" {
  name               = "jt-application-load-balancer"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.sg_id]
  subnets            = var.subnets
}


#listener
resource "aws_lb_listener" "jt-lb-listener" {
  load_balancer_arn = aws_lb.jt-alb.arn
  port              = "80"
  protocol          = "HTTP"
 

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.jt-lb-targetgroup.arn
  }
}

#target group
resource "aws_lb_target_group" "jt-lb-targetgroup" {
  name     = "jt-alb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}



#target attachment
resource "aws_lb_target_group_attachment" "jt-target-attachment" {
  count = length(var.instance)
  target_group_arn = aws_lb_target_group.jt-lb-targetgroup.arn
  target_id        = var.instance[count.index]
  port             = 80
}


