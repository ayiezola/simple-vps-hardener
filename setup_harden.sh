#!/bin/bash
# by ayiezola

echo " "
#user input
echo "Enter your VPS Ip Address"
read vps

sleep 1
echo "Enter your VPS account [Exp: root, ubuntu] : "
#echo "Enter for default account; exp : root "
read account

sleep 1
echo "Enter ssh port: "
#read -p "Enter for default 22 " -e -i 22 port
read port

sleep 1
#Upload key
echo "Upload pubkey to home current user"
#scp ~/id_rsa.pub $account@$vps:~/
ssh-copy-id -p $port $account@$vps

sleep 1
#Upload harden script
echo "Upload harderning script"
scp -P $port harden-option.sh $account@$vps:~/

sleep 1
#Done
echo "Done upload!"

#SSH Connect VPS
sleep 1
echo "Connecting to VPS!"

#echo "Using command : ssh -p" $port $account@$vps
#sleep 1
ssh -p $port $account@$vps && sudo chmod +x harden-option.sh
#echo "Success! Please run harden-option.sh using sudo"






