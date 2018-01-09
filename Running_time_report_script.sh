#!/bin/bash
#This is a script to calculate how long a script takes to run 

# Note starting time (in seconds in January 1st 1970)
STARTTIME=`date +%s`
echo "`date`: Starting the script..."

# a function to convert the number of seconds into hours, minutes, seconds format
hms()
{
local SECONDS H M S MM
SECONDS=${1:-0}
let S=${SECONDS}%60
let MM=${SECONDS}/60
let M=${MM}%60
let H=${MM}/60

if [ "$2" = "long" ]; then
# Display " hour, minutes, and seconds " format
[ "$H" -gt "0" ] && printf "%d %s" $H "hours, "
[ "$SECONDS" -ge "60" ] && printf "%d %s" $M "minutes and" printf "%d %s" $S " seconds"
else 
# Display hhmmss format
[ "$H" -gt "0" ] && printf "%02d%s" $H "h"
[ "$M" -gt "60" ] && printf "%02d%s" $M "m"
printf "%02d%s\n" $S "s"
fi
}

# Main script - choose anything that takes a non-predictable amount of time
# Sleep for 123 seconds unless some other values are passed to script

sleep ${1:-30}

# Note ending time
echo "`date`: The script has finished."
ENDTIME=`date +%s`

#Calculation duration of script running
let TIME=${ENDTIME}-${STARTTIME}

HOWLONG=`hms $TIME`
echo "That took $HOWLONG to run (short format)"

HOWLONG=`hms $TIME long`
echo "That took $HOWLONG to run (long format)"


