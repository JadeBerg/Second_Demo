# Local build and push docker image
resource "null_resource" "build" {
  provisioner "local-exec" {
    command = "make build"
    working_dir = "/mnt/d/terraform_practice/Second_Demo/app_docker"
    environment = {
        TAG = var.image_tag
        REGISTRY_ID = var.reg_id
        REPOSITORY_REGION = var.region
        APP_NAME = var.app_name
    }
  }
}