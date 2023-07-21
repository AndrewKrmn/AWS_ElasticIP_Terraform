provider "aws" {
  region = "eu-north-1"
  access_key = ""
  secret_key = ""
}
resource "aws_instance" "ec2"{
  availability_zone = "eu-north-1a"
  count = 2
  ami = "ami-016b30666f212275a"
  instance_type = "t3.micro"
  key_name = "key"
  vpc_security_group_ids =  [aws_security_group.DefaultTerraformSG.id]
  ebs_block_device {
  device_name = "/dev/sda1"
  volume_size = 8
  volume_type = "standard"
  tags = {
    Name = "root-disk"
    }
  }
  #user_data = file("bash/install.sh")

  tags = {
    Name = "EC2-Instance"
    }
}
resource "aws_security_group" "DefaultTerraformSG" {
  name="DefaultTerraformSG"
  description = "wtf"

  ingress {
    description = "Allow 22"
    from_port = 22
    to_port= 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    }
  ingress {
    description = "Allow 80"
    from_port = 80
    to_port= 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    }
  ingress {
    description = "Allow 443"
    from_port = 443
    to_port= 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    }
  ingress {
    description = "Allow 3389 rdp"
    from_port = 3389
    to_port= 3389
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    }
  egress {
    description = "Allow ping"
    from_port = 0
    to_port= 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
resource "aws_eip" "example_eip" {
  vpc = true
}
resource "aws_eip_association" "example_eip_assoc" {
  instance_id   = aws_instance.ec2[1].id
  allocation_id = aws_eip.example_eip.id
}
