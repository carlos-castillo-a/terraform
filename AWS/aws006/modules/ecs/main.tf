# Create Cluster
resource "aws_ecs_cluster" "main_cluster" {
  name = "main-cluster"
}

# Create Users Task Definition
resource "aws_ecs_task_definition" "users_task_definition" {
  family                   = "users-task-definition"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256" 
  memory                   = "512"  
  execution_role_arn       = aws_iam_role.ecs_execution_role.arn

  container_definitions = jsonencode([{
    name  = "users-container"
    image = "${var.users_image}"
    portMappings = [{
      containerPort = 3000
      hostPort      = 3000
    }]
  }])
}

# Create Users Service
resource "aws_ecs_service" "users_service" {
  name            = "aws${var.project}-${var.environment}-users-service"
  cluster         = aws_ecs_cluster.main_cluster.id
  task_definition = aws_ecs_task_definition.users_task_definition.arn
  launch_type     = "FARGATE"

  network_configuration {
    subnets = [var.PRI_SUB_3_A_ID, var.PRI_SUB_4_B_ID]
    security_groups = [var.app_sg_id]
  }

  load_balancer {
    target_group_arn = var.USERS_TG_ARN
    container_name   = "users-container"
    container_port   = 3000
  }

  desired_count = 1
}

# Create Threads Task Definition
resource "aws_ecs_task_definition" "threads_task_definition" {
  family                   = "threads-task-definition"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256" 
  memory                   = "512"  
  execution_role_arn       = aws_iam_role.ecs_execution_role.arn

  container_definitions = jsonencode([{
    name  = "threads-container"
    image = "${var.threads_image}"
    portMappings = [{
      containerPort = 3000
      hostPort      = 3000
    }]
  }])
}

# Create Threads Service
resource "aws_ecs_service" "threads_service" {
  name            = "aws${var.project}-${var.environment}-threads-service"
  cluster         = aws_ecs_cluster.main_cluster.id
  task_definition = aws_ecs_task_definition.threads_task_definition.arn
  launch_type     = "FARGATE"

  network_configuration {
    subnets = [var.PRI_SUB_3_A_ID, var.PRI_SUB_4_B_ID]
    security_groups = [var.app_sg_id]
  }

  load_balancer {
    target_group_arn = var.THREADS_TG_ARN
    container_name   = "threads-container"
    container_port   = 3000
  }

  desired_count = 1
}

# Create Posts Task Definition
resource "aws_ecs_task_definition" "posts_task_definition" {
  family                   = "posts-task-definition"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256" 
  memory                   = "512"  
  execution_role_arn       = aws_iam_role.ecs_execution_role.arn

  container_definitions = jsonencode([{
    name  = "posts-container"
    image = "${var.posts_image}"
    portMappings = [{
      containerPort = 3000
      hostPort      = 3000
    }]
  }])
}

# Create Posts Service
resource "aws_ecs_service" "posts_service" {
  name            = "aws${var.project}-${var.environment}-posts-service"
  cluster         = aws_ecs_cluster.main_cluster.id
  task_definition = aws_ecs_task_definition.posts_task_definition.arn
  launch_type     = "FARGATE"

  network_configuration {
    subnets = [var.PRI_SUB_3_A_ID, var.PRI_SUB_4_B_ID]
    security_groups = [var.app_sg_id]
  }

  load_balancer {
    target_group_arn = var.POSTS_TG_ARN
    container_name   = "posts-container"
    container_port   = 3000
  }

  desired_count = 1
}

# Create IAM Role
resource "aws_iam_role" "ecs_execution_role" {
  name = "ecs_execution_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      }
    ]
  })
}

# Attach Role
resource "aws_iam_role_policy_attachment" "ecs_execution_policy" {
  role       = aws_iam_role.ecs_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}
