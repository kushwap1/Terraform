resource "docker_image" "new" {
  name = lookup(var.image_name, var.env)
}

resource "docker_container" "new" {
  name = lookup(var.container_name, var.env)
  image = docker_image.new.name

  ports {
    internal = "2368"
    external = lookup(var.ext_port, var.env)
  }
}
