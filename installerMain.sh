#!/usr/bin/env bash
# -*- coding: utf-8 -*-

# Title:         Installer
# Description:   This BashScript install terminator(terminal) and the config file of treminator due the themes was made for terminator, this script only works with debian and deribates due this script use dpkg, maybe in a future it will works with pacman and dnf.
# Author:        Lexx (TitanHero)
# Date:          mié oct 23 20:18:37 CDT 2019
# Version:       0.0.1

#  ┌─────────────────────────────────────────────────┐
#  │ ___                        _                    │
#  │|   \ ___ _ __  ___ _ _  __| |___ _ _  __ ___ ___│
#  │| |) / -_) '_ \/ -_) ' \/ _` / -_) ' \/ _/ -_|_-<│
#  │|___/\___| .__/\___|_||_\__,_\___|_||_\__\___/__/│
#  │         |_|                                     │
#  └─────────────────────────────────────────────────┘




 echo """
 This script will install terminator and it gonna add the file with the themes(config archive)
 if already is installed terminator, a backup of your config file will be make in the folder .backupConfigThemes is a folder with dot so it is hide by default, if terminator isn't installed, it will be installed using apt

 """
 
 #Here we see if is installed terminator with the command hash
 hash terminator
 if [[ $? -ne 0 ]]; then
  echo "Terminator isn't installed will be installed\n"
  sudo apt-get update && sudo apt-get install terminator -y
 fi

 #Here we do a test if exist the folder where go the backup
test -a ~/.backupConfigThemes/config
if [[ $? -ne 0 ]]; then
  echo -e "Looks like is the first time that you use this script\nWill be make the folder \e[1;35m.backupConfigThemes\e[0m in the path \e[1;31m$HOME/.backupConfigThemes\e[0m \n"
  mkdir ~/.backupConfigThemes/
  if [[ ! -d ~/.config/terminator ]]; then
  	mkdir $HOME/.config/terminator
  elif [[ -a ~/.config/terminator/config ]]; then
  	cp $HOME/.config/terminator/config ~/.backupConfigThemes/
  fi
  
fi

declare -a options=(Restore_original_config configure_themes exit)

PS3="$(echo -e "\nSelect a option number, thanks for use GnuLinux and \e[1;36m Open Source\e[0m...Peace && Love\n>")"

main() {
select opt in ${options[*]}; do
	if [[ "$opt" = "${options[0]}" ]]; then
		printf "Ok Let's to restore the default config file\n"
		mv ~/.backupConfigThemes/config $HOME/.config/terminator/config
		echo "Ready, re open or only open terminator to get the changes"
		main
	elif [[ "$opt" = "${options[1]}" ]]; then
		cp $(dirname $(readlink -f $0))/config/ConfigShelltrific $HOME/.config/terminator/config
		echo "Ok Just open Terminator and remember use Ctrl+Super+t to change the theme(color scheme) of your shell"
                main
        elif [[ "$opt" = "${options[2]}" ]]; then
                echo "Ok good bye, animus, never give up, keep trying, Peace and Love"; sleep 2
                exit; return 0
        else
                main
	fi

done

}

main
