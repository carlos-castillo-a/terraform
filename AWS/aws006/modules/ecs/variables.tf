variable "project" {
  description = "The Project ID of this project."
  type        = string
}

variable "environment" {
  description = "The Enviornment of deployment."
  type        = string
}

variable "PRI_SUB_3_A_ID" {
  description = "The ID of the primary subnet A."
  type        = string
}

variable "PRI_SUB_4_B_ID" {
  description = "The ID of the primary subnet B."
  type        = string
}

variable "app_sg_id" {
  description = "The ID of the security group to associate with the ECS service."
  type        = string
}

variable "USERS_TG_ARN" {
  description = "The ARN of the Target Group for the users service."
  type        = string
}

variable "THREADS_TG_ARN" {
  description = "The ARN of the Target Group for the threads service."
  type        = string
}

variable "POSTS_TG_ARN" {
  description = "The ARN of the Target Group for the posts service."
  type        = string
}
