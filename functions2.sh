function svn_parse_revision() {
    local readonly URL=${1}

    if [ "${URL}" = "" ] ; then
        echo "error! an empty url: URL=\"${URL}\""
        return 1
    else
        LAST_REVISION=$(svn info ${URL} | grep "Revision: " | cut -d":" -f2 | tr -d " ")
        echo ${LAST_REVISION}
    fi
}

