provider "docker" {
  host    = "unix:///var/run/docker.sock"
}

resource "docker_container" "salt" {
  name  = "salt"
  image = "ubuntu:22.04"
  ports {
    internal = 4505
    external = 4505
  }
  ports {
    internal = 4506
    external = 4506
  }
  command = ["sh", "-c", "service ssh start && sleep infinity"]
}

resource "docker_container" "node1" {
  name  = "node1.local"
  image = "ubuntu:22.04"
  command = ["sh", "-c", "service ssh start && sleep infinity"]
}

resource "docker_container" "node2" {
  name  = "node2.local"
  image = "ubuntu:22.04"
  command = ["sh", "-c", "service ssh start && sleep infinity"]
}

resource "docker_container" "node3" {
  name  = "node3.local"
  image = "ubuntu:22.04"
  command = ["sh", "-c", "service ssh start && sleep infinity"]
}

resource "null_resource" "setup_salt" {
  triggers = {
    setup_salt = "${docker_container.salt.name}"
  }

  provisioner "remote-exec" {
    inline = [
      "salt-master --log-level=critical",
    ]
  }
}

resource "null_resource" "setup_minions" {
  depends_on = [docker_container.salt]

  provisioner "remote-exec" {
    inline = [
      "salt-key -A -y",
    ]
  }
}

resource "null_resource" "configure_minion_node1" {
  depends_on = [null_resource.setup_minions]

  provisioner "remote-exec" {
    inline = [
      "salt-key -A -y",
      "salt-key -L",
      "salt-key -A -y",
      "salt-call --local --id lsxvax grains.setval roles 'minion_node1'",
      "salt-call --local --id lsxvax state.highstate",
      "salt-call --local --id lsxvax config.option 'log_level' 'critical'",
      "systemctl restart salt-minion",
    ]
  }
}

resource "null_resource" "configure_minion_node2" {
  depends_on = [null_resource.setup_minions]

  provisioner "remote-exec" {
    inline = [
      "salt-call --local --id gcevyt grains.setval roles 'minion_node2'",
      "salt-call --local --id gcevyt state.highstate",
      "salt-call --local --id gcevyt config.option 'log_level' 'error'",
      "systemctl restart salt-minion",
    ]
  }
}

resource "null_resource" "configure_minion_node3" {
  depends_on = [null_resource.setup_minions]

  provisioner "remote-exec" {
    inline = [
      "salt-call --local --id foawji grains.setval roles 'minion_node3'",
      "salt-call --local --id foawji state.highstate",
      "salt-call --local --id foawji config.option 'log_level' 'warning'",
      "systemctl restart salt-minion",
    ]
  }
}
