output "vpc_idr" {
  value = aws_vpc.jt_vpc.id
}

output "subnet_ids"{
    value = aws_subnet.main.*.id
}