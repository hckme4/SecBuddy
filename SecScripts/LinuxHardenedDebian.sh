#!/bin/bash

# SecBuddy Linux Hardened Kernel Install Script: Debian Linux

printf "Linux Hardened Kernel Installation: Debian Linux"
printf "WARNING! Installing a new kernel can break compatibility with software. A backup is recommended before proceeding!"
printf "The linux-hardened kernel enables several security features. Would you like to install it now? [Y/n]: "

read -r RUN_INSTALL

while true
do
	if ["$RUN_INSTALL" == "Y"]
	then
		# Because user inputted y we begin linux-hardened install

		# install code here
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
