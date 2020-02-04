# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.define "master" do |node|
    node.vm.box = "bento/ubuntu-18.04"
    node.vm.hostname = "master"
    node.vm.network "private_network", ip: "10.0.0.100"
    node.vm.provider "virtualbox" do |vb|
      vb.name = "kmaster"
      vb.memory = "1024"
      vb.cpus = "2"
    end
    node.vm.provision "shell", path: "common.sh"
    node.vm.provision "shell", path: "master.sh"
  end

  NodeCount = 3
  (1..NodeCount).each do |i|
    config.vm.define "worker#{i}" do |worker|
      worker.vm.box = "bento/ubuntu-18.04"
      worker.vm.hostname = "worker#{i}"
      worker.vm.network "private_network", ip: "10.0.0.#{i}"
      worker.vm.provider "virtualbox" do |vb|
        vb.name = "kworker#{i}"
        vb.memory = "512"
        vb.cpus = "1"
      end
      worker.vm.provision "shell", path: "common.sh"
      worker.vm.provision "shell", path: "worker.sh"
    end
  end

end
