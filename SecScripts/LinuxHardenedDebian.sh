#!/bin/bash

# SecBuddy Linux Hardened Kernel Install Script: Debian Linux

printf "Linux Hardened Kernel Installation: Debian Linux"
printf "WARNING! Installing a new kernel can break compatibility with software. A backup is recommended before proceeding!"
printf "The linux-hardened kernel enables several security features. Would you like to install it now? [Y/n]: "

read -r RUN_INSTALL

while true
do
	if [ "$RUN_INSTALL" == "Y" ]
	then
		# Because user inputted y we begin linux-hardened install

		printf "Press 1 for amd64\nPress 2 for i686 (32bit)\nChoice: "
		read -r ARCH

		# Take selected architecture and install it.
		while true
		do
			if [ "$ARCH" == "1" ]
			then
				apt-get install -y linux-image-4.9.0-4-grsec-amd64 linux-headers-4.9.0-4-grsec-amd64
				apt-get install -y linux-headers-4.9.0-4-common-grsec linux-grsec-support-4.9.0-4
				apt-get install -y linux-grsec-source-4.9
				break
			elif [ "$ARCH" == "2" ]
			then
				apt-get install -y linux-image-4.9.0-4-grsec-686-pae linux-headers-4.9.0-4-grsec-686-pae
				apt-get install -y linux-headers-4.9.0-4-common-grsec linux-grsec-support-4.9.0-4
				apt-get install -y linux-grsec-source-4.9
				break
			else
				printf "Select 1 or 2:"
				read -r ARCH
			fi
		done
		

		printf "Linux hardened kernel install complete! Would you like to install additional security tools now? [Y/n]: "
		read -r ADDONS

		# Install fail2ban, firejail, and usbguard. 
		while true
		do
			if [ "$ADDONS" == "Y" ]
			then
				apt-get install -y fail2ban usbguard firejail
				
				#enable and start services
				systemctl enable usbguard
				systemctl enable fail2ban
				systemctl start usbguard
				systemctl start fail2ban

				#Exit
				printf "Install Finished! A reboot is recommended to be able to use the new hardened kernel."
				exit 0
			elif [ "$ADDONS" == "n" ]
			then
				printf "Install Finished! A reboot is recommended to be able to use the new hardened kernel."
				exit 0
			else
				printf "Enter a capital Y for yes, lowercase n for no: "
				read -r ADDONS
			fi
		done

	elif [ "$RUN_INSTALL" == "n" ]
	then
		# Since user inputted n we notify user and quit the script.
		printf "Not installing linux-hardened upon user request. Exiting........\n\n"
		exit 0
	else
		printf "Enter a capital Y for yes, lowercase n for no: "
		read -r RUN_INSTALL
	fi
done
