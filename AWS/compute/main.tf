data "aws_ami" "new" {
  most_recent = true

  owners = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn-ami-hvm*-x86_64-gp2"]
  }
}

resource "aws_key_pair" "new" {
  key_name   = var.key_name
  public_key = "${file(var.public_key_path)}"
}

data "template_file" "new" {
  count    = 4
  template = "${file("${path.module}/userdata.tpl")}"

  vars = {
    firewall_subnets = "${element(var.subnet_ips, count.index)}"
  }
}

resource "aws_instance" "new" {
  count         = var.instance_count
  instance_type = var.instance_type
  ami           = data.aws_ami.new.id

  tags = {
    Name = "tf_server-${count.index +1}"
  }

  key_name               = aws_key_pair.new.id
  vpc_security_group_ids = ["${var.security_group}"]
  subnet_id              = "${element(var.subnets, count.index)}"
  user_data              = "${data.template_file.new.*.rendered[count.index]}"
}
