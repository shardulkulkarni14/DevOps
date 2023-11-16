# import paramiko
# import time
# host = "server.local"
# key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCrFjZop9KJwzcTgO+5P+IYbX4DHHLF/f+1r84Kl23Q9sAFcy6dMofKqDs9u+c3KXHiYDGJUaXnO4mfU4SsSCxm5ZGrn84uNtHWHKJmYCX3RPbC3VkquAcWHidYOGAphjD3HlgryM1+fRIvOIbl4/FxW2gn6+AVbCt8kgR2/PTPWNIiLKin/ue+z/rFo/uQwSx1UI+GrxEFyfZda2tKtZNhQ0mIKFVIxllUA0kLgsKSnBmacBuyft4kfbL02SwwSxgJiWdUrzZCv0ZG21MqeIBBUCjAJOaJltWvH3sn3FwFptmvcRFCfohTmf13ZG89Hw21sMaMxFo463GDkHdxFnnD"
# sshcon   = paramiko.client.SSHClient()  # will create the object
# sshcon.set_missing_host_key_policy(paramiko.AutoAddPolicy()) # no known_hosts error
# sshcon.connect(host, port=22, username="admin",password="admin")
# script = open("script.sh").read()
# stdin,stdout,stderr=sshcon.exec_command(script,get_pty=True)
# stdin.write("admin\n")
# print("STDOUT:\n%s\n\nSTDERR:\n%s\n"%(stdout.read(), stderr.read()))
# sshcon.close()
import paramiko
import os

def setup_ssh(public_key_path, private_key_path, remote_host, remote_port, remote_user, remote_password):
    # Connect to the remote host
    ssh = paramiko.SSHClient()
    ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
    
    # Copy the public key to the remote host
    with open(public_key_path, 'r') as public_key_file:
        public_key_content = public_key_file.read().strip()

    ssh.connect(remote_host, port=remote_port, username=remote_user, password=remote_password)
    ssh.exec_command(f"echo '{public_key_content}' >> ~/.ssh/authorized_keys")
    
    # Setup key-based authentication
    private_key = paramiko.RSAKey(filename=private_key_path)
    ssh.get_transport().auth_publickey(remote_user, private_key)

    # Change sudo settings for user 'admin' to allow password-less sudo
    sudoers_content = f"{remote_user} ALL=(ALL:ALL) NOPASSWD:ALL"
    ssh.exec_command(f"echo '{sudoers_content}' | sudo tee /etc/sudoers.d/admin")

    # Change SSH server settings to deny password-based login
    ssh.exec_command("sudo sed -i 's/PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config")
    ssh.exec_command("sudo service ssh restart")

    ssh.close()

if __name__ == "__main__":
    feature_folder = "feature149"
    public_key_path = os.path.join(feature_folder, "public_key.pub")
    private_key_path = os.path.join(feature_folder, "private_key.pem")

    remote_host = "server.local"
    remote_port = 22
    remote_user = "admin"
    remote_password = "admin"

    setup_ssh(public_key_path, private_key_path, remote_host, remote_port, remote_user, remote_password)



