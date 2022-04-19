resource "aws_key_pair" "mykey" {
  key_name   = "mykey"
  public_key = "${file("${var.PATH_TO_PUBLIC_KEY}")}"
}

resource "aws_instance" "MyInstance" {
  ami                    = "ami-03ededff12e34e59e"
  instance_type          = "t2.micro"
  vpc_security_group_ids = ["sg-07468d7179e3b0899"]
  key_name = "${aws_key_pair.mykey.key_name}"
  tags = {
    Name = "Test_Instance"
  }

  provisioner "file" {
    source      = "script.sh"
    destination = "/tmp/script.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo chmod u+x /tmp/script.sh",
      "sudo /tmp/script.sh"
    ]
  }

  connection {
    user        = "${var.INSTANCE_USERNAME}"
    private_key = "${file("${var.PATH_TO_PRIVATE_KEY}")}"
    timeout = "2m"
    host = "${aws_instance.MyInstance.public_ip}"
  }
}

output "ip" {
  value = "${aws_instance.MyInstance.public_ip}"
}
