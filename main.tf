terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "3.0.2"
    }
  }
}

provider "docker" {
  host = "unix:///var/run/docker.sock"
}

# resource "docker_container" "ubuntu" {
#   name  = "foo"
#   image = docker_image.pgadmin4

#   ports {
#     internal = 80
#     external = var.ext_port
#   }
# }

resource "docker_image" "dbconn" {
  name = "dbconntest"
  build {
    context = "src/."
    tag     = ["dbconntest:develop"]
  }

  triggers = {
    dir_sha1 = sha1(join("", [for f in fileset(path.module, "src/*") : filesha1(f)]))
  }
}

resource "docker_container" "dbconn" {
  name  = "dbconn"
  image = docker_image.dbconn.image_id
  env = [
    "DB_HOST=${var.db_host}",
    "DB_PORT=5432",
    "DB_USER=${var.db_user}",
    "DB_PASS=${var.db_pass}",
    "DB_NAME=${var.db_name}"
  ]
}

resource "docker_image" "postgres" {
  name = "postgres"
}

resource "docker_container" "postgres" {
  name  = "postgres"
  image = docker_image.postgres.image_id
  env = [
    "POSTGRES_USER=admin",
    "POSTGRES_PASSWORD=admin",
    "POSTGRES_DB=mydb"
  ]
  ports {
    internal = 5432
    external = 5432
  }
}
