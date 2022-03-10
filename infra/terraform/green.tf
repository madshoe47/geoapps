resource "aws_instance" "geoapp_server_green" {
  count         = var.enable_green_env ? 1 : 0
  ami           = data.aws_ami.latest_ubuntu_image.id
  instance_type = var.instance_type

  associate_public_ip_address = true
  key_name                    = "udacity"

  root_block_device {
    delete_on_termination = true
    volume_size           = 20
  }

  vpc_security_group_ids = [aws_security_group.geoapp_sg.id]

  tags = {
    Name : "geoapp_server_${var.workflow_id}"
    Env : "green"
  }
}

output "green_public_ip" {
  value = var.enable_green_env ? aws_instance.geoapp_server_green[0].public_ip : ""
}
