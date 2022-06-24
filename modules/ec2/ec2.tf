data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

data "aws_vpc" "open-vpc_openco-vpc" {
  filter {
    name   = "tag:Name"
    values = ["default"]
  }
}

data "aws_subnets" "service_private-subnet_openco-subnet-ids" {

  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.open-vpc_openco-vpc.id]
  }
}

resource "aws_instance" "instance_openco" {
  for_each      = var.instance_vars
  ami           = data.aws_ami.ubuntu.id
  instance_type = each.value.type
  subnet_id     = data.aws_subnets.service_private-subnet_openco-subnet-ids.ids[0]

  root_block_device {
    volume_size = each.value.volume_size
    volume_type = each.value.volume_type
  }

  tags = {
    Name        = each.key
    Tool        = var.tool
    Service     = var.service
    Environment = var.environment
    Cost        = var.cost
    Team        = var.team
  }
}

resource "aws_lb" "application-load-balancer_openco" {
  name               = var.lb_name
  load_balancer_type = "application"
  subnets            = data.aws_subnets.service_private-subnet_openco-subnet-ids.ids

  enable_deletion_protection = false

  tags = {
    Name        = var.lb_name
    Tool        = var.tool
    Service     = var.service
    Environment = var.environment
    Cost        = var.cost
    Team        = var.team
  }
}
