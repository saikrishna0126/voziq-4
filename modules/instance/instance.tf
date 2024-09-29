# Create EC2 instances within the VPC (4 Linux in private, and one Windows in public)
resource "aws_instance" "linux_instances" {
  ami           = var.ami_id_linux
  instance_type = var.instance_types[count.index]
  count = 4

  subnet_id       = aws_subnet.private-subnet[0].id
  security_groups = [aws_security_group.demo-sg.id]
  key_name        = var.key_name
  

  tags = {
    Name = "LinuxInstance"
  }
}

resource "aws_instance" "windows_instance" {
  ami           = var.ami_id_windows
  instance_type = var.instance_types[4]
  count = 1
  subnet_id       = aws_subnet.public-subnet[0].id
  security_groups = [aws_security_group.demo-sg.id]
  key_name = var.key_name

  tags = {
    Name = "WindowsInstance"
  }
}   