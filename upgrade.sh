#!/bin/bash

# Debian Upgrader Automator (Jessie to Stretch) 
# Flynn Buckingham - April 2017

sp="###"

echo "DEBIAN UPGRADER SCRIPT"
echo "FLYNN BUCKINGHAM - APRIL 2017"

# ToDo: Add debian version detection

echo "THIS SCRIPT WILL UPDATE YOU FROM DEBIAN v8 (jessie) to v9 (stretch). I AM NOT RESPONSIBLE FOR ANY DAMAGES (EITHER DIGITAL, PHYSICAL, OR EMOTIONAL) THAT OCCOR FROM THE USAGE OF THIS SCRIPT"

read -p "$sp Are you sure you wish to continue? (Y/*)" -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Y]$ ]]
then
	# get the system completely up2date before upgrade
	sudo apt update
	sudo apt upgrade
	sudo apt full-upgrade
	
	# sed the changes in the package manager sources and update
	sudo sed -i 's/jessie/stretch/g' /etc/apt/sources.list
	sudo apt update
	
	sudo apt upgrade
	sudo apt full-upgrade
	
	sudo shutdown -r
fi
