#!/bin/bash

# Start Kubernetes
kubeadm init --pod-network-cidr=10.17.0.0/16 --apiserver-advertise-address 10.0.0.100
kubeadm token create --print-join-command > /vagrant/joincluster.sh

# Configure kubectl
mkdir -p /home/vagrant/.kube
cp -f /etc/kubernetes/admin.conf /home/vagrant/.kube/config
chown vagrant:vagrant /home/vagrant/.kube/config

# Install Weave net
su - vagrant -c "kubectl apply -f \"https://cloud.weave.works/k8s/net?k8s-version=$(kubectl version | base64 | tr -d '\n')\""

# Enable kubectl completion
apt-get update
apt-get install -y bash-completion
echo 'source <(kubectl completion bash)' >> ~vagrant/.bashrc
echo 'alias k=kubectl' >> ~vagrant/.bashrc
echo 'complete -F __start_kubectl k' >> ~vagrant/.bashrc
