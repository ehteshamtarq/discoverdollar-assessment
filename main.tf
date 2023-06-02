# Configure the AWS provider
provider "aws" {
  region = "ap-south-1"  
}

# Create a VPC
resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16"  

  tags = {
    Name = "MyVPC"
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = "10.0.1.0/24"  
  availability_zone = "ap-south-1a"  

  tags = {
    Name = "MySubnet"
  }
}

resource "aws_security_group" "my_security_group" {
  vpc_id = aws_vpc.my_vpc.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "MySecurityGroup"
  }
}

resource "aws_key_pair" "my_key_pair" {
  key_name   = "my-key-pair"
  public_key = file("~/.ssh/id_rsa.pub")  # Replace with the path to your public key file
}

# Create an EC2 instance
resource "aws_instance" "my_instance" {
  ami  = "ami-0607784b46cbe5816"
  instance_type = "t2.micro"  
  subnet_id= aws_subnet.public_subnet.id
 key_name = aws_key_pair.my_key_pair.key_name

associate_public_ip_address = true  # Assigns a public IP address


  tags = {
    Name = "MyInstance"
  }
}
