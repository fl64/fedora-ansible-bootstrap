# -*- mode: ruby -*-
# vi: set ft=ruby :
#goss_version="v0.3.6"

Vagrant.configure("2") do |config|
  config.vm.box = "bento/fedora-31"
  config.vm.synced_folder "./", "/bootstrap"
  config.vm.provider "virtualbox" do |vb|
    vb.gui = false
    vb.memory = "2048"
  end

  config.vm.provision "shell", inline: <<-SHELL
    dnf -y group install "Basic Desktop" GNOME
    systemctl set-default graphical.target
    systemctl isolate graphical.target
  SHELL

  config.vm.provision "ansible_local" do |ansible|
    ansible.verbose = "v"
    #ansible.galaxy_role_file = "requirements.yml"
    ansible.galaxy_roles_path = "/bootstrap/roles/"
    ansible.playbook = "/bootstrap/vagrant.yaml"
    ansible.raw_arguments = ["--diff"]
  end
end
