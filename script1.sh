#!/bin/bash
#set -x


if [ -f /tmp/foobar ] ; then
    echo "found /tmp/foobar file"
else
    echo "warning! couldn't find /tmp/foobar file"
    echo "will be created manually..."
    touch /tmp/foobar
    readlink -f /tmp/foobar 
fi
echo "done"

