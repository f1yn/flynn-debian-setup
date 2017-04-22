#!/bin/bash

# Environment updater script for Debian 9+ environments
# Flynn Buckingham - April 2017

clear

read -p "$sp (Over)write i3 config? (Yy/*) " -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
	cp i3config ~/.i3/config
fi

read -p "$sp Reconfigure Xresources? (Yy/*)" -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
	# backup incase stuff goes terribly wrong
	cp ~/.Xresources ~/Xresources.old

	# remove current configuration if present
	sed '/! @START-FLYNNCONFIG@/,/! @END-FLYNNCONFIG@/d' ~/.Xresources > tmp; mv tmp ~/.Xresources
	# append config to end of Xres
	cat Xresources >> ~/.Xresources
fi

read -p " $sp Reconfigure bashrc? (Yy/*)" -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
	# backup incase stuff goes terribly wrong
	cp ~/.bashrc ~/bashrc.old

	# remove current configuration if present
	sed '/#@START-FLYNNCONFIG@/,/#@END-FLYNNCONFIG@/d' ~/.bashrc > tmp; mv tmp ~/.bashrc
	# append config to end of bashrc
	cat bashext >> ~/.bashrc
fi
	

