resource "aws_route53_zone" "zone" {
  name = "empcbr.thoughtworks-labs.net"

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_route53_zone" "zone-tw" {
  name = var.domain_name

  lifecycle {
    prevent_destroy = true
  }
}