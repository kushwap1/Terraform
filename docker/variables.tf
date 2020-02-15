variable "env" {
  description = "env: dev, prod or qa"
}

variable "image_name" {
  type = "map"
  default = {
    dev = "ghost:latest"
    qa = "ghost:alpine"
    prod = "ghost"
  }
}

variable "container_name" {
  type = "map"
  default = {
    dev = "ghost_dev"
    qa = "ghost_qa"
    prod = "ghost_prod"
  }
}

variable "ext_port" {
  type = "map"
  default = {
    dev = "8200"
    qa = "8201"
    prod = "8203"
  }
}

