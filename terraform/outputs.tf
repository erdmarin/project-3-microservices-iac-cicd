output "user_service_ecr_url" {
  value = aws_ecr_repository.user_service.repository_url
}

output "order_service_ecr_url" {
  value = aws_ecr_repository.order_service.repository_url
}

output "notification_worker_ecr_url" {
  value = aws_ecr_repository.notification_worker.repository_url
}

output "orders_queue_url" {
  value = aws_sqs_queue.orders_queue.url
}

output "ecs_cluster_name" {
  value = aws_ecs_cluster.main.name
}

output "ecs_task_execution_role_arn" {
  value = aws_iam_role.ecs_task_execution_role.arn
}

output "ecs_task_role_arn" {
  value = aws_iam_role.ecs_task_role.arn
}
output "alb_dns_name" {
  value = aws_lb.main.dns_name
}

