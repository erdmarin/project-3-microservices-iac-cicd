resource "aws_cloudwatch_log_group" "user_service" {
  name              = "/ecs/${var.project_name}/user-service"
  retention_in_days = 7
}

resource "aws_cloudwatch_log_group" "order_service" {
  name              = "/ecs/${var.project_name}/order-service"
  retention_in_days = 7
}

resource "aws_cloudwatch_log_group" "notification_worker" {
  name              = "/ecs/${var.project_name}/notification-worker"
  retention_in_days = 7
}

