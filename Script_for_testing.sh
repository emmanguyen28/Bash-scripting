#!/bin/bash
TIMESTAMP=$(date +%d%M%Y.%H%M%S)
PASS_LOG=pass.log.${TIMESTAMP}
FAIL_LOG=fail.log.${TIMESTAMP}
UNKNOWN=unknown.log.${TIMESTAMP}

info()
{
local STATUS=$1
shift
case "$STATUS" in
0|PASS|pass|ok) 
echo "OK:${STATUS}:$@" | tee -a $PASS_LOG ;;
[0-9]*|FAIL|fail)
echo "FAIL:${STATUS}:$@" | tee -a $FAIL_LOG ;;
*)
echo "Unknown status:${STATUS}:$@" | tee -a $UNKNOWN ;;
esac
}

# Tests some simple processes
grep "rose" sonnets.txt | wc | awk '{ print $1 }'
info $? "Display search matches of "rose" in file sonnets.txt"

ls -al | cat > listing
info $? "List files"

grep 127 /etc/hosts > /dev/null 2>&1
info $? Searching for 127 in /etc/hosts file

echo
echo "RESULTS: "
[ -f ${PASS_LOG} ] && echo "Some tests succeeded: see \"$PASS_LOG\""
[ -f ${FAIL_LOG} ] && echo "Some tests failed: See \"$FAIL_LOG\""
[ -f ${UNKNOWN} ] && echo "Some tests produced unexpected results: See \"${UNKNOWN}\""
