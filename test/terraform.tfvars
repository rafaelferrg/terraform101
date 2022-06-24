instance_vars = {
  instance-a = {
    type        = "t2.nano"
    volume_size = 10
    volume_type = "gp2"
  },
  instance-b = {
    type        = "t2.nano"
    volume_size = 20
    volume_type = "gp2"
  }
}

lb_name = "lb-test"

route53_zone = "test.open-co.tech"

tool        = "terraform"
service     = "ec2"
environment = "test"
cost        = "sre"
team        = "sre"
