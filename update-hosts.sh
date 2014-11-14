#!/bin/bash
# Update the local host /etc/hosts file with the entries of the docker containters gs1 and gs2
cat /etc/hosts > hosts
sed -i '/gs1$/d' hosts
sed -i '/gs2$/d' hosts
echo $1 >> hosts
echo $2 >> hosts
sudo cp hosts  /etc/hosts


