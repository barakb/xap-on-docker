A collection of scripts and dockerfile that help to run 2 XAP sites in docker containers on your machine.
=========================================================================================================


# Prerequisites
1. docker
2. docker [group](http://askubuntu.com/questions/477551/how-can-i-use-docker-without-sudo)
3. ip forwarding enabled  `sudo echo 1 > /proc/sys/net/ipv4/ip_forward`

# Building the docker image

1. git clone https://github.com/barakb/xap-on-docker.git
2. Download XAP zip and put it in the xap-on-docker dir.
3. `cd xap-on-docker`
4. Edit Dockerfile replace 'gigaspaces-xap-premium-10.1.0-m6-b12586-99.zip' with your XAP zip.
5. `./rebuild.sh`

# Deploying XAP sites and configure network.

1. In one shell `./gs1.sh`
2. In second shell `./gs2.sh`
3. In third shell `./connect.sh` and type your password when requested.
This script edit /etc/hosts of your host and the 2 docker containers.
4. Now in shell one (gs1) type `./xap.sh`
5  In shell 2 (gs2) type `./xap.sh`
6. Run RI on your host with locators gs1,gs2
7. Deploy your app.

# Creating splitbrain.

1. Open shell and type `./shell.sh gs1`
2. In gs1 type `./disconnect.sh`

# Resolving splitbrain.

1. Open shell and type `./shell.sh gs1`
2. In gs1 type iptables --flush

# Re installing. 
1. Close both XAP and from your machine type `./rebuild.sh`


# Networking.
* If you wish to use network interface other then eth0 edit connect.sh


