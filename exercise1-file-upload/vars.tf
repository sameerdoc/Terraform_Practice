#declare access key and secret key variables as follows if you decide to use them instead of ssh keys
#variable "AWS_ACCESS_KEY" { }
#variable "AWS_SECRET_KEY" { }

variable "AWS_REGION" {
  default = "us-east-1"
}
variable "PATH_TO_PUBLIC_KEY" {
  default = "mykey.pub"
}
variable "INSTANCE_USERNAME" {
  default = "ec2-user"
}
variable "PATH_TO_PRIVATE_KEY" {
  default = "mykey"
}
