#!/bin/bash
#set -x


readonly SRC_FILE="script1.sh"
readonly SUITE_NAME="test_${SRC_FILE} test suite"

#source bash test framework
. assert.sh




#start tests for script1.sh file
echo -e "\nstarting \"${SUITE_NAME}\""

rm -f /tmp/foobar
touch /tmp/foobar
assert "../script1.sh" \
"found /tmp/foobar file\ndone"

rm -f /tmp/foobar
assert "../script1.sh" \
"warning! couldn't find /tmp/foobar file\nwill be created manually...\n/tmp/foobar\ndone"




#end test suite
echo -e "\ndone ${SUITE_NAME}"
assert_end \"${SUITE_NAME}\"

