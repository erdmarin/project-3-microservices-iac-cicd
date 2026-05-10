resource "aws_sqs_queue" "orders_queue" {
  name                       = "${var.project_name}-orders-queue"
  visibility_timeout_seconds = 30
  message_retention_seconds  = 345600
}

