#!/bin/sh

# Author : Chris Layton <linux@misterx.org> 
# Purpose : To make interaction with 3ware raid cards easier and to also allow easy scripting of write cache functions. 
# Usage : See USAGE Below
# Requires :  tw_cli (Make sure to get the right one for your card and card's code base! THIS IS IMPORTANT..SERIOUSLY, IT REALLY IS! )
# Disclaimer : This is a armed and dangerous program...use at your own risk!
# License : GPL V2

# Exit Codes 
# 0 - All is well..in theory 
# 1 - Something went wrong...really it did...
# 2 - No arguments given on CLI! 
# 3 - Error turning on writecache
# 4 - Error turning off writecache
# 5 - tw_cli is not installed!
# 6 - tw_cli show diag FAILED. Your controller might have a issue or might not work with this feature. 
# 7 - tw_cli dpmstat command FAILED.
# 8 - dpmstat was not set correct (on|off) and usage was displayed.
# 9 - dpmstat error on setting (on|off)

TWCLI=/usr/sbin/tw_cli
LOGGER=$(which logger)
SYSLOG="$LOGGER -t LSI"
#SYSLOG="echo -e"
CONTROLLER=$($TWCLI show | awk '/c./ {print $1}')
VERBOSE="0"
USAGE=" 
  Usage (-v must always be first if used) : \n 
 -v verbose \n  
 -W Turn on Writecache if off \n 
 -w turn off Writecache if on \n 
 -s drive status \n 
 -c controller status  \n 
 -d detailed controller information  \n
 -D (on|off) set state of dpmstat \n
 -p Show phy (link speed, Device type, SAS information, and others) \n
 -P (inst│ra│ext) dpmstat Performance Monitor (inst = Instantaneous| ra = Running Average | ext = Extended Drive Statistics)  \n
 -h This usage \n 
"

# Functions 

turn_on_writecache () {
for i in $($TWCLI /$CONTROLLER show unitstatus | egrep -o 'u[0-9]'); do
    case $($TWCLI /$CONTROLLER/$i show wrcache | cut -d= -f2 | sed 's/^[ \t]*//;/^$/d') in
	on)
	$SYSLOG "WriteCache is on for /$CONTROLLER/$i"
	;;
	off)
	$SYSLOG "WriteCache is off for /$CONTROLLER/$i ..turning on"
	$TWCLI /$CONTROLLER/$i set wrcache=on quiet
	;;
	*)
	$SYSLOG "ERROR: 3ware_tool ran into a unexpected error turning on writecache" && exit 3
	;;
    esac
done
}


turn_off_writecache () {
for i in $($TWCLI /$CONTROLLER show unitstatus | egrep -o 'u[0-9]'); do
    case $($TWCLI /$CONTROLLER/$i show wrcache | cut -d= -f2 | sed 's/^[ \t]*//;/^$/d') in
        on)
        $SYSLOG "WriteCache is on for /$CONTROLLER/$i turning off"
	$TWCLI /$CONTROLLER/$i set wrcache=off quiet
        ;;
        off)
        $SYSLOG "WriteCache is already off for /$CONTROLLER/$i"
        ;;
        *)
        $SYSLOG "ERROR : 3ware_tool ran into a unexpected error turning off writecache" && exit 4
        ;;
    esac
done
}

show_drive_status () {

for i in $($TWCLI /$CONTROLLER show unitstatus | egrep -o 'u[0-9]'); do
    if [[ $VERBOSE -eq 1 ]] ; then
        $TWCLI /$CONTROLLER/$i show
    else
        $TWCLI /$CONTROLLER/$i show status
    fi
done

}

show_controller_status () {

if [[ $VERBOSE -eq 1 ]] ; then 
	$TWCLI /$CONTROLLER show all
else
	$TWCLI /$CONTROLLER show unitstatus	
fi

}

show_phy () {

    $TWCLI /$CONTROLLER show phy

}

show_perf () {

$TWCLI /$CONTROLLER show dpmstat type=$OPTARG

if [[ $? -ne 0 ]] ; then
        echo "ERROR : $TWCLI /$CONTROLLER show dpmstat type=$OPTARG failed!"  && exit 7
fi

}

show_detailed_status () {

if [[ $VERBOSE -eq 1 ]] ; then
    $TWCLI show diag
else
    $TWCLI show diag | awk '/###/ {sub("###",""); print $0}'
fi

if [[ $? -ne 0 ]] ; then
	$SYSLOG "ERROR : $TWCLI show diag FAILED. Might be a controller issue!"  && exit 6 
fi

}

set_dpmstat () {

if [[ $OPTARG =~ (on|off) ]] ; then 
    $TWCLI /$CONTROLLER set dpmstat=$OPTARG 
else
    echo -e $USAGE && exit 8 
fi 

if [[ $? -ne 0 ]] ; then
        $SYSLOG "ERROR : Setting DPMSTAT Failed make sure you used (on|off) correctly !"  && exit 9
fi

}

# Make sure TWI_CLI is installed

if ! [[ $(which tw_cli) ]] ; then
	$SYSLOG "ERROR : tw_cli is not installed ! Program exiting!" && exit 5
fi


# Process the arguments

[[ ! $1 ]] && echo -e $USAGE && exit 0

while getopts vWwscD:dphP: arg; do
    case $arg in
        v)
            VERBOSE="1"
            ;;
	W) 
	    turn_on_writecache
	    ;;
	w)
	    turn_off_writecache
	    ;;
	s)
	    show_drive_status
	    ;;
	c)
	    show_controller_status
            ;;
	D)
	    set_dpmstat
	    ;;
        d)
            show_detailed_status
           ;;
	p) 
	    show_phy
	   ;;
	P)
	    show_perf
	   ;;
        h)
            echo -e $USAGE
            exit 0
	    ;;
        *)
            echo -e $USAGE
            exit 2
            ;;
	esac
done


