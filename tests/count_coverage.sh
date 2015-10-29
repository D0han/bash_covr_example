#!/bin/bash
#set -x
set -e


readonly CWD=$(pwd)
readonly OUT_DIR="${CWD}/coverage_results"
readonly ASSERT_SH_VER="v1.1"

#in case kcov is manually added to kcov/ dir
PATH=${PATH}:${CWD}/kcov


echo "searching for 'kcov' tool in the system, please wait..."
readonly KCOV_BIN=$(which kcov 2>/dev/null)
if [ -z "${KCOV_BIN}" ] ; then
    echo "error! 'kcov' tool not found!"
    exit 1
else
    echo "found 'kcov' tool -> KCOV_BIN=${KCOV_BIN}"
fi

echo "downloading 'assert.sh' framework (${ASSERT_SH_VER}), please wait..."
if ! [ -f assert.sh ] ; then
    wget --no-check-certificate https://raw.githubusercontent.com/lehmannro/assert.sh/${ASSERT_SH_VER}/assert.sh -O assert.sh
else
    echo "'assert.sh' already downloaded"
fi

echo "counting code coverage, please wait..."
time {
    rm -rf ${OUT_DIR} && mkdir ${OUT_DIR}
    touch ${OUT_DIR}/coverage_results.csv
    for f in test_functions1.sh test_functions2.sh test_script1.sh ; do
        echo "running kcov for ${CWD}/${f} file, please wait..."
        ${KCOV_BIN} \
            --exclude-path=${CWD}/assert.sh,${CWD}/${f} \
            --exclude-pattern=${CWD}/mocks/ \
            ${OUT_DIR}/ \
            ${CWD}/${f} \
            --stop \
            --verbose

        #if no error then show coverage value
        if [ $? -eq 0 ] ; then
            cat ${OUT_DIR}/index.json
            COVR=$(grep -o "${f}.*\"covered\":\"[0-9\.]*\"" ${OUT_DIR}/index.json | sed 's/.*"covered":"\([0-9\.]*\)".*/\1/g')
            echo "covered: ${COVR}%"
            echo "${f},${COVR}%">>${OUT_DIR}/coverage_results.csv
        else
            exit 1
        fi
    done
    COVR_TOTAL=$(grep -o "merged_files.*\"covered\":\"[0-9\.]*\"" ${OUT_DIR}/index.json | sed 's/.*"covered":"\([0-9\.]*\)".*/\1/g')
    echo "total,${COVR_TOTAL}%">>${OUT_DIR}/coverage_results.csv
    echo
    echo "coverage results:"
    cat ${OUT_DIR}/coverage_results.csv
}

exit 0

