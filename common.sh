#!/bin/bash

# Disable swap
swapoff -a
sed -i '/swap/d' /etc/fstab

# Install Docker
apt-get update
apt-get install -y docker.io
systemctl enable docker
systemctl start docker

# Install Kubernetes
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add
apt-add-repository "deb http://apt.kubernetes.io/ kubernetes-xenial main"
apt-get update
echo "KUBELET_EXTRA_ARGS=--node-ip=$(hostname -I | awk '{print $2}')" >> /etc/default/kubelet
apt-get install -y kubeadm kubelet kubectl

