#!/bin/bash

# UFW Configuration Script. UFW Must be installed and running for this to be of use.

printf "UFW CONFIGURATION"
printf "To use this program, you must have UFW installed and running. Proceed? [Y/n]: "

read -r STARTCONFIG

while true
do
	if [ "$STARTCONFIG" == "Y" ]
	then
		printf "Press 1 for a default deny security policy."
		printf "Press 2 for a default accept security policy."
		printf "Choice: "

		read -r SECPOLICY

		# Sets default security policy
		while true
		do
			if [ "$SECPOLICY" == "1" ]
			then
				ufw default deny
				break
			elif [ "$SECPOLICY" == "2" ]
			then
				ufw default allow
				break
			else
				printf "Select 1 or 2: "
				read -r SECPOLICY
			fi
		done

		printf "The application is now going to begin reading your firewall rules."
		printf "If you don't have any or are done, press 'q'"
		printf "To do this, specify a port number and push enter. depending on your default security policy,"
		print "the app will automatically block or allow the port for you.\n\n"

		# Allow/deny ports
		while true
		do
			if [ "$SECPOLICY" == "1" ]
			then
				while true
				do
					printf "Port: "
					read -r PORTNUM

					if [ "$PORTNUM" == "q" ]
					then
						break
					fi

					ufw allow "$PORTNUM"
				done
			elif [ "$SECPOLICY" == "2" ]
			then
				while true
				do
					printf "Port: "
					read -r PORTNUM

					if [ "$PORTNUM" == "q" ]
					then
						break
					fi

					ufw deny "$PORTNUM"
				done
			elif [ "$PORTNUM" == "q" ]
			then
				printf "Finished configuring firewall! Re-run this app to make changes again.\n\n"
				exit 0
			else
				printf "Error in reading firewall rules!"
				exit 1
			fi
		done


	elif [ "$STARTCONFIG" == "n" ]
	then
		printf "Exiting upon user request...\n\n"
		exit 0
	else
		printf "Enter a capital Y or a lowercase n: "
		read -r STARTCONFIG
	fi
done
