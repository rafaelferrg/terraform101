variable "instance_vars" {
  type = map(object({
    type        = string
    volume_size = number
    volume_type = string
  }))
}

variable "lb_name" {
  type = string
}

variable "service" {
  type        = string
}

variable "tool" {
  type        = string
  default     = "terraform"
}

variable "environment" {
  type        = string
}

variable "cost" {
  type        = string
}

variable "team" {
  type        = string
}
