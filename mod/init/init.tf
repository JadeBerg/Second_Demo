# Local build and push docker image
resource "null_resource" "build" {
  provisioner "local-exec" {
    command = "make build"
    working_dir = "/mnt/d/terraform_practice/Demo2_versions/dm_2_docker/app_docker"
    environment = {
        TAG = var.image_tag
        REGISTRY_ID = var.reg_id
        REPOSITORY_REGION = var.region
        APP_NAME = var.app_name
    }
  }
}