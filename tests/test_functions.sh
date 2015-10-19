readonly SRC_FILE="functions.sh"
readonly SIUTE_NAME="${SRC_FILE} test siute"

#source bash test framework
. assert.sh

#source file to be tested
. ../${SRC_FILE}




#start tests for functions.sh file
echo -e "\nstarting \"${SIUTE_NAME}\""

assert "print_msg 'xxx'" \
"STARTED
MSG=xxx
DONE"

assert "print_msg ''" \
"empty string"

assert "file_stats 'test_data/file_stats/file01.txt'" \
"test_data/file_stats/file01.txt stats:
lines: 3
size: 10 (bytes)"

assert "file_stats 'test_data/file_stats/file02.txt'" \
"test_data/file_stats/file02.txt stats:
lines: 0
size: 0 (bytes)"

assert "file_stats 'test_data/file_stats/file03.txt'" \
"test_data/file_stats/file03.txt stats:
lines: 1
size: 1 (bytes)"

assert "file_stats 'test_data/file_stats/file04.txt'" \
"test_data/file_stats/file04.txt stats:
lines: 11
size: 45 (bytes)"

assert "file_stats 'xxx' 2>&1" \
"wc: xxx: No such file or directory
wc: xxx: No such file or directory
xxx stats:
lines: 
size:  (bytes)"

assert "log 'example debug msg' 'DEBUG'" \
"DEBUG: MSG=example debug msg"

assert "log 'example warning msg' 'WARNING'" \
"\x1b[01;93mWARNING:\x1b[0m MSG=example warning msg"

assert "log 'example error msg' 'ERROR'" \
"\x1b[31mERROR:\x1b[0m MSG=example error msg"

assert "log 'testing unsupported debug param' 'CRITICAL'" \
"error! unsupported value for DEBUG param: DEBUG=\"CRITICAL\""

assert_raises "log 'testing unsupported debug param'" 1 ""

assert "log 'example debug msg' 'DEBUG' 'ADDITIONAL_PARAM'" \
"DEBUG: MSG=example debug msg"




#end test suite
echo -e "\ndone ${SIUTE_NAME}"
assert_end \"${SIUTE_NAME}\"

