#!/bin/bash
mkdir /mnt/iso
mkdir /mnt/fs
cd /tmp
wget http://dl.42.fr/BornToSecHackMe-v1.1.iso
mount /tmp/BornToSecHackMe-v1.1.iso /mnt/iso
mount /mnt/iso/casper/filesystem.squashfs /mnt/fs/ -t squashfs -o loop
wget -q -O - https://archive.kali.org/archive-key.asc  | apt-key add #get valid key 
sudo apt-get update
sudo apt-get install libc6-i386 -y
sudo apt-get install gcc-7-multilib -y
cat /tmp/root-me/utils/peda/install_peda.sh
/tmp/root-me/utils/peda/install_peda.sh

