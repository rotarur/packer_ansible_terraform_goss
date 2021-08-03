resource "tls_private_key" "main" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "main" {
  key_name   = var.project_name
  public_key = tls_private_key.main.public_key_openssh

  provisioner "local-exec" { # Create "myKey.pem" to your computer!!
    command = "echo '${tls_private_key.main.private_key_pem}' > ./example.pem; chmod 400 ./example.pem"
  }
}
