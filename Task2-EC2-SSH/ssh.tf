resource "aws_key_pair" "cmtr-959pompn-keypair" {
  key_name   = "cmtr-959pompn-keypair"
  public_key = var.ssh_key
}