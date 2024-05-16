provider "aws" {
        region = "${var.region}"
        access_key = "${var.access_key}"
        secret_key = "${var.secret_key}"
}

resource "aws_key_pair" "terraform-demo" {
  key_name   = "terraform-demo"
  public_key = "${file("id_rsa.pub")}"
}
resource "aws_instance" "my-instance" {
        ami = "${var.ami}"
        instance_type = "${var.instance_type}"
        key_name = "${aws_key_pair.terraform-demo.key_name}"
        user_data = "${file("apache-install.sh")}"
         vpc_security_group_ids = [aws_security_group.webserver-sg.id]
        tags = {
                Name = "Terraform"
        }
}
