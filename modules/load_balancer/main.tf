# ================================================
# Create the Application Load Balancer (ALB)
# ================================================
resource "aws_lb" "app-lb" {
  name               = "app-LB"
  internal           = false                         # ALB is internet-facing
  load_balancer_type = "application"                 # Type: Application Load Balancer
  security_groups    = [var.alb_sg_id]               # Security group to allow traffic
  subnets            = var.subnets                   # Subnets (must be public)
  enable_deletion_protection = false                 # Optional: Set to true in production
  ip_address_type    = "ipv4"                        # Use IPv4 addressing

  tags = {
    name = "Project ALB"
    Name = "Project ALB"
  }
}

# =====================================================
# Create the Target Group for EC2 instances (port 80)
# =====================================================
resource "aws_lb_target_group" "lb-target-group" {
  name     = "lb-target-group"
  port     = 80                                     # Port on the target (EC2)
  protocol = "HTTP"                                 # Protocol used to communicate with targets
  vpc_id   = var.vpc_id                             # VPC where the targets live

  # Health check configuration
  health_check {
    interval            = 30                        # Check every 30 seconds
    path                = "/"                       # Check this path
    protocol            = "HTTP"                    # Use HTTP protocol for health checks
    timeout             = 5                         # Fail if response takes >5 seconds
    healthy_threshold   = 2                         # Consider healthy after 2 successful checks
    unhealthy_threshold = 2                         # Consider unhealthy after 2 failed checks
  }

  tags = {
    name = "Project alb_target_group"
    Name = "Project alb_target_group"
  }
}

# =========================================================
# Create a Listener on the ALB to forward HTTP traffic
# =========================================================
resource "aws_lb_listener" "alb-listeners" {
  load_balancer_arn = aws_lb.app-lb.arn             # Link to the ALB
  port              = "80"                          # Listen on port 80 (HTTP)
  protocol          = "HTTP"                        # Protocol for incoming traffic

  # Forward the traffic to the target group
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.lb-target-group.arn
  }
}

# ========================================================
# Attach listeners to the Target Group
# ========================================================
resource "aws_lb_target_group_attachment" "td_attachment" {
  count              = length(var.instances)                         # One attachment per instance
  target_group_arn   = aws_lb_target_group.lb-target-group.arn      # Attach to this target group
  target_id          = var.instances[count.index]                   # ID of the EC2 instance
  port               = 80                                           # Port the EC2 listens on
  depends_on         = [aws_lb_target_group.lb-target-group]        # Ensure target group is ready first
}
