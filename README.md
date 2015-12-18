# my-Horton
HortonWorks(r) Hadoop distribution with Docker in Vagrant Box 

**!! Tested only with VirtualBox on Windows !!**


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


## How-To Create VM with Vagrant

Make sure you have installed VirtualBox, Vagrant, and 'vagrant' executable is in your path.

You are -still- in "my-Horton" directory.

### my-Ambari

Simplest way:

    PS my-Horton> .\build_vm.ps1

In detail:

1) (**Optional**) Clone repository 'my-Ambari' in 'vagrant' folder :

    PS my-Horton> git clone https://github.com/my-Horton/my-Ambari.git vagrant/my-Ambari

2) Build 'my-Ambari' VM :

    PS my-Horton> .\build_vm.ps1 my-Ambari

By default, this VM has 4096 MB memory size and IP address is 192.168.66.101.

3) Connect with ssh :

    PS my-Horton> .\ssh_vm.ps1

Now you are connected by ssh with user vagrant. 
You can have access to user root :

    [vagrant@horton ~]$ sudo su -
    [root@horton ~]#


## How-To Add / Start / Access Dockers

### my-Ambari

You have to build my-Ambari VM first (see above).

This VM gets my-Ambari docker from the web, then calls function 'amb-start-first' from source file '/root/ambari-functions'.

At start, 'amb-start-first' downloads docker images and creates 2 containers:
    - amb-consul (acts as DNS and registry for others dockers),
    - amb-server (Ambari Server itself)

You can list these containers :

directly with docker binary :

    [root@horton ~]# docker ps

    CONTAINER ID        IMAGE                         COMMAND                CREATED              STATUS              PORTS
                                                             NAMES
    4e369adee29d        horton/docker-ambari          "/start-server"        About a minute ago   Up About a minute   8080/tcp                                                           amb-server
    d6960706ca73        sequenceiq/consul:v0.5.0-v6   "/bin/start -server    35 minutes ago       Up 35 minutes       53/tcp, 53/udp, 8300-8302/tcp, 8400/tcp, 8500/tcp, 8301-8302/udp   amb-consul

or with 'docker-ps' function :

    [root@horton ~]# docker-ps

    /amb-server 172.17.0.2 horton/docker-ambari <nil> {[/start-server]}
    /amb-consul 172.17.0.1 sequenceiq/consul:v0.5.0-v6 {[/bin/start]} {[-server -bootstrap]}

Ambari Server URL is http://192.168.66.101:8080 (login: admin, password: admin).

Once connected by ssh and on user root, you can add node (as docker container) with 'amb-start-node'.
For example, to create a 3 nodes cluster, just launch these commands:

    ## Creates node amb1.service.consul with an Ambari agent
    [root@horton ~]# amb-start-node 1
    ## Creates node amb2.service.consul with an Ambari agent
    [root@horton ~]# amb-start-node 2
    ## Creates node amb3.service.consul with an Ambari agent
    [root@horton ~]# amb-start-node 3

You have access to these new containers with :

    [root@horton ~]# docker exec -it NODE_NAME /bin/bash

For example, to access amb1:

    [root@horton ~]# docker exec -it amb1 /bin/bash

To access amb-server:

    [root@horton ~]# docker exec -it amb-server /bin/bash

Aliases exist in root environment :

    [root@horton ~]# alias
    alias ssha1='docker exec -it amb1 /bin/bash'
    alias ssha2='docker exec -it amb2 /bin/bash'
    alias ssha3='docker exec -it amb3 /bin/bash'
    alias sshas='docker exec -it amb-server /bin/bash'

NOTE: In Ambari Web, you can register nodes with fullname (Default domainname is service.consul) and with manually method (as each new node starts with an Ambari agent).
