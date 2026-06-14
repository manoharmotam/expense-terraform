resource "aws_route53_record" "expense_records" {
  for_each = aws_instance.expense
  zone_id  = var.zoneid
  name     = "${each.key}-${var.environment}.${var.domain}" #backend-dev.mrmotam.online
  type     = "A"
  ttl      = 1
  records  = [aws_instance.expense[each.key].private_ip]
}

resource "aws_route53_record" "expense_frontend" {
  count   = contains(keys(var.instances), "lb") ? 1 : 0
  zone_id = var.zoneid
  name    = "${var.project}-${var.environment}.${var.domain}" #expense-dev.mrmotam.online
  type    = "A"
  ttl     = 1
  records = [lookup(aws_instance.expense, "lb").public_ip]
}