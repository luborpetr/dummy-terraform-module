resource "null_resource" "dummy_resource" {
  triggers = {
    always_run = timestamp()
  }
  provisioner "local-exec" {
    interpreter = ["bash", "-c"]
    command = <<EOT
        echo "Dummy module invoked"
    EOT
  }
}

resource "random_id" "server" {
  keepers = {
    always_run = timestamp()
  }

  byte_length = 8
}