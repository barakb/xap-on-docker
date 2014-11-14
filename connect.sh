#!/bin/bash -x 

#The ip address of the hosting machine that will be added to the /etc/hosts of the containers will be taken from this network interface.
interface=eth0

#Read the docker conetiner ip address.
gs1=`docker exec gs1 head -n1 /etc/hosts`
gs2=`docker exec gs2 head -n1 /etc/hosts`

#Get the host ip address and host name.
ipaddress=`ifconfig $interface | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1' | tr -d '\n'`
hostname=`hostname`

#Add to the continers's /etc/hosts the host and ip of the hosting machine.
docker exec gs1 bash -c "echo $gs2 >> /etc/hosts"
docker exec gs1 bash -c "echo $ipaddress $hostname >> /etc/hosts"
docker exec gs2 bash -c "echo $gs1 >> /etc/hosts"
docker exec gs2 bash -c "echo $ipaddress $hostname >> /etc/hosts"

l1=( $gs1 )
ip1=${l1[0]}


l2=( $gs2 )
ip2=${l2[0]}


#create the disconnect script on each of the docker containers.
docker exec gs1 bash -c  "printf '%s\n%s\n%s\n%s\n' '#!/bin/bash' 'iptables --flush' 'iptables -I INPUT -s gs2 -j DROP'  'iptables -I OUTPUT -d gs2 -j DROP' > /data/xap/bin/disconnect.sh && chmod +x /data/xap/bin/disconnect.sh"

docker exec gs2 bash -c  "printf '%s\n%s\n%s\n%s\n' '#!/bin/bash' 'iptables --flush' 'iptables -I INPUT -s gs1 -j DROP'  'iptables -I OUTPUT -d gs1 -j DROP' > /data/xap/bin/disconnect.sh && chmod +x /data/xap/bin/disconnect.sh"


./update-hosts.sh "$gs1" "$gs2"



