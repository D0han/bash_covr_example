function print_msg() {
    local readonly MSG=${1}

    if [ "${MSG}" = "" ] ; then
        echo "empty string"
        return 1
    else
        echo "STARTED"
        echo "MSG=${MSG}"
        echo "DONE"
    fi
    return 0
}


function log() {
    local readonly MSG=${1}
    local readonly DEBUG=${2}

    if [ "${DEBUG}" = "DEBUG" ] ; then
        echo "DEBUG: MSG=${MSG}"
    elif [ "${DEBUG}" = "WARNING" ] ; then
        echo -e "\x1b[01;93mWARNING:\x1b[0m MSG=${MSG}"
    elif [ "${DEBUG}" = "ERROR" ] ; then
        echo -e "\x1b[31mERROR:\x1b[0m MSG=${MSG}" >&2
    else
        echo "error! unsupported value for DEBUG param: DEBUG=\"${DEBUG}\""
        return 1
    fi
    return 0
}


function file_stats() {
    local readonly FILE_NAME=${1}

    LINES=$(wc -l "${FILE_NAME}" | cut -d" " -f1)
    BYTES=$(wc -c "${FILE_NAME}" | cut -d" " -f1)
    echo "${FILE_NAME} stats:"
    echo "lines: ${LINES}"
    echo "size: ${BYTES} (bytes)"
}

