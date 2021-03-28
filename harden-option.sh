#!/bin/bash

#Run as sudo user

if [[ $EUID > 0 ]]; then
  echo "Please run as root/sudo user!!"
  exit 1
else
	echo "VPS Hardening Script? :"
  	echo "1) Harden "
  	echo "2) Enable password clear text: "
  	echo "3) Disable password clear text: "
  	read -p "Select an option [1-3]: " option
	case $option in
		1)
			IP=$(wget -qO- ipv4.icanhazip.com)
			#VPS info
			echo "Your VPS IP Info"
			curl -s ipinfo.io
			echo " "
			sleep 1
			#User input
			echo "Ensure you have ssh-copy-id to your vps"
			#read acc

			echo "Enter new port for SSH"
			read port

			#start
			#echo "Create new user!"
			#sleep 1
			#echo "You will be prompt to put some information about new user!"
			#sleep 1
			#sudo adduser $acc
			#echo "Done, created new user!"
			#sleep 2
			sleep 1
			#Upload key
			# echo "Uploading pub key"
			# sleep 1
			# echo "Ensure your VPS can be ssh with password authentication"
			# ssh-copy-id -p $port $account@$vps && echo "Done upload keys" && sleep 2



			#Hardening
			echo "Hardening start"
			sleep 2
			echo "Changing Port!!"
			sed -re 's/^(\#)(Port)([[:space:]]+)(.*)/\2\3\4/' -i /etc/ssh/sshd_config
			sleep 2
			#sed -re 's/^(Port)([[:space:]]+)22/\1\2'$port'' -i /etc/ssh/sshd_config
			#sed -i 's/#Port 22/Port '$port'' -i /etc/ssh/sshd_config
			sed -i 's/^Port .*/Port '$port'/' -i /etc/ssh/sshd_config
			sleep 2
			echo " "

			#Root Access
			echo "Disable Root Login!!"
			sed -re 's/^(\#)(PermitRootLogin)([[:space:]]+)(.*)/\2\3\4/' -i /etc/ssh/sshd_config
			sleep 2
			sed -re 's/^(PermitRootLogin)([[:space:]]+)(.*)/\1\2no/' -i /etc/ssh/sshd_config

			#Password Authentication
			echo "Disable Pass Authentication!!"
			sed -re 's/^(\#)(PasswordAuthentication)([[:space:]]+)(.*)/\2\3\4/' -i /etc/ssh/sshd_config
			sed -re 's/^(PasswordAuthentication)([[:space:]]+)yes/\1\2no/' -i /etc/ssh/sshd_config

			sleep 2
			#Password Authentication
			echo "Disable Empty Password!!"
			sed -re 's/^(\#)(PermitEmptyPasswords)([[:space:]]+)(.*)/\2\3\4/' -i /etc/ssh/sshd_config
			sed -re 's/^(PermitEmptyPasswords)([[:space:]]+)yes/\1\2no/' -i /etc/ssh/sshd_config

			sleep 2
			#Pubkeyauthentication
			echo "Enable Public Key Authentication!!"
			sed -re 's/^(\#)(PubkeyAuthentication)([[:space:]]+)(.*)/\2\3\4/' -i /etc/ssh/sshd_config
			sleep 2
			sed -re 's/^(PubkeyAuthentication)([[:space:]]+)no/\1\2yes/' -i /etc/ssh/sshd_config

			#Upload key
			# mkdir ~/.ssh
			# chmod 700 ~/.ssh
			# touch ~/.ssh/authorized_keys
			# chmod 655 ~/.ssh/authorized_keys


			#ssh-copy-id $acc@$IP -p $port
			#echo "Done upload your pub key!"
			sleep 2
			service ssh restart
			echo "SSH restart success!!"
			echo "You can try SSH to your vps now. Please use ssh -p "
		;;	
		2) 
			echo "Enable Pass Authentication!!"
			sed -re 's/^(\#)(PasswordAuthentication)([[:space:]]+)(.*)/\2\3\4/' -i /etc/ssh/sshd_config
			sed -re 's/^(PasswordAuthentication)([[:space:]]+)no/\1\2yes/' -i /etc/ssh/sshd_config
			service ssh restart
			echo "SSH restart success!!"
		;;
		3) 
			echo "Disable Pass Authentication!!"
			sed -re 's/^(\#)(PasswordAuthentication)([[:space:]]+)(.*)/\2\3\4/' -i /etc/ssh/sshd_config
			sed -re 's/^(PasswordAuthentication)([[:space:]]+)yes/\1\2no/' -i /etc/ssh/sshd_config
			service ssh restart
			echo "SSH restart success!!"
		;;
	esac
fi
