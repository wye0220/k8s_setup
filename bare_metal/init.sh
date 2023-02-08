#!/bin/sh

sudo apt update
sudo apt install -y openssh-server
sudo apt install -y git vim tree curl jq


# install docker from ubuntu repo
sudo apt install -y docker.io

sudo service docker start
sudo usermod -aG docker ${USER}

sudo chmod 666 /var/run/docker.sock

# fix docker issue
cat <<EOF | sudo tee /etc/docker/daemon.json
{
  "exec-opts": ["native.cgroupdriver=systemd"],
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "100m"
  },
  "storage-driver": "overlay2"
}
EOF

sudo systemctl enable docker
sudo systemctl daemon-reload
sudo systemctl restart docker


# iptables

cat <<EOF | sudo tee /etc/modules-load.d/k8s.conf
br_netfilter
EOF

cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
net.ipv4.ip_forward=1 # better than modify /etc/sysctl.conf
EOF

sudo sysctl --system

# Disable Swap

sudo swapoff -a
sudo sed -ri '/\sswap\s/s/^#?/#/' /etc/fstab
