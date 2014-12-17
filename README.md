3ware_tool
==========

A simple tool to save keystrokes when dealing with 3ware raid controllers.


General
==========
I wrote this script to mainly check and turn on the writecache on my 3ware controller. I expanded it recently to save cycles typing commands and for easy intergration into other scripts.

USE AT YOUR OWN RISK!  


Files
==========

3ware_tool.sh



Example Output
==========
```
# STDOUT for echo and /var/log/messages for logger (or where ever you have syslog setup to log to)
./3ware_tool.sh -c

Unit  UnitType  Status         %RCmpl  %V/I/M  Stripe  Size(GB)  Cache  AVrfy
------------------------------------------------------------------------------
u0    JBOD      OK             -       -       -       698.638   RiW    OFF    
u1    JBOD      OK             -       -       -       232.886   RiW    OFF    
u2    JBOD      OK             -       -       -       2794.52   RiW    OFF    
u3    JBOD      OK             -       -       -       2794.52   RiW    OFF    
u4    JBOD      OK             -       -       -       1863.02   RiW    OFF    
u5    JBOD      OK             -       -       -       1863.02   RiW    OFF    


./3ware_tool.sh -s
/c2/u0 status = OK
/c2/u1 status = OK
/c2/u2 status = OK
/c2/u3 status = OK
/c2/u4 status = OK
/c2/u5 status = OK

#Cache was already set to ON
./3ware_tool.sh -W 
WriteCache is on for /c2/u0
WriteCache is on for /c2/u1
WriteCache is on for /c2/u2
WriteCache is on for /c2/u3
WriteCache is on for /c2/u4
WriteCache is on for /c2/u5

./3ware_tool.sh -w
WriteCache is on for /c2/u0 turning off
Setting Write Cache Policy on /c2/u0 to [off] ... Done.

WriteCache is on for /c2/u1 turning off
Setting Write Cache Policy on /c2/u1 to [off] ... Done.

WriteCache is on for /c2/u2 turning off
Setting Write Cache Policy on /c2/u2 to [off] ... Done.

WriteCache is on for /c2/u3 turning off
Setting Write Cache Policy on /c2/u3 to [off] ... Done.

WriteCache is on for /c2/u4 turning off
Setting Write Cache Policy on /c2/u4 to [off] ... Done.

WriteCache is on for /c2/u5 turning off
Setting Write Cache Policy on /c2/u5 to [off] ... Done.


./3ware_tool.sh -W
WriteCache is off for /c2/u0 ..turning on
Setting Write Cache Policy on /c2/u0 to [on] ... Done.

WriteCache is off for /c2/u1 ..turning on
Setting Write Cache Policy on /c2/u1 to [on] ... Done.

WriteCache is off for /c2/u2 ..turning on
Setting Write Cache Policy on /c2/u2 to [on] ... Done.

WriteCache is off for /c2/u3 ..turning on
Setting Write Cache Policy on /c2/u3 to [on] ... Done.

WriteCache is off for /c2/u4 ..turning on
Setting Write Cache Policy on /c2/u4 to [on] ... Done.

WriteCache is off for /c2/u5 ..turning on
Setting Write Cache Policy on /c2/u5 to [on] ... Done.

./3ware_tool.sh -d
 Time Stamp:        21:13:44 15-Nov-2014
 Host Name:         <REMOVED>
 Host Architecture: x86_64 (64 bit)
 OS Version:        Linux 2.6.32-504.el6.x86_64
 Model:             9650SE-8LPML
 Serial #:          L326025A8300609
 Controller ID:     2
 CLI Version:       2.00.11.022
 API Version:       2.08.00.027
 Driver Version:    2.26.02.014RH
 Firmware Version:  FE9X 4.10.00.027
 BIOS Version:      BE9X 4.08.00.004
 Available Memory:  224MB


```


Contact
================


Chris Layton <linux@misterx.org>

