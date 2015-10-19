readonly SRC_FILE="script1.sh"
readonly SIUTE_NAME="${SRC_FILE} test siute"

#source bash test framework
. assert.sh

#source file to be tested
#. ../${SRC_FILE}




#start tests for script1.sh file
echo -e "\nstarting \"${SIUTE_NAME}\""

>/tmp/foobar
assert "bash ../script1.sh" \
"found /tmp/foobar file
done"

rm -f /tmp/foobar
assert "bash ../script1.sh" \
"warning! couldn't find /tmp/foobar file
will be created manually...
/tmp/foobar
done"




#end test suite
echo -e "\ndone ${SIUTE_NAME}"
assert_end \"${SIUTE_NAME}\"

