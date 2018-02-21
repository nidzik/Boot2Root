#!/bin/bash
mkdir /mnt/iso
mkdir /mnt/fs
wget http://dl.42.fr/BornToSecHackMe-v1.1.iso /tmp
mount /tmp/BornToSecHackMe-v1.1.iso /mnt/iso
mount /mnt/iso/casper/filesystem.squashfs /tmp/fs/ -t squash -o loop
wget -q -O - https://archive.kali.org/archive-key.asc  | apt-key add #get valid key 
sudo apt-get install libc6-i386
sudo apt-get install gcc-7-multilib
cat /tmp/root-me/utils/install_peda.sh
/tmp/root-me/utils/install_peda.sh

