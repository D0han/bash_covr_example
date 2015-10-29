#!/bin/bash
#set -x


readonly SRC_FILE="functions2.sh"
readonly SIUTE_NAME="test_${SRC_FILE} test siute"

#source bash test framework
. assert.sh

#source file to be tested
. ../${SRC_FILE}

#PATH update
PATH=mocks/:$PATH




#start tests for functions2.sh file
echo -e "\nstarting \"${SIUTE_NAME}\""

assert "svn_parse_revision 'https://github.com/brand0m/bash_covr_example'" \
"6"

assert "svn_parse_revision ''" \
"error! an empty url: URL=\"\""




#end test suite
echo -e "\ndone ${SIUTE_NAME}"
assert_end \"${SIUTE_NAME}\"

