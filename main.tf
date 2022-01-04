resource "local_file" "terrakata" {
  for_each = toset(var.workspaces)
  filename = "${path.root}/workspaces/${each.key}/terrakata.tf"
  content  = templatefile("${path.module}/terrakata.tpl", { workspace = each.key, config = data.local_file.config.content })
}

resource "null_resource" "ws" {
  depends_on = [local_file.terrakata]
  for_each   = toset(var.workspaces)
  provisioner "local-exec" {
    #working_dir = "${path.root}/workspaces/${each.key}"
    command = "terraform workspace new ${each.key} || true"
  }
}

data "local_file" "config" {
  filename = "${path.root}/config.tf"
}
