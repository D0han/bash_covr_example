#!/bin/bash
#set -x


readonly SRC_FILE="functions1.sh"
readonly SUITE_NAME="test_${SRC_FILE} test suite"

#source bash test framework
. assert.sh

#source file to be tested
. ../${SRC_FILE}




#start tests for functions1.sh file
echo -e "\nstarting \"${SUITE_NAME}\""

assert "print_msg 'xxx'" \
"STARTED\nMSG=xxx\nDONE"

assert "print_msg ''" \
"empty string"

assert_raises "print_msg ''" \
1

assert_raises "print_msg 'abc'" \
0

skip assert_raises "print_msg '\n'" \
???

assert "file_stats 'input_test_data/functions1/file_stats/file01.txt'" \
"input_test_data/functions1/file_stats/file01.txt stats:\nlines: 3\nsize: 10 (bytes)"

assert "file_stats 'input_test_data/functions1/file_stats/file02.txt'" \
"input_test_data/functions1/file_stats/file02.txt stats:\nlines: 0\nsize: 0 (bytes)"

assert "file_stats 'input_test_data/functions1/file_stats/file03.txt'" \
"input_test_data/functions1/file_stats/file03.txt stats:\nlines: 1\nsize: 1 (bytes)"

assert "file_stats 'input_test_data/functions1/file_stats/file04.txt'" \
"input_test_data/functions1/file_stats/file04.txt stats:\nlines: 11\nsize: 45 (bytes)"

assert "log 'example debug msg' 'DEBUG'" \
"DEBUG: MSG=example debug msg"

assert "log 'example warning msg' 'WARNING'" \
"\x1b[01;93mWARNING:\x1b[0m MSG=example warning msg"

assert "log 'example error msg' 'ERROR' 2>stderr.log ; cat stderr.log" \
"\x1b[31mERROR:\x1b[0m MSG=example error msg"

assert "log 'testing unsupported debug param' 'CRITICAL'" \
"error! unsupported value for DEBUG param: DEBUG=\"CRITICAL\""

assert_raises "log 'testing unsupported debug param'" 1 ""

assert "log 'example debug msg' 'DEBUG' 'ADDITIONAL_PARAM'" \
"DEBUG: MSG=example debug msg"




#end test suite
echo -e "\ndone ${SUITE_NAME}"
assert_end \"${SUITE_NAME}\"

