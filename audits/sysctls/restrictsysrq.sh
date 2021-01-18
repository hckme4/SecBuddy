#!/bin/bash

printf "Linux contains a 'magic' system request key which the user can make the\n";
printf "kernel respond, provided the system isn't locked up. The problem with\n";
printf "the System Request key (SysRq) is that it allows for lots of dangerous\n";
printf "debugging abilities to users who do not have privileges. This issue may\n";
printf "be addressed by setting either setting it so the user may only use the\n";
printf "secure attention key (to securely access the root user) or alternatively\n";
printf "disabling the SysRq key entirely.\n\n";

printf "Press H to disable SysRq key, M to securely enable it, n to skip [H/M/n]: "
read -r SECLEVEL

# If user inputted H, we append kernel.sysrq=0 to /etc/sysctl.conf.
# If user inputted M, we append kernel.sysrq=4 to /etc/sysctl.conf.
# If user inputted n, we exit this script.

while true
do
	if [ "$SECLEVEL" == "H" ]
	then
		# Since user inputted "H" we append kernel.sysrq=0
		sed -i '/kernel.sysrq=*/d' /etc/sysctl.conf;
		echo "kernel.sysrq=0" >> /etc/sysctl.conf;
		exit 0;
	elif [ "$SECLEVEL" == "M" ]
	then
		# Since user inputted "M" we append kernel.sysrq=4
		sed -i '/kernel.sysrq=*/d' /etc/sysctl.conf;
		echo "kernel.sysrq=4" >> /etc/sysctl.conf;
		exit 0;
	elif [ "$SECLEVEL" == "n" ]
	then
		# Since user inputted "N" we ensure this option doesn't exist
		# in /etc/sysctl.conf and exit.
		sed -i '/kernel.sysrq=*/d' /etc/sysctl.conf;
		exit 0;
	else
		# Error Catching
		printf "Enter Y for yes, n for no: "
		read -r SECLEVEL;
	fi
done
