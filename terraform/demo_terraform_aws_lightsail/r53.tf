data "aws_route53_zone" "domain" {
  name = "empcbr.thoughtworks-labs.net"
}

resource "aws_route53_record" "ws" {
  zone_id = data.aws_route53_zone.domain.zone_id
  name    = var.domain_name
  type    = "A"
  ttl     = "300"
  records = [aws_lightsail_static_ip.microk8s_control_ip.ip_address]
}

resource "aws_route53_record" "backstage" {
  zone_id = data.aws_route53_zone.domain.zone_id
  name    = "backstage.${terraform.workspace}"
  type    = "CNAME"
  ttl     = "5"

  weighted_routing_policy {
    weight = 10
  }

  set_identifier = "backstage"
  records        = [aws_route53_record.ws.name]
}

resource "aws_route53_record" "grafana" {
  zone_id = data.aws_route53_zone.domain.zone_id
  name    = "grafana.${terraform.workspace}"
  type    = "CNAME"
  ttl     = "5"

  weighted_routing_policy {
    weight = 10
  }

  set_identifier = "grafana"
  records        = [aws_route53_record.ws.name]
}

resource "aws_route53_record" "prometheus" {
  zone_id = data.aws_route53_zone.domain.zone_id
  name    = "prometheus.${terraform.workspace}"
  type    = "CNAME"
  ttl     = "5"

  weighted_routing_policy {
    weight = 10
  }

  set_identifier = "prometheus"
  records        = [aws_route53_record.ws.name]
}
