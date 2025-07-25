output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnets" {
  value = module.vpc.public_subnets
}

output "private_subnets" {
  value = module.vpc.private_subnets
}

output "alb_dns_name" {
  value = aws_lb.app_alb.dns_name
  description = "DNS do Load Balancer"
}

output "users_asg_name" {
  value = aws_autoscaling_group.users.name
}

output "products_asg_name" {
  value = aws_autoscaling_group.products.name
}

output "orders_asg_name" {
  value = aws_autoscaling_group.orders.name
}

output "users_tg_arn" {
  value = aws_lb_target_group.users_tg.arn
}

output "products_tg_arn" {
  value = aws_lb_target_group.products_tg.arn
}

output "orders_tg_arn" {
  value = aws_lb_target_group.orders_tg.arn
} 