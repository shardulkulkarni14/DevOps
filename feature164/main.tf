terraform {
  required_providers {
    null = {
      source = "hashicorp/null"
    }
  }
}

provider "null" {}

# Set up Salt Master
resource "null_resource" "salt" {
  # Use remote-exec to execute commands on the Salt Master
  provisioner "remote-exec" {
    inline = [
      "curl -o bootstrap-salt.sh -L https://bootstrap.saltproject.io",
      "chmod +x bootstrap-salt.sh",
      "./bootstrap-salt.sh -P -M -N stable 3005",
      "service salt-master start",
      "echo 'auto_accept: True' >> /etc/salt/master",
      "echo 'log_level_logfile: critical' >> /etc/salt/master",
      "pkill salt-master",
      "service salt-master restart",
      "sudo salt-key -lsxvax -y",
      "sudo salt-key -gcevyt -y",
      "sudo salt-key -foawji -y"
    ]
  connection {
    # Connect to the Salt Master
    type     = "ssh"
    user     = "root"
    password = "ubuntu"
    host     = "salt"
    }
  }
}


# Set up Salt Minion for Node 1
resource "null_resource" "node1" {
  provisioner "remote-exec" {
    inline = [
      "apt-get install -y salt-minion",
      "service salt-minion start",
      "echo 'master: salt' > /etc/salt/minion.d/master.conf",
      "echo 'log_level_logfile: critical' > /etc/salt/minion.d/log_level.conf",
      "echo 'id: lsxvax' > /etc/salt/minion.d/id.conf",
      "service salt-minion restart"
    ]

  connection {
    type     = "ssh"
    user     = "root"
    password = "ubuntu"
    host     = "node1.local"
    }
  }
}

# Set up Salt Minion for Node 2
resource "null_resource" "node2" {
  provisioner "remote-exec" {
    inline = [
      "apt-get install -y salt-minion",
      "service salt-minion start",
      "echo 'master: salt' > /etc/salt/minion.d/master.conf",
      "echo 'log_level_logfile: error' > /etc/salt/minion.d/log_level.conf",
      "echo 'id: gcevyt' > /etc/salt/minion.d/id.conf",
      "service salt-minion restart"
    ]
  connection {
    host     = "node2.local"
    type     = "ssh"
    user     = "root"
    password = "ubuntu"
    }
  }
}

# Set up Salt Minion for Node 3
resource "null_resource" "node3" {
  provisioner "remote-exec" {
    inline = [
      "apt-get install -y salt-minion",
      "service salt-minion start",
      "echo 'master: salt' > /etc/salt/minion.d/master.conf",
      "echo 'log_level_logfile: warning' > /etc/salt/minion.d/log_level.conf",
      "echo 'id: foawji' > /etc/salt/minion.d/id.conf",
      "service salt-minion restart"
    ]
  connection {
    host     = "node3.local"
    type     = "ssh"
    user     = "root"
    password = "ubuntu"
    }
  }
}
