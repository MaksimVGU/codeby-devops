#!/usr/bin/env bash

set -e

export DEBIAN_FRONTEND=noninteractive

apt-get update
apt-get install -y openssh-server

systemctl enable --now ssh

mkdir -p /home/vagrant/.ssh
chmod 700 /home/vagrant/.ssh

cat /tmp/server_key.pub > /home/vagrant/.ssh/authorized_keys

chmod 600 /home/vagrant/.ssh/authorized_keys
chown -R vagrant:vagrant /home/vagrant/.ssh

rm -f /tmp/server_key.pub

cat > /etc/ssh/sshd_config.d/codeby.conf <<'EOF'
PubkeyAuthentication yes
PasswordAuthentication yes
PermitRootLogin no
EOF

systemctl restart ssh
