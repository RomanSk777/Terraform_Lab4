provider "aws" {
  access_key = "AKIATS46T7BXIXPF3LV4"
  secret_key = "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"
  region     = "eu-central-1"
}

resource "aws_instance" "my_jarvis" {
  ami                    = "ami-0a6dc7529cd559185" #Amazon ami -2
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.my_jarvis.id]
  user_data              = <<EOF
#!/bin/bash
yum -y update
yum -y install httpd
echo "<h1 align="center">Yraaaaaa!</h1>"  >  /var/www/html/index.html
sudo service httpd start
chkconfig httpd on
EOF

}

resource "aws_security_group" "my_jarvis" {
  name        = "Mine_Security_Group"
  description = "First_SecurityGroup"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
