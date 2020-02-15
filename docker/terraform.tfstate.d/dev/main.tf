variable "image_name" {
  default = "ghost:latest"
}


variable "container_name" {
  default = "ghost_blog"
}


variable "ext_port" {
  default = "8112"
}


resource "docker_image" "new" {
  name = var.image_name
}

resource "docker_container" "new" {
  name = var.container_name
  image = docker_image.new.name
  ports {
    internal = "2368"
    external = var.ext_port
  }
}


