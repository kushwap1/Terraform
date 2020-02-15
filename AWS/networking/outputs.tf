#-----networking/outputs.tf----

output "public_subnets" {
  value = "${aws_subnet.new.*.id}"
}

output "public_sg" {
  value = "${aws_security_group.new.id}"
}

output "subnet_ips" {
  value = "${aws_subnet.new.*.cidr_block}"
}
