resource "aws_key_pair" "test" {
  key_name   = "test"
  public_key = tls_private_key.rsa.public_key_openssh

}

resource "tls_private_key" "rsa" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "test" {
  content  = tls_private_key.rsa.private_key_pem
  filename = "test-key"

  provisioner "local-exec" {
    command = "chmod 600 ${local_file.test.filename}"

  }