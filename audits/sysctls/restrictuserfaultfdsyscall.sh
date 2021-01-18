#!/bin/bash

printf "In linux, there is a system call called userfaultfd(), commonly used\n";
printf "for memory handling. However, it can be exploited and abused through\n";
printf "use-after-free vulnerabilities, where memory is corrupted and allows\n";
printf "for the execution of arbitrary code. The userfaultfd() syscall can \n";
printf "be restricted to only the CAP_SYS_PTRACE capability, thus mitigating\n"
printf "many of these types of issues.\n\n";

printf "Would you like to harden userfaultfd()? [Y/n]: "
read -r SECLEVEL

# If user inputted Y, we append vm.unprivileged_userfaultfd=0 to /etc/sysctl.conf.
# If user inputted n, we exit this script.

while true
do
	if [ "$SECLEVEL" == "Y" ]
	then
		# Since user inputted "Y" we append vm.unprivileged_userfaultfd=0
		sed -i '/vm.unprivileged_userfaultfd*/d' /etc/sysctl.conf;
		echo "vm.unprivileged_userfaultfd=0" >> /etc/sysctl.conf;
		exit 0;
	elif [ "$SECLEVEL" == "n" ]
	then
		# Since user inputted "N" we ensure this option doesn't exist
		# in /etc/sysctl.conf and exit.
		sed -i '/vm.unprivileged_userfaultfd*/d' /etc/sysctl.conf;
		exit 0;
	else
		# Error Catching
		printf "Enter Y for yes, n for no: "
		read -r SECLEVEL;
	fi
done
