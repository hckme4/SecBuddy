#!/bin/bash

# User Management Script. Speeds up viewing of common files associated with users and
# Allows for user creation and deletion.

# Print User info before getting to main menu
printf "USER MANAGEMENT"
printf "Below is a list of all users on the system. Note that some users belong to system services:"
printf "------------------------------------------------\n"
cat /etc/passwd
printf "\n\n"

#display main menu
while true
do
	printf "Press 1 to Add a New User"
	printf "Press 2 to Delete a User"
	printf "Press 3 to Change a User's Password"
	printf "Press 4 to Set Password Expiry on a User"
	printf "Press 5 to Modify User Groups"
	printf "Press 0 to view all available content about Users and Groups on this system"
	printf "Press q to quit"
	printf "Selection: "

	read -r MENU

	# Quit if user inputs 'q'
	if [ "$MENU" == "q" ]
	then
		exit 0
	fi

	while true
	do
		# if user inputs '1' do an interactive useradd prompt
		if [ "$MENU" == "1" ]
		then
			printf "Enter username you want to add: "
			read -r USERNAME
			useradd "$USERNAME"
			break
		#interactive userdel
		elif [ "$MENU" == "2" ]
		then
			printf "Enter username you want to delete: "
			read -r USERNAME
			userdel "$USERNAME"
			break
		#interactive passwd
		elif [ "$MENU" == "3" ]
		then
			printf "Enter user you wish to change password for: "
			read -r USERNAME
			passwd "$USERNAME"
			break
		#interactive chage
		elif [ "$MENU" == "4" ]
		then
			printf "Enter user you wish to set expiry for: "
			read -r USERNAME
			printf "Enter max amount of days before password expiry: "
			read -r DAYS

			chage -M "$DAYS" "$USERNAME"
			break
		#interactive usermod
		elif [ "$MENU" == "5" ]
		then
			printf "Enter user you wish to modify groups for: "
			read -r USERNAME
			printf "The prompt will now ask for groups 1 by 1. Press lowercase q when done: "

			while true
			do
				printf "Enter name of group: "
				read -r GROUP

				if [ "$GROUP" == "q" ]
				then
					break
				fi

				usermod -aG "$GROUP" "$USERNAME"
			done
			break
		#Print out related files
		elif [ "$MENU" == "0" ]
		then
			printf "/etc/passwd:\n---------------------------\n"
			cat /etc/passwd
			printf "\n/etc/group:\n---------------------------\n"
			cat /etc/group
			printf "\n/etc/sudoers:\n--------------------------\n"
			cat /etc/sudoers
			printf "\n/etc/shadow:\n---------------------------\n"
			cat /etc/shadow
			printf "\n-------------------------------------------\n"
			break
		else
			printf "Available selections are 1, 2, 3, 4, 5 or 0: "
			read -r MENU
		fi
	done
done
