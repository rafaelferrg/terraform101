locals {
  instance_private_ips = [for instance in aws_instance.instance_openco : instance.private_ip]
}

data "aws_route53_zone" "route53-zone_openco" {
  name         = var.route53_zone
  private_zone = true
}

resource "aws_route53_record" "route53-instance-record_openco" {
  count   = length(local.instance_private_ips)
  zone_id = data.aws_route53_zone.route53-zone_openco.zone_id
  name    = "i${count.index}.${data.aws_route53_zone.route53-zone_openco.name}"
  type    = "A"
  ttl     = "30"
  records = [local.instance_private_ips[count.index]]
}

resource "aws_route53_record" "route53-lb-record_openco" {
  zone_id = data.aws_route53_zone.route53-zone_openco.zone_id
  name    = "ourcoolapp.${data.aws_route53_zone.route53-zone_openco.name}"
  type    = "CNAME"
  ttl     = "30"
  records = [aws_lb.application-load-balancer_openco.dns_name]
}
