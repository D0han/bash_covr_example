#!/bin/bash
#set -x


readonly ASSERT_SH_VER="v1.1"


echo "downloading 'assert.sh' framework (${ASSERT_SH_VER}), please wait..."
if ! [ -f assert.sh ] ; then
    wget --no-check-certificate https://raw.githubusercontent.com/lehmannro/assert.sh/${ASSERT_SH_VER}/assert.sh -O assert.sh
else
    echo "'assert.sh' already downloaded"
fi

echo "starting tests, please wait..."
time {
    for f in test_functions1.sh test_functions2.sh test_script1.sh ; do
        ./${f} --stop --verbose

        if [ $? -ne 0 ] ; then
            echo "error! tests failed: ${f}" >&2
            exit 1
        fi
    done
}

exit 0

