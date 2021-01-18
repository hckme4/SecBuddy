#!/bin/bash

printf "Linux contains a system facility called kexec(), a system call used to\n";
printf "execute kernel-level code during runtime. This syscall may be used to\n";
printf "load a different kernel during runtime, so it may also be used to load\n";
printf "malicious kernels to gain code execution at a kernel level.\n\n";

printf "Would you like to disable kexec()? [Y/n]: "
read -r SECLEVEL

# If user inputted Y, we append kernel.kexec_load_disabled=1 to /etc/sysctl.conf.
# If user inputted n, we exit this script.

while true
do
	if [ "$SECLEVEL" == "Y" ]
	then
		# Since user inputted "Y" we append kernel.kexec_load_disabled=1
		sed -i '/kernel.kexec_load_disabled*/d' /etc/sysctl.conf;
		echo "kernel.kexec_load_disabled=1" >> /etc/sysctl.conf;
		exit 0;
	elif [ "$SECLEVEL" == "n" ]
	then
		# Since user inputted "N" we ensure this option doesn't exist
		# in /etc/sysctl.conf and exit.
		sed -i '/kernel.kexec_load_disabled*/d' /etc/sysctl.conf;
		exit 0;
	else
		# Error Catching
		printf "Enter Y for yes, n for no: "
		read -r SECLEVEL;
	fi
done
