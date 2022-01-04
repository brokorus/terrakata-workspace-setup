${config}

locals {
  tklist = split("-", terraform.workspace)
  tags = {
    environment = local.tklist[0]
    service = local.tklist[1]
    managed_by = "Terraform"
    workspace = terraform.workspace
}
}

module "terrakata" {
  source = "brokorus/terrakata-workspace-validator"
}

output "tkcheck" {
  value = module.terrakata.wscheck
}
