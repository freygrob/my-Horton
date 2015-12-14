# my-Horton
HortonWorks(r) Hadoop distribution with Docker in Vagrant Box 

!! Tested only with VirtualBox on Windows !!

## Prerequisites

- [VirtualBox](https://www.virtualbox.org/wiki/Downloads)
- [Packer](https://www.packer.io/downloads.html)
- [Vagrant](https://www.vagrantup.com/downloads.html)
- [Git](https://git-scm.com/downloads)

## How-To Build Box

1) Clone this repository :

    PS my-Horton> git clone https://github.com/my-Horton/my-Horton.github
    PS my-Horton> cd my-Horton

2) Clone dependency inside :

    PS my-Horton> git clone https://github.com/freygrob/my_bento_centos-minimal.github bento

3) Download Packer & extract all binaries to folder 'packer' :

https://www.packer.io/downloads.html

4) Build 'CentOS Minimal' Box :

    PS my-Horton> .\build_box.ps1

## How-To Create VM

Make sure you have installed VirtualBox, Vagrant, and 'vagrant' executable is in your path.

You -still- are in "my-Horton" directory.

### my-Ambari

1) **Optional** Clone repository 'my-Ambari' in 'vagrant' folder :

    PS my-Horton> git clone https://github.com/my-Horton/my-Ambari.git vagrant/my-Ambari

2) Build 'my-Ambari' VM :

    PS my-Horton> .\build_vm.ps1 my-Ambari

