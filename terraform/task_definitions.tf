resource "aws_ecs_task_definition" "user_service" {
  family                   = "user-service"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]

  cpu    = "256"
  memory = "512"

  execution_role_arn = aws_iam_role.ecs_task_execution_role.arn
  task_role_arn      = aws_iam_role.ecs_task_role.arn

  container_definitions = jsonencode([
    {
      name  = "user-service"
      image = "${aws_ecr_repository.user_service.repository_url}:latest"

      essential = true

      portMappings = [
        {
          containerPort = 3001
          hostPort      = 3001
        }
      ]

      logConfiguration = {
        logDriver = "awslogs"

        options = {
          awslogs-group         = aws_cloudwatch_log_group.user_service.name
          awslogs-region        = var.aws_region
          awslogs-stream-prefix = "ecs"
        }
      }
    }
  ])
}
resource "aws_ecs_task_definition" "order_service" {
  family                   = "order-service"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]

  cpu    = "256"
  memory = "512"

  execution_role_arn = aws_iam_role.ecs_task_execution_role.arn
  task_role_arn      = aws_iam_role.ecs_task_role.arn

  container_definitions = jsonencode([
    {
      name  = "order-service"
      image = "${aws_ecr_repository.order_service.repository_url}:latest"

      essential = true

      portMappings = [
        {
          containerPort = 3002
          hostPort      = 3002
        }
      ]

      environment = [
        {
          name  = "ORDER_QUEUE_URL"
          value = aws_sqs_queue.orders_queue.url
        },
        {
          name  = "AWS_REGION"
          value = var.aws_region
        }
      ]

      logConfiguration = {
        logDriver = "awslogs"

        options = {
          awslogs-group         = aws_cloudwatch_log_group.order_service.name
          awslogs-region        = var.aws_region
          awslogs-stream-prefix = "ecs"
        }
      }
    }
  ])
}
resource "aws_ecs_task_definition" "notification_worker" {
  family                   = "notification-worker"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]

  cpu    = "256"
  memory = "512"

  execution_role_arn = aws_iam_role.ecs_task_execution_role.arn
  task_role_arn      = aws_iam_role.ecs_task_role.arn

  container_definitions = jsonencode([
    {
      name  = "notification-worker"
      image = "${aws_ecr_repository.notification_worker.repository_url}:latest"

      essential = true

      environment = [
        {
          name  = "ORDER_QUEUE_URL"
          value = aws_sqs_queue.orders_queue.url
        },
        {
          name  = "AWS_REGION"
          value = var.aws_region
        }
      ]

      logConfiguration = {
        logDriver = "awslogs"

        options = {
          awslogs-group         = aws_cloudwatch_log_group.notification_worker.name
          awslogs-region        = var.aws_region
          awslogs-stream-prefix = "ecs"
        }
      }
    }
  ])
}

