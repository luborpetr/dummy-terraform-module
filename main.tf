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

##
# This is covering scenarios when a module generates artifacts in terraform plan stage
##
data "archive_file" "archive_foo" {
  type        = "zip"
  source_dir = "${path.root}/dummy_data"
  output_path = "${path.root}/dummy_data.zip"
}

##
# Consume artifact created in terraform plan stage
##
resource "null_resource" "extract_my_tgz" {
  provisioner "local-exec" {
    command = "ls -lah ${path.root}/dummy_data.zip"
  }
}