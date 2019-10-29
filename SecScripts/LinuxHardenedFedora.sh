#!/bin/bash

# SecBuddy Linux Hardened Kernel Install Script: Fedora Linux


printf "Linux Hardened Kernel Installation: Fedora Linux"
printf "WARNING! Installing a new kernel can break compatibility with software. A backup is recommended before proceeding!"
printf "The linux-hardened kernel enables several security features. The installation time is over 1 hour as we are compiling it."
printf "Would you like to install the hardened kernel now? [Y/n]: "

read -r RUN_INSTALL

CONFIG= uname -r
CONFPATH=/boot/$CONFIG

while true
do
	if ["$RUN_INSTALL" == "Y"]
	then
		# Because user inputted y we begin linux-hardened install
		
		# Clone a version of the linux4.9, with grsec patch added
		git clone https://github.com/hckme4/linux-grsecurity.git
		cd linux-grsecurity

		# copy old kernel config to Linux source tree to simplify installation
		WORKINGDIR= pwd

		printf "Press 1 if you would like to use your old config.\nPress 2 if you would like to generate your own\nSelect: "
		read -r CONFIGOPT

		while true
		do
			if [ "$CONFIGOPT" == "1" ]
			then
				cp $CONFPATH $WORKINGDIR/.config
				make oldconfig
				break
			elif [ "$CONFIGOPT" == "2" ]
			then
				make menuconfig
				break
			else
				printf "1 for old config, 2 for creating new via menu: "
				read -r CONFIGOPT
			fi
		done

		# begin compiling hardened kernel. add -j MAKEOPT to speed up compilation.
		make bzImage
		make modules
		make modules_install
		make install

		printf "\nNew Kernel Installation Completed! Would you like to install additional security tools? [Y/n]: "
		read -r ADDONS

		while true
		do
			if [ "$ADDONS" == "Y" ]
				#install firejail, usbguard and fail2ban
				dnf install -y dnf-plugins-core
				dnf copr enable heikoada/firejail
				dnf install -y firejail usbguard fail2ban

				#enable and start services
				systemctl enable usbguard
				systemctl enable fail2ban
				systemctl start usbguard
				systemctl start fail2ban
				
				#Exit
				printf "Installation Finished, A reboot is recommended to use your new kernel.\n\n"
				exit 0

			elif [ "$ADDONS" == "n" ]
				printf "Installation Finished, A reboot is recommended to use your new kernel.\n\n"
				exit 0
			else
				printf "Enter a capital Y or a lowercase n: "
				read -r ADDONS
			fi
		done
		

	elif ["$RUN_INSTALL" == "n"]
	then
		# Since user inputted n we notify user and quit the script.
		printf "Not installing linux-hardened upon user request. Exiting........\n\n"
		exit 0
	else
		printf "Enter a capital Y for yes, lowercase n for no: "
		read -r RUN_INSTALL
	fi
done
