# -*- mode: ruby -*-
# vi: set ft=ruby :

#
# Vagrantfile for the NCP Debian VM
#
# Instructions: vagrant up; vagrant ssh
#
# Notes: User/Pass is ubnt/ubnt.
# $HOME is accessible as /external. CWD is accessible as /cwd
#

Vagrant.configure("2") do |config|

  vmname = "NCP Debian VM"

  #Box settings
  config.vm.box = "debian/stretch64"
  config.vm.box_check_update = false

  #VM settings
  config.vm.hostname = "ncp-vm"

  #Networking

  #Public IP
  #config.vm.network "public_network"
  #config.vm.network "public_network", ip: "192.168.0.17"
  config.vm.network "public_network", bridge: "ens4"

  #Private IP
  #config.vm.network "private_network", ip: "192.168.50.4"
  #config.vm.network "private_network", type: "dhcp"

  #Provider settings
  config.vm.provider "virtualbox" do |v|
    #Resources
    v.memory = 4096
    v.cpus = 4

    #VM name
    v.name = "NextCloudPi"

  end


  config.vm.synced_folder '.', '/vagrant', disabled: true

  $script = <<-SHELL
    sudo su
    BRANCH=gsoc2019-master
    #BRANCH=gsoc2019-devel  # uncomment to install devel
    apt-get update
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends git

    # indicate that this will be an image build
    touch /.ncp-image

    # install
    git clone -b "$BRANCH" https://github.com/eellak/gsoc2019-NextCloudPi.git /tmp/nextcloudpi
    cd /tmp/nextcloudpi

    # uncomment to install devel
    #sed -i 's|^BRANCH=gsoc2019-master|BRANCH=gsoc2019-devel|' install.sh ncp.sh

    #Do alltogether so that the install.sh won't fail as it does sometimes when run alone
    bash install.sh && source etc/library.sh && run_app_unsafe post-inst.sh && cd - && rm -r /tmp/nextcloudpi && systemctl disable sshd && poweroff

    # cleanup
#    source etc/library.sh
#    run_app_unsafe post-inst.sh
#    cd -
#    rm -r /tmp/nextcloudpi
#    systemctl disable sshd
#    poweroff
  SHELL

  # Provision the VM
  config.vm.provision "shell", inline: $script

end
