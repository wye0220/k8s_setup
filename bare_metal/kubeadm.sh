#!/bin/bash

# https://kubernetes.io/zh/docs/setup/production-environment/tools/kubeadm/install-kubeadm/
# https://kubernetes.io/zh/docs/tasks/administer-cluster/kubeadm/kubeadm-upgrade/

#sudo apt update
sudo apt install -y apt-transport-https ca-certificates curl nfs-common

sudo curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg

echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list

sudo apt update
sudo apt install -y kubeadm=1.23.3-00 kubelet=1.23.3-00 kubectl=1.23.3-00
sudo apt-mark hold kubeadm kubelet kubectl

# check
kubeadm version
kubectl version --client

# add this line to '.bashrc'
#source <(kubectl completion bash)
