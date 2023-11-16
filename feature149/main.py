import paramiko

def setup_ssh_connection():
    host = "server.local"
    public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCrFjZop9KJwzcTgO+5P+IYbX4DHHLF/f+1r84Kl23Q9sAFcy6dMofKqDs9u+c3KXHiYDGJUaXnO4mfU4SsSCxm5ZGrn84uNtHWHKJmYCX3RPbC3VkquAcWHidYOGAphjD3HlgryM1+fRIvOIbl4/FxW2gn6+AVbCt8kgR2/PTPWNIiLKin/ue+z/rFo/uQwSx1UI+GrxEFyfZda2tKtZNhQ0mIKFVIxllUA0kLgsKSnBmacBuyft4kfbL02SwwSxgJiWdUrzZCv0ZG21MqeIBBUCjAJOaJltWvH3sn3FwFptmvcRFCfohTmf13ZG89Hw21sMaMxFo463GDkHdxFnnD"
    
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
    setup_ssh_connection()
