#!/usr/bin/env bash

set -e

export DEBIAN_FRONTEND=noninteractive

apt-get update
apt-get install -y openssh-client

mkdir -p /home/vagrant/.ssh

chmod 700 /home/vagrant/.ssh
chmod 600 /home/vagrant/.ssh/server_key

chown vagrant:vagrant /home/vagrant/.ssh/server_key

cat > /home/vagrant/.ssh/config <<'EOF'
Host server
    HostName 192.168.56.11
    User vagrant
    IdentityFile /home/vagrant/.ssh/server_key
    StrictHostKeyChecking no
    UserKnownHostsFile /dev/null
EOF

chmod 600 /home/vagrant/.ssh/config
chown vagrant:vagrant /home/vagrant/.ssh/config

grep -q "192.168.56.11 server" /etc/hosts || echo "192.168.56.11 server" >> /etc/hosts
