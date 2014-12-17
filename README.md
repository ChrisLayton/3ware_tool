3ware_tool
==========

A simple tool to save keystrokes when dealing with 3ware raid controllers. Tested on 9650SE might not have full functionality on other models.

Sadly at the time of testing I was in JBOD mode for software raid tests so the examples are pretty boring. 


General
==========
I wrote this script to mainly check and turn on the writecache on my 3ware controller. I expanded it recently to save cycles typing commands and for easy intergration into other scripts.

USE AT YOUR OWN RISK! 
YOU HAVE BEEN WARNED !


Files
==========

3ware_tool.sh



Example Output
==========
```
# STDOUT for echo and /var/log/messages for logger (or where ever you have syslog setup to log to)

# general status and verbose status
./3ware_tool.sh -c

Unit  UnitType  Status         %RCmpl  %V/I/M  Stripe  Size(GB)  Cache  AVrfy
------------------------------------------------------------------------------
u0    JBOD      OK             -       -       -       698.638   RiW    OFF    
u1    JBOD      OK             -       -       -       232.886   RiW    OFF    
u2    JBOD      OK             -       -       -       2794.52   RiW    OFF    
u3    JBOD      OK             -       -       -       2794.52   RiW    OFF    
u4    JBOD      OK             -       -       -       1863.02   RiW    OFF    
u5    JBOD      OK             -       -       -       1863.02   RiW    OFF    

./3ware_tool.sh -v -c
/c2 Driver Version = 2.26.02.014RH
/c2 Model = 9650SE-8LPML
/c2 Available Memory = 224MB
/c2 Firmware Version = FE9X 4.10.00.027
/c2 Bios Version = BE9X 4.08.00.004
/c2 Boot Loader Version = BL9X 3.08.00.001
/c2 Serial Number = L326025A8300609
/c2 PCB Version = Rev 032
/c2 PCHIP Version = 2.00
/c2 ACHIP Version = 1.90
/c2 Number of Ports = 8
/c2 Number of Drives = 6
/c2 Number of Units = 6
/c2 Total Optimal Units = 6
/c2 Not Optimal Units = 0 
/c2 JBOD Export Policy = on
/c2 Disk Spinup Policy = Disabled
/c2 Spinup Stagger Time Policy (sec) = N/A
/c2 Auto-Carving Policy = off
/c2 Auto-Carving Size = 2048 GB
/c2 Auto-Rebuild Policy = off
/c2 Rebuild Mode = Adaptive
/c2 Rebuild Rate = 1
/c2 Verify Mode = Adaptive
/c2 Verify Rate = 1
/c2 Controller Bus Type = PCIe
/c2 Controller Bus Width = 4 lanes
/c2 Controller Bus Speed = 2.5 Gbps/lane

Unit  UnitType  Status         %RCmpl  %V/I/M  Stripe  Size(GB)  Cache  AVrfy
------------------------------------------------------------------------------
u0    JBOD      OK             -       -       -       698.638   RiW    OFF    
u1    JBOD      OK             -       -       -       232.886   RiW    OFF    
u2    JBOD      OK             -       -       -       2794.52   RiW    OFF    
u3    JBOD      OK             -       -       -       2794.52   RiW    OFF    
u4    JBOD      OK             -       -       -       1863.02   RiW    OFF    
u5    JBOD      OK             -       -       -       1863.02   RiW    OFF    

VPort Status         Unit Size      Type  Phy Encl-Slot    Model
------------------------------------------------------------------------------
p0    OK             u0   698.63 GB SATA  0   -            ST3750640NS         
p1    OK             u1   232.88 GB SATA  1   -            ST3250820NS         
p2    OK             u2   2.73 TB   SATA  2   -            ST3000DM001-1CH166  
p3    OK             u3   2.73 TB   SATA  3   -            ST3000DM001-9YN166  
p4    OK             u4   1.82 TB   SATA  4   -            ST32000542AS        
p5    OK             u5   1.82 TB   SATA  5   -            ST2000DM001-1CH164  

Name  OnlineState  BBUReady  Status    Volt     Temp     Hours  LastCapTest
---------------------------------------------------------------------------
bbu   On           Yes       OK        OK       OK       255    06-Jul-2013 


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

# Verbose output differences
./3ware_tool.sh -s
/c2/u0 status = OK

/c2/u1 status = OK

/c2/u2 status = OK

/c2/u3 status = OK

/c2/u4 status = OK

/c2/u5 status = OK


./3ware_tool.sh -v -s

Unit     UnitType  Status         %RCmpl  %V/I/M  Port  Stripe  Size(GB)
------------------------------------------------------------------------
u0       JBOD      OK             -       -       p0    -       698.638   


Unit     UnitType  Status         %RCmpl  %V/I/M  Port  Stripe  Size(GB)
------------------------------------------------------------------------
u1       JBOD      OK             -       -       p1    -       232.886   


Unit     UnitType  Status         %RCmpl  %V/I/M  Port  Stripe  Size(GB)
------------------------------------------------------------------------
u2       JBOD      OK             -       -       p2    -       2794.52   


Unit     UnitType  Status         %RCmpl  %V/I/M  Port  Stripe  Size(GB)
------------------------------------------------------------------------
u3       JBOD      OK             -       -       p3    -       2794.52   


Unit     UnitType  Status         %RCmpl  %V/I/M  Port  Stripe  Size(GB)
------------------------------------------------------------------------
u4       JBOD      OK             -       -       p4    -       1863.02   


Unit     UnitType  Status         %RCmpl  %V/I/M  Port  Stripe  Size(GB)
------------------------------------------------------------------------
u5       JBOD      OK             -       -       p5    -       1863.02   


# Setting and showing dpmstat output

./3ware_tool.sh -Don
Setting Drive Performance Monitoring on /c2 to [on] ... Done.

./3ware_tool.sh -Pra
Drive Performance Monitor Configuration for /c2 ...
Performance Monitor: ON
Version: 1
Max commands for averaging: 100
Max latency commands to save: 10
Requested data: Running Average Drive Statistics

                               Queue           Xfer         Resp
Port   Status           Unit   Depth   IOPs    Rate(MB/s)   Time(ms)
------------------------------------------------------------------------
p0     OK               u0     3       221     12.142       2         
p1     OK               u1     1       40      1.055        7         
p2     OK               u2     1       2022    82.910       0         
p3     OK               u3     1       1109    69.019       0         
p4     OK               u4     0       26      1.273        3         
p5     OK               u5     0       12      0.676        6         
p6     NOT-PRESENT      -      -       -       -            -         
p7     NOT-PRESENT      -      -       -       -            -  

```


Contact
================


Chris Layton <linux@misterx.org>

