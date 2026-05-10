resource "aws_ecr_repository" "user_service" {
  name                 = "${var.project_name}/user-service"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

resource "aws_ecr_repository" "order_service" {
  name                 = "${var.project_name}/order-service"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

resource "aws_ecr_repository" "notification_worker" {
  name                 = "${var.project_name}/notification-worker"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

