output "server_id" {
  value = "${join(", ", aws_instance.new.*.id)}"
}

output "server_ip" {
  value = "${join(", ", aws_instance.new.*.public_ip)}"
}
