provider "aws" {
  region = "us-east-1"
  access_key = "AKIAVNXG64A3WHQX5FO4"
  secret_key = "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"
}

resource "aws_security_group" "my_key" {
  name_prefix = "my_key"
  
  ingress {
    from_port = 0
    to_port = 0
    protocol = "all"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "all"
    cidr_blocks = ["0.0.0.0/0"]
}
}

resource "aws_instance" "sky-guardian" {
  ami           = "ami-007855ac798b5175e"
  instance_type = "t2.micro"
  key_name      = "my_key"

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("my_key.pem")
    host        = self.public_ip
  }

  provisioner "remote-exec" {
      inline = [
      "echo 'Starting provisioning'",
      "sudo apt-get update",
      "echo 'Finished apt-get update'",
      "sudo apt-get install -y openjdk-8-jdk",
      "echo 'installed jdk'",
      "wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -",
      "echo 'deb https://pkg.jenkins.io/debian-stable binary/' | sudo tee -a /etc/apt/sources.list",
      "sudo apt-get update",
      "sudo apt-get install -y jenkins",
      "echo 'installed Jenkins'",
      "sudo systemctl start jenkins",
      "echo 'started Jenkins'",
      "sudo systemctl enable jenkins",
      "echo 'enabled Jenkins'",
      "sudo apt-get install -y python3-pip",
      "echo 'Finished installing pip3'",
      "git clone https://github.com/AnishDubey27/Sky-Guardian.git",
      "echo 'Finished cloning repo'",
      "cd Sky-Guardian",
      "echo 'Changed directory to Sky-Guardian'",
      "pip3 install -r requirements.txt",
      "echo 'Finished installing requirements'",
      "python3 manage.py runserver 0:8000"
    ]
  }
}