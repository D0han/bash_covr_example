#!/bin/bash
#set -x


for f in test_functions1.sh test_functions2.sh test_script1.sh ; do
    chmod +x ${f}
    ./${f} --stop --verbose
    chmod -x ${f}

done

echo "done"

