cd /home/ubuntu
mkdir ~/.ssh/
chmod 700 /home/ubuntu/.ssh
chmod 600 /home/ubuntu/.ssh/*
cd ~/.ssh/
cat ~/.ssh/authorized_keys
echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCrFjZop9KJwzcTgO+5P+IYbX4DHHLF/f+1r84Kl23Q9sAFcy6dMofKqDs9u+c3KXHiYDGJUaXnO4mfU4SsSCxm5ZGrn84uNtHWHKJmYCX3RPbC3VkquAcWHidYOGAphjD3HlgryM1+fRIvOIbl4/FxW2gn6+AVbCt8kgR2/PTPWNIiLKin/ue+z/rFo/uQwSx1UI+GrxEFyfZda2tKtZNhQ0mIKFVIxllUA0kLgsKSnBmacBuyft4kfbL02SwwSxgJiWdUrzZCv0ZG21MqeIBBUCjAJOaJltWvH3sn3FwFptmvcRFCfohTmf13ZG89Hw21sMaMxFo463GDkHdxFnnD" > ~/.ssh/authorized_keys
echo 'admin ALL=(ALL) NOPASSWD: ALL'|sudo tee -a /etc/sudoers
sudo sed -i 's/#PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config
sudo service ssh reload


