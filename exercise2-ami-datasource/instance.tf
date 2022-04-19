data "aws_ami" "latest-ubuntu" {
  most_recent = true
  owners      = ["099720109477"]


  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }


  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}


resource "aws_key_pair" "mykey" {
  key_name   = "mykey"
  public_key = file("${var.PATH_TO_PUBLIC_KEY}")
}



resource "aws_instance" "MyInstance" {
  ami           = data.aws_ami.latest-ubuntu.id
  instance_type = "t2.micro"
  key_name      = aws_key_pair.mykey.key_name
  tags = {
    Name = "Test_Instance"
  }
}

output "ip" {
  value = aws_instance.MyInstance.public_ip
}
