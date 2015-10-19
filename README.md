# Docker VM
This vagrant setup is primarily intended for MacOS. It uses CoreOS to provide Docker to MacOS via a Vagrant / Virtualbox setup

## Docker Version
This box is intentionally pinned to CoreOS 717 such that the Docker version will be 1.6.2

## CloudConfig
The Vagrantfile for this box provides a ```cloud-config``` which makes the following changes

* Change the I/O scheduler to noop for improved performance
* Enable the Docker Remote API
* Disable the update service
    * we disable the update service so the Docker version in the VM can be considered static. To update the Docker version, you may change the ```config.vm.box_url``` value
    
## Resizing the VM Disk
```resize-disk.sh``` is provided as a simple way to increase the space available to the VM. As Docker tends to be disk-hungry, this is probably a good idea to do out of the box. The default vaule is 100GB, but that can be easily changed in the script

## Services file
This project takes an opinionated view on how to make servies available. We assume that you can have a canonical list of ports and assign them on a per-app basis. The services file is that canonical list. While the names are not important, any port number listed in that file will be forwarded by Vagrant, such that (in the example of 8080) ```localhost:8080``` on the host is forwarded to port ```8080``` on the guest. Additional networking configuration can then be done in Docker as needed. Doing this means that other people and programs will be able to easily access content served by your containers.

## Other conventions
Much of this project is convention or "gentleman's agreement" driven. Other conventions worth noting are as follows:

* The box will always bring up a static IP ```192.168.33.2```. In order to make a ```docker``` client on the host speak to this transparently, one would add the environment variable ```DOCKER_HOST=tcp://196.168.33.2:2375``` to their Bash profile or shell of choice
* This box assumes that you will want to do "live reload" style work. In order to facilitate this performantly, this box assume you have all your various projects checked out under ```~/projects```. We then auto mount via NFS your ```~/projects``` to ```/home/core/projects``` inside the VM
