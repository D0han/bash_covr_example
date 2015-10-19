#!/bin/bash
#set -x


readonly OUT_DIR="results"
readonly CWD=$(pwd)

#in case kcov is manually added to current dir
PATH=${PATH}:${PWD}


echo "searching for 'kcov' tool in the system, please wait..."
readonly KCOV_BIN=$(which kcov 2>/dev/null)
if [ -z ${KCOV_BIN} ] ; then
    echo "error! 'kcov' tool not found!"
    exit 1
else
    echo "found 'kcov' tool -> KCOV_BIN=${KCOV_BIN}"
fi

echo "downloading 'assert.sh' framework (v1.1), please wait..."
if ! [ -f assert.sh ] ; then
    wget https://raw.githubusercontent.com/lehmannro/assert.sh/v1.1/assert.sh -O assert.sh
else
    echo "'assert.sh' already downloaded"
fi

echo "running UTs, please wait..."
time {
    rm -rf ${OUT_DIR}
    ${KCOV_BIN} --exclude-path=assert.sh,test_functions.sh ${OUT_DIR}/ test_functions.sh --stop --verbose

    #if no error then show coverage value
    if [ $? -eq 0 ] ; then
        COVERAGE=$(cat ${OUT_DIR}/index.json | grep -o "\"covered\":\"[0-9\.]*\"" | tr -d '"' | sed 's/:/: /g')
        echo "${COVERAGE}%"
    else
        exit 1
    fi
}

