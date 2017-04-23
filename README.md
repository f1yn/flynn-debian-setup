# flynn-debian-setup
My personal user-environment installer scripts for [Debian 9+ (Stretch)](https://wiki.debian.org/DebianStretch). Intended to be used after a fresh install. This is actively in development, and tweaks and changes will be posted on a regular basis. This bundle was uploaded for my own personal use, but you are free to use and change it as you wish for your own Debian 9+ systems.

``` diff
- DISCLAIMER: I am not personally responsible for any damages that occur though the usage,
- modification, or distribution of this script bundle. Use these files at your own risk.
```

## What do they do?

These scripts are intended to automate the following tasks:

### init.sh
* Batch downloads Debian packages that I want on my system.
* Downloads and runs a NVM installation script, which then installs the latest stable release of [Node.js](https://github.com/nodejs/node).
* Downloads and builds the most recent version of [i3-gaps](https://github.com/Airblader/i3).
* Downloads and installs all fonts available in the Google Fonts repository (adapted from [this project](https://github.com/hotice/webupd8/blob/master/install-google-fonts)).

### update.sh
* Replaces `~/.i3/config` with `config/i3`.
* Dynamically adds configuration to the `~/.Xresources` and `~/.bashrc` files from `config/xres` and `config/bash` respectively. 

### upgrade.sh
* Upgrades Debian from version 8 (jessie) to version 9 (stretch).

## How to use:

If you are running a **CLEAN** install of Debian 8, run the `update.sh` script before proceeding. It is recommended that you delete this file after using it, to reduce clutter.

1. Clone the repository to the home directory using `git clone https://github.com/flynnham/flynn-debian-setup.git`.
2. `cd` into the directory
3. Execute `./init.sh`
4. Reboot your computer.
5. Behold the magic (that is in development).

If you cannot create config files (due to whatever reason): reboot first then run `update.sh`.
