resource "aws_lb" "app_alb" {
  name               = "app-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.app_sg.id]
  subnets            = module.vpc.public_subnets
}

resource "aws_lb_target_group" "users_tg" {
  name     = "users-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = module.vpc.vpc_id
  health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200-399"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}

resource "aws_lb_target_group" "products_tg" {
  name     = "products-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = module.vpc.vpc_id
  health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200-399"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}

resource "aws_lb_target_group" "orders_tg" {
  name     = "orders-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = module.vpc.vpc_id
  health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200-399"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}

resource "aws_lb_listener" "app_listener" {
  load_balancer_arn = aws_lb.app_alb.arn
  port              = 80
  protocol          = "HTTP"
  default_action {
    type             = "fixed-response"
    fixed_response {
      content_type = "text/plain"
      message_body = "Not found"
      status_code  = "404"
    }
  }
}

resource "aws_lb_listener_rule" "users_rule" {
  listener_arn = aws_lb_listener.app_listener.arn
  priority     = 10
  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.users_tg.arn
  }
  condition {
    path_pattern {
      values = ["/users*", "/users/*"]
    }
  }
}

resource "aws_lb_listener_rule" "products_rule" {
  listener_arn = aws_lb_listener.app_listener.arn
  priority     = 20
  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.products_tg.arn
  }
  condition {
    path_pattern {
      values = ["/products*", "/products/*"]
    }
  }
}

resource "aws_lb_listener_rule" "orders_rule" {
  listener_arn = aws_lb_listener.app_listener.arn
  priority     = 30
  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.orders_tg.arn
  }
  condition {
    path_pattern {
      values = ["/orders*", "/orders/*"]
    }
  }
} 