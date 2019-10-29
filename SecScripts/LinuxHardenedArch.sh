#!/bin/bash

# SecBuddy Linux Hardened Kernel Install Script: Arch Linux

printf "Linux Hardened Kernel Installation: Arch Linux"
printf "WARNING! Installing a new kernel can break compatibility with software. A backup is recommended before proceeding!"
printf "The linux-hardened kernel enables several security features. Would you like to install it now? [Y/n]: "

read -r RUN_INSTALL

while true
do
	if [ "$RUN_INSTALL" == "Y" ]
	then
		# Because user inputted y we begin linux-hardened install

		pacman -S linux-hardened

		printf "Linux-Hardened installation complete! would you like to install additional security tools? [Y/n]: "
		read -r ADDONS

		while true
		do
			if [ "$ADDONS" == "Y" ]
			then
				#installs and enables firejail, usbguard and fail2ban
				#firejail allows running apps in a sandbox
				#usbguard allows USB whitelisting/blacklisting
				#fail2ban creates login timeouts.
				pacman -S firejail usbguard fail2ban
			
				#enable and start services
				systemctl enable fail2ban
				systemctl enable usbguard
				systemctl start fail2ban
				systemctl start usbguard
			
				printf "Install Finished, Be sure to reboot your machine to use the new kernel.\n\n"
				exit 0
			elif [ "$ADDONS" == "n" ]
			then
				printf "Install Finished, Be sure to reboot your machine to use the new kernel.\n\n"
				exit 0
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
