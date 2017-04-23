#!/bin/bash

# Environment installer script for Debian 9+ environments
# Flynn Buckingham - April 2017

clear
printf "### Flynn's i3/URxvt environment installer ###\n\n"
printf "This bash script will build, install and configure Flynn's default user environment. This script is intended to run on Debian Stretch (9) or higher. I (Flynn) take no responsibility for how your system responds to this script, nor am I responsible for any system issues as a result of running this script.\n\n"
read -p "Are you sure you wish to continue? (Yy/*) " -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
	sp="###"
	sudo echo "$sp AUTHORIZED $sp"

	printf "$sp Downloading environment packages and build environment."

	# fetch and update packages
	sudo apt-get -qq update
	printf " ."
	
	# install env/build dependancies
	bdepends=(
		build-essential
		libssl-dev
		realpath
		gtk-chtheme
		rxvt-unicode
		libxcb-keysyms1-dev
		libpango1.0-dev
		libxcb-util0-dev
		xcb
		libxcb1-dev
		libxcb-icccm4-dev
		libyajl-dev
		libev-dev
		libxcb-xkb-dev
		libxcb-cursor-dev
		libxkbcommon-dev
		libxcb-xinerama0-dev
		libxkbcommon-x11-dev
		libstartup-notification0-dev
		libxcb-randr0-dev
		libxcb-xrm0 
		libxcb-xrm-dev
		i3blocks
		curl
		xdotool
	)
	sudo apt-get -qq install ${bdepends[@]}
	printf " . Done!\n"

	# enter into installer directory
	selfDir=$(dirname "$(realpath "$-1")")
 	cd "$selfDir"
	
	
	
	
	#install nvm + nodejs
	printf "$sp Fetching and installing NVM. . ."
	curl https://raw.githubusercontent.com/creationix/nvm/v0.33.1/install.sh | bash &> nvm.log
	printf ' Done!\n'

	# configure to use on demand
	export NVM_DIR="$HOME/.nvm"
	[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" # This loads nvm
	
	
	echo "$sp Installing latest stable Node version. . ."
	nvm install stable $> node.log # install dat latest goodness
	
	
	
	# download and extract PhpStorm version 10
	cd ~ # go to home directory
	echo "$sp Fetching and installing PhpStorm 10. . ."
	curl -Lk "http://download.jetbrains.com/webide/PhpStorm-10.0.4.tar.gz" | tar -zx
	echo 'Done!'
	cd "$selfDir" # return to install directory
	
	# prepare i3 installation
	i3Dir="i3-master"

	# if check enabled and package is not installed
	if [ ! $(dpkg-query -l | grep -q i3) ]; then
		# if install directory exists then skip git download - this assumes
		# build directory is complete. ToDo: add way to verify git interity
		# without causing fatal exception
		if [ ! -d "$i3Dir" ]; then 
			curl -Lk "https://github.com/Airblader/i3/archive/master.tar.gz" | tar -zx
		fi
	
		# enter directory and begin building
		cd "$i3Dir"
	
		# official build pattern from - 
		# https://github.com/Airblader/i3/wiki/Compiling-&-Installing

		printf "$sp Building i3-gaps [make sure to select it as your default window manager after rebooting]."

		autoreconf --force --install &> i3build.log
		printf " ."
		rm -rf build/
		mkdir -p build && cd build/
		# Disabling sanitizers is important for release versions!
		# The prefix and sysconfdir are, obviously, dependent on the distribution		
		../configure --prefix=/usr --sysconfdir=/etc --disable-sanitizers &>> i3buildlog.log
		make &>> i3buildlog.log

		printf " . Done!\n"

		printf "$sp Installing i3-gaps into system. . ."
		sudo make install &> i3build.log #aww yeah!
		printf " Done!\n"

	else
		# i3 is installed and should be ignored - continue config
		echo "ERROR: i3 is already installed. If not i3-gaps: please uninstall i3 if not correct version"

	fi

	#reenter working directory
	cd "$selfDir"
	
	# ToDo: Add GTK theme autoinstall here
	
	# implements - https://github.com/hotice/webupd8/blob/master/install-google-fonts
	# install google fonts if not present

	if [ -d ~/.fonts/fonts-master/ofl/sourcecodepro ]; then
		# skip installation
		echo "$sp Google Fonts already installed - skipping installation"
	else
		# install google fonts
	
		_gf="google-fonts"
		
		echo "$sp Installing Google Fonts..."
		# download and extract the fonts
		curl -Lk "https://github.com/google/fonts/archive/master.tar.gz" | tar -zx

		# setup TrueType font directory
		sudo mkdir -p /usr/share/fonts/truetype/$_gf

		# installs TrueType fonts into /usr/share/fonts/truetype/$_gf"
		find fonts-master/ -name "*.ttf" -exec sudo install -m644 {} /usr/share/fonts/truetype/google-fonts/ \; &> font.log|| return 1

		echo "Updating the font cache"
		fc-cache -f > /dev/null

		# get rid of the fonts folder
		rm fonts-master/

		echo "Done."
	fi

	cd "$selfDir"

	# do the final ui updating - prompt to reboot
	./update.sh

	echo "$sp Installation is complete. It is recommended you reboot for all settings to take effect."
fi	

