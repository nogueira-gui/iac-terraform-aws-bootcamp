 resource "aws_launch_template" "users" {
  name_prefix   = "users-"
  image_id      = "ami-01edd5711cfe3825c" # AMI do Amazon Linux 2023 kernel-6.12
  instance_type = "t3.micro"

  key_name = "seu-par-chave" # Gerado direto no console da AWS

  user_data = base64encode(file("user_data_users.sh"))

  network_interfaces {
    associate_public_ip_address = true
    security_groups = [aws_security_group.app_sg.id]
  }
}

resource "aws_launch_template" "products" {
  name_prefix   = "products-"
  image_id      = "ami-01edd5711cfe3825c" # AMI do Amazon Linux 2023 kernel-6.12

  instance_type = "t3.micro"

  key_name = "seu-par-chave" # Gerado direto no console da AWS

  user_data = base64encode(file("user_data_products.sh"))

  network_interfaces {
    associate_public_ip_address = true
    security_groups = [aws_security_group.app_sg.id]
  }
}

resource "aws_launch_template" "orders" {
  name_prefix   = "orders-"
  image_id      = "ami-01edd5711cfe3825c" # AMI do Amazon Linux 2023 kernel-6.12
  instance_type = "t3.micro"

  key_name = "seu-par-chave"

  user_data = base64encode(file("user_data_orders.sh"))

  network_interfaces {
    associate_public_ip_address = true
    security_groups = [aws_security_group.app_sg.id]
  }
}

resource "aws_autoscaling_group" "users" {
  desired_capacity     = 3
  max_size             = 6
  min_size             = 3
  vpc_zone_identifier  = module.vpc.public_subnets

  launch_template {
    id      = aws_launch_template.users.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "users-asg"
    propagate_at_launch = true
  }

  health_check_type         = "EC2"
  health_check_grace_period = 300
}

resource "aws_autoscaling_group" "products" {
  desired_capacity     = 3
  max_size             = 6
  min_size             = 3
  vpc_zone_identifier  = module.vpc.public_subnets

  launch_template {
    id      = aws_launch_template.products.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "products-asg"
    propagate_at_launch = true
  }

  health_check_type         = "EC2"
  health_check_grace_period = 300
}

resource "aws_autoscaling_group" "orders" {
  desired_capacity     = 3
  max_size             = 6
  min_size             = 3
  vpc_zone_identifier  = module.vpc.public_subnets

  launch_template {
    id      = aws_launch_template.orders.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "orders-asg"
    propagate_at_launch = true
  }

  health_check_type         = "EC2"
  health_check_grace_period = 300
}
