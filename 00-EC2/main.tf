resource "aws_instance" "docker" {
    ami = local.ami_id
    instance_type = "t3.micro"
    vpc_security_group_ids  = [aws_security_group.docker_sg_group.id]

    root_block_device {
        volume_size = 50
        volume_type = "gp3" # or "gp2", depending on your preference
    }
    
    user_data = file("docker.sh")

    tags ={
            Name = "docker"
          }
}


resource "aws_security_group" "docker_sg_group" {
  name        = "docker_sg_group"
  description = "SSH traffic"

  ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow SSH"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # Represents all protocols
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "docker_sg_group"
  }
}