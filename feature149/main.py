import paramiko

def setup_ssh():
    host = "server.local"
    
    # Read public key from file
    with open("public_key.pub", "r") as public_key_file:
        public_key = public_key_file.read().strip()

    # Establish SSH connection
    sshcon = paramiko.client.SSHClient()
    sshcon.set_missing_host_key_policy(paramiko.AutoAddPolicy())
    sshcon.connect(host, port=22, username="admin", password="admin")

    # Execute shell script on remote host
    script = """\
    cd /home/ubuntu
    mkdir ~/.ssh/
    chmod 700 /home/ubuntu/.ssh
    chmod 600 /home/ubuntu/.ssh/*
    cd ~/.ssh/
    cat ~/.ssh/authorized_keys
    echo "{}" > ~/.ssh/authorized_keys
    echo 'admin ALL=(ALL) NOPASSWD: ALL' | sudo tee -a /etc/sudoers
    sudo sed -i 's/#PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config
    sudo service ssh reload
    """.format(public_key)

    stdin, stdout, stderr = sshcon.exec_command(script, get_pty=True)
    stdin.write("admin\n")
    
    print("STDOUT:\n%s\n\nSTDERR:\n%s\n" % (stdout.read(), stderr.read()))

    sshcon.close()

if __name__ == "__main__":
    setup_ssh()
