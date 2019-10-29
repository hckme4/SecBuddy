#!/bin/bash

# Bash script to install UFW firewall on Fedora Linux.

printf "Uncomplicated Firewall Installer: Fedora Linux"
printf "This script will automate the installation and enabling of UFW on your system. Do you want to do this? [Y/n]: "

read -r RUN_INSTALL

while true
do
	if [ "$RUN_INSTALL" == "Y" ]
	then
		dnf install -y ufw
		systemctl disable --now firewalld.service
		systemctl stop --now firewalld.service

		printf "Would you like to enable and start UFW now? [Y/n]: "
		read -r STARTSERVICE

		# Offer user the option to enable ufw at boot and start ufw now.
		while true
		do
			if [ "$STARTSERVICE" == "Y" ]
			then
				systemctl enable ufw
				systemctl start ufw
				printf "UFW set to start at boot and is currently running!"
				printf "Installation Complete, it is recommended you configure UFW."
				exit 0
			elif [ "$STARTSERVICE" == "n" ]
			then
				printf "UFW installed and not set to start at boot and isn't running"
				printf "Installation Complete, it is recommend you configure UFW."
				exit 0
			else
				printf "Enter a capital Y or a lowercase n: "
				read -r STARTSERVICE
			fi
		done
	elif [ "$RUN_INSTALL" == "n" ]
	then
		printf "Not installing UFW and exiting upon user request...\n\n"
		exit 0
	else
		printf "Enter a capital Y or a lowercase n to proceed: "
		read -r RUN_INSTALL
	fi
done
