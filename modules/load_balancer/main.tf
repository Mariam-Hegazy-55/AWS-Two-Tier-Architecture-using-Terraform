# Create the Application Load Balancer (ALB)
resource "aws_lb" "app-lb" {
    name = "app-LB"
    internal = false # Accessible from internet
    load_balancer_type = "application"
    security_groups = [ aws_security_group.alb_sg.id ]
    subnets = var.subnets
    ip_address_type = "ipv4"
    tags = {
      name = "Project ALB"
    }
}

#Create the Target Group
resource "aws_lb_target_group" "lb-target-group" {
    name = "lb-target-group"
    port = 80
    protocol = "HTTP"
    vpc_id = var.vpc_id

    health_check {
    interval            = 30
    path                = "/"
    protocol            = "HTTP"
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
    }
    tags = {
      name="Project alb_target_group"
    }
  
}

resource "aws_lb_listener" "alb-listeners" {
    load_balancer_arn = aws_lb.app-lb.arn
    port = "80"
    protocol = "HTTP"

    default_action {
      type = "forward"
      target_group_arn = aws_lb_target_group.lb-target-group.arn
    }
}

#attach listeners to target group
resource "aws_lb_target_group_attachment" "td_attachment" {
    count = length(var.instances)
    target_group_arn = aws_lb_target_group.lb-target-group.arn
    target_id = var.instances[count.index]
    port = 80
    depends_on = [ aws_lb_target_group.lb-target-group ]

}


#create alb security group
resource "aws_security_group" "alb_sg" {
  name        = "alb-sg"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
