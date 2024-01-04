terraform {
  required_providers {
    null = {
      source = "hashicorp/null"
    }
  }
}

provider "null" {}

# Set up Salt Master
resource "null_resource" "salt_master" {
  # Use remote-exec to execute commands on the Salt Master
  provisioner "remote-exec" {
    inline = [
      "curl -o bootstrap-salt.sh -L https://bootstrap.saltproject.io",
      "chmod +x bootstrap-salt.sh",
      "./bootstrap-salt.sh -P -M -N stable 3005",
      "service salt-master start",
      "echo 'auto_accept: True' >> /etc/salt/master",
      "mkdir -p /var/log/salt/",
      "echo 'log_level_logfile: critical' >> /etc/salt/master",
      "pkill salt-master",
      "service salt-master start"
    ]
  }
  connection {
    # Connect to the Salt Master
    host     = "salt"
    type     = "ssh"
    user     = "root"
    password = "ubuntu"
  }
}


# Set up Salt Minion for Node 1
resource "null_resource" "salt_minion_node1" {
  depends_on = [null_resource.salt_master]

  provisioner "remote-exec" {
    inline = [
      "apt-get update",
      "apt-get install -y curl sudo openssh-server",
      "locale-gen en_US.UTF-8",
      "update-locale LANG=en_US.UTF-8",
      "echo 'Europe/Berlin' > /etc/timezone",
      "dpkg-reconfigure -f noninteractive tzdata",
      "echo 'root:ubuntu' | chpasswd",
      "apt-get install -y salt-minion",
      "echo 'master: salt' > /etc/salt/minion.d/master.conf",
      "echo 'id: lsxvax' > /etc/salt/minion.d/id.conf",
      "echo 'log_level: critical' > /etc/salt/minion.d/log_level.conf",
      "pkill salt-minion"
      "service salt-minion start"
    ]
  }
  connection {
    host     = "node1.local"
    type     = "ssh"
    user     = "root"
    password = "ubuntu"
  }
}

# Set up Salt Minion for Node 2
resource "null_resource" "salt_minion_node2" {
  depends_on = [null_resource.salt_master]

  provisioner "remote-exec" {
    inline = [
      "apt-get update",
      "apt-get install -y curl sudo openssh-server",
      "locale-gen en_US.UTF-8",
      "update-locale LANG=en_US.UTF-8",
      "echo 'Europe/Berlin' > /etc/timezone",
      "dpkg-reconfigure -f noninteractive tzdata",
      "echo 'root:ubuntu' | chpasswd",
      "apt-get install -y salt-minion",
      "echo 'master: salt' > /etc/salt/minion.d/master.conf",
      "echo 'id: gcevyt' > /etc/salt/minion.d/id.conf",
      "echo 'log_level: error' > /etc/salt/minion.d/log_level.conf",
      "pkill salt-minion"
      "service salt-minion start"
    ]
  }
  connection {
    host     = "node2.local"
    type     = "ssh"
    user     = "root"
    password = "ubuntu"
  }
}

# Set up Salt Minion for Node 3
resource "null_resource" "salt_minion_node3" {
  depends_on = [null_resource.salt_master]

  provisioner "remote-exec" {
    inline = [
      "apt-get update",
      "apt-get install -y curl sudo openssh-server",
      "locale-gen en_US.UTF-8",
      "update-locale LANG=en_US.UTF-8",
      "echo 'Europe/Berlin' > /etc/timezone",
      "dpkg-reconfigure -f noninteractive tzdata",
      "echo 'root:ubuntu' | chpasswd",
      "apt-get install -y salt-minion",
      "echo 'master: salt' > /etc/salt/minion.d/master.conf",
      "echo 'id: foawji' > /etc/salt/minion.d/id.conf",
      "echo 'log_level: warning' > /etc/salt/minion.d/log_level.conf",
      "pkill salt-minion"
      "service salt-minion start"
    ]
  }
  connection {
    host     = "node3.local"
    type     = "ssh"
    user     = "root"
    password = "ubuntu"
  }
}
