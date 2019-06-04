# Boot2Root

## Be root on Mysql database (method 1)

- Find IPv4 of guest VM
VBoxManage guestproperty get <VM-name> "/VirtualBox/GuestInfo/Net/0/V4/IP"

- Found open doors
ssh, http, https, https://<vm-ip>/forum, https://<vm-ip>/phpmyadmin, ftp

- search https to find a website :
```
root@kali:~# nikto -p  443 -h 10.0.2.14
- Nikto v2.1.6
---------------------------------------------------------------------------
+ Target IP:          10.0.2.14
+ Target Hostname:    10.0.2.14
+ Target Port:        443
---------------------------------------------------------------------------
+ SSL Info:        Subject:  /CN=BornToSec
                   Ciphers:  ECDHE-RSA-AES256-GCM-SHA384
                   Issuer:   /CN=BornToSec
+ Start Time:         2018-10-22 10:40:45 (GMT-4)
---------------------------------------------------------------------------
+ Server: Apache/2.2.22 (Ubuntu)
[...]
+ OSVDB-3092: /forum/: This might be interesting...
+ OSVDB-3093: /webmail/src/read_body.php: SquirrelMail found
+ OSVDB-3233: /icons/README: Apache default file found.
+ /phpmyadmin/: phpMyAdmin directory found
[...]
+ 8496 requests: 0 error(s) and 23 item(s) reported on remote host
+ End Time:           2018-10-22 10:42:26 (GMT-4) (101 seconds)
---------------------------------------------------------------------------
+ 1 host(s) tested

```

there is a few things interesting here :
	  - the forum (/forum)
	  - a squirel mail server (/webmail)
	  - phpmydamin (/phpmydamin)


- reading the forum lead us to a password in a log file : 
```
[...]
Oct 5 08:45:26 BornToSecHackMe sshd[7547]: Invalid user adam from 11.202.39.38
Oct 5 08:45:26 BornToSecHackMe sshd[7547]: input_userauth_request: invalid user adam [preauth]
Oct 5 08:45:27 BornToSecHackMe sshd[7547]: pam_unix(sshd:auth): check pass; user unknown
Oct 5 08:45:27 BornToSecHackMe sshd[7547]: pam_unix(sshd:auth): authentication failure; logname= uid=0 euid=0 tty=ssh ruser= rhost=161.202.39.38-static.reverse.softlayer.com
Oct 5 08:45:29 BornToSecHackMe sshd[7547]: Failed password for invalid user !q\]Ej?*5K5cy*AJ from 161.202.39.38 port 57764 ssh2
Oct 5 08:45:29 BornToSecHackMe sshd[7547]: Received disconnect from 161.202.39.38: 3: com.jcraft.jsch.JSchException: Auth fail [preauth]
Oct 5 08:46:01 BornToSecHackMe CRON[7549]: pam_unix(cron:session): session opened for user lmezard by (uid=1040)
Oct 5 09:21:01 BornToSecHackMe CRON[9111]: pam_unix(cron:session): session closed for user lmezard
[...]
```
```
lmezard
!q\]Ej?*5K5cy*AJ
```
- Found on the profil of lmezard, her email : laurie@borntosec.net

The email and the password match for an squirel mail account !

- Go to /webmail and use forum credential from lmezard to access mailbox
- Found mail with root access of database
#### user : root
#### password : Fg-'kKXBj87E:aJ$

- Go to https://<vm-ip>/phpmyadmin and connect to database manager

## WE ARE ROOT DB!!